#pragma once
#include <string/hash.hpp>

struct CScript;

namespace gm
{
	using Script_Data_t = CScript* (*)(int script_function_index);
} // namespace gm
