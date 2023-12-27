#pragma once
#include "load_module_result.hpp"
#include "lua_module.hpp"
#include "module_info.hpp"

#include <rorr/gm/CCode.hpp>
#include <rorr/gm/CInstance.hpp>
#include <rorr/gm/RValue.hpp>

namespace big
{
	class lua_manager
	{
	private:
		sol::state m_state;
		sol::protected_function m_loadfile;

		std::recursive_mutex m_module_lock;
		std::vector<std::shared_ptr<lua_module>> m_modules;

		std::thread m_reload_watcher_thread;
		static constexpr std::chrono::seconds m_delay_between_changed_plugins_check = 3s;
		std::chrono::high_resolution_clock::time_point m_wake_time_changed_plugins_check;

		folder m_config_folder;
		folder m_plugins_data_folder;
		folder m_plugins_folder;

	public:
		lua_manager(folder config_folder, folder plugins_data_folder, folder plugins_folder);
		~lua_manager();

		void init_lua_state();
		// used for sandboxing and limiting to only our custom search path for the lua require function
		void set_folder_for_lua_require();
		void sandbox_lua_os_library();
		void sandbox_lua_loads();
		void init_lua_api();

		void load_all_modules();
		void unload_all_modules();

		inline auto get_module_count() const
		{
			return m_modules.size();
		}

		inline const folder& get_config_folder() const
		{
			return m_config_folder;
		}

		inline const folder& get_plugins_data_folder() const
		{
			return m_plugins_data_folder;
		}

		inline const folder& get_plugins_folder() const
		{
			return m_plugins_folder;
		}

		bool pre_code_execute(CInstance* self, CInstance* other, CCode* code, RValue* result, int flags);
		void post_code_execute(CInstance* self, CInstance* other, CCode* code, RValue* result, int flags);

		void draw_independent_gui();

		std::weak_ptr<lua_module> get_module(const std::string& module_guid);

		void unload_module(const std::string& module_guid);
		load_module_result load_module(const module_info& module_info, bool ignore_failed_to_load = false);

		void reload_changed_plugins();

		inline void for_each_module(auto func)
		{
			std::lock_guard guard(m_module_lock);

			for (auto& module : m_modules)
			{
				func(module);
			}
		}
	};

	inline lua_manager* g_lua_manager;
}