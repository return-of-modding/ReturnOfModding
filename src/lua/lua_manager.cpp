#include "lua_manager.hpp"

#include "file_manager/file_manager.hpp"

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

	void lua_manager::unload_module(const std::string& module_name)
	{
		std::lock_guard guard(m_module_lock);

		std::erase_if(m_modules, [&](auto& module) {
			return module_name == module->module_name();
		});
	}

	void lua_manager::load_module(const std::filesystem::path& module_path)
	{
		if (!std::filesystem::exists(module_path))
		{
			LOG(WARNING) << reinterpret_cast<const char*>(module_path.u8string().c_str()) << " does not exist in the filesystem. Not loading it.";
			return;
		}

		std::lock_guard guard(m_module_lock);

		const auto module_name = module_path.filename().string();

		for (const auto& module : m_modules)
		{
			if (module->module_name() == module_name)
			{
				LOG(WARNING) << "Module with the name " << module_name << " already loaded.";
				return;
			}
		}

		const auto module = std::make_shared<lua_module>(module_path, m_scripts_folder);
		module->load_and_call_script();

		m_modules.push_back(module);
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
								unload_module(module->module_name());
								load_module(module_path);
								break;
							}
						}
					}
				}

				m_wake_time_changed_scripts_check = std::chrono::high_resolution_clock::now() + m_delay_between_changed_scripts_check;
			}
		}
	}

	std::weak_ptr<lua_module> lua_manager::get_module(const std::string& module_name)
	{
		std::lock_guard guard(m_module_lock);

		for (const auto& module : m_modules)
			if (module->module_name() == module_name)
				return module;

		return {};
	}

	void lua_manager::handle_error(const sol::error& error, const sol::state_view& state)
	{
		LOG(FATAL) << state["!module_name"].get<std::string_view>() << ": " << error.what();
		Logger::FlushQueue();
	}

	void lua_manager::load_all_modules()
	{
		for (const auto& entry : std::filesystem::recursive_directory_iterator(m_scripts_folder.get_path(), std::filesystem::directory_options::skip_permission_denied))
			if (entry.is_regular_file() && entry.path().extension() == ".lua")
				load_module(entry.path());
	}
	void lua_manager::unload_all_modules()
	{
		std::lock_guard guard(m_module_lock);

		for (auto& module : m_modules)
			module.reset();

		m_modules.clear();
	}
}