#pragma once

namespace big
{
	enum class load_module_result
	{
		FILE_MISSING,
		MISSING_DEPENDENCIES,
		ALREADY_LOADED,
		FAILED_TO_LOAD,
		SUCCESS
	};
}