#include "lua_module.hpp"

#include "bindings/game_maker.hpp"
#include "bindings/global_table.hpp"
#include "bindings/gui.hpp"
#include "bindings/imgui.hpp"
#include "bindings/log.hpp"
#include "bindings/memory.hpp"
#include "file_manager/file_manager.hpp"

namespace big
{
	// https://sol2.readthedocs.io/en/latest/exceptions.html
	int exception_handler(lua_State* L, sol::optional<const std::exception&> maybe_exception, sol::string_view description)
	{
		// L is the lua state, which you can wrap in a state_view if necessary
		// maybe_exception will contain exception, if it exists
		// description will either be the what() of the exception or a description saying that we hit the general-case catch(...)
		if (maybe_exception)
		{
			const std::exception& ex = *maybe_exception;
			LOG(FATAL) << ex.what();
		}
		else
		{
			LOG(FATAL) << description;
		}
		Logger::FlushQueue();

		// you must push 1 element onto the stack to be
		// transported through as the error object in Lua
		// note that Lua -- and 99.5% of all Lua users and libraries -- expects a string
		// so we push a single string (in our case, the description of the error)
		return sol::stack::push(L, description);
	}

	inline void panic_handler(sol::optional<std::string> maybe_msg)
	{
		LOG(FATAL) << "Lua is in a panic state and will now abort() the application";
		if (maybe_msg)
		{
			const std::string& msg = maybe_msg.value();
			LOG(FATAL) << "error message: " << msg;
		}
		Logger::FlushQueue();

		// When this function exits, Lua will exhibit default behavior and abort()
	}

	lua_module::lua_module(const module_info& module_info, folder& scripts_folder) :
	    m_state(),
	    m_module_path(module_info.m_module_path),
	    m_manifest(module_info.m_manifest),
	    m_module_guid(module_info.m_module_guid)
	{
		// clang-format off
		m_state.open_libraries(
			sol::lib::base,
			sol::lib::package,
			sol::lib::coroutine,
		    sol::lib::string,
		    sol::lib::os,
		    sol::lib::math,
			sol::lib::table,
			sol::lib::bit32,
			sol::lib::utf8
		);
		// clang-format on

		init_lua_api(scripts_folder);

		m_state["!module_guid"] = m_module_guid;
		m_state["!this"]        = this;

		m_state.set_exception_handler(exception_handler);
		m_state.set_panic(sol::c_call<decltype(&panic_handler), &panic_handler>);

		m_last_write_time = std::filesystem::last_write_time(m_module_path);
	}

	lua_module::~lua_module()
	{
		for (auto memory : m_allocated_memory)
			delete[] memory;
	}

	const std::filesystem::path& lua_module::module_path() const
	{
		return m_module_path;
	}

	const ts::v1::manifest& lua_module::manifest() const
	{
		return m_manifest;
	}

	const std::string& lua_module::module_guid() const
	{
		return m_module_guid;
	}

	const std::chrono::time_point<std::chrono::file_clock> lua_module::last_write_time() const
	{
		return m_last_write_time;
	}

	void lua_module::set_folder_for_lua_require(folder& scripts_folder)
	{
		std::string scripts_search_path = scripts_folder.get_path().string() + "/?.lua;";

		for (const auto& entry : std::filesystem::recursive_directory_iterator(scripts_folder.get_path(), std::filesystem::directory_options::skip_permission_denied))
		{
			if (!entry.is_directory())
				continue;

			scripts_search_path += entry.path().string() + "/?.lua;";
		}
		// Remove final ';'
		scripts_search_path.pop_back();

		m_state["package"]["path"] = scripts_search_path;
	}

	void lua_module::sandbox_lua_os_library()
	{
		const auto& os = m_state["os"];
		sol::table sandbox_os(m_state, sol::create);

		sandbox_os["clock"]    = os["clock"];
		sandbox_os["date"]     = os["date"];
		sandbox_os["difftime"] = os["difftime"];
		sandbox_os["time"]     = os["time"];

		m_state["os"] = sandbox_os;
	}

	template<size_t N>
	static constexpr auto not_supported_lua_function(const char (&function_name)[N])
	{
		return [function_name](sol::this_state state, sol::variadic_args args) {
			big::lua_module* module = sol::state_view(state)["!this"];

			LOG(FATAL) << module->module_guid() << " tried calling a currently not supported lua function: " << function_name;
			Logger::FlushQueue();
		};
	}

	void lua_module::sandbox_lua_loads(folder& scripts_folder)
	{
		// That's from lua base lib, luaB
		m_state["load"]       = not_supported_lua_function("load");
		m_state["loadstring"] = not_supported_lua_function("loadstring");
		m_state["loadfile"]   = not_supported_lua_function("loadfile");
		m_state["dofile"]     = not_supported_lua_function("dofile");

		// That's from lua package lib.
		// We only allow dependencies between .lua files, no DLLs.
		m_state["package"]["loadlib"] = not_supported_lua_function("package.loadlib");
		m_state["package"]["cpath"]   = "";

		// 1                   2               3            4
		// {searcher_preload, searcher_Lua, searcher_C, searcher_Croot, NULL};
		m_state["package"]["searchers"][3] = not_supported_lua_function("package.searcher C");
		m_state["package"]["searchers"][4] = not_supported_lua_function("package.searcher Croot");

		set_folder_for_lua_require(scripts_folder);
	}

	void lua_module::init_lua_api(folder& scripts_folder)
	{
		// https://blog.rubenwardy.com/2020/07/26/sol3-script-sandbox/
		// https://www.lua.org/manual/5.4/manual.html#pdf-require
		sandbox_lua_os_library();
		sandbox_lua_loads(scripts_folder);

		lua::log::bind(m_state);
		lua::memory::bind(m_state);
		lua::gui::bind(m_state);
		lua::global_table::bind(m_state);
		lua::imgui::bind(m_state, m_state.globals());
		lua::game_maker::bind(m_state);
	}

	void lua_module::load_and_call_script()
	{
		auto result = m_state.safe_script_file(m_module_path.string(), &sol::script_pass_on_error, sol::load_mode::text);

		if (!result.valid())
		{
			LOG(FATAL) << m_module_guid << " failed to load: " << result.get<sol::error>().what();
			Logger::FlushQueue();
		}
		else
		{
			LOG(INFO) << "Loaded " << m_module_guid;
		}
	}
}