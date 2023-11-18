#pragma once
#include "lua_patch.hpp"
#include "sol.hpp"
#include "lua/bindings/gui_element.hpp"

namespace big
{
	class lua_module
	{
		sol::state m_state;

		std::filesystem::path m_module_path;

		std::string m_module_name;

		std::chrono::time_point<std::chrono::file_clock> m_last_write_time;

	public:
		std::vector<sol::protected_function> m_pre_code_execute_callbacks;
		std::vector<sol::protected_function> m_post_code_execute_callbacks;

		std::vector<std::unique_ptr<lua::gui::gui_element>> m_independent_gui;

		std::vector<std::unique_ptr<lua_patch>> m_registered_patches;

		std::vector<void*> m_allocated_memory;

		lua_module(const std::filesystem::path& module_path, folder& scripts_folder);
		~lua_module();

		const std::filesystem::path& module_path() const;

		const std::string& module_name() const;
		const std::chrono::time_point<std::chrono::file_clock> last_write_time() const;

		// used for sandboxing and limiting to only our custom search path for the lua require function
		void set_folder_for_lua_require(folder& scripts_folder);

		void sandbox_lua_os_library();
		void sandbox_lua_loads(folder& scripts_folder);

		void init_lua_api(folder& scripts_folder);

		void load_and_call_script();
	};
}