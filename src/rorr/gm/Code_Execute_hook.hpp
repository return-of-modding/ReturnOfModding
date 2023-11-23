#pragma once
#include "Code_Function_GET_the_function.hpp"
#include <string/string.hpp>
#include <lua/lua_manager.hpp>

namespace gm
{
	inline bool hook_Code_Execute(CInstance* self, CInstance* other, CCode* code, RValue* result, int flags)
	{
		big::g_lua_manager->pre_code_execute(self, other, code, result, flags);

		const auto res = big::g_hooking->get_original<hook_Code_Execute>()(self, other, code, result, flags);

		big::g_lua_manager->post_code_execute(self, other, code, result, flags);

		return res;
	}
}
