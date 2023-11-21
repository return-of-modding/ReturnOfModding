#include "lua_manager.hpp"

#include "file_manager/file_manager.hpp"
#include "string/string.hpp"

#include <thunderstore/v1/manifest.hpp>
#include <unordered_set>

namespace big
{
	lua_manager::lua_manager(folder scripts_folder) :
	    m_scripts_folder(scripts_folder)
	{
		m_wake_time_changed_scripts_check = std::chrono::high_resolution_clock::now() + m_delay_between_changed_scripts_check;

		g_lua_manager = this;

		load_all_modules();

		m_reload_watcher_thread = std::thread([&]() {
			reload_changed_scripts();
		});
	}

	lua_manager::~lua_manager()
	{
		m_reload_watcher_thread.join();

		unload_all_modules();

		g_lua_manager = nullptr;
	}

	void lua_manager::pre_code_execute(CInstance* self, CInstance* other, CCode* code, RValue* result, int flags)
	{
		std::lock_guard guard(m_module_lock);

		for (const auto& module : m_modules)
		{
			for (const auto& cb : module->m_pre_code_execute_callbacks)
			{
				cb(self, other, code, result, flags);
			}
		}
	}

	void lua_manager::post_code_execute(CInstance* self, CInstance* other, CCode* code, RValue* result, int flags)
	{
		std::lock_guard guard(m_module_lock);

		for (const auto& module : m_modules)
		{
			for (const auto& cb : module->m_post_code_execute_callbacks)
			{
				cb(self, other, code, result, flags);
			}
		}
	}

	void lua_manager::draw_independent_gui()
	{
		std::lock_guard guard(m_module_lock);

		for (const auto& module : m_modules)
		{
			for (const auto& element : module->m_independent_gui)
			{
				element->draw();
			}
		}
	}

	void lua_manager::unload_module(const std::string& module_guid)
	{
		std::lock_guard guard(m_module_lock);

		std::erase_if(m_modules, [&](auto& module) {
			return module_guid == module->module_guid();
		});
	}

	void lua_manager::load_module(const module_info& module_info)
	{
		if (!std::filesystem::exists(module_info.m_module_path))
		{
			LOG(WARNING) << reinterpret_cast<const char*>(module_info.m_module_path.u8string().c_str()) << " does not exist in the filesystem. Not loading it.";
			return;
		}

		std::lock_guard guard(m_module_lock);
		for (const auto& module : m_modules)
		{
			if (module->module_guid() == module_info.m_module_guid)
			{
				LOG(WARNING) << "Module with the guid " << module_info.m_module_guid << " already loaded.";
				return;
			}
		}

		const auto module = std::make_shared<lua_module>(module_info, m_scripts_folder);
		module->load_and_call_script();

		m_modules.push_back(module);
	}

	static module_info get_module_info(const std::filesystem::path& module_path)
	{
		constexpr auto thunderstore_manifest_json_file_name = "manifest.json";
		std::filesystem::path manifest_path;
		std::filesystem::path current_folder = module_path.parent_path();
		std::filesystem::path root_folder    = g_file_manager.get_base_dir();
		while (true)
		{
			if (current_folder == root_folder)
			{
				break;
			}

			const auto potential_manifest_path = current_folder / thunderstore_manifest_json_file_name;
			if (std::filesystem::exists(potential_manifest_path))
			{
				manifest_path = potential_manifest_path;
				break;
			}

			if (current_folder.has_parent_path())
			{
				current_folder = current_folder.parent_path();
			}
			else
			{
				break;
			}
		}

		if (!std::filesystem::exists(manifest_path))
		{
			LOG(WARNING) << "No manifest path, can't load " << reinterpret_cast<const char*>(module_path.u8string().c_str());
			return {};
		}

		std::ifstream manifest_file(manifest_path);
		nlohmann::json manifest_json = nlohmann::json::parse(manifest_file, nullptr, false, true);

		ts::v1::manifest manifest = manifest_json.get<ts::v1::manifest>();

		manifest.version = semver::version::parse(manifest.version_number);

		for (const auto& dep : manifest.dependencies)
		{
			const auto splitted = big::string::split(dep, '-');
			if (splitted.size() == 3)
			{
				// clang-format off
				manifest.dependency_objects.push_back(
					ts::v1::dependency
					{
						.team_name = splitted[0],
						.name = splitted[1],
						.version = semver::version::parse(splitted[2])
					}
				);
				// clang-format on
			}
		}

		return {
		    .m_module_path = module_path,
		    .m_module_guid = std::string(reinterpret_cast<const char*>(current_folder.filename().u8string().c_str())) + "-"
		        + manifest.version_number,
		    .m_manifest    = manifest,
		};
	}

