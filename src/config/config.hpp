#pragma once

#include "config/config_entry.hpp"

#include <toml++/toml.hpp>

namespace big
{
	struct config
	{
		big::file m_file;

		toml::table m_table;
		toml::table m_last_saved_table;

		void init(big::file file);

		template<typename T>
		void add(config_entry<T>& cfg_entry)
		{
			if (!cfg_entry.m_save_on_disk)
			{
				return;
			}

			auto config_category = m_table[cfg_entry.m_config_category_name];

			// Create the category if needed.
			const auto config_category_doesnt_exist = !config_category.is_table();
			if (config_category_doesnt_exist)
			{
				m_table.insert_or_assign(cfg_entry.m_config_category_name, toml::table{});
				config_category = m_table[cfg_entry.m_config_category_name];
			}

			// Create the config entry inside the category if needed.
			const auto config_value_doesnt_exist = !config_category.as_table()->contains(cfg_entry.m_config_entry_name);
			if (config_value_doesnt_exist)
			{
				config_category.as_table()->insert_or_assign(cfg_entry.m_config_entry_name, *cfg_entry.m_value->as<T>());
			}

			cfg_entry.m_value = config_category.as_table()->get_as<T>(cfg_entry.m_config_entry_name);
		}

		void save_if_needed();
		void save();
	};

	inline config g_config{};
}