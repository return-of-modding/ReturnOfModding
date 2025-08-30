#pragma once
#include "GetSaveFileName_t.hpp"

namespace gm
{
	inline void fix_save(RValue* res)
	{
		if (!res->asString().contains("lobby_votes"))
		{
			return;
		}

		try
		{
			nlohmann::json save_file = nlohmann::json::parse(res->asString());

			// Game will hard crash on char select screen if it's a non vanilla difficulty that get saved to user save file.
			auto lobby_vote_fix = [](nlohmann::json& save_file, const char* lobby_vote_id)
			{
				constexpr auto difficulty_key = "d";

				if (save_file.contains(lobby_vote_id) && save_file[lobby_vote_id].contains(difficulty_key))
				{
					if (save_file[lobby_vote_id][difficulty_key].is_number())
					{
						const auto selected_difficulty = save_file[lobby_vote_id][difficulty_key].get<int>();
						if (selected_difficulty < 0 || selected_difficulty > 2)
						{
							save_file[lobby_vote_id][difficulty_key] = 1;
						}
					}
					else
					{
						save_file[lobby_vote_id][difficulty_key] = 1;
					}
				}
			};

			lobby_vote_fix(save_file, "lobby_votes");
			lobby_vote_fix(save_file, "lobby_votes_multi");

			// Game will hard crash on char select screen if it's a non vanilla character that was last selected get saved to user save file.
			constexpr auto last_selected_survivor_key = "survivor_choice";
			if (save_file.contains(last_selected_survivor_key))
			{
				if (save_file[last_selected_survivor_key].is_string())
				{
					const auto selected_survivor = save_file[last_selected_survivor_key].get<std::string>();

					// TODO: This is bad check, assumes that modders will never use the ror namespace for their custom survivors.
					if (!selected_survivor.starts_with("ror-"))
					{
						save_file[last_selected_survivor_key] = "ror-commando";
					}
				}
				else
				{
					save_file[last_selected_survivor_key] = "ror-commando";
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
	}

	inline RValue* hook_save_file_serialize(CInstance* a1, CInstance* a2, RValue* a3, int a4, RValue** a5)
	{
		auto res = big::g_hooking->get_original<hook_save_file_serialize>()(a1, a2, a3, a4, a5);

		fix_save(res);

		return res;
	}

	inline RValue* hook_save_file_deserialize(CInstance* a1, CInstance* a2, RValue* a3, int a4, RValue** a5)
	{
		const auto res = big::g_hooking->get_original<hook_save_file_deserialize>()(a1, a2, a3, a4, a5);

		return res;
	}

	inline void hook_json_parse(RValue* res, CInstance* a2, CInstance* a3, __int64 a4, RValue* arg)
	{
		fix_save(arg);

		big::g_hooking->get_original<hook_json_parse>()(res, a2, a3, a4, arg);
	}
} // namespace gm
