#pragma once
#include "GetSaveFileName_t.hpp"

namespace gm
{
	inline RValue* hook_save_file_serialize(CInstance* a1, CInstance* a2, RValue* a3, int a4, RValue** a5)
	{
		auto res = big::g_hooking->get_original<hook_save_file_serialize>()(a1, a2, a3, a4, a5);

		try
		{
			nlohmann::json save_file = nlohmann::json::parse(res->asString());

			// Game will hard crash on char select screen if it's a non vanilla difficulty that get saved to user save file.
			if (save_file.contains("lobby_votes") && save_file["lobby_votes"].contains("d"))
			{
				if (save_file["lobby_votes"]["d"].is_number())
				{
					const auto selected_difficulty = save_file["lobby_votes"]["d"].get<int>();
					if (selected_difficulty < 0 || selected_difficulty > 2)
					{
						save_file["lobby_votes"]["d"] = 1;
					}
				}
				else
				{
					save_file["lobby_votes"]["d"] = 1;
				}
			}

			// Game will hard crash on char select screen if it's a non vanilla character that was last selected get saved to user save file.
			if (save_file.contains("survivor_choice"))
			{
				if (save_file["survivor_choice"].is_string())
				{
					const auto selected_survivor = save_file["survivor_choice"].get<std::string>();

					// TODO: This is bad check, assumes that modders will never use the ror namespace for their custom survivors.
					if (!selected_survivor.starts_with("ror-"))
					{
						save_file["survivor_choice"] = "ror-commando";
					}
				}
				else
				{
					save_file["survivor_choice"] = "ror-commando";
				}
			}

			// TODO: loadout_choice bound checking

			*res = save_file.dump();
		}
		catch (const std::exception& e)
		{
			LOG(WARNING) << "Failed save file serialize check: " << e.what();
		}
		catch (...)
		{
			LOG(WARNING) << "Unknown exception while trying to check user save file";
		}

		return res;
	}
} // namespace gm
