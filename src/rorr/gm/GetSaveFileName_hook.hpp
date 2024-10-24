#pragma once
#include "GetSaveFileName_t.hpp"

namespace gm
{
	// Don't allow creation of a multiplayer lobby
	// with "Allow Rule Voting" enabled, because custom difficulties will cause a hard crash otherwise.
	inline __int64 hook_gml_Script_host_commit_lobby_options(CInstance* a1, __int64 a2, __int64 a3)
	{
		gm::call("variable_global_set", std::to_array({RValue("HOST_OPT__enable_voting"), RValue(0.0)}));

		const auto res = big::g_hooking->get_original<hook_gml_Script_host_commit_lobby_options>()(a1, a2, a3);

		return res;
	}

	inline bool hook_GetSaveFileName(char* output_path, __int64 size_of_output_path, const char* input_path)
	{
		try
		{
			const auto file_path = std::filesystem::path(input_path);

			// Fix ReturnOfModding paths getting fucked by the game sandbox.
			if (strstr((char*)file_path.u8string().c_str(), "ReturnOfModding"))
			{
				strcpy(output_path, input_path);

				return 0;
			}
		}
		catch (const std::exception& e)
		{
			LOG(ERROR) << e.what();
		}
		catch (...)
		{
			LOG(ERROR) << "Unknown exception";
		}

		const auto res = big::g_hooking->get_original<hook_GetSaveFileName>()(output_path, size_of_output_path, input_path);

		return res;
	}
} // namespace gm
