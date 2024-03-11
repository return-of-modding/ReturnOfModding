#pragma once
#include "GetSaveFileName_t.hpp"

namespace gm
{
	inline bool hook_GetSaveFileName(char* output_path, __int64 size_of_output_path, const char* input_path)
	{
		const auto file_path = std::filesystem::path(input_path);

		// Fix ReturnOfModding paths getting fucked by the game sandbox.
		if (file_path.is_absolute() && file_path.native().contains(L"ReturnOfModding"))
		{
			strcpy(output_path, input_path);

			return 0;
		}

		const auto res = big::g_hooking->get_original<hook_GetSaveFileName>()(output_path, size_of_output_path, input_path);

		return res;
	}
} // namespace gm
