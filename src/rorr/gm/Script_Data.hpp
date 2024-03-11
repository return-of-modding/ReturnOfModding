#pragma once
#include <string/hash.hpp>

struct CScript;

namespace gm
{
	inline std::unordered_map<std::string, int, big::string::transparent_string_hash, std::equal_to<>> script_asset_cache;

	using Script_Data_t = CScript* (*)(int script_function_index);
} // namespace gm
