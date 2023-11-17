#pragma once
#include "lua_module.hpp"

namespace big
{
	class lua_manager
	{
	private:
		std::mutex m_module_lock;
		std::vector<std::shared_ptr<lua_module>> m_modules;

		static constexpr std::chrono::seconds m_delay_between_changed_scripts_check = 3s;
		std::chrono::high_resolution_clock::time_point m_wake_time_changed_scripts_check;

		folder m_scripts_folder;

	public:
		lua_manager(folder scripts_folder);
		~lua_manager();

		void load_all_modules();
		void unload_all_modules();

		inline auto get_module_count() const
		{
			return m_modules.size();
		}

		inline const folder& get_scripts_folder() const
		{
			return m_scripts_folder;
		}

		void draw_independent_gui();

		std::weak_ptr<lua_module> get_module(const std::string& module_name);

		void unload_module(const std::string& module_name);
		void load_module(const std::filesystem::path& module_path);

		void reload_changed_scripts();

		void handle_error(const sol::error& error, const sol::state_view& state);

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