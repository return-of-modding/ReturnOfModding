#pragma once
#include "Code_Execute_trace.hpp"
#include "Code_Function_GET_the_function.hpp"

#include <lua/lua_manager_extension.hpp>
#include <string/string.hpp>

static void* lua_custom_alloc(void* ud, void* ptr, size_t osize, size_t nsize)
{
	(void)ud;
	(void)osize;
	if (nsize == 0)
	{
		//mi_free(ptr);
		free(ptr);
		return NULL;
	}
	else
	{
		//return mi_realloc_aligned(ptr, nsize, 16);
		return realloc(ptr, nsize);
	}
}

namespace gm
{
	inline bool g_is_gml_safe_to_init = false;

	inline void init_lua_manager()
	{
		if (!big::g_abort)
		{
			YYObjectPinMap::init_pin_map();
		}

		big::g_running = true;

		lua_State* L = lua_newstate(lua_custom_alloc, NULL);
		//lua_State* L = luaL_newstate();

		// Purposely leak it, we are not unloading this module in any case.
		auto lua_manager_instance = new big::lua_manager(L,
		                                                 big::g_file_manager.get_project_folder("config"),
		                                                 big::g_file_manager.get_project_folder("plugins_data"),
		                                                 big::g_file_manager.get_project_folder("plugins"),
		                                                 [](sol::state_view& state, sol::table& lua_ext)
		                                                 {
			                                                 big::lua_manager_extension::init_lua_api(state, lua_ext);
		                                                 });
		sol::state_view sol_state_view(L);
		big::lua_manager_extension::init_lua_base(sol_state_view);
		lua_manager_instance->init<big::lua_module_ext>(true);
		LOG(INFO) << "Lua manager initialized.";

		if (big::g_abort)
		{
			LOG(ERROR) << "ReturnOfModding failed to init properly, exiting.";
			big::g_running = false;
		}
	}

	inline bool hook_Code_Execute(CInstance* self, CInstance* other, CCode* code, RValue* result, int flags)
	{
		g_last_code_execute = code->name;

		bool no_error = true;
		if (big::g_lua_manager)
		{
			const auto call_orig_if_true = big::lua_manager_extension::pre_code_execute(self, other, code, result, flags);

			if (call_orig_if_true)
			{
				__try
				{
					no_error = big::g_hooking->get_original<hook_Code_Execute>()(self, other, code, result, flags);
				}
				__except (triple_exception_handler(GetExceptionInformation()), EXCEPTION_EXECUTE_HANDLER)
				{
				}
			}

			big::lua_manager_extension::post_code_execute(self, other, code, result, flags);
		}
		else
		{
			__try
			{
				no_error = big::g_hooking->get_original<hook_Code_Execute>()(self, other, code, result, flags);
			}
			__except (double_exception_handler(GetExceptionInformation()), EXCEPTION_EXECUTE_HANDLER)
			{
			}
		}

		if (!g_is_gml_safe_to_init && big::string::starts_with("gml_Object_oInit_Alarm_", code->name))
		{
			g_is_gml_safe_to_init = true;

			init_lua_manager();
		}

		g_last_code_execute = nullptr;
		return no_error;
	}
} // namespace gm
