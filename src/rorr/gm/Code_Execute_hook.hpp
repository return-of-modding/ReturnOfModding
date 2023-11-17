#pragma once
#include "CDynamicArray.hpp"
#include "Code_Function_GET_the_function.hpp"
#include "RefThing.hpp"
#include <string/string.hpp>

namespace gm
{
	inline bool hook_Code_Execute(CInstance* self, CInstance* other, CCode* code, RValue* result, int flags)
	{
		// pre

		if (code->i_pName)
		{
			const auto code_name  = big::string::to_lower(code->i_pName);
		}

		const auto res = big::g_hooking->get_original<hook_Code_Execute>()(self, other, code, result, flags);

		// post

		return res;
	}
}
