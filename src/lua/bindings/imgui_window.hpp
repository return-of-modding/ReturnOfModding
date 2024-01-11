#pragma once

#include "toml.hpp"

namespace lua::window
{
	// mod guid -> window name -> is the window open
	inline std::unordered_map<std::string, std::unordered_map<std::string, bool>> is_open;

	inline void serialize(const std::unordered_map<std::string, std::unordered_map<std::string, bool>>& data, const std::filesystem::path& filename)
	{
		try
		{
			std::ofstream ofs(filename);
			if (ofs.is_open())
			{
				toml::table output_table;

				for (const auto& [mod_guid, window_states] : data)
				{
					output_table.emplace(mod_guid, toml::table());
					auto window_states_table = output_table.get_as<toml::table>(mod_guid);

					for (const auto& [window_name, is_open] : window_states)
					{
						window_states_table->emplace(window_name, is_open);
					}
				}

				ofs << output_table;

				ofs.close();
				LOG(INFO) << "Serialization successful.";
			}
			else
			{
				LOG(WARNING) << "Error: Unable to open lua::window file for serialization.";
			}
		}
		catch (const std::exception& e)
		{
			LOG(INFO) << "Failed serialize window states.";
		}
	}

	inline void deserialize(std::unordered_map<std::string, std::unordered_map<std::string, bool>>& data, const std::filesystem::path& filename)
	{
		try
		{
			auto config = toml::parse_file(filename.c_str());

			for (const auto& [mod_guid, window_states] : config)
			{
				if (window_states.is_table())
				{
					for (const auto& [window_name, is_open] : *window_states.as_table())
					{
						if (is_open.is_boolean())
						{
							data[mod_guid.str().data()][window_name.str().data()] = is_open.as_boolean()->get();
						}
						else
						{
							LOG(WARNING) << "is_open wasnt a bool";
						}
					}
				}
				else
				{
					LOG(WARNING) << "window_states wasnt a table";
				}
			}
		}
		catch (const std::exception& e)
		{
			LOG(INFO) << "Failed deserialize window states.";
		}
	}
}