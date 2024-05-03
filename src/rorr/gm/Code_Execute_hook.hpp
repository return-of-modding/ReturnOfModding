#pragma once
#include "Code_Execute_trace.hpp"
#include "Code_Function_GET_the_function.hpp"

#include <lua/lua_manager_extension.hpp>
#include <string/string.hpp>

namespace gm
{
	inline bool hook_Code_Execute(CInstance* self, CInstance* other, CCode* code, RValue* result, int flags)
	{
		is_inside_code_execute = true;
		last_executed_code     = code->name;

		bool no_error = true;
		if (big::g_lua_manager)
		{
			const auto call_orig_if_true = big::lua_manager_extension::pre_code_execute(self, other, code, result, flags);

			if (call_orig_if_true)
			{
				try
				{
					no_error = big::g_hooking->get_original<hook_Code_Execute>()(self, other, code, result, flags);
				}
				catch (const YYGMLException& e)
				{
					gml_exception_handler(e.GetExceptionObject());
				}
			}

			big::lua_manager_extension::post_code_execute(self, other, code, result, flags);
		}
		else
		{
			try
			{
				no_error = big::g_hooking->get_original<hook_Code_Execute>()(self, other, code, result, flags);
			}
			catch (const YYGMLException& e)
			{
				gml_exception_handler(e.GetExceptionObject());
			}
		}

		if (!big::g_gml_safe && big::string::starts_with("gml_Object_oInit_Alarm_", code->name))
		{
			std::lock_guard lk(big::g_gml_safe_mutex);
			big::g_gml_safe_notifier.notify_all();
			big::g_gml_safe = true;
		}

		is_inside_code_execute = false;
		return no_error;
	}
} // namespace gm
