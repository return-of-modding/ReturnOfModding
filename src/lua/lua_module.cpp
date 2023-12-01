#include "lua_module.hpp"

#include "file_manager/file_manager.hpp"

namespace big
{
	lua_module::lua_module(const module_info& module_info, folder& scripts_folder, sol::state& state) :
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

	void lua_module::load_and_call_script(sol::state& state)
	{
		auto result = state.safe_script_file(m_info.m_path.string(), m_env, &sol::script_pass_on_error, sol::load_mode::text);

		if (!result.valid())
		{
			LOG(FATAL) << m_info.m_guid << " failed to load: " << result.get<sol::error>().what();
			Logger::FlushQueue();
		}
		else
		{
			LOG(INFO) << "Loaded " << m_info.m_guid;

			state.traverse_set("mods", m_info.m_guid, m_env);
		}
	}

	static std::string dummy_guid = "No guid (require module?)";
	std::string lua_module::guid_from(sol::this_environment this_env)
	{
		sol::environment& env = this_env;
		sol::optional<std::string> _guid = env["!guid"];
		if (_guid)
			return _guid.value();
		return dummy_guid;
	}

	big::lua_module* lua_module::this_from(sol::this_environment this_env)
	{
		sol::environment& env = this_env;
		sol::optional<big::lua_module*> _this = env["!this"];
		if (_this)
			return _this.value();
		return nullptr;
	}
}