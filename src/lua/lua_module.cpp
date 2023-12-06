#include "lua_module.hpp"

#include "file_manager/file_manager.hpp"

namespace big
{
	lua_module::lua_module(const module_info& module_info, sol::state& state) :
	    m_info(module_info),
	    m_last_write_time(std::filesystem::last_write_time(module_info.m_path)),
	    m_env(state, sol::create, state.globals())
	{
		m_env["!guid"] = m_info.m_guid;
		m_env["!this"] = this;
	}

	lua_module::~lua_module()
	{
		for (auto memory : m_allocated_memory)
			delete[] memory;
	}

	const std::filesystem::path& lua_module::path() const
	{
		return m_info.m_path;
	}

	const ts::v1::manifest& lua_module::manifest() const
	{
		return m_info.m_manifest;
	}

	const std::string& lua_module::guid() const
	{
		return m_info.m_guid;
	}

	const std::chrono::time_point<std::chrono::file_clock> lua_module::last_write_time() const
	{
		return m_last_write_time;
	}

	sol::environment& lua_module::env()
	{
		return m_env;
	}

	load_module_result lua_module::load_and_call_plugin(sol::state& state)
	{
		auto result = state.safe_script_file(m_info.m_path.string(), m_env, &sol::script_pass_on_error, sol::load_mode::text);

		if (!result.valid())
		{
			LOG(FATAL) << m_info.m_guid << " failed to load: " << result.get<sol::error>().what();
			Logger::FlushQueue();

			return load_module_result::FAILED_TO_LOAD;
		}
		else
		{
			LOG(INFO) << "Loaded " << m_info.m_guid;

			state.traverse_set("mods", m_info.m_guid, m_env);
		}

		return load_module_result::SUCCESS;
	}

	static std::string dummy_guid = "No guid (issue with a required module?)";
	std::string lua_module::guid_from(sol::this_environment this_env)
	{
		sol::environment& env            = this_env;
		sol::optional<std::string> _guid = env["!guid"];
		if (_guid)
			return _guid.value();
		return dummy_guid;
	}

	big::lua_module* lua_module::this_from(sol::this_environment this_env)
	{
		sol::environment& env                 = this_env;
		sol::optional<big::lua_module*> _this = env["!this"];
		if (_this)
			return _this.value();
		return nullptr;
	}
}