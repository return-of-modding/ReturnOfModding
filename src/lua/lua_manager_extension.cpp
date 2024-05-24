#include "lua_manager_extension.hpp"

#include "bindings/game_maker.hpp"
#include "bindings/gui_ext.hpp"
#include "string/string.hpp"

#include <lua/lua_manager.hpp>

namespace big::lua_manager_extension
{
	static void set_folder_for_lua_require(sol::state_view& state)
	{
		std::string plugins_search_path = g_lua_manager->m_plugins_folder.get_path().string() + "/?.lua;";

		for (const auto& entry : std::filesystem::recursive_directory_iterator(g_lua_manager->m_plugins_folder.get_path(), std::filesystem::directory_options::skip_permission_denied))
		{
			if (!entry.is_directory())
			{
				continue;
			}

			plugins_search_path += entry.path().string() + "/?.lua;";
		}
		// Remove final ';'
		plugins_search_path.pop_back();

		state["package"]["path"] = plugins_search_path;
	}

	static void sandbox_lua_os_library(sol::state_view& state)
	{
		const auto& os = state["os"];
		sol::table sandbox_os(state, sol::create);

		sandbox_os["clock"]    = os["clock"];
		sandbox_os["date"]     = os["date"];
		sandbox_os["difftime"] = os["difftime"];
		sandbox_os["time"]     = os["time"];

		state["os"] = sandbox_os;
	}

	template<size_t N>
	static constexpr auto not_supported_lua_function(const char (&function_name)[N])
	{
		return [function_name](sol::this_environment env, sol::variadic_args args)
		{
			LOG(ERROR) << big::lua_module::guid_from(env) << " tried calling a currently not supported lua function: " << function_name;
			Logger::FlushQueue();
		};
	}

	static auto get_loadfile_function(sol::state_view& state)
	{
		return state["_rom_loadfile"];
	}

	static void sandbox_lua_loads(sol::state_view& state)
	{
		// That's from lua base lib, luaB
		get_loadfile_function(state) = state["loadfile"];

		// That's from lua package lib.
		// We only allow dependencies between .lua files, no DLLs.
		state["package"]["loadlib"] = not_supported_lua_function("package.loadlib");
		state["package"]["cpath"]   = "";

		// 1                   2               3            4
		// {searcher_preload, searcher_Lua, searcher_C, searcher_Croot, NULL};
		state["package"]["searchers"][3] = not_supported_lua_function("package.searcher C");
		state["package"]["searchers"][4] = not_supported_lua_function("package.searcher Croot");

		// Custom require for setting environment on required modules, the setenv is based on
		// which folder (and so ultimately package/mod) contains the required module file.
		// If no match is found with the folder path then we just set the same env as the require caller.
		// TODO: This is hacked together, need to be cleaned up at some point.
		// TODO: sub folders are not supported currently.
		state["require"] = [](std::string path, sol::variadic_args args, sol::this_environment this_env) -> sol::object
		{
			sol::environment& env = this_env;

			// Example of a non local require (mod is requiring a file from another mod/package):
			// require "ReturnOfModding-DebugToolkit/lib_debug"
			const auto is_non_local_require = !path.starts_with("./") && path.contains('-') && path.contains('/');
			std::string required_module_guid{};
			if (is_non_local_require)
			{
				LOG(INFO) << "Non Local require: " << path;
				required_module_guid = string::split(path, '/')[0];
				if (std::ranges::count(path, '/') > 1)
				{
					LOG(WARNING) << "Require with sub folders are currently not supported";
				}
			}
			else
			{
				LOG(INFO) << "Local require: " << path;
				if (path.starts_with("./"))
				{
					path.erase(0, 2);
				}
				if (path.contains('/'))
				{
					LOG(WARNING) << "Require with sub folders are currently not supported";
				}
				required_module_guid = lua_module::guid_from(this_env);
			}

			const auto path_stem = std::filesystem::path(path).stem();

			for (const auto& entry : std::filesystem::recursive_directory_iterator(g_lua_manager->m_plugins_folder.get_path(), std::filesystem::directory_options::skip_permission_denied))
			{
				if (entry.path().extension() == ".lua")
				{
					if (entry.path().stem() == path_stem)
					{
						const auto full_path_ = entry.path().u8string();
						const auto full_path  = (char*)full_path_.c_str();

						if (!strstr(full_path, required_module_guid.c_str()))
						{
							LOG(WARNING) << "Skipping " << full_path << " because the required module guid was not in the path " << required_module_guid;
							continue;
						}

						const auto guid_from_path = lua_manager::get_module_info(full_path);
						if (!guid_from_path)
						{
							LOG(WARNING) << "Couldnt get module info from path " << full_path;
							break;
						}

						static std::unordered_map<std::string, sol::protected_function> required_module_cache;

						if (!required_module_cache.contains(full_path))
						{
							sol::state_view state = this_env.env.value().lua_state();
							auto fresh_result     = get_loadfile_function(state)(full_path);
							if (!fresh_result.valid() || fresh_result.get_type() == sol::type::nil /*LuaJIT*/)
							{
								const auto error_msg =
								    !fresh_result.valid() ? fresh_result.get<sol::error>().what() : fresh_result.get<const char*>(1) /*LuaJIT*/;

								LOG(ERROR) << "Failed require: " << error_msg;
								Logger::FlushQueue();
								break;
							}
							required_module_cache[full_path] = fresh_result.get<sol::protected_function>();
						}

						auto& result = required_module_cache[full_path];

						bool found_the_other_module = false;
						for (const auto& mod : g_lua_manager->m_modules)
						{
							if (guid_from_path.value().m_guid == mod->guid())
							{
								env                    = mod->env();
								found_the_other_module = true;

								break;
							}
						}

						if (!found_the_other_module && is_non_local_require)
						{
							LOG(ERROR) << "You require'd a module called " << path << " but did not have a package manifest.json level dependency on it. Which lead to the owning package of that module to not be properly init yet. Expect unstable behaviors related to your dependencies.";
						}

						env.set_on(result);

						//LOG(INFO) << "Calling require on " << full_path;

						const auto res = result(args);

						//LOG(INFO) << "type: " << (int)res.get_type();

						return res;
					}
				}
			}

			return {};
		};

		set_folder_for_lua_require(state);
	}

