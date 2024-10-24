#pragma once

namespace gm
{
	using GetSaveFileName_t = __int64 (*)(char *output_path, __int64 size_of_output_path, const char *input_path);

	using gml_Script_host_commit_lobby_options_t = __int64 (*)(CInstance *a1, __int64 a2, __int64 a3);
} // namespace gm
