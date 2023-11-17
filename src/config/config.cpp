#include "config.hpp"

namespace big
{
	void config::init(big::file file)
	{
		m_file = file;

		if (m_file.exists())
		{
			const auto file_path = m_file.get_path();
			const auto parse_file_result = toml::parse_file(file_path.c_str());
			if (parse_file_result.succeeded())
			{
				m_table = parse_file_result.table();
			}
			else
			{
				LOG(WARNING) << "Failed to read existing config file.";
			}
		}
	}

	void config::save_if_needed()
	{
		if (m_table != m_last_saved_table)
			save();
	}

	void config::save()
	{
		std::ofstream file_stream(m_file.get_path());
		if (file_stream.is_open())
		{
			file_stream << m_table;
		}
		else
		{
			LOG(WARNING) << "Failed to save config file.";
		}
	}
}