	void lua_manager::reload_changed_scripts()
	{
		while (g_running)
		{
			if (m_wake_time_changed_scripts_check <= std::chrono::high_resolution_clock::now())
			{
				for (const auto& entry : std::filesystem::recursive_directory_iterator(m_scripts_folder.get_path(), std::filesystem::directory_options::skip_permission_denied))
				{
					if (entry.is_regular_file())
					{
						const auto& module_path    = entry.path();
						const auto last_write_time = entry.last_write_time();

						for (const auto& module : m_modules)
						{
							if (module->module_path() == module_path && module->last_write_time() < last_write_time)
							{
								unload_module(module->module_guid());
								const auto module_info = get_module_info(module_path);
								load_module(module_info);
								break;
							}
						}
					}
				}

				m_wake_time_changed_scripts_check = std::chrono::high_resolution_clock::now() + m_delay_between_changed_scripts_check;
			}
		}
	}

	std::weak_ptr<lua_module> lua_manager::get_module(const std::string& module_guid)
	{
		std::lock_guard guard(m_module_lock);

		for (const auto& module : m_modules)
			if (module->module_guid() == module_guid)
				return module;

		return {};
	}

	void lua_manager::handle_error(const sol::error& error, const sol::state_view& state)
	{
		LOG(FATAL) << state["!module_guid"].get<std::string_view>() << ": " << error.what();
		Logger::FlushQueue();
	}

	static bool topological_sort_visit(const std::string& node, std::stack<std::string>& stack, std::vector<std::string>& sorted_list, const std::function<std::vector<std::string>(const std::string&)>& dependency_selector, std::unordered_set<std::string>& visited, std::unordered_set<std::string>& sorted)
	{
		if (visited.contains(node))
		{
			if (!sorted.contains(node))
			{
				return false;
			}
		}
		else
		{
			visited.insert(node);
			stack.push(node);
			for (const auto& dep : dependency_selector(node))
			{
				if (!topological_sort_visit(dep, stack, sorted_list, dependency_selector, visited, sorted))
				{
					return false;
				}
			}

			sorted.insert(node);
			sorted_list.push_back(node);

			stack.pop();
		}

		return true;
	}

	static std::vector<std::string> topological_sort(std::vector<std::string>& nodes, const std::function<std::vector<std::string>(const std::string&)>& dependency_selector)
	{
		std::vector<std::string> sorted_list;

		std::unordered_set<std::string> visited;
		std::unordered_set<std::string> sorted;

		for (const auto& input : nodes)
		{
			std::stack<std::string> current_stack;
			if (!topological_sort_visit(input, current_stack, sorted_list, dependency_selector, visited, sorted))
			{
				LOG(FATAL) << "Cyclic Dependency: " << input;
				while (!current_stack.empty())
				{
					LOG(FATAL) << current_stack.top();
					current_stack.pop();
				}
			}
		}

		return sorted_list;
	}

	void lua_manager::load_all_modules()
	{
		std::map<std::string, module_info> module_guid_to_module_info{};

		for (const auto& entry : std::filesystem::recursive_directory_iterator(m_scripts_folder.get_path(), std::filesystem::directory_options::skip_permission_denied))
		{
			if (entry.is_regular_file() && entry.path().extension() == ".lua")
			{
				const auto module_info = get_module_info(entry.path());
				module_guid_to_module_info.insert({module_info.m_module_guid, module_info});
			}
		}

		std::vector<std::string> module_guids;
		for (const auto& [guid, info] : module_guid_to_module_info)
		{
			module_guids.push_back(guid);
		}

		const auto sorted_modules = topological_sort(module_guids, [&](const std::string& guid) {
			if (module_guid_to_module_info.contains(guid))
			{
				return module_guid_to_module_info[guid].m_manifest.dependencies;
			}
			return std::vector<std::string>();
		});

		for (const auto& guid : sorted_modules)
		{
			load_module(module_guid_to_module_info[guid]);
		}
	}
	void lua_manager::unload_all_modules()
	{
		std::lock_guard guard(m_module_lock);

		for (auto& module : m_modules)
			module.reset();

		m_modules.clear();
	}
}