#pragma once
#include "Code_Function_GET_the_function.hpp"
#include <string/string.hpp>
#include <lua/lua_manager.hpp>

namespace gm
{
	inline bool hook_Code_Execute(CInstance* self, CInstance* other, CCode* code, RValue* result, int flags)
	{
		if (!big::g_gml_safe && !strcmp(code->name, "gml_Object_oLoadScreen_Step_0"))
		{
		big::g_gml_safe = true;
		}

		if (big::g_lua_manager)
			big::g_lua_manager->pre_code_execute(self, other, code, result, flags);

		const auto res = big::g_hooking->get_original<hook_Code_Execute>()(self, other, code, result, flags);

		if (big::g_lua_manager)
			big::g_lua_manager->post_code_execute(self, other, code, result, flags);

		return res;
	}
}
