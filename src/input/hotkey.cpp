#include "hotkey.hpp"

namespace big
{
	hotkey::hotkey(const std::string& name, int64_t default_vk)
	{
		if (!name.size())
		{
			LOG(FATAL) << "Invalid hotkey";
			*(int*)0xDE'AD = 0;
		}
		m_name       = name;
		m_default_vk = default_vk;

		hotkeys.insert({m_name, this});
	}

	hotkey::~hotkey()
	{
		hotkeys.erase(m_name);
	}

	int64_t& hotkey::vk()
	{
		return m_vk->ref<int64_t>();
	}

	void hotkey::init_hotkeys()
	{
		try
		{
			m_file_path = g_file_manager.get_project_folder("config").get_path() / m_file_name;
			if (std::filesystem::exists(m_file_path))
			{
				m_table = toml::parse_file(m_file_path.c_str());
			}
			m_last_saved_table = m_table;

			// Fill entries based on the serialized disk data if needed
			for (auto& hotkey_entry_pair : hotkeys)
			{
				const auto& hotkey_entry = hotkey_entry_pair.second;

				const auto hotkey_entry_doesnt_exist = !m_table.contains(hotkey_entry->m_name);
				if (hotkey_entry_doesnt_exist)
				{
					m_table.insert_or_assign(hotkey_entry->m_name, hotkey_entry->m_default_vk);
				}

				hotkey_entry->m_vk = m_table.get(hotkey_entry->m_name);
				if (hotkey_entry->m_vk == nullptr)
				{
					LOG(FATAL) << "what";
				}

				if (hotkey_entry->m_vk == nullptr || hotkey_entry->m_vk->type() != toml::node_type::integer)
				{
					LOG(WARNING) << "Invalid serialized data. Clearing " << hotkey_entry->m_name << " hotkey";

					m_table.insert_or_assign(hotkey_entry->m_name, hotkey_entry->m_default_vk);
					hotkey_entry->m_vk = m_table.get(hotkey_entry->m_name);
					if (hotkey_entry->m_vk == nullptr)
					{
						LOG(FATAL) << "what2";
					}
				}
			}

			save_hotkeys_if_needed();
		}
		catch (const std::exception& e)
		{
			LOG(INFO) << "Failed init hotkeys: " << e.what();
		}
	}

	void hotkey::save_hotkeys_if_needed()
	{
		if (m_table != m_last_saved_table)
		{
			LOG(INFO) << "table was different, saving";
			save_hotkeys();
		}
	}

	void hotkey::save_hotkeys()
	{
		std::ofstream file_stream(m_file_path, std::ios::out | std::ios::trunc);
		if (file_stream.is_open())
		{
			file_stream << m_table;

			m_last_saved_table = m_table;
		}
		else
		{
			LOG(WARNING) << "Failed to save hotkeys.";
		}
	}

} // namespace big
