#pragma once

#include "lua/lua_module.hpp"

namespace big
{
	enum GMHookType : int16_t
	{
		NONE,

		PRE_CODE,
		POST_CODE,

		PRE_BUILTIN,
		POST_BUILTIN,

		PRE_SCRIPT,
		POST_SCRIPT
	};

	class lua_module_ext;
	struct GMHookHandle
	{
		void* m_original_func_ptr{};
		big::lua_module_ext* m_module{};
		GMHookType m_type{};
		size_t m_lua_function_id{};
	};

	struct lua_function_data_ext
	{
		static inline size_t g_last_id = 0;

		sol::protected_function m_cb;
		size_t m_id{};
		bool m_enabled{true};
		void* m_original_function_ptr{};
		GMHookType m_type{};
	};

	struct lua_function_cached_data_ext
	{
		sol::protected_function m_cb;
		size_t m_id{};
	};

	struct lua_module_data_ext
	{
		bool m_need_to_rebuild_callback_cache{false};

		std::vector<sol::protected_function> m_pre_code_execute_callbacks;
		std::vector<sol::protected_function> m_post_code_execute_callbacks;

		ankerl::unordered_dense::map<void*, std::vector<lua_function_cached_data_ext>> m_pre_code_execute_fast_callbacks;
		ankerl::unordered_dense::map<void*, std::vector<lua_function_cached_data_ext>> m_post_code_execute_fast_callbacks;

		ankerl::unordered_dense::map<void*, std::vector<lua_function_cached_data_ext>> m_pre_builtin_execute_callbacks;
		ankerl::unordered_dense::map<void*, std::vector<lua_function_cached_data_ext>> m_post_builtin_execute_callbacks;

		ankerl::unordered_dense::map<void*, std::vector<lua_function_cached_data_ext>> m_pre_script_execute_callbacks;
		ankerl::unordered_dense::map<void*, std::vector<lua_function_cached_data_ext>> m_post_script_execute_callbacks;

		std::vector<big::lua_function_data_ext> m_all_callbacks;
	};

	class lua_module_ext : public lua_module
	{
	public:
		lua_module_data_ext m_data_ext;

		static auto get_PLUGIN_table(sol::environment& env)
		{
			return env["_PLUGIN"].get_or_create<sol::table>();
		}

	private:
		void backcompat_init()
		{
			auto plugin_ns = get_PLUGIN_table(m_env);

			// Lua API: Field
			// Table: _ENV - Plugin Specific Global Table
			// Field: !guid: string
			// Guid of the mod.
			m_env["!guid"] = plugin_ns["guid"];

			// Lua API: Field
			// Table: _ENV - Plugin Specific Global Table
			// Field: !config_mod_folder_path: string
			// Path to the mod folder inside `config`
			m_env["!config_mod_folder_path"] = plugin_ns["config_mod_folder_path"];

			// Lua API: Field
			// Table: _ENV - Plugin Specific Global Table
			// Field: !plugins_data_mod_folder_path: string
			// Path to the mod folder inside `plugins_data`
			m_env["!plugins_data_mod_folder_path"] = plugin_ns["plugins_data_mod_folder_path"];

			// Lua API: Field
			// Table: _ENV - Plugin Specific Global Table
			// Field: !plugins_mod_folder_path: string
			// Path to the mod folder inside `plugins`
			m_env["!plugins_mod_folder_path"] = plugin_ns["plugins_mod_folder_path"];

			// Lua API: Field
			// Table: _ENV - Plugin Specific Global Table
			// Field: !this: lua_module*
			m_env["!this"] = this;
		}

	public:

		lua_module_ext(const module_info& module_info, sol::environment& env) :
		    lua_module(module_info, env)
		{
			backcompat_init();
		}

		lua_module_ext(const module_info& module_info, sol::state_view& state) :
		    lua_module(module_info, state)
		{
			backcompat_init();
		}

		inline void cleanup() override
		{
			lua_module::cleanup();

			m_data_ext = {};
		}
	};
} // namespace big