	void init_lua_base(sol::state_view& state)
	{
		// clang-format off
		state.open_libraries(
			sol::lib::base,
			sol::lib::package,
			sol::lib::coroutine,
		    sol::lib::string,
		    sol::lib::os,
		    sol::lib::math,
			sol::lib::table,
			sol::lib::debug,
			sol::lib::bit32,
			sol::lib::io,
			sol::lib::utf8
		);
		// clang-format on

		// https://blog.rubenwardy.com/2020/07/26/sol3-script-sandbox/
		// https://www.lua.org/manual/5.4/manual.html#pdf-require
		sandbox_lua_os_library(state);
		sandbox_lua_loads(state);
	}

	void init_lua_api(sol::state_view& state, sol::table& lua_ext)
	{
		// Let's keep that list sorted the same as the solution file explorer
		lua::game_maker::bind(lua_ext);
		lua::gui_ext::bind(lua_ext);
	}

	bool pre_code_execute(CInstance* self, CInstance* other, CCode* code, RValue* result, int flags)
	{
		std::lock_guard guard(g_lua_manager->m_module_lock);

		bool call_orig_if_true = true;

		for (const auto& module_ : g_lua_manager->m_modules)
		{
			auto mod = (lua_module_ext*)module_.get();
			for (const auto& cb : mod->m_data_ext.m_pre_code_execute_callbacks)
			{
				const auto new_call_orig_if_true = cb(self, other, code, result, flags);
				if (call_orig_if_true && new_call_orig_if_true.valid() && new_call_orig_if_true.get_type() == sol::type::boolean
				    && new_call_orig_if_true.get<bool>() == false)
				{
					call_orig_if_true = false;
				}
			}
		}

		return call_orig_if_true;
	}

	void post_code_execute(CInstance* self, CInstance* other, CCode* code, RValue* result, int flags)
	{
		std::lock_guard guard(g_lua_manager->m_module_lock);

		for (const auto& module_ : g_lua_manager->m_modules)
		{
			auto mod = (lua_module_ext*)module_.get();
			for (const auto& cb : mod->m_data_ext.m_post_code_execute_callbacks)
			{
				cb(self, other, code, result, flags);
			}
		}
	}

	bool pre_builtin_execute(void* original_func_ptr, CInstance* self, CInstance* other, RValue* result, int arg_count, RValue* args)
	{
		std::lock_guard guard(g_lua_manager->m_module_lock);

		bool call_orig_if_true = true;

		for (const auto& module_ : g_lua_manager->m_modules)
		{
			auto mod = (lua_module_ext*)module_.get();
			for (const auto& cb : mod->m_data_ext.m_pre_builtin_execute_callbacks[original_func_ptr])
			{
				const auto new_call_orig_if_true = cb(self, other, result, std::span(args, arg_count));
				if (call_orig_if_true && new_call_orig_if_true.valid() && new_call_orig_if_true.get_type() == sol::type::boolean
				    && new_call_orig_if_true.get<bool>() == false)
				{
					call_orig_if_true = false;
				}
			}
		}

		return call_orig_if_true;
	}

	void post_builtin_execute(void* original_func_ptr, CInstance* self, CInstance* other, RValue* result, int arg_count, RValue* args)
	{
		std::lock_guard guard(g_lua_manager->m_module_lock);

		for (const auto& module_ : g_lua_manager->m_modules)
		{
			auto mod = (lua_module_ext*)module_.get();
			for (const auto& cb : mod->m_data_ext.m_post_builtin_execute_callbacks[original_func_ptr])
			{
				cb(self, other, result, std::span(args, arg_count));
			}
		}
	}

	bool pre_script_execute(void* original_func_ptr, CInstance* self, CInstance* other, RValue* result, int arg_count, RValue** args)
	{
		std::lock_guard guard(g_lua_manager->m_module_lock);

		bool call_orig_if_true = true;

		for (const auto& module_ : g_lua_manager->m_modules)
		{
			auto mod = (lua_module_ext*)module_.get();
			for (const auto& cb : mod->m_data_ext.m_pre_script_execute_callbacks[original_func_ptr])
			{
				const auto new_call_orig_if_true = cb(self, other, result, std::span(args, arg_count));
				if (call_orig_if_true && new_call_orig_if_true.valid() && new_call_orig_if_true.get_type() == sol::type::boolean
				    && new_call_orig_if_true.get<bool>() == false)
				{
					call_orig_if_true = false;
				}
			}
		}

		return call_orig_if_true;
	}

	void post_script_execute(void* original_func_ptr, CInstance* self, CInstance* other, RValue* result, int arg_count, RValue** args)
	{
		std::lock_guard guard(g_lua_manager->m_module_lock);

		for (const auto& module_ : g_lua_manager->m_modules)
		{
			auto mod = (lua_module_ext*)module_.get();
			for (const auto& cb : mod->m_data_ext.m_post_script_execute_callbacks[original_func_ptr])
			{
				cb(self, other, result, std::span(args, arg_count));
			}
		}
	}
} // namespace big::lua_manager_extension
