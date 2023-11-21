#pragma once
#include "thunderstore/v1/manifest.hpp"

namespace big
{
	struct module_info
	{
		std::filesystem::path m_module_path{};
		std::string m_module_guid{};
		ts::v1::manifest m_manifest{};
	};
}