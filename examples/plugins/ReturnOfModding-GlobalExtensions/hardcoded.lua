return {

	script = {
		["LogbookEnvironmentDisplay"] = {
			source = 'scr_logbook_environment_display',
			line = 2,
			constructor = true,
			base = nil,
			params = {}
		},
		["draw"] = {
			source = 'scr_logbook_environment_display',
			line = 157,
			constructor = false,
			base = nil,
			params = {
				{ name = 'view_x' },
				{ name = 'view_y' },
				{ name = 'view_w' },
				{ name = 'view_h' },
				{ name = 'bg_view_x' },
				{ name = 'bg_view_y' },
				{ name = 'bg_view_w' },
				{ name = 'bg_view_h' },
				{ name = 'bg_offs_x' },
				{ name = 'bg_offs_y' },
			}
		},
		["_dbg_draw"] = {
			source = 'scr_logbook_environment_display',
			line = 163,
			constructor = false,
			base = nil,
			params = {
				{ name = 'view_x' },
				{ name = 'view_y' },
				{ name = 'view_w' },
				{ name = 'view_h' },
				{ name = 'bg_view_x' },
				{ name = 'bg_view_y' },
				{ name = 'bg_view_w' },
				{ name = 'bg_view_h' },
				{ name = 'bg_offs_x' },
				{ name = 'bg_offs_y' },
			}
		},
		["__net_packet_client_process_attack_local_write__"] = {
			source = 'scr_network_packets_client_process_attack',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = 'attack_info' },
				{ name = 'hit_list' },
				{ name = 'max_index' },
			}
		},
		["__net_packet_client_process_attack_local_read__"] = {
			source = 'scr_network_packets_client_process_attack',
			line = 75,
			constructor = false,
			base = nil,
			params = {}
		},
		["__draw_layout_clear"] = {
			source = 'scr_draw_layout',
			line = 11,
			constructor = false,
			base = nil,
			params = {}
		},
		["draw_layout_create"] = {
			source = 'scr_draw_layout',
			line = 50,
			constructor = false,
			base = nil,
			params = {}
		},
		["draw_layout_destroy"] = {
			source = 'scr_draw_layout',
			line = 56,
			constructor = false,
			base = nil,
			params = {
				{ name = 'dl' },
			}
		},
		["draw_layout_merge"] = {
			source = 'scr_draw_layout',
			line = 72,
			constructor = false,
			base = nil,
			params = {
				{ name = 'from' },
				{ name = 'to' },
			}
		},
		["draw_layout_end"] = {
			source = 'scr_draw_layout',
			line = 88,
			constructor = false,
			base = nil,
			params = {
				{ name = 'dl' },
			}
		},
		["_draw_layout_end_current_element"] = {
			source = 'scr_draw_layout',
			line = 96,
			constructor = false,
			base = nil,
			params = {
				{ name = 'dl' },
			}
		},
		["_draw_layout_prepare_vb"] = {
			source = 'scr_draw_layout',
			line = 104,
			constructor = false,
			base = nil,
			params = {
				{ name = 'dl' },
				{ name = 'tex' },
				{ name = 'tpage_id' },
			}
		},
		["draw_layout_sprite"] = {
			source = 'scr_draw_layout',
			line = 127,
			constructor = false,
			base = nil,
			params = {
				{ name = 'dl' },
				{ name = 'spr' },
				{ name = 'sub' },
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'xscale', value = [=[1]=] },
				{ name = 'yscale', value = [=[1]=] },
				{ name = 'col', value = [=[c_white]=] },
				{ name = 'alpha', value = [=[1]=] },
			}
		},
		["draw_layout_text"] = {
			source = 'scr_draw_layout',
			line = 177,
			constructor = false,
			base = nil,
			params = {
				{ name = 'dl' },
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'str' },
			}
		},
		["draw_layout_scribble"] = {
			source = 'scr_draw_layout',
			line = 264,
			constructor = false,
			base = nil,
			params = {
				{ name = 'dl' },
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'elem' },
			}
		},
		["draw_layout_function"] = {
			source = 'scr_draw_layout',
			line = 274,
			constructor = false,
			base = nil,
			params = {
				{ name = 'dl' },
				{ name = 'mthd' },
			}
		},
		["draw_layout_submit"] = {
			source = 'scr_draw_layout',
			line = 280,
			constructor = false,
			base = nil,
			params = {
				{ name = 'dl' },
				{ name = 'override_view_mat', value = [=[false]=] },
			}
		},
		["control_swap_pressed"] = {
			source = 'control_swap_pressed',
			line = 4,
			constructor = false,
			base = nil,
			params = {}
		},
		["_trials_json_script_clear_execution_state"] = {
			source = 'trials_json_script_execute',
			line = 7,
			constructor = false,
			base = nil,
			params = {}
		},
		["trials_json_script_clear_script_variables"] = {
			source = 'trials_json_script_execute',
			line = 14,
			constructor = false,
			base = nil,
			params = {}
		},
		["trials_json_script_wrap"] = {
			source = 'trials_json_script_execute',
			line = 23,
			constructor = false,
			base = nil,
			params = {
				{ name = 'arr' },
			}
		},
		["trials_json_script_execute"] = {
			source = 'trials_json_script_execute',
			line = 36,
			constructor = false,
			base = nil,
			params = {
				{ name = 'arr' },
				{ name = 'arg', value = [=[undefined]=] },
			}
		},
		["_trials_json_script_execute_internal"] = {
			source = 'trials_json_script_execute',
			line = 42,
			constructor = false,
			base = nil,
			params = {
				{ name = 'arr' },
			}
		},
		["_trials_json_script_command_execute"] = {
			source = 'trials_json_script_execute',
			line = 48,
			constructor = false,
			base = nil,
			params = {
				{ name = 'command' },
			}
		},
		["_trials_json_script_command_find_instance"] = {
			source = 'trials_json_script_execute',
			line = 571,
			constructor = false,
			base = nil,
			params = {
				{ name = 'target' },
			}
		},
		["_survivor_arti_inflict_flame_dot"] = {
			source = 'scr_ror_init_survivor_artificer',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'parent' },
				{ name = 'ttarget' },
			}
		},
		["_survivor_drifter_find_scrap_bar"] = {
			source = 'scr_ror_init_survivor_Drifter',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = 'parent' },
			}
		},
		["_survivor_drifter_scrap_add"] = {
			source = 'scr_ror_init_survivor_Drifter',
			line = 15,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
				{ name = 'amount' },
			}
		},
		["__rpc_survivor_drifter_scrap_add_implementation__"] = {
			source = 'scr_ror_init_survivor_Drifter',
			line = 27,
			constructor = false,
			base = nil,
			params = {
				{ name = 'target' },
				{ name = 'amount' },
			}
		},
		["_survivor_drifter_scrap_set"] = {
			source = 'scr_ror_init_survivor_Drifter',
			line = 34,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
				{ name = 'amount' },
			}
		},
		["_survivor_drifter_scrap_get"] = {
			source = 'scr_ror_init_survivor_Drifter',
			line = 40,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
			}
		},
		["__rpc_survivor_drifter_scrap_sync_implementation__"] = {
			source = 'scr_ror_init_survivor_Drifter',
			line = 48,
			constructor = false,
			base = nil,
			params = {
				{ name = 'target' },
				{ name = 'amount' },
			}
		},
		["_survivor_drifter_scrap_sync"] = {
			source = 'scr_ror_init_survivor_Drifter',
			line = 52,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
			}
		},
		["_survivor_drifter_create_scrap_bar"] = {
			source = 'scr_ror_init_survivor_Drifter',
			line = 62,
			constructor = false,
			base = nil,
			params = {}
		},
		["team_canhit"] = {
			source = 'scr_team',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = 'attacking_team' },
				{ name = 'target_team' },
			}
		},
		["team_get_name"] = {
			source = 'scr_team',
			line = 14,
			constructor = false,
			base = nil,
			params = {
				{ name = 'team' },
			}
		},
		["skill_util_fix_hspeed"] = {
			source = 'scr_actor_skill_util',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["skill_util_exit_state_on_anim_end"] = {
			source = 'scr_actor_skill_util',
			line = 65,
			constructor = false,
			base = nil,
			params = {}
		},
		["skill_util_reset_activity_state"] = {
			source = 'scr_actor_skill_util',
			line = 78,
			constructor = false,
			base = nil,
			params = {}
		},
		["skill_util_apply_friction"] = {
			source = 'scr_actor_skill_util',
			line = 90,
			constructor = false,
			base = nil,
			params = {}
		},
		["skill_util_facing_direction"] = {
			source = 'scr_actor_skill_util',
			line = 96,
			constructor = false,
			base = nil,
			params = {}
		},
		["skill_util_lock_cooldown"] = {
			source = 'scr_actor_skill_util',
			line = 102,
			constructor = false,
			base = nil,
			params = {
				{ name = 'skill_id' },
			}
		},
		["skill_util_unlock_cooldown"] = {
			source = 'scr_actor_skill_util',
			line = 108,
			constructor = false,
			base = nil,
			params = {
				{ name = 'skill_id' },
			}
		},
		["skill_util_update_heaven_cracker"] = {
			source = 'scr_actor_skill_util',
			line = 115,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'damage_co' },
				{ name = 'xscale', value = [=[image_xscale]=] },
				{ name = 'flags', value = [=[0]=] },
			}
		},
		["skill_util_update_free"] = {
			source = 'scr_actor_skill_util',
			line = 142,
			constructor = false,
			base = nil,
			params = {}
		},
		["skill_util_nudge_forward"] = {
			source = 'scr_actor_skill_util',
			line = 146,
			constructor = false,
			base = nil,
			params = {
				{ name = 'dist' },
			}
		},
		["survivor_util_init_half_sprites"] = {
			source = 'scr_actor_skill_util',
			line = 153,
			constructor = false,
			base = nil,
			params = {}
		},
		["skill_util_strafe_init"] = {
			source = 'scr_actor_skill_util',
			line = 163,
			constructor = false,
			base = nil,
			params = {}
		},
		["skill_util_strafe_update"] = {
			source = 'scr_actor_skill_util',
			line = 176,
			constructor = false,
			base = nil,
			params = {
				{ name = 'anim_speed' },
				{ name = 'move_speed_modifier', value = [=[STRAFE_SPEED_NORMAL]=] },
			}
		},
		["skill_util_strafe_exit"] = {
			source = 'scr_actor_skill_util',
			line = 202,
			constructor = false,
			base = nil,
			params = {}
		},
		["skill_util_strafe_and_slide"] = {
			source = 'scr_actor_skill_util',
			line = 208,
			constructor = false,
			base = nil,
			params = {
				{ name = 'move_speed_modifier', value = [=[STRAFE_SPEED_SLOW]=] },
			}
		},
		["skill_util_strafe_and_slide_init"] = {
			source = 'scr_actor_skill_util',
			line = 218,
			constructor = false,
			base = nil,
			params = {}
		},
		["skill_util_set_strafe_sprites"] = {
			source = 'scr_actor_skill_util',
			line = 222,
			constructor = false,
			base = nil,
			params = {}
		},
		["skill_util_step_strafe_sprites"] = {
			source = 'scr_actor_skill_util',
			line = 243,
			constructor = false,
			base = nil,
			params = {}
		},
		["skill_util_strafe_turn_init"] = {
			source = 'scr_actor_skill_util',
			line = 262,
			constructor = false,
			base = nil,
			params = {}
		},
		["skill_util_strafe_turn_update"] = {
			source = 'scr_actor_skill_util',
			line = 268,
			constructor = false,
			base = nil,
			params = {
				{ name = 'strafe_and_slide', value = [=[false]=] },
			}
		},
		["skill_util_check_turnaround"] = {
			source = 'scr_actor_skill_util',
			line = 288,
			constructor = false,
			base = nil,
			params = {}
		},
		["skill_util_strafe_turn_turn_if_direction_changed"] = {
			source = 'scr_actor_skill_util',
			line = 311,
			constructor = false,
			base = nil,
			params = {
				{ name = 'set_xscale', value = [=[true]=] },
			}
		},
		["skill_util_authority_get_aim_direction"] = {
			source = 'scr_actor_skill_util',
			line = 319,
			constructor = false,
			base = nil,
			params = {}
		},
		["_effectdisplay_medallion_draw_script_above"] = {
			source = 'scr_ror_init_buffs',
			line = 1054,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'draw_x' },
				{ name = 'draw_y' },
			}
		},
		["_buff_medallion_init_display"] = {
			source = 'scr_ror_init_buffs',
			line = 1066,
			constructor = false,
			base = nil,
			params = {}
		},
		["actor_set_kill_cause"] = {
			source = 'actor_set_kill_cause',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'sprite' },
				{ name = 'name' },
				{ name = 'name_is_token', value = [=[true]=] },
			}
		},
		["__lf_oEnforcerGrenadePrimary_create_deserialize"] = {
			source = '__lf_oEnforcerGrenadePrimary_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["_survivor_bandit_target"] = {
			source = 'scr_ror_init_survivor_bandit',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
			}
		},
		["_survivor_loader_primary_fire"] = {
			source = 'scr_ror_init_survivor_loader',
			line = 27,
			constructor = false,
			base = nil,
			params = {
				{ name = 'is_final', value = [=[false]=] },
			}
		},
		["_survivor_loader_primary_continue_combo"] = {
			source = 'scr_ror_init_survivor_loader',
			line = 51,
			constructor = false,
			base = nil,
			params = {
				{ name = 'data' },
				{ name = 'next_state' },
			}
		},
		["_survivor_loader_utility_fire_state_update"] = {
			source = 'scr_ror_init_survivor_loader',
			line = 81,
			constructor = false,
			base = nil,
			params = {
				{ name = 'data' },
				{ name = 'anim' },
				{ name = 'up' },
			}
		},
		["skill_system_init"] = {
			source = 'scr_skill_system',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["_skill_system_update_skill_used"] = {
			source = 'scr_skill_system',
			line = 24,
			constructor = false,
			base = nil,
			params = {
				{ name = 'i' },
			}
		},
		["skill_system_update"] = {
			source = 'scr_skill_system',
			line = 80,
			constructor = false,
			base = nil,
			params = {}
		},
		["skill_index_to_verb"] = {
			source = 'scr_actor_skills',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = 'index' },
			}
		},
		["actor_skill_set"] = {
			source = 'scr_actor_skills',
			line = 21,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'index' },
				{ name = 'skill_id' },
			}
		},
		["actor_skill_get_cooldown"] = {
			source = 'scr_actor_skills',
			line = 28,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'index' },
			}
		},
		["actor_skill_reset_cooldowns"] = {
			source = 'scr_actor_skills',
			line = 37,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'value', value = [=[0]=] },
				{ name = 'relative', value = [=[false]=] },
				{ name = 'ignore_cancel_frame', value = [=[false]=] },
				{ name = 'network', value = [=[false]=] },
			}
		},
		["actor_skill_reset_stocks"] = {
			source = 'scr_actor_skills',
			line = 64,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
			}
		},
		["actor_skill_get_all_equipped_skills"] = {
			source = 'scr_actor_skills',
			line = 76,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
			}
		},
		["actor_skill_add_stock_networked"] = {
			source = 'scr_actor_skills',
			line = 89,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'index' },
				{ name = 'ignore_stock_cap', value = [=[false]=] },
				{ name = 'raw', value = [=[false]=] },
			}
		},
		["actor_skill_add_stock"] = {
			source = 'scr_actor_skills',
			line = 98,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'index' },
				{ name = 'ignore_stock_cap', value = [=[false]=] },
				{ name = 'raw', value = [=[false]=] },
			}
		},
		["ActorSkillSlot"] = {
			source = 'scr_actor_skills',
			line = 133,
			constructor = true,
			base = nil,
			params = {
				{ name = 'parent' },
				{ name = 'default_skill' },
				{ name = 'slot_index' },
			}
		},
		["ActorSkillOverride"] = {
			source = 'scr_actor_skills',
			line = 214,
			constructor = true,
			base = nil,
			params = {
				{ name = 'skill' },
				{ name = 'priority' },
			}
		},
		["ActorSkill"] = {
			source = 'scr_actor_skills',
			line = 219,
			constructor = true,
			base = nil,
			params = {
				{ name = 'parent' },
				{ name = 'skill_id' },
				{ name = 'slot_index' },
			}
		},
		["actor_get_skill_active"] = {
			source = 'scr_actor_skills',
			line = 402,
			constructor = false,
			base = nil,
			params = {
				{ name = 'index' },
			}
		},
		["actor_get_skill_slot"] = {
			source = 'scr_actor_skills',
			line = 405,
			constructor = false,
			base = nil,
			params = {
				{ name = 'index' },
			}
		},
		["actor_find_skill"] = {
			source = 'scr_actor_skills',
			line = 411,
			constructor = false,
			base = nil,
			params = {
				{ name = 'skill' },
			}
		},
		["actor_find_skill_fallback"] = {
			source = 'scr_actor_skills',
			line = 418,
			constructor = false,
			base = nil,
			params = {
				{ name = 'skill1' },
				{ name = 'skill2' },
			}
		},
		["actor_remove_skill_override"] = {
			source = 'scr_actor_skills',
			line = 422,
			constructor = false,
			base = nil,
			params = {
				{ name = 'override' },
			}
		},
		["actor_get_skill_animation"] = {
			source = 'scr_actor_skills',
			line = 429,
			constructor = false,
			base = nil,
			params = {
				{ name = 'skill_id' },
				{ name = 'animation_index', value = [=[0]=] },
			}
		},
		["_mod_ActorSkill_recalculateStats"] = {
			source = 'scr_actor_skills',
			line = 437,
			constructor = false,
			base = nil,
			params = {
				{ name = 'skill' },
			}
		},
		["_mod_ActorSkill_getSlotIndex"] = {
			source = 'scr_actor_skills',
			line = 438,
			constructor = false,
			base = nil,
			params = {
				{ name = 'skill' },
			}
		},
		["_mod_ActorSkill_getSkill"] = {
			source = 'scr_actor_skills',
			line = 439,
			constructor = false,
			base = nil,
			params = {
				{ name = 'skill' },
			}
		},
		["_mod_ActorSkill_getParent"] = {
			source = 'scr_actor_skills',
			line = 440,
			constructor = false,
			base = nil,
			params = {
				{ name = 'skill' },
			}
		},
		["_mod_ActorSkillSlot_getActiveSkill"] = {
			source = 'scr_actor_skills',
			line = 442,
			constructor = false,
			base = nil,
			params = {
				{ name = 'slot' },
			}
		},
		["_mod_ActorSkillSlot_getDefaultSkill"] = {
			source = 'scr_actor_skills',
			line = 443,
			constructor = false,
			base = nil,
			params = {
				{ name = 'slot' },
			}
		},
		["_mod_ActorSkillSlot_getSlotIndex"] = {
			source = 'scr_actor_skills',
			line = 444,
			constructor = false,
			base = nil,
			params = {
				{ name = 'slot' },
			}
		},
		["_mod_ActorSkillSlot_getParent"] = {
			source = 'scr_actor_skills',
			line = 445,
			constructor = false,
			base = nil,
			params = {
				{ name = 'slot' },
			}
		},
		["_mod_ActorSkillSlot_getOverrides"] = {
			source = 'scr_actor_skills',
			line = 446,
			constructor = false,
			base = nil,
			params = {
				{ name = 'slot' },
			}
		},
		["_mod_ActorSkillSlot_addOverride"] = {
			source = 'scr_actor_skills',
			line = 447,
			constructor = false,
			base = nil,
			params = {
				{ name = 'slot' },
				{ name = 'skill_id' },
				{ name = 'priority' },
			}
		},
		["_mod_ActorSkillSlot_removeOverride"] = {
			source = 'scr_actor_skills',
			line = 448,
			constructor = false,
			base = nil,
			params = {
				{ name = 'slot' },
				{ name = 'skill_id' },
				{ name = 'priority' },
			}
		},
		["_mod_ActorSkillOverride_getPriority"] = {
			source = 'scr_actor_skills',
			line = 450,
			constructor = false,
			base = nil,
			params = {
				{ name = 'override' },
			}
		},
		["_mod_ActorSkillOverride_getSkill"] = {
			source = 'scr_actor_skills',
			line = 451,
			constructor = false,
			base = nil,
			params = {
				{ name = 'override' },
			}
		},
		["actor_activity_set"] = {
			source = 'actor_activity_set',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = '_activity' },
				{ name = '_activity_type', value = [=[0]=] },
				{ name = '_handler_lua', value = [=[-1]=] },
				{ name = '_handler_gml', value = [=[-1]=] },
				{ name = '_auto_end', value = [=[false]=] },
			}
		},
		["actor_get_blue_temp_item_duration"] = {
			source = 'scr_tempItems',
			line = 15,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
			}
		},
		["TempItemStack"] = {
			source = 'scr_tempItems',
			line = 20,
			constructor = true,
			base = nil,
			params = {
				{ name = 'item_id' },
				{ name = 'stack_blue' },
				{ name = 'stack_red' },
				{ name = 'initial_duration_if_blue', value = [=[undefined]=] },
			}
		},
		["step_temp_items"] = {
			source = 'scr_tempItems',
			line = 30,
			constructor = false,
			base = nil,
			params = {}
		},
		["temp_item_remove_if_expired"] = {
			source = 'scr_tempItems',
			line = 51,
			constructor = false,
			base = nil,
			params = {
				{ name = 'item_id' },
			}
		},
		["__temp_item_duration_completed_internal"] = {
			source = 'scr_tempItems',
			line = 62,
			constructor = false,
			base = nil,
			params = {
				{ name = 'i' },
			}
		},
		["__rpc_drifter_cube_push_implementation__"] = {
			source = 'scr_ror_init_survivor_Drifter_alts',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'cube' },
				{ name = 'xspeed' },
				{ name = 'x_for_sync' },
				{ name = 'y_for_sync' },
			}
		},
		["_survivor_drifter_push_cube"] = {
			source = 'scr_ror_init_survivor_Drifter_alts',
			line = 14,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'x2' },
				{ name = 'y2' },
				{ name = 'force' },
				{ name = 'center' },
			}
		},
		["_survivor_drifter_eat_cube"] = {
			source = 'scr_ror_init_survivor_Drifter_alts',
			line = 32,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'x2' },
				{ name = 'y2' },
			}
		},
		["_survivor_drifter_v_alt_find_target_item"] = {
			source = 'scr_ror_init_survivor_Drifter_alts',
			line = 56,
			constructor = false,
			base = nil,
			params = {
				{ name = 'tx' },
				{ name = 'ty' },
				{ name = 'range' },
			}
		},
		["_survivor_drifter_v2_windup_state_update"] = {
			source = 'scr_ror_init_survivor_Drifter_alts',
			line = 260,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
				{ name = 'data,' },
			}
		},
		["_survivor_drifter_v2_windup_state_serialize"] = {
			source = 'scr_ror_init_survivor_Drifter_alts',
			line = 280,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
				{ name = 'data' },
			}
		},
		["_survivor_drifter_v2_windup_state_deserialize"] = {
			source = 'scr_ror_init_survivor_Drifter_alts',
			line = 292,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
				{ name = 'data' },
			}
		},
		["_survivor_drifter_v2_fire_state_start"] = {
			source = 'scr_ror_init_survivor_Drifter_alts',
			line = 304,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
				{ name = 'data' },
			}
		},
		["_survivor_drifter_v2_fire_state_update"] = {
			source = 'scr_ror_init_survivor_Drifter_alts',
			line = 311,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
				{ name = 'data,' },
			}
		},
		["_survivor_drifter_v2_on_can_activate"] = {
			source = 'scr_ror_init_survivor_Drifter_alts',
			line = 364,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
			}
		},
		["_survivor_pilot_primary_fire"] = {
			source = 'scr_ror_init_survivor_pilot',
			line = 32,
			constructor = false,
			base = nil,
			params = {
				{ name = 'is_final', value = [=[false]=] },
			}
		},
		["_survivor_pilot_find_target"] = {
			source = 'scr_ror_init_survivor_pilot',
			line = 57,
			constructor = false,
			base = nil,
			params = {
				{ name = 'maxDistance,range,air' },
			}
		},
		["__rpc_survivor_pilot_spawn_bullet_tracer_implementation__"] = {
			source = 'scr_ror_init_survivor_pilot',
			line = 89,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'dir' },
			}
		},
		["_survivor_pilot_special_state_step"] = {
			source = 'scr_ror_init_survivor_pilot',
			line = 99,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
				{ name = 'data' },
				{ name = 'boosted' },
			}
		},
		["fire_explosion"] = {
			source = 'fire_explosion',
			line = 11,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
				{ name = 'argument5' },
				{ name = 'argument6' },
				{ name = 'argument7' },
				{ name = 'argument8' },
			}
		},
		["fire_explosion_local"] = {
			source = 'fire_explosion',
			line = 50,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
				{ name = 'argument5' },
				{ name = 'argument6' },
				{ name = 'argument7' },
			}
		},
		["AttackInfo"] = {
			source = 'damager_init_properties',
			line = 1,
			constructor = true,
			base = nil,
			params = {}
		},
		["attack_get_knockback_direction"] = {
			source = 'damager_init_properties',
			line = 47,
			constructor = false,
			base = nil,
			params = {
				{ name = 'attack' },
				{ name = 'hit' },
			}
		},
		["HitInfo"] = {
			source = 'damager_init_properties',
			line = 52,
			constructor = true,
			base = nil,
			params = {}
		},
		["TracerKindInfo"] = {
			source = 'damager_init_properties',
			line = 162,
			constructor = true,
			base = nil,
			params = {
				{ name = 'consistent_sparks_flip', value = [=[false]=] },
				{ name = 'show_sparks_if_miss', value = [=[true]=] },
				{ name = 'sparks_offset_y', value = [=[0]=] },
				{ name = 'show_end_sparks_on_piercing_hit', value = [=[false]=] },
				{ name = 'override_sparks_miss', value = [=[-1]=] },
				{ name = 'override_sparks_solid', value = [=[-1]=] },
				{ name = 'draw_tracer', value = [=[true]=] },
			}
		},
		["_mod_damager_get_attackInfo"] = {
			source = 'damager_init_properties',
			line = 227,
			constructor = false,
			base = nil,
			params = {
				{ name = 'd' },
			}
		},
		["damager_init_properties"] = {
			source = 'damager_init_properties',
			line = 229,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_HitInfo_getAttackInfo"] = {
			source = 'damager_init_properties',
			line = 244,
			constructor = false,
			base = nil,
			params = {
				{ name = 'h' },
			}
		},
		["damager_attack_process"] = {
			source = 'damager_attack_process',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'attack_info' },
				{ name = 'hit_list' },
				{ name = 'max_index' },
				{ name = 'is_attack_authority' },
				{ name = 'handle_only_local_collisions', value = [=[false]=] },
			}
		},
		["hit_should_count_towards_total_hit_number_client_and_server"] = {
			source = 'damager_attack_process',
			line = 485,
			constructor = false,
			base = nil,
			params = {
				{ name = 'hit' },
			}
		},
		["_proc_missile_queue_for_actor"] = {
			source = 'damager_proc_onhitactor',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'count' },
				{ name = 'tdamage' },
				{ name = 'tjelly', value = [=[0]=] },
			}
		},
		["damager_proc_onhitactor"] = {
			source = 'damager_proc_onhitactor',
			line = 26,
			constructor = false,
			base = nil,
			params = {
				{ name = 'hit_info' },
				{ name = 'rng' },
				{ name = 'is_attack_authority' },
			}
		},
		["damager_proc_onaoe"] = {
			source = 'damager_proc_onaoe',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'attack_info' },
				{ name = 'hit_x' },
				{ name = 'hit_y' },
			}
		},
		["_item_proc_behemoth"] = {
			source = 'damager_proc_onaoe',
			line = 25,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
			}
		},
		["__rpc_item_proc_behemoth_implementation__"] = {
			source = 'damager_proc_onaoe',
			line = 34,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
			}
		},
		["damager_proc_onaoe___attack_authority"] = {
			source = 'damager_proc_onaoe',
			line = 39,
			constructor = false,
			base = nil,
			params = {
				{ name = 'attack_info' },
				{ name = 'hit_x' },
				{ name = 'hit_y' },
				{ name = 'handle_only_local_collisions', value = [=[false]=] },
			}
		},
		["attackinfo_create"] = {
			source = 'attackinfo_create',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'attack_type' },
				{ name = 'proc_type' },
				{ name = 'team' },
				{ name = 'damage_co' },
				{ name = 'crit' },
				{ name = 'a_x' },
				{ name = 'a_y' },
				{ name = 'a_direction' },
				{ name = 'hit_effect' },
			}
		},
		["attack_get_hit_seed"] = {
			source = 'attackinfo_create',
			line = 57,
			constructor = false,
			base = nil,
			params = {
				{ name = 'base_seed' },
				{ name = 'i' },
			}
		},
		["step_player"] = {
			source = 'step_player',
			line = 8,
			constructor = false,
			base = nil,
			params = {}
		},
		["_player_aim_init"] = {
			source = 'step_player',
			line = 410,
			constructor = false,
			base = nil,
			params = {}
		},
		["_player_aim_update"] = {
			source = 'step_player',
			line = 418,
			constructor = false,
			base = nil,
			params = {
				{ name = 'use_mouse_aim' },
			}
		},
		["_player_aim_draw_pre"] = {
			source = 'step_player',
			line = 429,
			constructor = false,
			base = nil,
			params = {
				{ name = 'profile' },
			}
		},
		["_player_aim_draw_post"] = {
			source = 'step_player',
			line = 465,
			constructor = false,
			base = nil,
			params = {}
		},
		["actor_team_set"] = {
			source = 'scr_actor_team_utils',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'team' },
			}
		},
		["actor_team_set_internal"] = {
			source = 'scr_actor_team_utils',
			line = 12,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'tteam' },
			}
		},
		["actor_set_dead"] = {
			source = 'scr_actor_team_utils',
			line = 22,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'dead' },
			}
		},
		["actor_no_targetting_add"] = {
			source = 'scr_actor_team_utils',
			line = 33,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
			}
		},
		["actor_no_targetting_remove"] = {
			source = 'scr_actor_team_utils',
			line = 52,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
			}
		},
		["__actor_update_target_marker"] = {
			source = 'scr_actor_team_utils',
			line = 68,
			constructor = false,
			base = nil,
			params = {}
		},
		["actor_canhit"] = {
			source = 'scr_actor_team_utils',
			line = 101,
			constructor = false,
			base = nil,
			params = {
				{ name = 'attacker' },
				{ name = 'target' },
			}
		},
		["find_opponent"] = {
			source = 'scr_actor_team_utils',
			line = 110,
			constructor = false,
			base = nil,
			params = {
				{ name = 'tx' },
				{ name = 'ty' },
				{ name = 'radius' },
				{ name = 'tteam' },
			}
		},
		["__target_marker_move_player"] = {
			source = 'scr_actor_team_utils',
			line = 115,
			constructor = false,
			base = nil,
			params = {}
		},
		["__target_marker_move_enemy"] = {
			source = 'scr_actor_team_utils',
			line = 126,
			constructor = false,
			base = nil,
			params = {}
		},
		["find_target"] = {
			source = 'scr_actor_team_utils',
			line = 139,
			constructor = false,
			base = nil,
			params = {}
		},
		["find_target_random"] = {
			source = 'scr_actor_team_utils',
			line = 154,
			constructor = false,
			base = nil,
			params = {
				{ name = 'tteam', value = [=[team]=] },
			}
		},
		["find_target_nearest"] = {
			source = 'scr_actor_team_utils',
			line = 160,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx', value = [=[x]=] },
				{ name = 'yy', value = [=[y]=] },
				{ name = 'tteam', value = [=[team]=] },
			}
		},
		["find_target_nearest_ignore"] = {
			source = 'scr_actor_team_utils',
			line = 171,
			constructor = false,
			base = nil,
			params = {
				{ name = 'ignore_array' },
				{ name = 'xx', value = [=[x]=] },
				{ name = 'yy', value = [=[y]=] },
				{ name = 'tteam', value = [=[team]=] },
			}
		},
		["__find_characters_filter"] = {
			source = 'scr_actor_team_utils',
			line = 204,
			constructor = false,
			base = nil,
			params = {
				{ name = 'col_list' },
				{ name = 'out_list' },
				{ name = 'team' },
				{ name = 'find_allies' },
				{ name = 'targettable_only' },
			}
		},
		["__find_characters_filter_first"] = {
			source = 'scr_actor_team_utils',
			line = 220,
			constructor = false,
			base = nil,
			params = {
				{ name = 'col_list' },
				{ name = 'team' },
				{ name = 'find_allies' },
				{ name = 'targettable_only' },
			}
		},
		["find_characters_rectangle"] = {
			source = 'scr_actor_team_utils',
			line = 246,
			constructor = false,
			base = nil,
			params = {
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'x2' },
				{ name = 'y2' },
				{ name = 'team' },
				{ name = 'find_allies' },
				{ name = 'targettable_only', value = [=[true]=] },
				{ name = 'out_list', value = [=[global.__find_allies_list]=] },
			}
		},
		["find_characters_circle   "] = {
			source = 'scr_actor_team_utils',
			line = 248,
			constructor = false,
			base = nil,
			params = {
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'radius' },
				{ name = 'ordered' },
				{ name = 'team' },
				{ name = 'find_allies' },
				{ name = 'targettable_only', value = [=[true]=] },
				{ name = 'out_list', value = [=[global.__find_allies_list]=] },
			}
		},
		["find_characters_circle_first"] = {
			source = 'scr_actor_team_utils',
			line = 250,
			constructor = false,
			base = nil,
			params = {
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'radius' },
				{ name = 'ordered' },
				{ name = 'team' },
				{ name = 'find_allies' },
				{ name = 'targettable_only', value = [=[true]=] },
				{ name = 'out_list', value = [=[global.__find_allies_list]=] },
			}
		},
		["actor_death"] = {
			source = 'scr_actor_death',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'force_death_flag' },
			}
		},
		["actor_phy_move"] = {
			source = 'scr_actor_phy',
			line = 5,
			constructor = false,
			base = nil,
			params = {}
		},
		["actor_phy_prevent_overlap"] = {
			source = 'scr_actor_phy',
			line = 410,
			constructor = false,
			base = nil,
			params = {}
		},
		["actor_phy_on_landed"] = {
			source = 'scr_actor_phy',
			line = 426,
			constructor = false,
			base = nil,
			params = {}
		},
		["init_multiplayer_globals"] = {
			source = 'init_multiplayer_globals',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["udp_join_result_get_error"] = {
			source = 'init_multiplayer_globals',
			line = 674,
			constructor = false,
			base = nil,
			params = {
				{ name = 'result' },
			}
		},
		["update_multiplayer_globals"] = {
			source = 'init_multiplayer_globals',
			line = 683,
			constructor = false,
			base = nil,
			params = {
				{ name = 'online' },
				{ name = 'host' },
			}
		},
		["multiplayer_globals_init_sparks_sprites"] = {
			source = 'init_multiplayer_globals',
			line = 697,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sprs' },
			}
		},
		["multiplayer_globals_init_damage_colors"] = {
			source = 'init_multiplayer_globals',
			line = 711,
			constructor = false,
			base = nil,
			params = {
				{ name = 'col' },
			}
		},
		["read_sprite"] = {
			source = 'scr_buffer_assets',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["write_sprite"] = {
			source = 'scr_buffer_assets',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'val' },
			}
		},
		["read_sprite_direct"] = {
			source = 'scr_buffer_assets',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["write_sprite_direct"] = {
			source = 'scr_buffer_assets',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'asset' },
			}
		},
		["read_sound"] = {
			source = 'scr_buffer_assets',
			line = 6,
			constructor = false,
			base = nil,
			params = {}
		},
		["write_sound"] = {
			source = 'scr_buffer_assets',
			line = 7,
			constructor = false,
			base = nil,
			params = {
				{ name = 'val' },
			}
		},
		["read_sound_direct"] = {
			source = 'scr_buffer_assets',
			line = 8,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["write_sound_direct"] = {
			source = 'scr_buffer_assets',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'asset' },
			}
		},
		["read_room"] = {
			source = 'scr_buffer_assets',
			line = 11,
			constructor = false,
			base = nil,
			params = {}
		},
		["write_room"] = {
			source = 'scr_buffer_assets',
			line = 12,
			constructor = false,
			base = nil,
			params = {
				{ name = 'val' },
			}
		},
		["read_room_direct"] = {
			source = 'scr_buffer_assets',
			line = 13,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["write_room_direct"] = {
			source = 'scr_buffer_assets',
			line = 14,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'asset' },
			}
		},
		["read_object"] = {
			source = 'scr_buffer_assets',
			line = 16,
			constructor = false,
			base = nil,
			params = {}
		},
		["write_object"] = {
			source = 'scr_buffer_assets',
			line = 17,
			constructor = false,
			base = nil,
			params = {
				{ name = 'val' },
			}
		},
		["read_object_direct"] = {
			source = 'scr_buffer_assets',
			line = 18,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["write_object_direct"] = {
			source = 'scr_buffer_assets',
			line = 19,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'asset' },
			}
		},
		["write_sparks_sprite"] = {
			source = 'scr_buffer_assets',
			line = 21,
			constructor = false,
			base = nil,
			params = {
				{ name = 'spr' },
			}
		},
		["read_sparks_sprite"] = {
			source = 'scr_buffer_assets',
			line = 40,
			constructor = false,
			base = nil,
			params = {}
		},
		["server_message_send"] = {
			source = 'server_message_send',
			line = 6,
			constructor = false,
			base = nil,
			params = {}
		},
		["proc_server"] = {
			source = 'proc_server',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["client_message_send"] = {
			source = 'client_message_send',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["proc_client"] = {
			source = 'proc_client',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'is_start_of_message', value = [=[true]=] },
			}
		},
		["__lf_oEnforcerGrenadePrimary_create_serialize"] = {
			source = '__lf_oEnforcerGrenadePrimary_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["background_set_megasprite"] = {
			source = 'scr_tilemap_rendering',
			line = 48,
			constructor = false,
			base = nil,
			params = {
				{ name = 'spr' },
			}
		},
		["tile_render_init_animated"] = {
			source = 'scr_tilemap_rendering',
			line = 59,
			constructor = false,
			base = nil,
			params = {
				{ name = 'tileset_spr' },
				{ name = 'anim_speed' },
				{ name = 'subs_arr' },
			}
		},
		["tile_render_init_final"] = {
			source = 'scr_tilemap_rendering',
			line = 74,
			constructor = false,
			base = nil,
			params = {
				{ name = 'tileset_spr' },
			}
		},
		["tile_render_setup_draw_func"] = {
			source = 'scr_tilemap_rendering',
			line = 83,
			constructor = false,
			base = nil,
			params = {
				{ name = 'tiles_vb' },
				{ name = 'tileset_spr' },
			}
		},
		["count_enemies"] = {
			source = 'count_enemies',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["__rpc_chef_pot_gibbed_implementation__"] = {
			source = 'scr_ror_init_survivor_chef_alts',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'enemy' },
				{ name = 'pot' },
			}
		},
		["ResourceManager"] = {
			source = 'scr_ResourceManager',
			line = 2,
			constructor = true,
			base = [=[BaseClassManager(]=],
			params = {
				{ name = 'delete_resource' },
			}
		},
		["BaseClassManager"] = {
			source = 'scr_ResourceManager',
			line = 106,
			constructor = true,
			base = nil,
			params = {}
		},
		["control_interact_pressed"] = {
			source = 'control_interact_pressed',
			line = 4,
			constructor = false,
			base = nil,
			params = {}
		},
		["_survivor_arti_special2_set_scepter"] = {
			source = 'scr_ror_init_survivor_artificer_alts',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_arti_bolt_pulse_write__"] = {
			source = 'scr_ror_init_survivor_artificer_alts',
			line = 37,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_arti_bolt_pulse_read__"] = {
			source = 'scr_ror_init_survivor_artificer_alts',
			line = 38,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_arti_fireball_position_update_write__"] = {
			source = 'scr_ror_init_survivor_artificer_alts',
			line = 46,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_arti_fireball_position_update_read__"] = {
			source = 'scr_ror_init_survivor_artificer_alts',
			line = 52,
			constructor = false,
			base = nil,
			params = {}
		},
		["player_util_count_alive"] = {
			source = 'scr_player_utils',
			line = 21,
			constructor = false,
			base = nil,
			params = {}
		},
		["player_util_nearest_player"] = {
			source = 'scr_player_utils',
			line = 31,
			constructor = false,
			base = nil,
			params = {
				{ name = 'tx' },
				{ name = 'ty' },
				{ name = 'allow_p_drone', value = [=[false]=] },
			}
		},
		["player_util_get_input_profile"] = {
			source = 'scr_player_utils',
			line = 54,
			constructor = false,
			base = nil,
			params = {
				{ name = 'p', value = [=[id]=] },
			}
		},
		["player_util_get_hold_swap"] = {
			source = 'scr_player_utils',
			line = 59,
			constructor = false,
			base = nil,
			params = {
				{ name = 'p', value = [=[id]=] },
			}
		},
		["player_util_get_use_mouse_aim"] = {
			source = 'scr_player_utils',
			line = 63,
			constructor = false,
			base = nil,
			params = {
				{ name = 'p', value = [=[id]=] },
			}
		},
		["player_util_get_rapid_fire"] = {
			source = 'scr_player_utils',
			line = 69,
			constructor = false,
			base = nil,
			params = {
				{ name = 'p', value = [=[id]=] },
			}
		},
		["player_util_spawn_unique_drone"] = {
			source = 'scr_player_utils',
			line = 76,
			constructor = false,
			base = nil,
			params = {
				{ name = 'p' },
				{ name = 'obj' },
			}
		},
		["player_util_local_player_get_equipment_activation_direction"] = {
			source = 'scr_player_utils',
			line = 95,
			constructor = false,
			base = nil,
			params = {}
		},
		["set_state"] = {
			source = 'oEnforcerGrenadePrimary-Create',
			line = 21,
			constructor = false,
			base = nil,
			params = {
				{ name = 'new_state' },
			}
		},
		["ActorComponentScript"] = {
			source = 'scr_actorScript',
			line = 15,
			constructor = true,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'func' },
			}
		},
		["ActorComponent"] = {
			source = 'scr_actorScript',
			line = 21,
			constructor = true,
			base = nil,
			params = {
				{ name = 'name', value = [=[undefined]=] },
				{ name = 'on_apply', value = [=[undefined]=] },
				{ name = 'on_remove', value = [=[undefined]=] },
			}
		},
		["ActorComponentExecRateFunc"] = {
			source = 'scr_actorScript',
			line = 41,
			constructor = true,
			base = [=[ActorComponent(undefined, undefined, undefined]=],
			params = {
				{ name = 'tickrate' },
				{ name = 'host_only' },
				{ name = 'func)' },
			}
		},
		["on_apply"] = {
			source = 'scr_actorScript',
			line = 45,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
			}
		},
		["on_remove"] = {
			source = 'scr_actorScript',
			line = 54,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
			}
		},
		["actor_script_attach"] = {
			source = 'scr_actorScript',
			line = 65,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'kind' },
				{ name = 'name' },
				{ name = 'func' },
			}
		},
		["actor_script_remove"] = {
			source = 'scr_actorScript',
			line = 72,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'kind' },
				{ name = 'name' },
			}
		},
		["actor_component_attach"] = {
			source = 'scr_actorScript',
			line = 87,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'component' },
			}
		},
		["actor_component_remove"] = {
			source = 'scr_actorScript',
			line = 101,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'component' },
			}
		},
		["actor_has_component"] = {
			source = 'scr_actorScript',
			line = 114,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'component' },
			}
		},
		["actor_get_component_data"] = {
			source = 'scr_actorScript',
			line = 118,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
				{ name = 'com' },
			}
		},
		["actor_script_execute"] = {
			source = 'scr_actorScript',
			line = 124,
			constructor = false,
			base = nil,
			params = {
				{ name = 'kind' },
			}
		},
		["actor_init_componentscript"] = {
			source = 'scr_actorScript',
			line = 137,
			constructor = false,
			base = nil,
			params = {}
		},
		["actor_component_remove_flagged_for_death_removal"] = {
			source = 'scr_actorScript',
			line = 144,
			constructor = false,
			base = nil,
			params = {}
		},
		["sprite_get_id"] = {
			source = 'scr_spriteResource',
			line = 33,
			constructor = false,
			base = nil,
			params = {
				{ name = 'spr' },
			}
		},
		["sprite_find"] = {
			source = 'scr_spriteResource',
			line = 39,
			constructor = false,
			base = nil,
			params = {
				{ name = 'id_string' },
			}
		},
		["sprite_backup"] = {
			source = 'scr_spriteResource',
			line = 45,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sprite' },
			}
		},
		["sprite_delete_w"] = {
			source = 'scr_spriteResource',
			line = 60,
			constructor = false,
			base = nil,
			params = {
				{ name = 'ind' },
			}
		},
		["sprite_add_w"] = {
			source = 'scr_spriteResource',
			line = 64,
			constructor = false,
			base = nil,
			params = {
				{ name = 'namespace' },
				{ name = 'name' },
				{ name = 'fname' },
				{ name = 'imgnum' },
				{ name = 'xorig' },
				{ name = 'yorig' },
			}
		},
		["sprite_create_from_surface_w"] = {
			source = 'scr_spriteResource',
			line = 77,
			constructor = false,
			base = nil,
			params = {
				{ name = 'namespace' },
				{ name = 'name' },
				{ name = 'surf_id' },
				{ name = '_x' },
				{ name = '_y' },
				{ name = 'w' },
				{ name = 'h' },
				{ name = 'xorig' },
				{ name = 'yorig' },
			}
		},
		["sprite_assign_w"] = {
			source = 'scr_spriteResource',
			line = 86,
			constructor = false,
			base = nil,
			params = {
				{ name = 'ind' },
				{ name = 'source' },
			}
		},
		["sprite_add_from_surface_w"] = {
			source = 'scr_spriteResource',
			line = 91,
			constructor = false,
			base = nil,
			params = {
				{ name = 'ind' },
				{ name = 'surf_id' },
				{ name = '_x' },
				{ name = '_y' },
				{ name = 'w' },
				{ name = 'h' },
			}
		},
		["_mod_sprite_find"] = {
			source = 'scr_spriteResource',
			line = 99,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'origin' },
			}
		},
		["_mod_sprite_findAll"] = {
			source = 'scr_spriteResource',
			line = 100,
			constructor = false,
			base = nil,
			params = {
				{ name = 'origin' },
			}
		},
		["_mod_sprite_get_name"] = {
			source = 'scr_spriteResource',
			line = 101,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sprite' },
			}
		},
		["_mod_sprite_get_namespace"] = {
			source = 'scr_spriteResource',
			line = 102,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sprite' },
			}
		},
		["_mod_sprite_get_netID"] = {
			source = 'scr_spriteResource',
			line = 103,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sprite' },
			}
		},
		["_mod_sprite_from_netID"] = {
			source = 'scr_spriteResource',
			line = 104,
			constructor = false,
			base = nil,
			params = {
				{ name = 'nid' },
			}
		},
		["_mod_sprite_from_id"] = {
			source = 'scr_spriteResource',
			line = 105,
			constructor = false,
			base = nil,
			params = {
				{ name = 'nid' },
			}
		},
		["_mod_sprite_set_speed"] = {
			source = 'scr_spriteResource',
			line = 106,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sprite' },
				{ name = 'spd' },
			}
		},
		["_mod_sprite_get_speed"] = {
			source = 'scr_spriteResource',
			line = 107,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sprite' },
			}
		},
		["_mod_sprite_load"] = {
			source = 'scr_spriteResource',
			line = 114,
			constructor = false,
			base = nil,
			params = {
				{ name = 'fname' },
				{ name = 'imgnum' },
				{ name = 'xorig' },
				{ name = 'yorig' },
				{ name = 'name' },
			}
		},
		["_mod_sprite_from_surface"] = {
			source = 'scr_spriteResource',
			line = 129,
			constructor = false,
			base = nil,
			params = {
				{ name = 'surf' },
				{ name = 'xorig' },
				{ name = 'yorig' },
				{ name = '_x' },
				{ name = '_y' },
				{ name = 'w' },
				{ name = 'h' },
				{ name = 'name' },
			}
		},
		["_mod_sprite_add_from_surface"] = {
			source = 'scr_spriteResource',
			line = 143,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sprite' },
				{ name = 'surf' },
				{ name = '_x' },
				{ name = '_y' },
				{ name = 'w' },
				{ name = 'h' },
			}
		},
		["EffectDisplayData"] = {
			source = 'scr_effectDisplay',
			line = 8,
			constructor = true,
			base = nil,
			params = {}
		},
		["EffectDisplay"] = {
			source = 'scr_effectDisplay',
			line = 13,
			constructor = true,
			base = nil,
			params = {}
		},
		["EffectDisplayInstance"] = {
			source = 'scr_effectDisplay',
			line = 20,
			constructor = true,
			base = [=[EffectDisplay(]=],
			params = {
				{ name = 'display_object' },
				{ name = 'setup_display_instance' },
				{ name = 'host_only', value = [=[false]=] },
			}
		},
		["EffectDisplayDrawScript"] = {
			source = 'scr_effectDisplay',
			line = 47,
			constructor = true,
			base = [=[EffectDisplay(]=],
			params = {
				{ name = 'draw_script' },
			}
		},
		["EffectDisplaySprite"] = {
			source = 'scr_effectDisplay',
			line = 57,
			constructor = true,
			base = [=[EffectDisplayDrawScript(undefined]=],
			params = {
				{ name = 'sprite' },
				{ name = 'priority' },
				{ name = 'animspeed' },
				{ name = 'xoffs' },
				{ name = 'yoffs' },
			}
		},
		["EffectDisplayFunction"] = {
			source = 'scr_effectDisplay',
			line = 67,
			constructor = true,
			base = [=[EffectDisplayDrawScript(undefined]=],
			params = {
				{ name = 'func' },
				{ name = 'priority' },
			}
		},
		["EffectDisplayTickRate"] = {
			source = 'scr_effectDisplay',
			line = 71,
			constructor = true,
			base = [=[EffectDisplay(]=],
			params = {
				{ name = 'rate' },
				{ name = 'func' },
			}
		},
		["EffectDisplayParticles"] = {
			source = 'scr_effectDisplay',
			line = 85,
			constructor = true,
			base = [=[EffectDisplay(]=],
			params = {
				{ name = 'particle' },
				{ name = 'rate' },
				{ name = 'amount' },
				{ name = 'partlayer' },
				{ name = 'colour' },
				{ name = 'xrand' },
				{ name = 'yrand' },
			}
		},
		["EffectDisplayElitePalette"] = {
			source = 'scr_effectDisplay',
			line = 137,
			constructor = true,
			base = [=[EffectDisplay(]=],
			params = {
				{ name = 'pal_index' },
			}
		},
		["actor_init_effectdisplay"] = {
			source = 'scr_effectDisplay',
			line = 161,
			constructor = false,
			base = nil,
			params = {}
		},
		["actor_effectdisplay_attach"] = {
			source = 'scr_effectDisplay',
			line = 168,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'display' },
			}
		},
		["actor_effectdisplay_remove"] = {
			source = 'scr_effectDisplay',
			line = 181,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'display' },
			}
		},
		["actor_effectdisplay_hide"] = {
			source = 'scr_effectDisplay',
			line = 202,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'display' },
			}
		},
		["actor_effectdisplay_unhide"] = {
			source = 'scr_effectDisplay',
			line = 215,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'display' },
			}
		},
		["actor_effectdisplay_hide_all"] = {
			source = 'scr_effectDisplay',
			line = 228,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
			}
		},
		["actor_effectdisplay_unhide_all"] = {
			source = 'scr_effectDisplay',
			line = 236,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
			}
		},
		["ActorDrawScript"] = {
			source = 'scr_effectDisplay',
			line = 680,
			constructor = true,
			base = nil,
			params = {
				{ name = 'draw' },
				{ name = 'priority' },
			}
		},
		["actor_drawscript_attached"] = {
			source = 'scr_effectDisplay',
			line = 686,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'drawscript' },
			}
		},
		["actor_drawscript_attach"] = {
			source = 'scr_effectDisplay',
			line = 697,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'drawscript' },
			}
		},
		["actor_drawscript_remove"] = {
			source = 'scr_effectDisplay',
			line = 710,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'drawscript' },
			}
		},
		["input_gamepad_get_dpad_style"] = {
			source = 'input_gamepad_get_dpad_style',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_index' },
			}
		},
		["input_chord_create"] = {
			source = 'input_chord_create',
			line = 10,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_binding_mouse_button"] = {
			source = 'input_binding_mouse_button',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_button' },
			}
		},
		["input_default_joycon_axis"] = {
			source = 'input_default_joycon_axis',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["execute_later"] = {
			source = 'oInit-Create',
			line = 68,
			constructor = false,
			base = nil,
			params = {
				{ name = 'f' },
			}
		},
		["achievement_unlocked"] = {
			source = 'oInit-Create',
			line = 72,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achiev_id' },
				{ name = 'show_only_alt_or_main_condition', value = [=[-1]=] },
			}
		},
		["register_async_handler"] = {
			source = 'oInit-Create',
			line = 80,
			constructor = false,
			base = nil,
			params = {
				{ name = 'kind' },
				{ name = 'async_id' },
				{ name = 'handler' },
			}
		},
		["call_async_handler"] = {
			source = 'oInit-Create',
			line = 91,
			constructor = false,
			base = nil,
			params = {
				{ name = '_async_load' },
			}
		},
		["file_async_save"] = {
			source = 'oInit-Create',
			line = 196,
			constructor = false,
			base = nil,
			params = {
				{ name = 'filename' },
				{ name = 'content_string' },
				{ name = 'callback_func' },
			}
		},
		["file_async_load"] = {
			source = 'oInit-Create',
			line = 205,
			constructor = false,
			base = nil,
			params = {
				{ name = 'filename' },
				{ name = 'callback_func' },
			}
		},
		["_file_async_start"] = {
			source = 'oInit-Create',
			line = 214,
			constructor = false,
			base = nil,
			params = {
				{ name = 'content_string' },
				{ name = 'filename' },
				{ name = 'callback_func' },
				{ name = 'is_write' },
			}
		},
		["set_loaded_stage_texgroup"] = {
			source = 'oInit-Create',
			line = 232,
			constructor = false,
			base = nil,
			params = {
				{ name = 'group' },
				{ name = 'force_prefetch', value = [=[true]=] },
			}
		},
		["network_handle_message"] = {
			source = 'oClient-Create',
			line = 51,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buff' },
				{ name = 'ip', value = [=[undefined]=] },
				{ name = 'port', value = [=[undefined]=] },
			}
		},
		["sparse_grid_create"] = {
			source = 'scr_sparsegrid',
			line = 8,
			constructor = false,
			base = nil,
			params = {}
		},
		["sparse_grid_destroy"] = {
			source = 'scr_sparsegrid',
			line = 19,
			constructor = false,
			base = nil,
			params = {
				{ name = 'struct' },
			}
		},
		["sparse_grid_get"] = {
			source = 'scr_sparsegrid',
			line = 35,
			constructor = false,
			base = nil,
			params = {
				{ name = 'struct' },
				{ name = 'xx' },
				{ name = 'yy' },
			}
		},
		["sparse_grid_set"] = {
			source = 'scr_sparsegrid',
			line = 44,
			constructor = false,
			base = nil,
			params = {
				{ name = 'struct' },
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'value' },
			}
		},
		["sparse_grid_delete"] = {
			source = 'scr_sparsegrid',
			line = 55,
			constructor = false,
			base = nil,
			params = {
				{ name = 'struct' },
				{ name = 'xx' },
				{ name = 'yy' },
			}
		},
		["sparse_grid_exists"] = {
			source = 'scr_sparsegrid',
			line = 69,
			constructor = false,
			base = nil,
			params = {
				{ name = 'struct' },
				{ name = 'xx' },
				{ name = 'yy' },
			}
		},
		["sparse_grid_for_each"] = {
			source = 'scr_sparsegrid',
			line = 77,
			constructor = false,
			base = nil,
			params = {
				{ name = 'struct' },
				{ name = 'func' },
			}
		},
		["network_handle_message"] = {
			source = 'oServer-Create',
			line = 114,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'ip', value = [=[undefined]=] },
				{ name = 'port', value = [=[undefined]=] },
			}
		},
		["populate_variance_choice_array"] = {
			source = 'oDirectorControl-Create',
			line = 87,
			constructor = false,
			base = nil,
			params = {}
		},
		["stage_goto_next"] = {
			source = 'oDirectorControl-Create',
			line = 108,
			constructor = false,
			base = nil,
			params = {
				{ name = 'can_loop' },
			}
		},
		["player_level_up"] = {
			source = 'oDirectorControl-Create',
			line = 152,
			constructor = false,
			base = nil,
			params = {}
		},
		["register_boss_party"] = {
			source = 'oDirectorControl-Create',
			line = 174,
			constructor = false,
			base = nil,
			params = {
				{ name = 'bp' },
			}
		},
		["update_boss_party_active"] = {
			source = 'oDirectorControl-Create',
			line = 192,
			constructor = false,
			base = nil,
			params = {}
		},
		["set_boss_party_active_internal"] = {
			source = 'oDirectorControl-Create',
			line = 215,
			constructor = false,
			base = nil,
			params = {
				{ name = 'bp' },
			}
		},
		["monster_spawn_array_get_boss_candidates"] = {
			source = 'oDirectorControl-Create',
			line = 255,
			constructor = false,
			base = nil,
			params = {}
		},
		["get_root_menu_level"] = {
			source = 'oPauseMenu-Create',
			line = 55,
			constructor = false,
			base = nil,
			params = {}
		},
		["PauseMenuOption"] = {
			source = 'oPauseMenu-Create',
			line = 62,
			constructor = true,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'clicked' },
			}
		},
		["_mod_verify_pickup_object"] = {
			source = 'scr_luaApi_loot',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'obj_id' },
			}
		},
		["_mod_verify_enemy_object"] = {
			source = 'scr_luaApi_loot',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = 'obj_id' },
			}
		},
		["_mod_loot_get_treasureWeights"] = {
			source = 'scr_luaApi_loot',
			line = 10,
			constructor = false,
			base = nil,
			params = {
				{ name = 'weight_index' },
			}
		},
		["_mod_loot_create_treasureWeights"] = {
			source = 'scr_luaApi_loot',
			line = 15,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_loot_get_treasurePool"] = {
			source = 'scr_luaApi_loot',
			line = 21,
			constructor = false,
			base = nil,
			params = {
				{ name = 'pool_index' },
			}
		},
		["_mod_loot_create_treasurePool"] = {
			source = 'scr_luaApi_loot',
			line = 26,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_loot_treasure_boss_register"] = {
			source = 'scr_luaApi_loot',
			line = 34,
			constructor = false,
			base = nil,
			params = {
				{ name = 'boss_object' },
				{ name = 'pickup_id' },
			}
		},
		["_mod_loot_treasure_boss_remove"] = {
			source = 'scr_luaApi_loot',
			line = 39,
			constructor = false,
			base = nil,
			params = {
				{ name = 'boss_object' },
				{ name = 'pickup_id' },
			}
		},
		["_mod_loot_treasure_boss_clear"] = {
			source = 'scr_luaApi_loot',
			line = 44,
			constructor = false,
			base = nil,
			params = {
				{ name = 'boss_object' },
			}
		},
		["_mod_loot_treasure_boss_get_all"] = {
			source = 'scr_luaApi_loot',
			line = 48,
			constructor = false,
			base = nil,
			params = {
				{ name = 'boss_object' },
			}
		},
		["__input_rejoin_tick"] = {
			source = '__input_rejoin_tick',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["update_selected_mod"] = {
			source = 'oSteamMods-Create',
			line = 16,
			constructor = false,
			base = nil,
			params = {
				{ name = 'mod_selected' },
			}
		},
		["draw_mod_sprite"] = {
			source = 'oSteamMods-Create',
			line = 40,
			constructor = false,
			base = nil,
			params = {
				{ name = 'display_info' },
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'icon_size' },
			}
		},
		["draw_mod"] = {
			source = 'oSteamMods-Create',
			line = 47,
			constructor = false,
			base = nil,
			params = {
				{ name = 'display_info' },
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'x2' },
				{ name = 'y2' },
			}
		},
		["sort_mods"] = {
			source = 'oSteamMods-Create',
			line = 138,
			constructor = false,
			base = nil,
			params = {}
		},
		["menu_open_check_tutorial"] = {
			source = 'oStartMenu-Create',
			line = 133,
			constructor = false,
			base = nil,
			params = {
				{ name = 'func' },
			}
		},
		["start_connecting"] = {
			source = 'oSteamMultiplayer-Create',
			line = 76,
			constructor = false,
			base = nil,
			params = {}
		},
		["stopped_connecting"] = {
			source = 'oSteamMultiplayer-Create',
			line = 82,
			constructor = false,
			base = nil,
			params = {}
		},
		["start_viewing_lobby"] = {
			source = 'oSteamMultiplayer-Create',
			line = 102,
			constructor = false,
			base = nil,
			params = {
				{ name = '_game' },
			}
		},
		["LobbyRuleDisplay"] = {
			source = 'oSteamMultiplayer-Create',
			line = 200,
			constructor = true,
			base = nil,
			params = {}
		},
		["LobbyRuleDisplayArtifact"] = {
			source = 'oSteamMultiplayer-Create',
			line = 207,
			constructor = true,
			base = [=[LobbyRuleDisplay(]=],
			params = {
				{ name = 'artifact_id' },
			}
		},
		["LobbyRuleDisplayDifficulty"] = {
			source = 'oSteamMultiplayer-Create',
			line = 214,
			constructor = true,
			base = [=[LobbyRuleDisplay(]=],
			params = {
				{ name = 'difficulty_id' },
			}
		},
		["handle_clicked_item"] = {
			source = 'oSteamMultiplayer-Create',
			line = 282,
			constructor = false,
			base = nil,
			params = {
				{ name = 'ident' },
			}
		},
		["map_tag_list"] = {
			source = 'oSteamMultiplayer-Create',
			line = 373,
			constructor = false,
			base = nil,
			params = {
				{ name = 'str' },
			}
		},
		["draw_lobby_field"] = {
			source = 'oSteamMultiplayer-Create',
			line = 387,
			constructor = false,
			base = nil,
			params = {
				{ name = '_field' },
				{ name = '_value' },
				{ name = '_text_x' },
				{ name = '_val_x' },
				{ name = '_r' },
				{ name = '_draw_y' },
			}
		},
		["draw_lobby_game"] = {
			source = 'oSteamMultiplayer-Create',
			line = 398,
			constructor = false,
			base = nil,
			params = {
				{ name = 'game' },
				{ name = 'screen_index' },
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'x2' },
				{ name = 'y2' },
				{ name = '_title_x' },
				{ name = '_players_x' },
				{ name = '_ping_x' },
				{ name = '_tags_x' },
				{ name = '_menu_r' },
			}
		},
		["wrap_lobby"] = {
			source = 'oSteamMultiplayer-Create',
			line = 485,
			constructor = false,
			base = nil,
			params = {
				{ name = 'i' },
			}
		},
		["lobby_get_mods_to_download"] = {
			source = 'oSteamMultiplayer-Create',
			line = 568,
			constructor = false,
			base = nil,
			params = {
				{ name = 'lobby' },
			}
		},
		["lobby_get_mods_sorted_status"] = {
			source = 'oSteamMultiplayer-Create',
			line = 584,
			constructor = false,
			base = nil,
			params = {
				{ name = 'lobby' },
			}
		},
		["draw_browsed_game"] = {
			source = 'oSteamMultiplayer-Create',
			line = 643,
			constructor = false,
			base = nil,
			params = {}
		},
		["is_viewing_game"] = {
			source = 'oSteamMultiplayer-Create',
			line = 956,
			constructor = false,
			base = nil,
			params = {}
		},
		["stop_viewing_game"] = {
			source = 'oSteamMultiplayer-Create',
			line = 959,
			constructor = false,
			base = nil,
			params = {}
		},
		["set_active_tab"] = {
			source = 'oSteamMultiplayer-Create',
			line = 967,
			constructor = false,
			base = nil,
			params = {
				{ name = 'new_tab' },
			}
		},
		["add_item_pickup_display_for_player"] = {
			source = 'oHUD-Create',
			line = 111,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
				{ name = 'name' },
				{ name = 'text' },
				{ name = 'sprite' },
				{ name = 'subimage' },
				{ name = 'tier' },
				{ name = 'stack_kind' },
				{ name = 'dupe' },
				{ name = 'isSkillIcon' },
			}
		},
		["add_offscreen_object_indicator"] = {
			source = 'oHUD-Create',
			line = 124,
			constructor = false,
			base = nil,
			params = {
				{ name = 'inst' },
				{ name = 'sprite' },
				{ name = 'col' },
			}
		},
		["remove_offscreen_object_indicator"] = {
			source = 'oHUD-Create',
			line = 130,
			constructor = false,
			base = nil,
			params = {
				{ name = 'inst' },
			}
		},
		["get_offscreen_object_indicator_info"] = {
			source = 'oHUD-Create',
			line = 139,
			constructor = false,
			base = nil,
			params = {
				{ name = 'inst' },
			}
		},
		["add_gold"] = {
			source = 'oHUD-Create',
			line = 189,
			constructor = false,
			base = nil,
			params = {
				{ name = 'value' },
			}
		},
		["input_on_player_disconnect_gamepad"] = {
			source = 'input_on_player_disconnect_gamepad',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'input_player_index' },
			}
		},
		["input_player_index_to_player_info_index"] = {
			source = 'input_on_player_disconnect_gamepad',
			line = 84,
			constructor = false,
			base = nil,
			params = {
				{ name = 'input_player_index' },
			}
		},
		["__lf_oArtiSnap_create_serialize"] = {
			source = '__lf_oArtiSnap_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_gamepad_is_axis"] = {
			source = 'input_gamepad_is_axis',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_index' },
				{ name = '_gm' },
			}
		},
		["input_player_connected"] = {
			source = 'input_player_connected',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["__input_class_cursor"] = {
			source = '__input_class_cursor',
			line = 1,
			constructor = true,
			base = nil,
			params = {}
		},
		["input_cursor_speed_get"] = {
			source = 'input_cursor_speed_get',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["__lf_oBossSkill3_create_deserialize"] = {
			source = '__lf_oBossSkill3_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__input_class_player"] = {
			source = '__input_class_player',
			line = 6,
			constructor = true,
			base = nil,
			params = {}
		},
		["__lf_oLizardRSpear_create_deserialize"] = {
			source = '__lf_oLizardRSpear_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__input_gamepad_set_blacklist"] = {
			source = '__input_gamepad_set_blacklist',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_y"] = {
			source = 'input_y',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb_l' },
				{ name = '_verb_r' },
				{ name = '_verb_u' },
				{ name = '_verb_d' },
				{ name = '_player_index', value = [=[undefined]=] },
				{ name = '_most_recent', value = [=[false]=] },
			}
		},
		["stage_load_room_async"] = {
			source = 'stage_load_room_async',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = '_namespace' },
				{ name = '_name' },
				{ name = '_fname' },
			}
		},
		["__lf_oEfArtiNanobolt_create_deserialize"] = {
			source = '__lf_oEfArtiNanobolt_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["UIOptionsButtonBase"] = {
			source = 'scr_ui_options_list',
			line = 25,
			constructor = true,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'get' },
				{ name = 'set' },
			}
		},
		["UIOptionsButtonSlider"] = {
			source = 'scr_ui_options_list',
			line = 43,
			constructor = true,
			base = [=[UIOptionsButtonBase(name, get, set]=],
			params = {
				{ name = 'name' },
				{ name = 'get' },
				{ name = 'set' },
				{ name = 'display_type', value = [=[UI_SLIDER_VALUE_DISPLAY_TYPE.percent]=] },
				{ name = 'value_min', value = [=[0]=] },
				{ name = 'value_max', value = [=[1]=] },
				{ name = 'value_int', value = [=[false]=] },
				{ name = 'toggle_name', value = [=[undefined]=] },
				{ name = 'toggle_get', value = [=[undefined]=] },
				{ name = 'toggle_set', value = [=[undefined]=] },
			}
		},
		["UIOptionsButtonToggle"] = {
			source = 'scr_ui_options_list',
			line = 62,
			constructor = true,
			base = [=[UIOptionsButtonBase(name, get, set]=],
			params = {
				{ name = 'name' },
				{ name = 'get' },
				{ name = 'set' },
			}
		},
		["UIOptionsButtonDropdown"] = {
			source = 'scr_ui_options_list',
			line = 72,
			constructor = true,
			base = [=[UIOptionsButtonBase(name, get, set]=],
			params = {
				{ name = 'name' },
				{ name = 'get' },
				{ name = 'set' },
				{ name = 'choices' },
			}
		},
		["UIOptionsButtonProfileField"] = {
			source = 'scr_ui_options_list',
			line = 77,
			constructor = true,
			base = [=[UIOptionsButtonBase(name, undefined, undefined]=],
			params = {
				{ name = 'name' },
			}
		},
		["UIOptionsGroupHeader"] = {
			source = 'scr_ui_options_list',
			line = 81,
			constructor = true,
			base = [=[UIOptionsButtonBase(name, undefined, undefined]=],
			params = {
				{ name = 'name' },
			}
		},
		["UIOptionsButtonControlRemapKey"] = {
			source = 'scr_ui_options_list',
			line = 86,
			constructor = true,
			base = [=[UIOptionsButtonBase(name, undefined, undefined]=],
			params = {
				{ name = 'name' },
				{ name = 'verb_name' },
				{ name = 'profile' },
			}
		},
		["UIOptionsButtonControlRemapToggle"] = {
			source = 'scr_ui_options_list',
			line = 99,
			constructor = true,
			base = [=[UIOptionsButtonBase(name, get, set]=],
			params = {
				{ name = 'name' },
				{ name = 'get' },
				{ name = 'set' },
			}
		},
		["UIOptionsButton"] = {
			source = 'scr_ui_options_list',
			line = 112,
			constructor = true,
			base = [=[UIOptionsButtonBase(name, undefined, undefined]=],
			params = {
				{ name = 'name' },
				{ name = 'button_text' },
				{ name = 'pressed' },
			}
		},
		["UIOptionsButton2"] = {
			source = 'scr_ui_options_list',
			line = 119,
			constructor = true,
			base = [=[UIOptionsButtonBase(name, undefined, undefined]=],
			params = {
				{ name = 'name' },
				{ name = 'pressed' },
				{ name = 'icon_sprite', value = [=[-1]=] },
				{ name = 'button_style', value = [=[global._ui_style_default]=] },
				{ name = 'is_active_tab', value = [=[undefined]=] },
			}
		},
		["ui_options_menu_option_list_init_vars"] = {
			source = 'scr_ui_options_list',
			line = 132,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_options_menu_option_list_step"] = {
			source = 'scr_ui_options_list',
			line = 145,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_options_menu_option_list_cleanup"] = {
			source = 'scr_ui_options_list',
			line = 149,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_options_menu_option_type_is_control"] = {
			source = 'scr_ui_options_list',
			line = 153,
			constructor = false,
			base = nil,
			params = {
				{ name = 't' },
			}
		},
		["ui_options_menu_option_list_get_height"] = {
			source = 'scr_ui_options_list',
			line = 159,
			constructor = false,
			base = nil,
			params = {
				{ name = 'options' },
			}
		},
		["ui_options_menu_option_list_draw"] = {
			source = 'scr_ui_options_list',
			line = 182,
			constructor = false,
			base = nil,
			params = {
				{ name = 'options' },
				{ name = 'opt_x' },
				{ name = 'opt_y' },
				{ name = 'opt_width' },
				{ name = 'force_small_slider', value = [=[false]=] },
			}
		},
		["ui_options_draw_tooltip"] = {
			source = 'scr_ui_options_list',
			line = 658,
			constructor = false,
			base = nil,
			params = {
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'w' },
				{ name = 'opt_text' },
				{ name = 'opt_alt_text' },
			}
		},
		["ui_options_list_refresh"] = {
			source = 'scr_ui_options_list',
			line = 688,
			constructor = false,
			base = nil,
			params = {
				{ name = 'options' },
			}
		},
		["__lf_oBanditGrenade_create_serialize"] = {
			source = '__lf_oBanditGrenade_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_player_connected_count"] = {
			source = 'input_player_connected_count',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["font_get_glyph_map"] = {
			source = 'font_get_glyph_map',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'font' },
			}
		},
		["input_source_detect_new"] = {
			source = 'input_source_detect_new',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_player_import"] = {
			source = 'input_player_import',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_json' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["set_state"] = {
			source = 'oHANDBaby-Create',
			line = 22,
			constructor = false,
			base = nil,
			params = {
				{ name = 'new_state' },
			}
		},
		["set_type"] = {
			source = 'oHANDBaby-Create',
			line = 46,
			constructor = false,
			base = nil,
			params = {
				{ name = 'new_type' },
			}
		},
		["switchmultiplayer_generate_lobby_description"] = {
			source = 'switchmultiplayer_generate_lobby_description',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["tick_actor_collision2"] = {
			source = 'tick_actor_collision2',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_mouse_check_released"] = {
			source = 'input_mouse_check_released',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_binding' },
			}
		},
		["__input_load_type_csv"] = {
			source = '__input_load_type_csv',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = '_filename' },
			}
		},
		["input_gamepad_check_pressed"] = {
			source = 'input_gamepad_check_pressed',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_index' },
				{ name = '_gm' },
			}
		},
		["bullet_draw_tracer"] = {
			source = 'bullet_draw_tracer',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'kind' },
				{ name = 'acol' },
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'x2' },
				{ name = 'y2' },
			}
		},
		["bullet_draw_tracer_networked"] = {
			source = 'bullet_draw_tracer',
			line = 440,
			constructor = false,
			base = nil,
			params = {
				{ name = 'tracer_kind' },
				{ name = 'tracer_col' },
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'x2' },
				{ name = 'y2' },
			}
		},
		["ui_block_slider"] = {
			source = 'ui_block_slider',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'num_segments' },
				{ name = 'text' },
				{ name = 'gp_index', value = [=[undefined]=] },
				{ name = 'flags', value = [=[0]=] },
				{ name = 'style', value = [=[global._ui_style_default]=] },
			}
		},
		["input_system_verify"] = {
			source = 'input_system_verify',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_json' },
			}
		},
		["TrialsModeGlobals"] = {
			source = 'scr_trials_game',
			line = 5,
			constructor = true,
			base = nil,
			params = {
				{ name = 'info' },
				{ name = 'board_name' },
				{ name = 'trial_name' },
				{ name = 'launch_info' },
			}
		},
		["TrialGameStartInfo"] = {
			source = 'scr_trials_game',
			line = 146,
			constructor = true,
			base = nil,
			params = {}
		},
		["trials_game_start_load_from_board"] = {
			source = 'scr_trials_game',
			line = 151,
			constructor = false,
			base = nil,
			params = {
				{ name = 'board' },
				{ name = 'trial_name' },
				{ name = 'launch_info' },
			}
		},
		["trials_game_start_from_board"] = {
			source = 'scr_trials_game',
			line = 162,
			constructor = false,
			base = nil,
			params = {
				{ name = 'board' },
				{ name = 'trial_name' },
				{ name = 'launch_info', value = [=[new TrialGameStartInfo()]=] },
			}
		},
		["trials_game_start"] = {
			source = 'scr_trials_game',
			line = 167,
			constructor = false,
			base = nil,
			params = {
				{ name = 'info' },
				{ name = 'board_name', value = [=["test"]=] },
				{ name = 'trial_name', value = [=["test"]=] },
				{ name = 'launch_info', value = [=[new TrialGameStartInfo()]=] },
			}
		},
		["trials_game_cleanup"] = {
			source = 'scr_trials_game',
			line = 238,
			constructor = false,
			base = nil,
			params = {}
		},
		["trials_script_call"] = {
			source = 'scr_trials_game',
			line = 250,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'arg', value = [=[undefined]=] },
			}
		},
		["trials_grant_score"] = {
			source = 'scr_trials_game',
			line = 266,
			constructor = false,
			base = nil,
			params = {
				{ name = 'points', value = [=[1]=] },
			}
		},
		["trials_game_end"] = {
			source = 'scr_trials_game',
			line = 275,
			constructor = false,
			base = nil,
			params = {
				{ name = 'postpone_menu_spawn', value = [=[false]=] },
			}
		},
		["trials_objective_update_auto_end"] = {
			source = 'scr_trials_game',
			line = 311,
			constructor = false,
			base = nil,
			params = {}
		},
		["trials_game_is_won"] = {
			source = 'scr_trials_game',
			line = 339,
			constructor = false,
			base = nil,
			params = {}
		},
		["trials_game_restart"] = {
			source = 'scr_trials_game',
			line = 358,
			constructor = false,
			base = nil,
			params = {}
		},
		["trials_setting_get"] = {
			source = 'scr_trials_game',
			line = 370,
			constructor = false,
			base = nil,
			params = {
				{ name = 'setting' },
				{ name = 'default_value' },
			}
		},
		["trials_game_score_add"] = {
			source = 'scr_trials_game',
			line = 378,
			constructor = false,
			base = nil,
			params = {
				{ name = 'amount' },
			}
		},
		["trials_time_frames_to_score"] = {
			source = 'scr_trials_game',
			line = 385,
			constructor = false,
			base = nil,
			params = {
				{ name = 'time' },
			}
		},
		["trials_score_string"] = {
			source = 'scr_trials_game',
			line = 390,
			constructor = false,
			base = nil,
			params = {
				{ name = 'points' },
				{ name = 'is_time' },
			}
		},
		["trials_spawn_score_orbs"] = {
			source = 'scr_trials_game',
			line = 415,
			constructor = false,
			base = nil,
			params = {
				{ name = 'target' },
				{ name = 'n' },
				{ name = 'show_number' },
			}
		},
		["input_check_axis"] = {
			source = 'input_check_axis',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = '_gm' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["input_check_long_released"] = {
			source = 'input_check_long_released',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb' },
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_buffer_duration', value = [=[0]=] },
			}
		},
		["on_bounce"] = {
			source = 'oEfBrain-Create',
			line = 10,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oHuntressTrirang_create_deserialize"] = {
			source = '__lf_oHuntressTrirang_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_ignore_key_add"] = {
			source = 'input_ignore_key_add',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_key' },
			}
		},
		["set_state"] = {
			source = 'oArtiSnap-Create',
			line = 32,
			constructor = false,
			base = nil,
			params = {
				{ name = 'new_state' },
				{ name = 'should_network', value = [=[true]=] },
			}
		},
		["input_gamepad_get_map"] = {
			source = 'input_gamepad_get_map',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_index' },
			}
		},
		["input_profile_set"] = {
			source = 'input_profile_set',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_profile_name' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["control_can_rebind"] = {
			source = 'control_can_rebind',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'i' },
				{ name = 'profile' },
			}
		},
		["__input_key_get_name"] = {
			source = '__input_key_get_name',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = '_key' },
			}
		},
		["RunPostgameReport"] = {
			source = 'scr_player_game_report',
			line = 7,
			constructor = true,
			base = nil,
			params = {}
		},
		["write_runpostgamereport"] = {
			source = 'scr_player_game_report',
			line = 95,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'report' },
			}
		},
		["read_runpostgamereport"] = {
			source = 'scr_player_game_report',
			line = 123,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["RunPostgameReport_clone"] = {
			source = 'scr_player_game_report',
			line = 158,
			constructor = false,
			base = nil,
			params = {
				{ name = 'report' },
			}
		},
		["PlayerPostgameResult"] = {
			source = 'scr_player_game_report',
			line = 168,
			constructor = true,
			base = nil,
			params = {}
		},
		["write_playerpostgameresult"] = {
			source = 'scr_player_game_report',
			line = 229,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'struct' },
			}
		},
		["read_playerpostgameresult"] = {
			source = 'scr_player_game_report',
			line = 254,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'VERSION', value = [=[GAME_REPORT_VERSION_CURRENT]=] },
			}
		},
		["PlayerGameReport"] = {
			source = 'scr_player_game_report',
			line = 282,
			constructor = true,
			base = nil,
			params = {
				{ name = 'copy_from', value = [=[undefined]=] },
			}
		},
		["write_playergamereport"] = {
			source = 'scr_player_game_report',
			line = 457,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'pgr' },
			}
		},
		["read_playergamereport"] = {
			source = 'scr_player_game_report',
			line = 467,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'VERSION', value = [=[GAME_REPORT_VERSION_CURRENT]=] },
			}
		},
		["PrefsFile"] = {
			source = 'scr_prefsFile',
			line = 6,
			constructor = true,
			base = nil,
			params = {}
		},
		["prefs_file_serialize"] = {
			source = 'scr_prefsFile',
			line = 119,
			constructor = false,
			base = nil,
			params = {
				{ name = 'prefs' },
			}
		},
		["prefs_file_deserialize"] = {
			source = 'scr_prefsFile',
			line = 195,
			constructor = false,
			base = nil,
			params = {
				{ name = 'str' },
			}
		},
		["gamepad_get_available_ids"] = {
			source = 'gamepad_get_available_ids',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_player_ghost_set"] = {
			source = 'input_player_ghost_set',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_state' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["__net_packet_sync_position_motion_write__"] = {
			source = 'scr_network_packets_actor',
			line = 32,
			constructor = false,
			base = nil,
			params = {
				{ name = 'skill_index' },
			}
		},
		["__net_packet_sync_position_motion_read__"] = {
			source = 'scr_network_packets_actor',
			line = 35,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_actor_teleport_write__"] = {
			source = 'scr_network_packets_actor',
			line = 43,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_actor_teleport_read__"] = {
			source = 'scr_network_packets_actor',
			line = 47,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_actor_elite_teleport_write__"] = {
			source = 'scr_network_packets_actor',
			line = 62,
			constructor = false,
			base = nil,
			params = {
				{ name = 'skill_index' },
			}
		},
		["__net_packet_actor_elite_teleport_read__"] = {
			source = 'scr_network_packets_actor',
			line = 65,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_actor_position_info_write__"] = {
			source = 'scr_network_packets_actor',
			line = 83,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_actor_position_info_read__"] = {
			source = 'scr_network_packets_actor',
			line = 109,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_activate_skill_write__"] = {
			source = 'scr_network_packets_actor',
			line = 137,
			constructor = false,
			base = nil,
			params = {
				{ name = 'skill_index' },
				{ name = 'sync_x' },
				{ name = 'sync_y' },
				{ name = 'sync_hsp' },
				{ name = 'sync_vsp' },
			}
		},
		["__net_packet_activate_skill_read__"] = {
			source = 'scr_network_packets_actor',
			line = 155,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_bounce_geyser_write__"] = {
			source = 'scr_network_packets_actor',
			line = 185,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_bounce_geyser_read__"] = {
			source = 'scr_network_packets_actor',
			line = 188,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_npc_knockback_write__"] = {
			source = 'scr_network_packets_actor',
			line = 199,
			constructor = false,
			base = nil,
			params = {
				{ name = 'kind' },
				{ name = 'dir' },
				{ name = 'amount' },
				{ name = 'value' },
			}
		},
		["__net_packet_npc_knockback_read__"] = {
			source = 'scr_network_packets_actor',
			line = 206,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_actor_dead_write__"] = {
			source = 'scr_network_packets_actor',
			line = 220,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_actor_dead_read__"] = {
			source = 'scr_network_packets_actor',
			line = 224,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_lizardf_land_write__"] = {
			source = 'scr_network_packets_actor',
			line = 234,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_lizardf_land_read__"] = {
			source = 'scr_network_packets_actor',
			line = 238,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_actor_use_equipment_write__"] = {
			source = 'scr_network_packets_actor',
			line = 249,
			constructor = false,
			base = nil,
			params = {
				{ name = 'equipment_index' },
				{ name = 'ignore_cooldown' },
				{ name = 'aim_dir' },
				{ name = 'double_effect' },
				{ name = 'is_chaos' },
			}
		},
		["__net_packet_actor_use_equipment_read__"] = {
			source = 'scr_network_packets_actor',
			line = 260,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_enemy_despawn_oob_write__"] = {
			source = 'scr_network_packets_actor',
			line = 271,
			constructor = false,
			base = nil,
			params = {
				{ name = 'is_oob' },
			}
		},
		["__net_packet_enemy_despawn_oob_read__"] = {
			source = 'scr_network_packets_actor',
			line = 274,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_set_actor_state_write__"] = {
			source = 'scr_network_packets_actor',
			line = 286,
			constructor = false,
			base = nil,
			params = {
				{ name = 'state_id' },
			}
		},
		["__net_packet_set_actor_state_read__"] = {
			source = 'scr_network_packets_actor',
			line = 308,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_heal_barrier_write__"] = {
			source = 'scr_network_packets_actor',
			line = 345,
			constructor = false,
			base = nil,
			params = {
				{ name = 'amount' },
			}
		},
		["__net_packet_heal_barrier_read__"] = {
			source = 'scr_network_packets_actor',
			line = 348,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_mark_as_crown_boss_write__"] = {
			source = 'scr_network_packets_actor',
			line = 358,
			constructor = false,
			base = nil,
			params = {
				{ name = 'should_drop_item' },
			}
		},
		["__net_packet_mark_as_crown_boss_read__"] = {
			source = 'scr_network_packets_actor',
			line = 361,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_grant_equipment_cdr_write__"] = {
			source = 'scr_network_packets_actor',
			line = 370,
			constructor = false,
			base = nil,
			params = {
				{ name = 'amount' },
			}
		},
		["__net_packet_grant_equipment_cdr_read__"] = {
			source = 'scr_network_packets_actor',
			line = 373,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_bramble_set_head_target_write__"] = {
			source = 'scr_network_packets_actor',
			line = 381,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_bramble_set_head_target_read__"] = {
			source = 'scr_network_packets_actor',
			line = 384,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_key_macg_write__"] = {
			source = 'scr_network_packets_actor',
			line = 391,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_key_macg_read__"] = {
			source = 'scr_network_packets_actor',
			line = 397,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_lizardr_set_rider_write__"] = {
			source = 'scr_network_packets_actor',
			line = 405,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_lizardr_set_rider_read__"] = {
			source = 'scr_network_packets_actor',
			line = 408,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_actor_skill_restock_write__"] = {
			source = 'scr_network_packets_actor',
			line = 417,
			constructor = false,
			base = nil,
			params = {
				{ name = 'index' },
				{ name = 'ignore_stock_cap' },
				{ name = 'raw' },
			}
		},
		["__net_packet_actor_skill_restock_read__"] = {
			source = 'scr_network_packets_actor',
			line = 423,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_merc_c_refresh_write__"] = {
			source = 'scr_network_packets_actor',
			line = 435,
			constructor = false,
			base = nil,
			params = {
				{ name = 'is_refund' },
				{ name = 'is_success' },
			}
		},
		["__net_packet_merc_c_refresh_read__"] = {
			source = 'scr_network_packets_actor',
			line = 439,
			constructor = false,
			base = nil,
			params = {}
		},
		["keyboard_key_is_valid_rebind"] = {
			source = 'keyboard_key_is_valid_rebind',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'scancode' },
			}
		},
		["__input_finalize_verb_groups"] = {
			source = '__input_finalize_verb_groups',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oShellMissile_create_serialize"] = {
			source = '__lf_oShellMissile_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["actor_skin_set"] = {
			source = 'actor_skin_set',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'skin' },
			}
		},
		["player_grant_equipment_cooldown_reduction"] = {
			source = 'player_grant_equipment_cooldown_reduction',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
				{ name = 'amount' },
			}
		},
		["virtual_keyboard_show"] = {
			source = 'show_virtual_keyboard',
			line = 10,
			constructor = false,
			base = nil,
			params = {}
		},
		["virtual_keyboard_hide"] = {
			source = 'show_virtual_keyboard',
			line = 27,
			constructor = false,
			base = nil,
			params = {}
		},
		["VirtualKeyboardResultStruct"] = {
			source = 'show_virtual_keyboard',
			line = 32,
			constructor = false,
			base = nil,
			params = {}
		},
		["damager_calculate_damage"] = {
			source = 'damager_calculate_damage',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = 'hit_info' },
				{ name = 'true_hit' },
				{ name = 'hit' },
				{ name = 'damage' },
				{ name = 'critical' },
				{ name = 'parent' },
				{ name = 'proc' },
				{ name = 'attack_flags' },
				{ name = 'damage_col' },
				{ name = 'team' },
				{ name = 'climb' },
				{ name = 'percent_hp' },
				{ name = 'xscale' },
				{ name = 'hit_x' },
				{ name = 'hit_y' },
			}
		},
		["__lf_oEfBossStar_create_deserialize"] = {
			source = '__lf_oEfBossStar_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oChefPot_create_serialize"] = {
			source = '__lf_oChefPot_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["load_step_add"] = {
			source = 'oLoadScreen-Create',
			line = 34,
			constructor = false,
			base = nil,
			params = {
				{ name = 'func' },
			}
		},
		["load_step_add_global_event"] = {
			source = 'oLoadScreen-Create',
			line = 39,
			constructor = false,
			base = nil,
			params = {
				{ name = 'event' },
			}
		},
		["item_log_create"] = {
			source = 'scr_ItemLog',
			line = 93,
			constructor = false,
			base = nil,
			params = {
				{ name = 'namespace' },
				{ name = 'name' },
				{ name = 'group', value = [=[undefined]=] },
				{ name = 'sprite_id', value = [=[undefined]=] },
				{ name = 'object_id', value = [=[undefined]=] },
			}
		},
		["item_log_set_group"] = {
			source = 'scr_ItemLog',
			line = 137,
			constructor = false,
			base = nil,
			params = {
				{ name = 'log_id' },
				{ name = 'group' },
			}
		},
		["item_log_get_save_key_got"] = {
			source = 'scr_ItemLog',
			line = 155,
			constructor = false,
			base = nil,
			params = {
				{ name = 'log_id' },
			}
		},
		["item_log_get_save_key_viewed"] = {
			source = 'scr_ItemLog',
			line = 156,
			constructor = false,
			base = nil,
			params = {
				{ name = 'log_id' },
			}
		},
		["item_log_get_token_priority"] = {
			source = 'scr_ItemLog',
			line = 158,
			constructor = false,
			base = nil,
			params = {
				{ name = 'log_id' },
			}
		},
		["_mod_console_registerCommandSignature"] = {
			source = 'scr_luaAPI_console',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
			}
		},
		["_mod_console_get"] = {
			source = 'scr_luaAPI_console',
			line = 11,
			constructor = false,
			base = nil,
			params = {
				{ name = 'index' },
			}
		},
		["get_platform_provider"] = {
			source = 'PLATFORM',
			line = 85,
			constructor = false,
			base = nil,
			params = {}
		},
		["PlatformProvider_generic"] = {
			source = 'PLATFORM',
			line = 98,
			constructor = true,
			base = nil,
			params = {}
		},
		["get_system_language"] = {
			source = 'PLATFORM',
			line = 102,
			constructor = false,
			base = nil,
			params = {}
		},
		["display_system_virtual_keyboard"] = {
			source = 'PLATFORM',
			line = 108,
			constructor = false,
			base = nil,
			params = {
				{ name = 'initial_string' },
				{ name = 'callback_kb_closed' },
			}
		},
		["hide_system_virtual_keyboard"] = {
			source = 'PLATFORM',
			line = 112,
			constructor = false,
			base = nil,
			params = {}
		},
		["multi_is_in_lobby"] = {
			source = 'PLATFORM',
			line = 117,
			constructor = false,
			base = nil,
			params = {}
		},
		["multi_lobby_get_member_count"] = {
			source = 'PLATFORM',
			line = 118,
			constructor = false,
			base = nil,
			params = {}
		},
		["multi_lobby_get_visbility"] = {
			source = 'PLATFORM',
			line = 119,
			constructor = false,
			base = nil,
			params = {}
		},
		["multi_lobby_get_owner_id"] = {
			source = 'PLATFORM',
			line = 120,
			constructor = false,
			base = nil,
			params = {}
		},
		["multi_lobby_get_member_id"] = {
			source = 'PLATFORM',
			line = 121,
			constructor = false,
			base = nil,
			params = {
				{ name = 'index' },
			}
		},
		["PlatformProvider_steam"] = {
			source = 'PLATFORM',
			line = 141,
			constructor = true,
			base = [=[PlatformProvider_generic(]=],
			params = {}
		},
		["get_system_language"] = {
			source = 'PLATFORM',
			line = 143,
			constructor = false,
			base = nil,
			params = {}
		},
		["display_system_virtual_keyboard"] = {
			source = 'PLATFORM',
			line = 148,
			constructor = false,
			base = nil,
			params = {
				{ name = 'initial_string' },
				{ name = 'max_length' },
				{ name = 'callback_kb_closed' },
				{ name = 'flags' },
			}
		},
		["hide_system_virtual_keyboard"] = {
			source = 'PLATFORM',
			line = 163,
			constructor = false,
			base = nil,
			params = {}
		},
		["multi_is_in_lobby"] = {
			source = 'PLATFORM',
			line = 170,
			constructor = false,
			base = nil,
			params = {}
		},
		["multi_lobby_get_member_count"] = {
			source = 'PLATFORM',
			line = 189,
			constructor = false,
			base = nil,
			params = {}
		},
		["multi_lobby_get_visbility"] = {
			source = 'PLATFORM',
			line = 194,
			constructor = false,
			base = nil,
			params = {}
		},
		["multi_lobby_get_owner_id"] = {
			source = 'PLATFORM',
			line = 204,
			constructor = false,
			base = nil,
			params = {}
		},
		["multi_lobby_get_member_id"] = {
			source = 'PLATFORM',
			line = 208,
			constructor = false,
			base = nil,
			params = {
				{ name = 'index' },
			}
		},
		["switch_controller_support_setup_players"] = {
			source = 'PLATFORM',
			line = 239,
			constructor = false,
			base = nil,
			params = {
				{ name = 'max_players' },
			}
		},
		["PlatformProvider_switch"] = {
			source = 'PLATFORM',
			line = 249,
			constructor = true,
			base = [=[PlatformProvider_generic(]=],
			params = {}
		},
		["get_system_language"] = {
			source = 'PLATFORM',
			line = 251,
			constructor = false,
			base = nil,
			params = {}
		},
		["display_system_virtual_keyboard"] = {
			source = 'PLATFORM',
			line = 283,
			constructor = false,
			base = nil,
			params = {
				{ name = 'initial_string' },
				{ name = 'max_length' },
				{ name = 'callback_kb_closed' },
				{ name = 'flags' },
			}
		},
		["hide_system_virtual_keyboard"] = {
			source = 'PLATFORM',
			line = 299,
			constructor = false,
			base = nil,
			params = {}
		},
		["multi_is_in_lobby"] = {
			source = 'PLATFORM',
			line = 305,
			constructor = false,
			base = nil,
			params = {}
		},
		["multi_lobby_get_member_count"] = {
			source = 'PLATFORM',
			line = 310,
			constructor = false,
			base = nil,
			params = {}
		},
		["multi_lobby_get_owner_id"] = {
			source = 'PLATFORM',
			line = 315,
			constructor = false,
			base = nil,
			params = {}
		},
		["multi_lobby_get_member_id"] = {
			source = 'PLATFORM',
			line = 319,
			constructor = false,
			base = nil,
			params = {
				{ name = 'index' },
			}
		},
		["is_new_achievement_unlocked"] = {
			source = 'is_new_achievement_unlocked',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_binding_swap"] = {
			source = 'input_binding_swap',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb_a' },
				{ name = '_alternate_a' },
				{ name = '_verb_b' },
				{ name = '_alternate_b' },
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_profile_name', value = [=[undefined]=] },
			}
		},
		["input_binding_get_source_type"] = {
			source = 'input_binding_get_source_type',
			line = 10,
			constructor = false,
			base = nil,
			params = {
				{ name = '_binding' },
			}
		},
		["input_consume"] = {
			source = 'input_consume',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["actor_knockback_should_inflict"] = {
			source = 'actor_knockback_inflict',
			line = 13,
			constructor = false,
			base = nil,
			params = {
				{ name = 'hit' },
				{ name = 'damage' },
			}
		},
		["actor_knockback_inflict"] = {
			source = 'actor_knockback_inflict',
			line = 17,
			constructor = false,
			base = nil,
			params = {
				{ name = 'target' },
				{ name = 'kind' },
				{ name = 'dir' },
				{ name = 'amount', value = [=[20]=] },
				{ name = 'value', value = [=[3]=] },
			}
		},
		["actor_knockback_inflict_internal"] = {
			source = 'actor_knockback_inflict',
			line = 50,
			constructor = false,
			base = nil,
			params = {
				{ name = 'kind' },
				{ name = 'dir' },
				{ name = 'amount' },
				{ name = 'value' },
			}
		},
		["input_combo_get_phase"] = {
			source = 'input_combo_get_phase',
			line = 7,
			constructor = false,
			base = nil,
			params = {
				{ name = '_name' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["trials_callbacks_bind"] = {
			source = 'scr_trials_game_callbacks',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["trials_callbacks_unbind"] = {
			source = 'scr_trials_game_callbacks',
			line = 32,
			constructor = false,
			base = nil,
			params = {}
		},
		["trials_grant_items_from_json_array"] = {
			source = 'scr_trials_game_callbacks',
			line = 47,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'arr' },
			}
		},
		["_trials_onPlayerInit"] = {
			source = 'scr_trials_game_callbacks',
			line = 60,
			constructor = false,
			base = nil,
			params = {
				{ name = 'p' },
			}
		},
		["_trials_onEnemyInit"] = {
			source = 'scr_trials_game_callbacks',
			line = 91,
			constructor = false,
			base = nil,
			params = {
				{ name = 'e' },
			}
		},
		["_trials_onStageStart"] = {
			source = 'scr_trials_game_callbacks',
			line = 96,
			constructor = false,
			base = nil,
			params = {}
		},
		["_trials_onDirectorPopulateSpawnArrays"] = {
			source = 'scr_trials_game_callbacks',
			line = 115,
			constructor = false,
			base = nil,
			params = {}
		},
		["_trials_onGameStart"] = {
			source = 'scr_trials_game_callbacks',
			line = 135,
			constructor = false,
			base = nil,
			params = {}
		},
		["_trials_onStep"] = {
			source = 'scr_trials_game_callbacks',
			line = 187,
			constructor = false,
			base = nil,
			params = {}
		},
		["_trials_onHUDDraw"] = {
			source = 'scr_trials_game_callbacks',
			line = 201,
			constructor = false,
			base = nil,
			params = {}
		},
		["arcCalcXspeed"] = {
			source = 'arcCalcXspeed',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'yspeed' },
				{ name = 'grav' },
				{ name = 'spawn_x' },
				{ name = 'spawn_y' },
				{ name = 'impact_x' },
				{ name = 'impact_y' },
			}
		},
		["scribble_trim_width"] = {
			source = 'scribble_trim_width',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = '_draw_string' },
				{ name = '_max_width' },
				{ name = '_to_word', value = [=[true]=] },
				{ name = '_append_colour_tag', value = [=[true]=] },
				{ name = '_append_ellipsis', value = [=[true]=] },
			}
		},
		["graphics_quality_update"] = {
			source = 'graphics_quality_update',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oBanditGrenade_create_deserialize"] = {
			source = '__lf_oBanditGrenade_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["damager_proc_posthit_clientandserver"] = {
			source = 'damager_proc_posthit_clientandserver',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = '_parent' },
				{ name = 'critical' },
				{ name = 'attack_flags' },
				{ name = 'hit_number' },
			}
		},
		["item_spawn_draw_flash"] = {
			source = 'item_spawn_draw_flash',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'dx', value = [=[x]=] },
				{ name = 'dy', value = [=[y]=] },
				{ name = 'alpha', value = [=[1]=] },
			}
		},
		["pickup_draw_sprite"] = {
			source = 'item_spawn_draw_flash',
			line = 21,
			constructor = false,
			base = nil,
			params = {
				{ name = 'dx' },
				{ name = 'dy' },
				{ name = 'alpha' },
			}
		},
		["__lf_oAcridSpit_create_deserialize"] = {
			source = '__lf_oAcridSpit_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oArtiPlatform_create_deserialize"] = {
			source = '__lf_oArtiPlatform_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oShamGBlock_create_serialize"] = {
			source = '__lf_oShamGBlock_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_language_setKey"] = {
			source = 'scr_luaApi_language',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'key' },
				{ name = 'str' },
			}
		},
		["_mod_language_getLanguageName"] = {
			source = 'scr_luaApi_language',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["__input_binding_get_label"] = {
			source = '__input_binding_get_label',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = '_type' },
				{ name = '_value' },
				{ name = '_axis_negative' },
			}
		},
		["input_profile_get_array"] = {
			source = 'input_profile_get_array',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["keyboard_key_get_sprite"] = {
			source = 'keyboard_key_get_sprite',
			line = 26,
			constructor = false,
			base = nil,
			params = {
				{ name = 'key_name' },
				{ name = 'size' },
			}
		},
		["keyboard_key_get_sprite_string"] = {
			source = 'keyboard_key_get_sprite',
			line = 182,
			constructor = false,
			base = nil,
			params = {
				{ name = 'key_name' },
			}
		},
		["EnemyParty"] = {
			source = 'scr_enemyParty',
			line = 12,
			constructor = true,
			base = nil,
			params = {}
		},
		["write_enemyparty"] = {
			source = 'scr_enemyParty',
			line = 150,
			constructor = false,
			base = nil,
			params = {
				{ name = 'ep' },
			}
		},
		["read_enemyparty"] = {
			source = 'scr_enemyParty',
			line = 174,
			constructor = false,
			base = nil,
			params = {}
		},
		["actor_add_to_enemy_party"] = {
			source = 'scr_enemyParty',
			line = 207,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'party' },
			}
		},
		["actor_create_enemy_party_from_ids"] = {
			source = 'scr_enemyParty',
			line = 218,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor_ids' },
			}
		},
		["__net_packet_achievement_add_progress_packet_write__"] = {
			source = 'scr_network_packets_unlocks',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = 'ach_id' },
				{ name = 'amount' },
			}
		},
		["__net_packet_achievement_add_progress_packet_read__"] = {
			source = 'scr_network_packets_unlocks',
			line = 10,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_sync_available_unlocks_write__"] = {
			source = 'scr_network_packets_unlocks',
			line = 23,
			constructor = false,
			base = nil,
			params = {
				{ name = 'unlocks_string' },
			}
		},
		["__net_packet_sync_available_unlocks_read__"] = {
			source = 'scr_network_packets_unlocks',
			line = 26,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oLizardRSpear_create_serialize"] = {
			source = '__lf_oLizardRSpear_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_binding_threshold_get"] = {
			source = 'input_binding_threshold_get',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_binding' },
			}
		},
		["player_get_color"] = {
			source = 'scr_player',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player,bright', value = [=[0]=] },
			}
		},
		["player_index_get_color"] = {
			source = 'scr_player',
			line = 8,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player_index,bright', value = [=[0]=] },
			}
		},
		["player_get_gold"] = {
			source = 'scr_player',
			line = 13,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
			}
		},
		["player_set_user_name"] = {
			source = 'scr_player',
			line = 24,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
				{ name = 'user_name' },
			}
		},
		["input_cursor_capture_mouse_get"] = {
			source = 'input_mouse_capture_get',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["__input_csv_to_array"] = {
			source = '__input_csv_to_array',
			line = 11,
			constructor = false,
			base = nil,
			params = {
				{ name = '_csv_string' },
				{ name = '_cell_delimiter', value = [=[","]=] },
				{ name = '_string_delimiter', value = [=["\""]=] },
			}
		},
		["draw_surface_scaled_supersample"] = {
			source = 'draw_surface_supersample',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = 'resample_surf' },
				{ name = 'surf' },
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'w' },
				{ name = 'h' },
				{ name = 'scale' },
				{ name = 'blend', value = [=[c_white]=] },
				{ name = 'alpha', value = [=[1]=] },
				{ name = 'force_opaque', value = [=[false]=] },
			}
		},
		["set_burrowed"] = {
			source = 'oWorm-Create',
			line = 54,
			constructor = false,
			base = nil,
			params = {
				{ name = 'burrowed' },
			}
		},
		["__input_class_combo_state"] = {
			source = '__input_class_combo_state',
			line = 1,
			constructor = true,
			base = nil,
			params = {
				{ name = '_name' },
				{ name = '_combo_definition_struct' },
			}
		},
		["input_gamepad_value"] = {
			source = 'input_gamepad_value',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_index' },
				{ name = '_gm' },
			}
		},
		["input_default_key"] = {
			source = 'input_default_key',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["PlayerInfo"] = {
			source = 'scr_player_info',
			line = 3,
			constructor = true,
			base = nil,
			params = {}
		},
		["PlayerLobbyChoiceInfo"] = {
			source = 'scr_player_info',
			line = 42,
			constructor = true,
			base = nil,
			params = {
				{ name = 'survivor_choice', value = [=[0]=] },
				{ name = 'preplayer_id', value = [=[noone]=] },
				{ name = 'loadout_selection', value = [=[undefined]=] },
				{ name = 'input_player_index', value = [=[-1]=] },
				{ name = 'balance_config', value = [=[new PlayerBalanceConfig()]=] },
			}
		},
		["input_players_get_status"] = {
			source = 'input_players_get_status',
			line = 18,
			constructor = false,
			base = nil,
			params = {}
		},
		["actor:getFacingDirection"] = {
			source = 'pActor-Create',
			line = 193,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_33"] = {
			source = '__lf_content_init_buffs_33',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_32"] = {
			source = '__lf_content_init_buffs_32',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oSpitterBullet_create_deserialize"] = {
			source = '__lf_oSpitterBullet_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_items_equipment_45"] = {
			source = '__lf_content_init_items_equipment_45',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__input_exception_handler"] = {
			source = '__input_exception_handler',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oSpitterBullet_create_serialize"] = {
			source = '__lf_oSpitterBullet_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_31"] = {
			source = '__lf_content_init_buffs_31',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_30"] = {
			source = '__lf_content_init_buffs_30',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oImpM_create_serialize"] = {
			source = '__lf_oImpM_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oImpM_create_deserialize"] = {
			source = '__lf_oImpM_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_buffer_setSeekPos"] = {
			source = 'scr_luaApi_buffer',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'pos' },
			}
		},
		["__lf_content_init_buffs_29"] = {
			source = '__lf_content_init_buffs_29',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_27"] = {
			source = '__lf_content_init_buffs_27',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_28"] = {
			source = '__lf_content_init_buffs_28',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_survivor_commando_4_1"] = {
			source = '__lf_content_init_survivor_commando_4_1',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["__lf_content_init_survivor_commando_1_"] = {
			source = '__lf_content_init_survivor_commando_1_',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["input_cursor_coord_space_set"] = {
			source = 'input_cursor_coord_space_set',
			line = 17,
			constructor = false,
			base = nil,
			params = {
				{ name = '_coord_space' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["__lf_content_init_items_equipment_apply_equipment_buff"] = {
			source = '__lf_content_init_items_equipment_apply_equipment_buff',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
			}
		},
		["__lf_oEfMushroom_create_deserialize"] = {
			source = '__lf_oEfMushroom_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_buff_bar_remove"] = {
			source = '__lf_content_init_buffs_buff_bar_remove',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_buffs_buff_bar_update"] = {
			source = '__lf_content_init_buffs_buff_bar_update',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'iindex' },
				{ name = 'color' },
				{ name = 'ttime' },
				{ name = 'bottom', value = [=[false]=] },
			}
		},
		["__lf_oEfMushroom_create_serialize"] = {
			source = '__lf_oEfMushroom_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfJewel_create_serialize"] = {
			source = '__lf_oEfJewel_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__input_load_blacklist_csv"] = {
			source = '__input_load_blacklist_csv',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = '_filename' },
			}
		},
		["__lf_oSniperDrone_create_deserialize"] = {
			source = '__lf_oSniperDrone_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oSniperDrone_create_serialize"] = {
			source = '__lf_oSniperDrone_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_pPickup_step_unlock_log"] = {
			source = '__lf_pPickup_step_unlock_log',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["__lf_pPickup_step_get_item_id"] = {
			source = '__lf_pPickup_step_get_item_id',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_pPickup_step_collect_item"] = {
			source = '__lf_pPickup_step_collect_item',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
			}
		},
		["do_on_frame_system_init"] = {
			source = 'scr_do_on_frame',
			line = 7,
			constructor = false,
			base = nil,
			params = {}
		},
		["do_on_frame_system_update"] = {
			source = 'scr_do_on_frame',
			line = 21,
			constructor = false,
			base = nil,
			params = {}
		},
		["do_on_frame"] = {
			source = 'scr_do_on_frame',
			line = 39,
			constructor = false,
			base = nil,
			params = {
				{ name = 'frame_index' },
				{ name = 'func' },
			}
		},
		["do_in_frames"] = {
			source = 'scr_do_on_frame',
			line = 53,
			constructor = false,
			base = nil,
			params = {
				{ name = 'frame_relative' },
				{ name = 'func' },
			}
		},
		["do_on_frame_unregister"] = {
			source = 'scr_do_on_frame',
			line = 58,
			constructor = false,
			base = nil,
			params = {
				{ name = 'frame_index' },
				{ name = 'func' },
			}
		},
		["__lf_oWurmHead_create_deserialize"] = {
			source = '__lf_oWurmHead_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_pPickup_step_get_equipment_id"] = {
			source = '__lf_pPickup_step_get_equipment_id',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oWurmHead_create_serialize"] = {
			source = '__lf_oWurmHead_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oBossText_create_deserialize"] = {
			source = '__lf_oBossText_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oWurmMissile_create_deserialize"] = {
			source = '__lf_oWurmMissile_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oWurmMissile_create_serialize"] = {
			source = '__lf_oWurmMissile_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oBossText_create_serialize"] = {
			source = '__lf_oBossText_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_x"] = {
			source = 'input_x',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb_l' },
				{ name = '_verb_r' },
				{ name = '_verb_u' },
				{ name = '_verb_d' },
				{ name = '_player_index', value = [=[undefined]=] },
				{ name = '_most_recent', value = [=[false]=] },
			}
		},
		["__lf_oArtiNanobomb_create_deserialize"] = {
			source = '__lf_oArtiNanobomb_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oBoss1Bullet1_create_deserialize"] = {
			source = '__lf_oBoss1Bullet1_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oBoss1Bullet1_create_serialize"] = {
			source = '__lf_oBoss1Bullet1_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["trials_stage_load_room"] = {
			source = 'trials_stage_load_room',
			line = 17,
			constructor = false,
			base = nil,
			params = {
				{ name = 'path' },
			}
		},
		["trials_stage_load_temp_room"] = {
			source = 'trials_stage_load_room',
			line = 36,
			constructor = false,
			base = nil,
			params = {
				{ name = 'path' },
			}
		},
		["trials_stage_swap_temp_room"] = {
			source = 'trials_stage_load_room',
			line = 51,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oBossSkill2_create_deserialize"] = {
			source = '__lf_oBossSkill2_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_binding_set"] = {
			source = 'input_binding_set',
			line = 10,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb_name' },
				{ name = '_binding' },
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_alternate', value = [=[0]=] },
				{ name = '_profile_name', value = [=[undefined]=] },
			}
		},
		["write_instance_direct"] = {
			source = 'scr_buffer_instances',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'inst' },
			}
		},
		["read_instance_direct"] = {
			source = 'scr_buffer_instances',
			line = 10,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["write_instance"] = {
			source = 'scr_buffer_instances',
			line = 20,
			constructor = false,
			base = nil,
			params = {
				{ name = 'inst' },
			}
		},
		["read_instance"] = {
			source = 'scr_buffer_instances',
			line = 21,
			constructor = false,
			base = nil,
			params = {}
		},
		["write_target_direct"] = {
			source = 'scr_buffer_instances',
			line = 25,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'inst' },
			}
		},
		["read_target_direct"] = {
			source = 'scr_buffer_instances',
			line = 34,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["write_target"] = {
			source = 'scr_buffer_instances',
			line = 49,
			constructor = false,
			base = nil,
			params = {
				{ name = 'inst' },
			}
		},
		["read_target"] = {
			source = 'scr_buffer_instances',
			line = 50,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oBossSkill2_create_serialize"] = {
			source = '__lf_oBossSkill2_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_init_multiplayer_globals_customobject_deserialize"] = {
			source = '__lf_init_multiplayer_globals_customobject_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oBossSkill1_create_serialize"] = {
			source = '__lf_oBossSkill1_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oBossSkill1_create_deserialize"] = {
			source = '__lf_oBossSkill1_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["part_type_destroy_w"] = {
			source = 'scr_particleResource',
			line = 15,
			constructor = false,
			base = nil,
			params = {
				{ name = 'ind' },
			}
		},
		["part_type_create_w"] = {
			source = 'scr_particleResource',
			line = 18,
			constructor = false,
			base = nil,
			params = {
				{ name = 'namespace' },
				{ name = 'name' },
			}
		},
		["part_system_destroy_w"] = {
			source = 'scr_particleResource',
			line = 24,
			constructor = false,
			base = nil,
			params = {
				{ name = 'ind' },
			}
		},
		["part_system_create_w"] = {
			source = 'scr_particleResource',
			line = 27,
			constructor = false,
			base = nil,
			params = {
				{ name = 'namespace' },
				{ name = 'name' },
			}
		},
		["_mod_part_system_create"] = {
			source = 'scr_particleResource',
			line = 32,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
			}
		},
		["_mod_part_system_find"] = {
			source = 'scr_particleResource',
			line = 33,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'origin' },
			}
		},
		["_mod_part_system_findAll"] = {
			source = 'scr_particleResource',
			line = 34,
			constructor = false,
			base = nil,
			params = {
				{ name = 'origin' },
			}
		},
		["_mod_part_system_get_name"] = {
			source = 'scr_particleResource',
			line = 35,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sprite' },
			}
		},
		["_mod_part_system_get_namespace"] = {
			source = 'scr_particleResource',
			line = 36,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sprite' },
			}
		},
		["_mod_part_system_get_netID"] = {
			source = 'scr_particleResource',
			line = 37,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sprite' },
			}
		},
		["_mod_part_system_from_netID"] = {
			source = 'scr_particleResource',
			line = 38,
			constructor = false,
			base = nil,
			params = {
				{ name = 'nid' },
			}
		},
		["_mod_part_system_from_id"] = {
			source = 'scr_particleResource',
			line = 39,
			constructor = false,
			base = nil,
			params = {
				{ name = 'nid' },
			}
		},
		["_mod_part_system_is_valid"] = {
			source = 'scr_particleResource',
			line = 40,
			constructor = false,
			base = nil,
			params = {
				{ name = 'nid' },
			}
		},
		["_mod_part_system_depth"] = {
			source = 'scr_particleResource',
			line = 42,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sys' },
				{ name = 'val' },
			}
		},
		["_mod_part_system_position"] = {
			source = 'scr_particleResource',
			line = 43,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sys' },
				{ name = 'tx' },
				{ name = 'ty' },
			}
		},
		["_mod_part_system_clear"] = {
			source = 'scr_particleResource',
			line = 44,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sys' },
			}
		},
		["_mod_part_system_count"] = {
			source = 'scr_particleResource',
			line = 45,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sys' },
			}
		},
		["_mod_part_system_automatic_update"] = {
			source = 'scr_particleResource',
			line = 46,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sys' },
				{ name = 'val' },
			}
		},
		["_mod_part_system_automatic_draw"] = {
			source = 'scr_particleResource',
			line = 47,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sys' },
				{ name = 'val' },
			}
		},
		["_mod_part_system_drawit"] = {
			source = 'scr_particleResource',
			line = 48,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sys' },
			}
		},
		["_mod_part_system_update"] = {
			source = 'scr_particleResource',
			line = 49,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sys' },
			}
		},
		["_mod_part_system_draw_order"] = {
			source = 'scr_particleResource',
			line = 50,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sys' },
				{ name = 'val' },
			}
		},
		["_mod_part_type_create"] = {
			source = 'scr_particleResource',
			line = 52,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
			}
		},
		["_mod_part_type_find"] = {
			source = 'scr_particleResource',
			line = 53,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'origin' },
			}
		},
		["_mod_part_type_findAll"] = {
			source = 'scr_particleResource',
			line = 54,
			constructor = false,
			base = nil,
			params = {
				{ name = 'origin' },
			}
		},
		["_mod_part_type_get_name"] = {
			source = 'scr_particleResource',
			line = 55,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sprite' },
			}
		},
		["_mod_part_type_get_namespace"] = {
			source = 'scr_particleResource',
			line = 56,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sprite' },
			}
		},
		["_mod_part_type_get_netID"] = {
			source = 'scr_particleResource',
			line = 57,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sprite' },
			}
		},
		["_mod_part_type_from_netID"] = {
			source = 'scr_particleResource',
			line = 58,
			constructor = false,
			base = nil,
			params = {
				{ name = 'nid' },
			}
		},
		["_mod_part_type_from_id"] = {
			source = 'scr_particleResource',
			line = 59,
			constructor = false,
			base = nil,
			params = {
				{ name = 'nid' },
			}
		},
		["_mod_part_type_is_valid"] = {
			source = 'scr_particleResource',
			line = 60,
			constructor = false,
			base = nil,
			params = {
				{ name = 'nid' },
			}
		},
		["_mod_particles_create"] = {
			source = 'scr_particleResource',
			line = 61,
			constructor = false,
			base = nil,
			params = {
				{ name = 'system' },
				{ name = 'type' },
				{ name = '_x' },
				{ name = '_y' },
				{ name = 'amount' },
				{ name = 'color' },
			}
		},
		["_mod_part_type_alpha"] = {
			source = 'scr_particleResource',
			line = 65,
			constructor = false,
			base = nil,
			params = {
				{ name = 'type' },
				{ name = 'a1' },
				{ name = 'a2' },
				{ name = 'a3' },
			}
		},
		["_mod_part_type_color"] = {
			source = 'scr_particleResource',
			line = 71,
			constructor = false,
			base = nil,
			params = {
				{ name = 'type' },
				{ name = 'c1' },
				{ name = 'c2' },
				{ name = 'c3' },
			}
		},
		["_mod_part_type_life"] = {
			source = 'scr_particleResource',
			line = 77,
			constructor = false,
			base = nil,
			params = {
				{ name = 'type' },
				{ name = '_min' },
				{ name = '_max' },
			}
		},
		["_mod_part_type_gravity"] = {
			source = 'scr_particleResource',
			line = 78,
			constructor = false,
			base = nil,
			params = {
				{ name = 'type' },
				{ name = 'amount' },
				{ name = 'dir' },
			}
		},
		["_mod_part_type_direction"] = {
			source = 'scr_particleResource',
			line = 79,
			constructor = false,
			base = nil,
			params = {
				{ name = 'type' },
				{ name = '_min' },
				{ name = '_max' },
				{ name = '_add' },
				{ name = '_wiggle' },
			}
		},
		["_mod_part_type_speed"] = {
			source = 'scr_particleResource',
			line = 80,
			constructor = false,
			base = nil,
			params = {
				{ name = 'type' },
				{ name = '_min' },
				{ name = '_max' },
				{ name = '_add' },
				{ name = '_wiggle' },
			}
		},
		["_mod_part_type_angle"] = {
			source = 'scr_particleResource',
			line = 81,
			constructor = false,
			base = nil,
			params = {
				{ name = 'type' },
				{ name = '_min' },
				{ name = '_max' },
				{ name = '_add' },
				{ name = '_wiggle' },
				{ name = '_relative' },
			}
		},
		["_mod_part_type_size"] = {
			source = 'scr_particleResource',
			line = 82,
			constructor = false,
			base = nil,
			params = {
				{ name = 'type' },
				{ name = '_min' },
				{ name = '_max' },
				{ name = '_add' },
				{ name = '_wiggle' },
			}
		},
		["_mod_part_type_scale"] = {
			source = 'scr_particleResource',
			line = 83,
			constructor = false,
			base = nil,
			params = {
				{ name = 'type' },
				{ name = 'xs' },
				{ name = 'ys' },
			}
		},
		["_mod_part_type_blend"] = {
			source = 'scr_particleResource',
			line = 84,
			constructor = false,
			base = nil,
			params = {
				{ name = 'type' },
				{ name = 'additive' },
			}
		},
		["_mod_part_type_clear"] = {
			source = 'scr_particleResource',
			line = 85,
			constructor = false,
			base = nil,
			params = {
				{ name = 'type' },
			}
		},
		["_mod_part_type_shape"] = {
			source = 'scr_particleResource',
			line = 86,
			constructor = false,
			base = nil,
			params = {
				{ name = 'type' },
				{ name = 'shape' },
			}
		},
		["_mod_part_type_sprite"] = {
			source = 'scr_particleResource',
			line = 87,
			constructor = false,
			base = nil,
			params = {
				{ name = 'type' },
				{ name = 'sprite' },
				{ name = 'animat' },
				{ name = 'stretch' },
				{ name = 'rand' },
			}
		},
		["_mod_part_type_step"] = {
			source = 'scr_particleResource',
			line = 88,
			constructor = false,
			base = nil,
			params = {
				{ name = 'type' },
				{ name = 'child' },
				{ name = 'amount' },
			}
		},
		["_mod_part_type_death"] = {
			source = 'scr_particleResource',
			line = 89,
			constructor = false,
			base = nil,
			params = {
				{ name = 'type' },
				{ name = 'child' },
				{ name = 'amount' },
			}
		},
		["__lf_init_multiplayer_globals_customobject_serialize"] = {
			source = '__lf_init_multiplayer_globals_customobject_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oServer_step_end_position_message_end"] = {
			source = '__lf_oServer_step_end_position_message_end',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["input_source_detect_input"] = {
			source = 'input_source_detect_input',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_source' },
				{ name = '_available_only', value = [=[true]=] },
			}
		},
		["__lf_oServer_step_end_position_message_write_instance"] = {
			source = '__lf_oServer_step_end_position_message_write_instance',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_oServer_step_end_position_message_start"] = {
			source = '__lf_oServer_step_end_position_message_start',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEngiTurret_create_serialize"] = {
			source = '__lf_oEngiTurret_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEngiTurret_create_deserialize"] = {
			source = '__lf_oEngiTurret_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oImpFriend_create_deserialize"] = {
			source = '__lf_oImpFriend_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oImpFriend_create_serialize"] = {
			source = '__lf_oImpFriend_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oTurtleMissile_create_calculate_speed"] = {
			source = '__lf_oTurtleMissile_create_calculate_speed',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oDrifterRec_create_deserialize"] = {
			source = '__lf_oDrifterRec_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oTurtleMissile_create_deserialize"] = {
			source = '__lf_oTurtleMissile_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["monster_sprite_set_kill_offset"] = {
			source = 'scr_monster_kill_screen_offsets',
			line = 67,
			constructor = false,
			base = nil,
			params = {
				{ name = 'spr' },
				{ name = 'xoffs' },
				{ name = 'yoffs' },
				{ name = 'flip', value = [=[true]=] },
			}
		},
		["__lf_oEfLaserLine_create_serialize"] = {
			source = '__lf_oEfLaserLine_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oImpFriend_create_setup"] = {
			source = '__lf_oImpFriend_create_setup',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_check_double_pressed"] = {
			source = 'input_check_double_pressed',
			line = 8,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb' },
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_buffer_duration', value = [=[0]=] },
			}
		},
		["__lf_oTurtleMissile_create_serialize"] = {
			source = '__lf_oTurtleMissile_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfLaserLine_create_deserialize"] = {
			source = '__lf_oEfLaserLine_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oServer_step_end_hp_message_write_instance"] = {
			source = '__lf_oServer_step_end_hp_message_write_instance',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__net_packet_stage_transport_write__"] = {
			source = 'scr_network_packets_run',
			line = 7,
			constructor = false,
			base = nil,
			params = {
				{ name = 'new_room' },
				{ name = 'new_stage' },
				{ name = 'player_x' },
				{ name = 'player_y' },
			}
		},
		["__net_packet_stage_transport_read__"] = {
			source = 'scr_network_packets_run',
			line = 13,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_stage_load_start_write__"] = {
			source = 'scr_network_packets_run',
			line = 25,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_stage_load_start_read__"] = {
			source = 'scr_network_packets_run',
			line = 26,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_stage_load_end_write__"] = {
			source = 'scr_network_packets_run',
			line = 37,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_stage_load_end_read__"] = {
			source = 'scr_network_packets_run',
			line = 38,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_set_timestop_write__"] = {
			source = 'scr_network_packets_run',
			line = 44,
			constructor = false,
			base = nil,
			params = {
				{ name = 'value' },
			}
		},
		["__net_packet_set_timestop_read__"] = {
			source = 'scr_network_packets_run',
			line = 47,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_set_kin_choice_write__"] = {
			source = 'scr_network_packets_run',
			line = 53,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_set_kin_choice_read__"] = {
			source = 'scr_network_packets_run',
			line = 56,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_player_level_up_write__"] = {
			source = 'scr_network_packets_run',
			line = 63,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_player_level_up_read__"] = {
			source = 'scr_network_packets_run',
			line = 65,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_update_enemy_buff_write__"] = {
			source = 'scr_network_packets_run',
			line = 71,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_update_enemy_buff_read__"] = {
			source = 'scr_network_packets_run',
			line = 77,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_client_enter_pigbeach_write__"] = {
			source = 'scr_network_packets_run',
			line = 87,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_client_enter_pigbeach_read__"] = {
			source = 'scr_network_packets_run',
			line = 89,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_director_register_boss_party_write__"] = {
			source = 'scr_network_packets_run',
			line = 99,
			constructor = false,
			base = nil,
			params = {
				{ name = 'bp' },
			}
		},
		["__net_packet_director_register_boss_party_read__"] = {
			source = 'scr_network_packets_run',
			line = 102,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_set_music_write__"] = {
			source = 'scr_network_packets_run',
			line = 109,
			constructor = false,
			base = nil,
			params = {
				{ name = 'm' },
			}
		},
		["__net_packet_set_music_read__"] = {
			source = 'scr_network_packets_run',
			line = 112,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oServer_step_end_hp_message_end"] = {
			source = '__lf_oServer_step_end_hp_message_end',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["__lf_oServer_step_end_hp_message_start"] = {
			source = '__lf_oServer_step_end_hp_message_start',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oChainLightning_create_deserialize"] = {
			source = '__lf_oChainLightning_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oAcridDisease2_create_deserialize"] = {
			source = '__lf_oAcridDisease2_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oHANDBaby_create_serialize"] = {
			source = '__lf_oHANDBaby_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_binding_scan_start"] = {
			source = 'input_binding_scan_start',
			line = 45,
			constructor = false,
			base = nil,
			params = {
				{ name = '_success_method' },
				{ name = '_failure_method', value = [=[undefined]=] },
				{ name = '_source_filter', value = [=[undefined]=] },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["__lf_oDot2_create_deserialize"] = {
			source = '__lf_oDot2_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oChainLightning_create_serialize"] = {
			source = '__lf_oChainLightning_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oHANDBaby_create_deserialize"] = {
			source = '__lf_oHANDBaby_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_worm_jump_write__"] = {
			source = 'scr_network_packets_enemies',
			line = 6,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_worm_jump_read__"] = {
			source = 'scr_network_packets_enemies',
			line = 12,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfMissileSmall_create_serialize"] = {
			source = '__lf_oEfMissileSmall_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oConsRod_create_deserialize"] = {
			source = '__lf_oConsRod_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oDot2_create_serialize"] = {
			source = '__lf_oDot2_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oConsRod_create_serialize"] = {
			source = '__lf_oConsRod_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfMissileSmall_create_deserialize"] = {
			source = '__lf_oEfMissileSmall_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEngiHarpoon_create_deserialize"] = {
			source = '__lf_oEngiHarpoon_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oImpGLaser_create_serialize"] = {
			source = '__lf_oImpGLaser_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEngiHarpoon_create_serialize"] = {
			source = '__lf_oEngiHarpoon_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfIceCrystal_create_deserialize"] = {
			source = '__lf_oEfIceCrystal_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfMortar_create_deserialize"] = {
			source = '__lf_oEfMortar_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oAcridDisease2_create_serialize"] = {
			source = '__lf_oAcridDisease2_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oImpGLaser_create_deserialize"] = {
			source = '__lf_oImpGLaser_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfIceCrystal_create_serialize"] = {
			source = '__lf_oEfIceCrystal_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oAcridDisease_create_serialize"] = {
			source = '__lf_oAcridDisease_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oAcridDisease_create_deserialize"] = {
			source = '__lf_oAcridDisease_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__input_key_is_ignored"] = {
			source = '__input_key_is_ignored',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = '_key' },
			}
		},
		["UIDropdownStyle"] = {
			source = 'ui_button_dropdown',
			line = 2,
			constructor = true,
			base = nil,
			params = {
				{ name = 'props', value = [=[undefined]=] },
			}
		},
		["ui_button_dropdown"] = {
			source = 'ui_button_dropdown',
			line = 46,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'width' },
				{ name = 'choices' },
				{ name = 'active_choice_index' },
				{ name = 'align', value = [=[fa_left]=] },
				{ name = 'gp_index', value = [=[undefined]=] },
				{ name = 'style', value = [=[global.ui_styles.basic_with_hover]=] },
				{ name = 'dropdown_style', value = [=[global._ui_dropdown_style_default]=] },
				{ name = 'flags', value = [=[0]=] },
			}
		},
		["ui_get_dropdown_choice"] = {
			source = 'ui_button_dropdown',
			line = 157,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
			}
		},
		["_ui_button_dropdown_draw_internal"] = {
			source = 'ui_button_dropdown',
			line = 166,
			constructor = false,
			base = nil,
			params = {
				{ name = 'subimage' },
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'x2' },
				{ name = 'y2' },
				{ name = 'width' },
				{ name = 'height' },
				{ name = 'selected' },
				{ name = 'align' },
				{ name = 'state' },
				{ name = 'style' },
				{ name = 'dropdown_style' },
				{ name = 'flags' },
			}
		},
		["_UIDropdownActiveState"] = {
			source = 'ui_button_dropdown',
			line = 172,
			constructor = true,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'submenu' },
			}
		},
		["__lf_oEfMortar_create_serialize"] = {
			source = '__lf_oEfMortar_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oIfritBullet_create_deserialize"] = {
			source = '__lf_oIfritBullet_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oIfritBullet_create_serialize"] = {
			source = '__lf_oIfritBullet_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oSpiderBullet_create_deserialize"] = {
			source = '__lf_oSpiderBullet_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oAcridSpit_create_serialize"] = {
			source = '__lf_oAcridSpit_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oSpiderBullet_create_serialize"] = {
			source = '__lf_oSpiderBullet_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfMissileEnemy_create_deserialize"] = {
			source = '__lf_oEfMissileEnemy_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oMushDust_create_deserialize"] = {
			source = '__lf_oMushDust_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oScavengerBullet_create_deserialize"] = {
			source = '__lf_oScavengerBullet_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oMushDust_create_serialize"] = {
			source = '__lf_oMushDust_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfMissileEnemy_create_serialize"] = {
			source = '__lf_oEfMissileEnemy_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["actor_state_create"] = {
			source = 'scr_ActorState',
			line = 281,
			constructor = false,
			base = nil,
			params = {
				{ name = 'namespace' },
				{ name = 'name,' },
			}
		},
		["actor_state_system_init"] = {
			source = 'scr_ActorState',
			line = 318,
			constructor = false,
			base = nil,
			params = {}
		},
		["actor_state_system_step"] = {
			source = 'scr_ActorState',
			line = 322,
			constructor = false,
			base = nil,
			params = {}
		},
		["actor_state_system_clear_state"] = {
			source = 'scr_ActorState',
			line = 334,
			constructor = false,
			base = nil,
			params = {}
		},
		["actor_get_current_actor_state"] = {
			source = 'scr_ActorState',
			line = 343,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
			}
		},
		["actor_get_actor_state_data"] = {
			source = 'scr_ActorState',
			line = 346,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
			}
		},
		["actor_get_state_interrupt_priority"] = {
			source = 'scr_ActorState',
			line = 349,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
			}
		},
		["actor_set_state"] = {
			source = 'scr_ActorState',
			line = 358,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'state_id' },
			}
		},
		["actor_set_state_networked"] = {
			source = 'scr_ActorState',
			line = 376,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'state_id' },
			}
		},
		["actor_set_state_networked_host"] = {
			source = 'scr_ActorState',
			line = 384,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'state_id' },
			}
		},
		["actor_state_is_climb_state"] = {
			source = 'scr_ActorState',
			line = 392,
			constructor = false,
			base = nil,
			params = {
				{ name = 'state_id' },
			}
		},
		["__lf_oGuardBullet_create_deserialize"] = {
			source = '__lf_oGuardBullet_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oScavengerBullet_create_serialize"] = {
			source = '__lf_oScavengerBullet_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oJellyMissile_create_deserialize"] = {
			source = '__lf_oJellyMissile_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oGuardBullet_create_serialize"] = {
			source = '__lf_oGuardBullet_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oJellyMissile_create_serialize"] = {
			source = '__lf_oJellyMissile_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["LobbyHostVotableRuleBase"] = {
			source = 'scr_lobby_rule_settings',
			line = 15,
			constructor = true,
			base = nil,
			params = {
				{ name = 'name' },
			}
		},
		["LobbyHostVotableRuleToggle"] = {
			source = 'scr_lobby_rule_settings',
			line = 37,
			constructor = true,
			base = [=[LobbyHostVotableRuleBase(name]=],
			params = {
				{ name = 'name' },
			}
		},
		["LobbyHostVotableRuleToggleArtifact"] = {
			source = 'scr_lobby_rule_settings',
			line = 86,
			constructor = true,
			base = [=[LobbyHostVotableRuleToggle(name]=],
			params = {
				{ name = 'name' },
				{ name = 'artifact_id' },
			}
		},
		["LobbyHostVotableRuleMultiChoice"] = {
			source = 'scr_lobby_rule_settings',
			line = 91,
			constructor = true,
			base = [=[LobbyHostVotableRuleBase(name]=],
			params = {
				{ name = 'name' },
				{ name = 'default_value' },
			}
		},
		["LobbyClientVotableContainer"] = {
			source = 'scr_lobby_rule_settings',
			line = 213,
			constructor = true,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'default_vote_value' },
				{ name = 'votable', value = [=[undefined]=] },
			}
		},
		["LobbyRulebook"] = {
			source = 'scr_lobby_rule_settings',
			line = 282,
			constructor = true,
			base = nil,
			params = {}
		},
		["_tta"] = {
			source = 'scr_lobby_rule_settings',
			line = 446,
			constructor = false,
			base = nil,
			params = {
				{ name = 'p' },
				{ name = 'v' },
			}
		},
		["__lf_oJellyMissileFriendly_create_serialize"] = {
			source = '__lf_oJellyMissileFriendly_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oJellyMissileFriendly_create_deserialize"] = {
			source = '__lf_oJellyMissileFriendly_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfFirework_create_serialize"] = {
			source = '__lf_oEfFirework_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfFirework_create_deserialize"] = {
			source = '__lf_oEfFirework_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfMissileMagic_create_deserialize"] = {
			source = '__lf_oEfMissileMagic_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oHuntressBoomerang_create_deserialize"] = {
			source = '__lf_oHuntressBoomerang_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfMissileMagic_create_serialize"] = {
			source = '__lf_oEfMissileMagic_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oServer_step_end_projectile_message_write_instance"] = {
			source = '__lf_oServer_step_end_projectile_message_write_instance',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
			}
		},
		["input_multiplayer_is_finished"] = {
			source = 'input_multiplayer_is_finished',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oHuntressBoomerang_create_serialize"] = {
			source = '__lf_oHuntressBoomerang_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfMissile_create_serialize"] = {
			source = '__lf_oEfMissile_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_gamepad_constant_get_name"] = {
			source = 'input_gamepad_constant_get_name',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_gm_constant' },
			}
		},
		["__lf_oEfMissile_create_deserialize"] = {
			source = '__lf_oEfMissile_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEngiMine_create_on_activate"] = {
			source = '__lf_oEngiMine_create_on_activate',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oServer_step_end_projectile_message_end"] = {
			source = '__lf_oServer_step_end_projectile_message_end',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_oServer_step_end_projectile_message_start"] = {
			source = '__lf_oServer_step_end_projectile_message_start',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["function_dummy"] = {
			source = 'RORLIB_DUMMY',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEngiMine_create_deserialize"] = {
			source = '__lf_oEngiMine_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["actor_get_hp_total"] = {
			source = 'scr_actor_hp_utils',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
			}
		},
		["actor_get_maxhp_total"] = {
			source = 'scr_actor_hp_utils',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
			}
		},
		["actor_get_hp_percent"] = {
			source = 'scr_actor_hp_utils',
			line = 16,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
			}
		},
		["__lf_oEngiMine_create_serialize"] = {
			source = '__lf_oEngiMine_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfPoison_create_serialize"] = {
			source = '__lf_oEfPoison_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfPoison_create_deserialize"] = {
			source = '__lf_oEfPoison_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_default_gamepad_button"] = {
			source = 'input_default_gamepad_button',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfChestRain_create_deserialize"] = {
			source = '__lf_oEfChestRain_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfSawmerang_create_deserialize"] = {
			source = '__lf_oEfSawmerang_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfDecoy_create_deserialize"] = {
			source = '__lf_oEfDecoy_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfChestRain_create_serialize"] = {
			source = '__lf_oEfChestRain_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfSawmerang_create_serialize"] = {
			source = '__lf_oEfSawmerang_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfBubbleShield_create_deserialize"] = {
			source = '__lf_oEfBubbleShield_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfLantern_create_deserialize"] = {
			source = '__lf_oEfLantern_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfBubbleShield_create_serialize"] = {
			source = '__lf_oEfBubbleShield_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfDecoy_create_serialize"] = {
			source = '__lf_oEfDecoy_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfMeteorShower_create_deserialize"] = {
			source = '__lf_oEfMeteorShower_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfSmite_create_deserialize"] = {
			source = '__lf_oEfSmite_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfLantern_create_serialize"] = {
			source = '__lf_oEfLantern_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfSmite_create_serialize"] = {
			source = '__lf_oEfSmite_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfBlizzard_create_deserialize"] = {
			source = '__lf_oEfBlizzard_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfMeteorShower_create_serialize"] = {
			source = '__lf_oEfMeteorShower_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfBrain_create_serialize"] = {
			source = '__lf_oEfBrain_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfDeskPlant_create_deserialize"] = {
			source = '__lf_oEfDeskPlant_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfBlizzard_create_serialize"] = {
			source = '__lf_oEfBlizzard_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfBrain_create_deserialize"] = {
			source = '__lf_oEfBrain_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfDeskPlant_create_serialize"] = {
			source = '__lf_oEfDeskPlant_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfChain_create_serialize"] = {
			source = '__lf_oEfChain_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfScope_create_serialize"] = {
			source = '__lf_oEfScope_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfPoison2_create_deserialize"] = {
			source = '__lf_oEfPoison2_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfChain_create_deserialize"] = {
			source = '__lf_oEfChain_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_player_update_ping_write__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 7,
			constructor = false,
			base = nil,
			params = {
				{ name = 'tping' },
				{ name = 'player_m_id', value = [=[-1]=] },
			}
		},
		["__net_packet_player_update_ping_read__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 15,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_player_add_write__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 39,
			constructor = false,
			base = nil,
			params = {
				{ name = 'm_id' },
				{ name = 'class_choice' },
				{ name = 'loadout' },
				{ name = 'client_steam_id' },
				{ name = 'user_name' },
			}
		},
		["__net_packet_player_add_read__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 46,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_player_disconnected_write__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 92,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player_m_id', value = [=[-1]=] },
			}
		},
		["__net_packet_player_disconnected_read__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 97,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_player_set_ready_write__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 118,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_player_set_ready_read__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 121,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_player_chat_message_write__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 129,
			constructor = false,
			base = nil,
			params = {
				{ name = 'msg' },
			}
		},
		["__net_packet_player_chat_message_read__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 133,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_player_update_class_write__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 141,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_player_update_class_read__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 146,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_set_diff_level_write__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 203,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_set_diff_level_read__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 206,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_set_artifact_active_write__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 212,
			constructor = false,
			base = nil,
			params = {
				{ name = 'artifact' },
				{ name = 'active' },
			}
		},
		["__net_packet_set_artifact_active_read__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 216,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_set_lobby_votable_value_write__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 225,
			constructor = false,
			base = nil,
			params = {
				{ name = 'votable_name' },
				{ name = 'value' },
			}
		},
		["__net_packet_set_lobby_votable_value_read__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 229,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_set_lobby_votable_vote_count_write__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 238,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
			}
		},
		["__net_packet_set_lobby_votable_vote_count_read__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 242,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_boot_player_write__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 254,
			constructor = false,
			base = nil,
			params = {
				{ name = 'msg' },
			}
		},
		["__net_packet_boot_player_read__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 257,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_system_chat_message_write__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 268,
			constructor = false,
			base = nil,
			params = {
				{ name = 'ttype' },
				{ name = 'tstring' },
				{ name = '_user_name' },
				{ name = '_pickup_name_key' },
				{ name = '_pickup_name_subkey' },
				{ name = '_pickup_tier' },
				{ name = '_pickup_count' },
			}
		},
		["__net_packet_system_chat_message_read__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 283,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_player_sync_gold_write__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 305,
			constructor = false,
			base = nil,
			params = {
				{ name = 'gold' },
			}
		},
		["__net_packet_player_sync_gold_read__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 308,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_player_loaded_write__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 316,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_player_loaded_read__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 318,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_set_game_style_write__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 325,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_set_game_style_read__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 328,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_set_shared_intensity_write__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 337,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_set_shared_intensity_read__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 340,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_set_player_intensity_write__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 351,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_set_player_intensity_read__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 354,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_player_drone_spawn_write__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 364,
			constructor = false,
			base = nil,
			params = {
				{ name = 'mid' },
				{ name = 'xx' },
				{ name = 'yy' },
			}
		},
		["__net_packet_player_drone_spawn_read__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 369,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_player_drone_sync_move_write__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 386,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_player_drone_sync_move_read__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 398,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_player_body_sync_move_write__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 414,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_player_body_sync_move_read__"] = {
			source = 'scr_network_packets_player_and_lobby',
			line = 425,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfScope_create_deserialize"] = {
			source = '__lf_oEfScope_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfPoison2_create_serialize"] = {
			source = '__lf_oEfPoison2_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfSpikestrip_create_serialize"] = {
			source = '__lf_oEfSpikestrip_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfPoisonMine_create_deserialize"] = {
			source = '__lf_oEfPoisonMine_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfPoisonMine_create_serialize"] = {
			source = '__lf_oEfPoisonMine_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfSpikestrip_create_deserialize"] = {
			source = '__lf_oEfSpikestrip_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["_room_delete_internal"] = {
			source = 'scr_roomResource',
			line = 7,
			constructor = false,
			base = nil,
			params = {
				{ name = 'rm' },
			}
		},
		["room_add_w"] = {
			source = 'scr_roomResource',
			line = 49,
			constructor = false,
			base = nil,
			params = {
				{ name = 'namespace' },
				{ name = 'name' },
			}
		},
		["room_delete_w"] = {
			source = 'scr_roomResource',
			line = 63,
			constructor = false,
			base = nil,
			params = {
				{ name = 'rm' },
			}
		},
		["room_goto_w"] = {
			source = 'scr_roomResource',
			line = 68,
			constructor = false,
			base = nil,
			params = {
				{ name = 'rm' },
			}
		},
		["room_associate_vertex_buffer"] = {
			source = 'scr_roomResource',
			line = 76,
			constructor = false,
			base = nil,
			params = {
				{ name = 'rm' },
				{ name = 'vb' },
				{ name = 'tex' },
				{ name = 'dpth' },
			}
		},
		["CustomRoomData"] = {
			source = 'scr_roomResource',
			line = 84,
			constructor = true,
			base = nil,
			params = {
				{ name = 'room_id' },
			}
		},
		["_mod_room_get_current"] = {
			source = 'scr_roomResource',
			line = 120,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_room_get_current_width"] = {
			source = 'scr_roomResource',
			line = 121,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_room_get_current_height"] = {
			source = 'scr_roomResource',
			line = 122,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_room_create"] = {
			source = 'scr_roomResource',
			line = 123,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
			}
		},
		["_mod_room_load"] = {
			source = 'scr_roomResource',
			line = 126,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
			}
		},
		["_mod_room_find"] = {
			source = 'scr_roomResource',
			line = 130,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'origin' },
			}
		},
		["_mod_room_findAll"] = {
			source = 'scr_roomResource',
			line = 131,
			constructor = false,
			base = nil,
			params = {
				{ name = 'origin' },
			}
		},
		["_mod_room_get_name"] = {
			source = 'scr_roomResource',
			line = 132,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sprite' },
			}
		},
		["_mod_room_get_namespace"] = {
			source = 'scr_roomResource',
			line = 133,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sprite' },
			}
		},
		["_mod_room_get_netID"] = {
			source = 'scr_roomResource',
			line = 134,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sprite' },
			}
		},
		["_mod_room_from_netID"] = {
			source = 'scr_roomResource',
			line = 135,
			constructor = false,
			base = nil,
			params = {
				{ name = 'nid' },
			}
		},
		["_mod_room_from_id"] = {
			source = 'scr_roomResource',
			line = 136,
			constructor = false,
			base = nil,
			params = {
				{ name = 'nid' },
			}
		},
		["__lf_oEfMine_create_deserialize"] = {
			source = '__lf_oEfMine_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfMine_create_serialize"] = {
			source = '__lf_oEfMine_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfWarbanner_create_deserialize"] = {
			source = '__lf_oEfWarbanner_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["draw_line4"] = {
			source = 'draw_line4',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'p0x' },
				{ name = 'p0y' },
				{ name = 'p1x' },
				{ name = 'p1y' },
				{ name = 'p2x' },
				{ name = 'p2y' },
				{ name = 'p3x' },
				{ name = 'p3y' },
				{ name = 'width0' },
				{ name = 'width1' },
				{ name = 'width2' },
				{ name = 'width3' },
				{ name = 'num_samples' },
			}
		},
		["__lf_oEfWarbanner_create_serialize"] = {
			source = '__lf_oEfWarbanner_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["nodegraph_grid_init"] = {
			source = 'scr_nodeGraph',
			line = 73,
			constructor = false,
			base = nil,
			params = {}
		},
		["nodegraph_cleanup"] = {
			source = 'scr_nodeGraph',
			line = 230,
			constructor = false,
			base = nil,
			params = {}
		},
		["nodegraph_Node"] = {
			source = 'scr_nodeGraph',
			line = 258,
			constructor = true,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
			}
		},
		["nodegraph_NodeConnection"] = {
			source = 'scr_nodeGraph',
			line = 267,
			constructor = true,
			base = nil,
			params = {
				{ name = 'nodea' },
				{ name = 'nodeb' },
				{ name = 'conditions' },
			}
		},
		["nodegraph_NavigationProperties"] = {
			source = 'scr_nodeGraph',
			line = 275,
			constructor = true,
			base = nil,
			params = {}
		},
		["nodegraph_get_distance_along_connection"] = {
			source = 'scr_nodeGraph',
			line = 286,
			constructor = false,
			base = nil,
			params = {
				{ name = 'connection' },
				{ name = 'xx' },
				{ name = 'yy' },
			}
		},
		["nodegraph_get_nearest_node_SLOW"] = {
			source = 'scr_nodeGraph',
			line = 293,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
			}
		},
		["nodegraph_debug_draw_path"] = {
			source = 'scr_nodeGraph',
			line = 309,
			constructor = false,
			base = nil,
			params = {
				{ name = 'p' },
			}
		},
		["nodegraph_get_root_connection"] = {
			source = 'scr_nodeGraph',
			line = 321,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'feet_y' },
			}
		},
		["nodegraph_get_path_between_connections"] = {
			source = 'scr_nodeGraph',
			line = 335,
			constructor = false,
			base = nil,
			params = {
				{ name = 'connection_a' },
				{ name = 'connection_a_dist_normalized' },
				{ name = 'connection_b' },
				{ name = 'nav_props' },
			}
		},
		["nodegraph_get_path_random"] = {
			source = 'scr_nodeGraph',
			line = 455,
			constructor = false,
			base = nil,
			params = {
				{ name = 'connection_start' },
				{ name = 'nav_props' },
				{ name = 'max_dist_nodes' },
				{ name = 'max_dist_units' },
			}
		},
		["nodegraph_create_connection"] = {
			source = 'scr_nodeGraph',
			line = 534,
			constructor = false,
			base = nil,
			params = {
				{ name = 'node_a' },
				{ name = 'node_b' },
				{ name = 'conditions' },
				{ name = 'bidirectional' },
			}
		},
		["nodegraph_check_connection_conditions"] = {
			source = 'scr_nodeGraph',
			line = 542,
			constructor = false,
			base = nil,
			params = {
				{ name = 'child' },
				{ name = 'nav_props' },
			}
		},
		["nodegraph_init_make_connection"] = {
			source = 'scr_nodeGraph',
			line = 568,
			constructor = false,
			base = nil,
			params = {
				{ name = 'temp_grid' },
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'x2' },
				{ name = 'y2' },
				{ name = 'conditions' },
			}
		},
		["nodegraph_init_post_process_lookup_grid_x"] = {
			source = 'scr_nodeGraph',
			line = 633,
			constructor = false,
			base = nil,
			params = {
				{ name = 'yy' },
			}
		},
		["nodegraph_init_post_process_lookup_grid_y"] = {
			source = 'scr_nodeGraph',
			line = 649,
			constructor = false,
			base = nil,
			params = {
				{ name = 'yy' },
			}
		},
		["nodegraph_init_generate_nodes_for_geyser"] = {
			source = 'scr_nodeGraph',
			line = 658,
			constructor = false,
			base = nil,
			params = {
				{ name = 'geyser_x' },
				{ name = 'geyser_y' },
				{ name = 'check_h' },
			}
		},
		["nodegraph_init_generate_nodes_from_grid"] = {
			source = 'scr_nodeGraph',
			line = 700,
			constructor = false,
			base = nil,
			params = {
				{ name = 'yy' },
			}
		},
		["nodegraph_init_grid_traverse_from_cell"] = {
			source = 'scr_nodeGraph',
			line = 921,
			constructor = false,
			base = nil,
			params = {
				{ name = 'cell_x' },
				{ name = 'cell_y' },
				{ name = 'world_x' },
				{ name = 'world_y' },
			}
		},
		["nodegraph_init_collision"] = {
			source = 'scr_nodeGraph',
			line = 1111,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'o', value = [=[pBlock]=] },
			}
		},
		["nodegraph_init_cell_get_distance"] = {
			source = 'scr_nodeGraph',
			line = 1115,
			constructor = false,
			base = nil,
			params = {
				{ name = 'cell_value' },
			}
		},
		["nodegraph_init_special_connection_add"] = {
			source = 'scr_nodeGraph',
			line = 1124,
			constructor = false,
			base = nil,
			params = {
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'x2' },
				{ name = 'y2' },
				{ name = 'conditions' },
			}
		},
		["nodegraph_init_any_special_connection_at"] = {
			source = 'scr_nodeGraph',
			line = 1147,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
			}
		},
		["nodegraph_SpecialConnectionInfo"] = {
			source = 'scr_nodeGraph',
			line = 1152,
			constructor = true,
			base = nil,
			params = {
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'x2' },
				{ name = 'y2' },
				{ name = 'conditions' },
			}
		},
		["__lf_oEfHeal_create_deserialize"] = {
			source = '__lf_oEfHeal_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfBomb_create_deserialize"] = {
			source = '__lf_oEfBomb_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfBomb_create_serialize"] = {
			source = '__lf_oEfBomb_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_draw_hover_default"] = {
			source = 'ui_draw_hover_default',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'x2' },
				{ name = 'y2' },
				{ name = 'sprite', value = [=[sUILogGridCursor]=] },
				{ name = 'curve', value = [=[anmCurveLogbook]=] },
				{ name = 'curve_track', value = [=[0]=] },
			}
		},
		["input_cursor_y"] = {
			source = 'input_cursor_y',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["__lf_oEfHeal_create_serialize"] = {
			source = '__lf_oEfHeal_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oSucker_create_serialize"] = {
			source = '__lf_oSucker_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfNugget_create_serialize"] = {
			source = '__lf_oEfNugget_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["ScribbleDrawAutoScrollCallState"] = {
			source = 'scribble_draw_auto_scroll',
			line = 2,
			constructor = true,
			base = nil,
			params = {}
		},
		["scribble_draw_auto_scroll"] = {
			source = 'scribble_draw_auto_scroll',
			line = 13,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'elem' },
				{ name = 'ww' },
				{ name = 'hh' },
				{ name = 'pad_top' },
				{ name = 'pad_bot' },
				{ name = 'state' },
				{ name = 'matrix_set_pre', value = [=[undefined]=] },
				{ name = 'matrix_set_post', value = [=[undefined]=] },
			}
		},
		["scribble_draw_auto_scroll_x"] = {
			source = 'scribble_draw_auto_scroll',
			line = 77,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'elem' },
				{ name = 'ww' },
				{ name = 'hh' },
				{ name = 'pad_l' },
				{ name = 'pad_r' },
				{ name = 'state' },
				{ name = 'yoffs', value = [=[0]=] },
			}
		},
		["__lf_oBugBullet_create_deserialize"] = {
			source = '__lf_oBugBullet_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oSuckerPacket_create_deserialize"] = {
			source = '__lf_oSuckerPacket_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oSuckerPacket_create_serialize"] = {
			source = '__lf_oSuckerPacket_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oWispBMine_create_deserialize"] = {
			source = '__lf_oWispBMine_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfNugget_create_deserialize"] = {
			source = '__lf_oEfNugget_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oSucker_create_deserialize"] = {
			source = '__lf_oSucker_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oWispBMine_create_serialize"] = {
			source = '__lf_oWispBMine_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oBugBullet_create_serialize"] = {
			source = '__lf_oBugBullet_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_verb_set"] = {
			source = 'input_verb_set',
			line = 8,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb' },
				{ name = '_value' },
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_analogue', value = [=[true]=] },
			}
		},
		["buffer_prettyprint"] = {
			source = 'scr_reliable_udp',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_buf' },
				{ name = '_per_row', value = [=[20]=] },
				{ name = '_max_data', value = [=[infinity]=] },
			}
		},
		["udp_reliable_ordered_free_connection"] = {
			source = 'scr_reliable_udp',
			line = 91,
			constructor = false,
			base = nil,
			params = {
				{ name = 'ip' },
				{ name = 'port' },
			}
		},
		["udp_reliable_ordered_free_all"] = {
			source = 'scr_reliable_udp',
			line = 115,
			constructor = false,
			base = nil,
			params = {}
		},
		["udp_reliable_ordered_write_message_id"] = {
			source = 'scr_reliable_udp',
			line = 140,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer_id' },
				{ name = 'URL' },
				{ name = 'port' },
				{ name = 'reliable' },
			}
		},
		["network_send_udp_reliable"] = {
			source = 'scr_reliable_udp',
			line = 163,
			constructor = false,
			base = nil,
			params = {
				{ name = 'socket' },
				{ name = 'URL' },
				{ name = 'port' },
				{ name = 'bufferid' },
				{ name = 'ordered' },
				{ name = 'reliable' },
			}
		},
		["udp_reliable_queue_failed_message"] = {
			source = 'scr_reliable_udp',
			line = 208,
			constructor = false,
			base = nil,
			params = {
				{ name = 'socket' },
				{ name = 'URL' },
				{ name = 'port' },
				{ name = 'bufferid' },
			}
		},
		["udp_reliable_handle_async"] = {
			source = 'scr_reliable_udp',
			line = 270,
			constructor = false,
			base = nil,
			params = {
				{ name = 'method_handle' },
			}
		},
		["udp_reliable_handle_async_internal"] = {
			source = 'scr_reliable_udp',
			line = 361,
			constructor = false,
			base = nil,
			params = {
				{ name = 'b' },
				{ name = 'ip' },
				{ name = 'port' },
				{ name = 'method_handle' },
			}
		},
		["__lf_oEfThqwib_create_deserialize"] = {
			source = '__lf_oEfThqwib_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfThqwib_create_serialize"] = {
			source = '__lf_oEfThqwib_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oSelectCoop_step_end_reset_pad_choice"] = {
			source = '__lf_oSelectCoop_step_end_reset_pad_choice',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oConsole_create_6"] = {
			source = '__lf_oConsole_create_6',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["__lf_oConsole_create_4"] = {
			source = '__lf_oConsole_create_4',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["__lf_oConsole_create_5"] = {
			source = '__lf_oConsole_create_5',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["__lf_oEfOilPuddle_create_serialize"] = {
			source = '__lf_oEfOilPuddle_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["draw_highscore_text"] = {
			source = 'draw_highscore_text',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'short', value = [=[false]=] },
				{ name = 'max_character_width', value = [=[-1]=] },
				{ name = 'use_small_font_if_too_large', value = [=[false]=] },
			}
		},
		["switchmultiplayer_write_lobby_player_info"] = {
			source = 'switchmultiplayer_lobby_network_communication',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["switchmultiplayer_read_lobby_player_info"] = {
			source = 'switchmultiplayer_lobby_network_communication',
			line = 16,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["switchmultiplayer_lobby_message_send"] = {
			source = 'switchmultiplayer_lobby_network_communication',
			line = 46,
			constructor = false,
			base = nil,
			params = {
				{ name = 'command' },
			}
		},
		["switchmultiplayer_lobby_message_handle"] = {
			source = 'switchmultiplayer_lobby_network_communication',
			line = 92,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_pPickup_step_collide_item"] = {
			source = '__lf_pPickup_step_collide_item',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_oConsole_create_1"] = {
			source = '__lf_oConsole_create_1',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["__lf_oConsole_create_2"] = {
			source = '__lf_oConsole_create_2',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["__lf_oConsole_create_3"] = {
			source = '__lf_oConsole_create_3',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["treasure_loot_pool_roll_and_handle_artifacts"] = {
			source = 'treasure_loot_pool_roll_and_handle_artifacts',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'pool' },
				{ name = '_result_must_be_a_pickup' },
				{ name = '_required_loot_tags' },
				{ name = '_disallowed_loot_tags' },
			}
		},
		["__lf_sync_asset_string_write_chunk"] = {
			source = '__lf_sync_asset_string_write_chunk',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["TitlescreenBiomeProperties"] = {
			source = 'TitlescreenBiomeProperties',
			line = 2,
			constructor = true,
			base = nil,
			params = {}
		},
		["titlescreen_populate_biome_properties"] = {
			source = 'TitlescreenBiomeProperties',
			line = 11,
			constructor = false,
			base = nil,
			params = {
				{ name = 'stage_id' },
			}
		},
		["__lf_oConsole_create_"] = {
			source = '__lf_oConsole_create_',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["__lf_sync_asset_string_write_asset_chunk"] = {
			source = '__lf_sync_asset_string_write_asset_chunk',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
			}
		},
		["get_survivor_skin_id"] = {
			source = 'oSelectMenu-Create',
			line = 1042,
			constructor = false,
			base = nil,
			params = {
				{ name = 'srv' },
				{ name = 'choice' },
			}
		},
		["__lf_content_init_buffs_13"] = {
			source = '__lf_content_init_buffs_13',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_9"] = {
			source = '__lf_content_init_buffs_9',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_17"] = {
			source = '__lf_content_init_buffs_17',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_7"] = {
			source = '__lf_content_init_buffs_7',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_12"] = {
			source = '__lf_content_init_buffs_12',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_10"] = {
			source = '__lf_content_init_buffs_10',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_8"] = {
			source = '__lf_content_init_buffs_8',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_26"] = {
			source = '__lf_content_init_buffs_26',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_11"] = {
			source = '__lf_content_init_buffs_11',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_21"] = {
			source = '__lf_content_init_buffs_21',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_18"] = {
			source = '__lf_content_init_buffs_18',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_25"] = {
			source = '__lf_content_init_buffs_25',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_14"] = {
			source = '__lf_content_init_buffs_14',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_16"] = {
			source = '__lf_content_init_buffs_16',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_15"] = {
			source = '__lf_content_init_buffs_15',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_5"] = {
			source = '__lf_content_init_buffs_5',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_6"] = {
			source = '__lf_content_init_buffs_6',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_4"] = {
			source = '__lf_content_init_buffs_4',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["animcurve_evaluate"] = {
			source = 'animcurve_evaluate',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'curve' },
				{ name = 'position' },
				{ name = 'channel', value = [=[0]=] },
			}
		},
		["__lf_content_init_buffs_"] = {
			source = '__lf_content_init_buffs_',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_2"] = {
			source = '__lf_content_init_buffs_2',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_3"] = {
			source = '__lf_content_init_buffs_3',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_buffs_1"] = {
			source = '__lf_content_init_buffs_1',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["_skill_umbra_start_charge_animation"] = {
			source = 'scr_ror_init_skills_umbra',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
				{ name = 'charge_state_id' },
				{ name = 'target_state_id' },
				{ name = 'charge_spr' },
				{ name = 'charge_sub' },
				{ name = 'finish_f' },
				{ name = 'is_transform', value = [=[false]=] },
			}
		},
		["_actor_state_umbra_charge_init"] = {
			source = 'scr_ror_init_skills_umbra',
			line = 10,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
				{ name = 'data' },
				{ name = 'time' },
				{ name = 'col' },
			}
		},
		["_actor_state_umbra_charge_update"] = {
			source = 'scr_ror_init_skills_umbra',
			line = 20,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
				{ name = 'data' },
			}
		},
		["_actor_umbra_destroy"] = {
			source = 'scr_ror_init_skills_umbra',
			line = 43,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_items_equipment_44"] = {
			source = '__lf_content_init_items_equipment_44',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_42"] = {
			source = '__lf_content_init_items_equipment_42',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_43"] = {
			source = '__lf_content_init_items_equipment_43',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["actor_skin_create"] = {
			source = 'scr_ActorSkin',
			line = 37,
			constructor = false,
			base = nil,
			params = {
				{ name = 'namespace' },
				{ name = 'name,' },
			}
		},
		["actor_skin_set_custom_palette_swap_apply_func"] = {
			source = 'scr_ActorSkin',
			line = 83,
			constructor = false,
			base = nil,
			params = {
				{ name = 'survivor_id' },
				{ name = 'pal_swap_index' },
				{ name = 'func' },
			}
		},
		["actor_skin_get_default_palette_swap"] = {
			source = 'scr_ActorSkin',
			line = 88,
			constructor = false,
			base = nil,
			params = {
				{ name = 'pal_swap_index' },
			}
		},
		["actor_skin_get_providence"] = {
			source = 'scr_ActorSkin',
			line = 132,
			constructor = false,
			base = nil,
			params = {
				{ name = 'namespace,' },
			}
		},
		["actor_skin_draw_inactive_default"] = {
			source = 'scr_ActorSkin',
			line = 255,
			constructor = false,
			base = nil,
			params = {
				{ name = 'spr' },
				{ name = 'sub' },
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'xscale' },
				{ name = 'yscale' },
			}
		},
		["actor_skin_draw_selected_default"] = {
			source = 'scr_ActorSkin',
			line = 261,
			constructor = false,
			base = nil,
			params = {
				{ name = 'spr' },
				{ name = 'sub' },
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'xscale' },
				{ name = 'yscale' },
			}
		},
		["actor_skin_skinnable_init"] = {
			source = 'scr_ActorSkin',
			line = 275,
			constructor = false,
			base = nil,
			params = {}
		},
		["actor_skin_skinnable_set_skin"] = {
			source = 'scr_ActorSkin',
			line = 280,
			constructor = false,
			base = nil,
			params = {
				{ name = 'from_actor' },
			}
		},
		["actor_skin_skinnable_draw_self"] = {
			source = 'scr_ActorSkin',
			line = 286,
			constructor = false,
			base = nil,
			params = {
				{ name = '_spr', value = [=[sprite_index]=] },
				{ name = '_sub', value = [=[image_index]=] },
				{ name = '_x', value = [=[x]=] },
				{ name = '_y', value = [=[y]=] },
				{ name = '_xs', value = [=[image_xscale]=] },
				{ name = '_ys', value = [=[image_yscale]=] },
				{ name = '_angle', value = [=[image_angle]=] },
				{ name = '_col', value = [=[image_blend]=] },
				{ name = '_alpha', value = [=[image_alpha]=] },
			}
		},
		["actor_skin_draw_portrait"] = {
			source = 'scr_ActorSkin',
			line = 297,
			constructor = false,
			base = nil,
			params = {
				{ name = 'survivor_id' },
				{ name = 'small' },
				{ name = 'sub' },
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'xscale' },
				{ name = 'yscale' },
				{ name = 'skin_id' },
			}
		},
		["actor_skin_get_portrait_sprite"] = {
			source = 'scr_ActorSkin',
			line = 300,
			constructor = false,
			base = nil,
			params = {
				{ name = 'survivor_id' },
				{ name = 'small' },
				{ name = 'skin_id' },
			}
		},
		["actor_skin_draw_loadout_sprite"] = {
			source = 'scr_ActorSkin',
			line = 308,
			constructor = false,
			base = nil,
			params = {
				{ name = 'survivor_id' },
				{ name = 'sub' },
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'xscale' },
				{ name = 'yscale' },
				{ name = 'skin_id' },
			}
		},
		["ACTOR_SKIN_TYPE_INDEX_pal_swap"] = {
			source = 'scr_ActorSkin',
			line = 327,
			constructor = false,
			base = nil,
			params = {
				{ name = 'index' },
			}
		},
		["__actor_skin_type_setup_internal"] = {
			source = 'scr_ActorSkin',
			line = 341,
			constructor = false,
			base = nil,
			params = {
				{ name = 'type' },
			}
		},
		["actor_skin_type_set_colour_override"] = {
			source = 'scr_ActorSkin',
			line = 353,
			constructor = false,
			base = nil,
			params = {
				{ name = 'type' },
				{ name = 'name' },
				{ name = 'value' },
			}
		},
		["actor_skin_type_set_sprite_override"] = {
			source = 'scr_ActorSkin',
			line = 357,
			constructor = false,
			base = nil,
			params = {
				{ name = 'type' },
				{ name = 'name' },
				{ name = 'value' },
			}
		},
		["skin_get_colour_override"] = {
			source = 'scr_ActorSkin',
			line = 362,
			constructor = false,
			base = nil,
			params = {
				{ name = 'skin_id' },
				{ name = 'name' },
				{ name = 'default_value' },
			}
		},
		["skin_get_sprite_override"] = {
			source = 'scr_ActorSkin',
			line = 366,
			constructor = false,
			base = nil,
			params = {
				{ name = 'skin_id' },
				{ name = 'name' },
				{ name = 'default_value' },
			}
		},
		["actor_skin_get_id"] = {
			source = 'scr_ActorSkin',
			line = 376,
			constructor = false,
			base = nil,
			params = {
				{ name = 'skin' },
			}
		},
		["actor_skin_find"] = {
			source = 'scr_ActorSkin',
			line = 382,
			constructor = false,
			base = nil,
			params = {
				{ name = 'id_string' },
			}
		},
		["__lf_content_init_items_equipment_41"] = {
			source = '__lf_content_init_items_equipment_41',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_39"] = {
			source = '__lf_content_init_items_equipment_39',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_40"] = {
			source = '__lf_content_init_items_equipment_40',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_38"] = {
			source = '__lf_content_init_items_equipment_38',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_37"] = {
			source = '__lf_content_init_items_equipment_37',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["on_activate"] = {
			source = 'oEngiMine2-Create',
			line = 21,
			constructor = false,
			base = nil,
			params = {}
		},
		["_survivor_acrid_bubble_hit_internal"] = {
			source = 'scr_ror_init_survivor_acrid_alts',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__rpc_acrid_bubble_push_implementation__"] = {
			source = 'scr_ror_init_survivor_acrid_alts',
			line = 23,
			constructor = false,
			base = nil,
			params = {
				{ name = 'bubble' },
				{ name = 'dir' },
				{ name = 'x_for_sync' },
				{ name = 'y_for_sync' },
			}
		},
		["_survivor_acrid_push_bubble"] = {
			source = 'scr_ror_init_survivor_acrid_alts',
			line = 37,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'x2' },
				{ name = 'y2' },
			}
		},
		["__rpc_acrid_bubble_bounce_implementation__"] = {
			source = 'scr_ror_init_survivor_acrid_alts',
			line = 55,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'bubble' },
				{ name = 'x_for_sync' },
				{ name = 'y_for_sync' },
			}
		},
		["__lf_content_init_items_equipment_34"] = {
			source = '__lf_content_init_items_equipment_34',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_36"] = {
			source = '__lf_content_init_items_equipment_36',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_35"] = {
			source = '__lf_content_init_items_equipment_35',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_32"] = {
			source = '__lf_content_init_items_equipment_32',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_33"] = {
			source = '__lf_content_init_items_equipment_33',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'p' },
				{ name = 'embryo' },
				{ name = 'aim_dir' },
			}
		},
		["__lf_content_init_items_equipment_30"] = {
			source = '__lf_content_init_items_equipment_30',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_31"] = {
			source = '__lf_content_init_items_equipment_31',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_29"] = {
			source = '__lf_content_init_items_equipment_29',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_28"] = {
			source = '__lf_content_init_items_equipment_28',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'p' },
				{ name = 'embryo' },
				{ name = 'aim_dir' },
			}
		},
		["__lf_content_init_items_equipment_27"] = {
			source = '__lf_content_init_items_equipment_27',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_boss_1"] = {
			source = '__lf_content_init_items_boss_1',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_26"] = {
			source = '__lf_content_init_items_equipment_26',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_misc_2"] = {
			source = '__lf_content_init_items_misc_2',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["__lf_content_init_items_equipment_24"] = {
			source = '__lf_content_init_items_equipment_24',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_23"] = {
			source = '__lf_content_init_items_equipment_23',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_22"] = {
			source = '__lf_content_init_items_equipment_22',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_21"] = {
			source = '__lf_content_init_items_equipment_21',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_20"] = {
			source = '__lf_content_init_items_equipment_20',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_19"] = {
			source = '__lf_content_init_items_equipment_19',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_18"] = {
			source = '__lf_content_init_items_equipment_18',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_17"] = {
			source = '__lf_content_init_items_equipment_17',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_15"] = {
			source = '__lf_content_init_items_equipment_15',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_14"] = {
			source = '__lf_content_init_items_equipment_14',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_13"] = {
			source = '__lf_content_init_items_equipment_13',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_12"] = {
			source = '__lf_content_init_items_equipment_12',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_11"] = {
			source = '__lf_content_init_items_equipment_11',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_10"] = {
			source = '__lf_content_init_items_equipment_10',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_9"] = {
			source = '__lf_content_init_items_equipment_9',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_8"] = {
			source = '__lf_content_init_items_equipment_8',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["_mod_prefs_graphics"] = {
			source = 'scr_luaApi_prefs',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_prefs_scale"] = {
			source = 'scr_luaApi_prefs',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_prefs_volume"] = {
			source = 'scr_luaApi_prefs',
			line = 4,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_prefs_music_volume"] = {
			source = 'scr_luaApi_prefs',
			line = 5,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_prefs_damage_numbers"] = {
			source = 'scr_luaApi_prefs',
			line = 6,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_prefs_item_notification"] = {
			source = 'scr_luaApi_prefs',
			line = 7,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_prefs_frameskip"] = {
			source = 'scr_luaApi_prefs',
			line = 8,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_prefs_vsync"] = {
			source = 'scr_luaApi_prefs',
			line = 9,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_content_init_items_equipment_7"] = {
			source = '__lf_content_init_items_equipment_7',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_6"] = {
			source = '__lf_content_init_items_equipment_6',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["item_spawn_init"] = {
			source = 'item_spawn_init',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'allow_spawn_position_calculation', value = [=[true]=] },
			}
		},
		["pickup_get_loot_tags"] = {
			source = 'pickup_get_loot_tags',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'pickup' },
			}
		},
		["__lf_content_init_items_equipment_3"] = {
			source = '__lf_content_init_items_equipment_3',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_5"] = {
			source = '__lf_content_init_items_equipment_5',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_"] = {
			source = '__lf_content_init_items_equipment_',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'p' },
				{ name = 'embryo' },
				{ name = 'aimdir' },
			}
		},
		["__lf_content_init_items_equipment_2"] = {
			source = '__lf_content_init_items_equipment_2',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_4"] = {
			source = '__lf_content_init_items_equipment_4',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_content_init_items_equipment_1"] = {
			source = '__lf_content_init_items_equipment_1',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["scribble_add_autotype_character_delay"] = {
			source = 'scribble_add_autotype_character_delay',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["scribble_combine_fonts"] = {
			source = 'scribble_combine_fonts',
			line = 5,
			constructor = false,
			base = nil,
			params = {}
		},
		["server_update_lobby_data"] = {
			source = 'server_update_lobby_data',
			line = 5,
			constructor = false,
			base = nil,
			params = {}
		},
		["server_update_lobby_data_with_delay"] = {
			source = 'server_update_lobby_data',
			line = 10,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_system_import"] = {
			source = 'input_system_import',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_string' },
			}
		},
		["scribble_autotype_function"] = {
			source = 'scribble_autotype_function',
			line = 4,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_bake_shader"] = {
			source = 'scribble_bake_shader',
			line = 15,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_set_local_player_mid_write__"] = {
			source = 'scr_network_packet_set_local_player_mid',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player_m_id' },
			}
		},
		["__net_packet_set_local_player_mid_read__"] = {
			source = 'scr_network_packet_set_local_player_mid',
			line = 19,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_switch_set_player_icon_index_write__"] = {
			source = 'scr_network_packet_set_local_player_mid',
			line = 112,
			constructor = false,
			base = nil,
			params = {
				{ name = 'icon' },
			}
		},
		["__net_packet_switch_set_player_icon_index_read__"] = {
			source = 'scr_network_packet_set_local_player_mid',
			line = 117,
			constructor = false,
			base = nil,
			params = {}
		},
		["SwitchMultiplayerHostOption"] = {
			source = 'oSwitchMultiplayer-Create',
			line = 152,
			constructor = false,
			base = nil,
			params = {
				{ name = 'token' },
				{ name = 'val_get' },
				{ name = 'val_set' },
			}
		},
		["begin_session_join"] = {
			source = 'oSwitchMultiplayer-Create',
			line = 540,
			constructor = false,
			base = nil,
			params = {
				{ name = 'session_id' },
			}
		},
		["begin_session_join_or_show_password_prompt"] = {
			source = 'oSwitchMultiplayer-Create',
			line = 557,
			constructor = false,
			base = nil,
			params = {
				{ name = 'session_id' },
				{ name = 'require_password_prompt' },
			}
		},
		["scribble_whitelist_sprite"] = {
			source = 'scribble_whitelist_sprite',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["director_populate_enemy_spawn_array"] = {
			source = 'director_populate_enemy_spawn_array',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'rng' },
			}
		},
		["scribble_add_shader_effect"] = {
			source = 'scribble_add_shader_effect',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["scribble_get_glyph_property"] = {
			source = 'scribble_get_glyph_property',
			line = 11,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["input_default_mouse_wheel_down"] = {
			source = 'input_default_mouse_wheel_down',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_flush"] = {
			source = 'scribble_flush',
			line = 4,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_set_glyph_property"] = {
			source = 'scribble_set_glyph_property',
			line = 18,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_page_get"] = {
			source = 'scribble_page_get',
			line = 6,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_page_count"] = {
			source = 'scribble_page_count',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["scribble_page_on_last"] = {
			source = 'scribble_page_on_last',
			line = 5,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_page_set"] = {
			source = 'scribble_page_set',
			line = 9,
			constructor = false,
			base = nil,
			params = {}
		},
		["InstanceCallback"] = {
			source = 'scr_InstanceCallback',
			line = 3,
			constructor = true,
			base = nil,
			params = {}
		},
		["instance_callback_create"] = {
			source = 'scr_InstanceCallback',
			line = 7,
			constructor = false,
			base = nil,
			params = {}
		},
		["instance_callback_set"] = {
			source = 'scr_InstanceCallback',
			line = 12,
			constructor = false,
			base = nil,
			params = {
				{ name = 'callback' },
				{ name = 'func' },
			}
		},
		["instance_callback_clear"] = {
			source = 'scr_InstanceCallback',
			line = 18,
			constructor = false,
			base = nil,
			params = {
				{ name = 'callback' },
			}
		},
		["instance_callback_call"] = {
			source = 'scr_InstanceCallback',
			line = 26,
			constructor = false,
			base = nil,
			params = {
				{ name = 'callback' },
				{ name = 'argument_types' },
			}
		},
		["_mod_instance_callback_add"] = {
			source = 'scr_InstanceCallback',
			line = 46,
			constructor = false,
			base = nil,
			params = {
				{ name = 'callback' },
				{ name = 'func' },
			}
		},
		["_mod_instance_callback_contains"] = {
			source = 'scr_InstanceCallback',
			line = 49,
			constructor = false,
			base = nil,
			params = {
				{ name = 'callback' },
				{ name = 'func' },
			}
		},
		["_mod_instance_callback_remove"] = {
			source = 'scr_InstanceCallback',
			line = 52,
			constructor = false,
			base = nil,
			params = {
				{ name = 'callback' },
				{ name = 'func' },
			}
		},
		["scribble_autotype_is_paused"] = {
			source = 'scribble_autotype_is_paused',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_add_autotype_event"] = {
			source = 'scribble_add_autotype_event',
			line = 50,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["scribble_autotype_set_pause"] = {
			source = 'scribble_autotype_set_pause',
			line = 4,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_autotype_set_sound_per_char"] = {
			source = 'scribble_autotype_set_sound_per_char',
			line = 10,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_autotype_set_sound"] = {
			source = 'scribble_autotype_set_sound',
			line = 17,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_autotype_get"] = {
			source = 'scribble_autotype_get',
			line = 13,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_autotype_skip"] = {
			source = 'scribble_autotype_skip',
			line = 7,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_set_transform"] = {
			source = 'scribble_set_transform',
			line = 12,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["scribble_set_animation"] = {
			source = 'scribble_set_animation',
			line = 31,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["scribble_autotype_fade_out"] = {
			source = 'scribble_autotype_fade_out',
			line = 12,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_get_state"] = {
			source = 'scribble_get_state',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = '_ignore_animation', value = [=[false]=] },
			}
		},
		["scribble_set_blend"] = {
			source = 'scribble_set_blend',
			line = 13,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["scribble_set_line_height"] = {
			source = 'scribble_set_line_height',
			line = 8,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["scribble_set_state"] = {
			source = 'scribble_set_state',
			line = 24,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["scribble_autotype_fade_in"] = {
			source = 'scribble_autotype_fade_in',
			line = 14,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_set_box_align"] = {
			source = 'scribble_set_box_align',
			line = 13,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_set_starting_format"] = {
			source = 'scribble_set_starting_format',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["actor_emit_audio"] = {
			source = 'actor_emit_audio',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'snd' },
				{ name = 'loops', value = [=[false]=] },
				{ name = 'pitch', value = [=[1]=] },
			}
		},
		["actor_audio_update"] = {
			source = 'actor_emit_audio',
			line = 11,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_get_width"] = {
			source = 'scribble_get_width',
			line = 4,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_get_height"] = {
			source = 'scribble_get_height',
			line = 4,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_escape"] = {
			source = 'scribble_escape',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["scribble_cache"] = {
			source = 'scribble_cache',
			line = 8,
			constructor = false,
			base = nil,
			params = {}
		},
		["item_set_dibs"] = {
			source = 'item_set_dibs',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
			}
		},
		["ui_draw_holo_panel"] = {
			source = 'ui_draw_holo_panel',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'w' },
				{ name = 'h' },
				{ name = 'alpha' },
			}
		},
		["scribble_bake_outline"] = {
			source = 'scribble_bake_outline',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
				{ name = 'argument5' },
			}
		},
		["scribble_add_font"] = {
			source = 'scribble_add_font',
			line = 6,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_chat_isEnabled"] = {
			source = 'scr_luaAPI_chat',
			line = 10,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_get_bbox"] = {
			source = 'scribble_get_bbox',
			line = 17,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_add_color"] = {
			source = 'scribble_add_color',
			line = 6,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_add_spritefont"] = {
			source = 'scribble_add_spritefont',
			line = 25,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_draw"] = {
			source = 'scribble_draw',
			line = 39,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_reset"] = {
			source = 'scribble_reset',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_ignore_animation', value = [=[false]=] },
			}
		},
		["log_text"] = {
			source = 'log_text',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["__scribble_macros"] = {
			source = '__scribble_macros',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["lua_handle_error"] = {
			source = 'lua_handle_error',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["console_alert_error"] = {
			source = 'console_alert_error',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["scribble_init"] = {
			source = 'scribble_init',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["__lf_oEfDuplicator_create_serialize"] = {
			source = '__lf_oEfDuplicator_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["init_name"] = {
			source = 'init_name',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name_key', value = [=[undefined]=] },
				{ name = 'section_key', value = [=["actor."]=] },
			}
		},
		["translate_load_file_internal"] = {
			source = 'translate_load_file_internal',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'output_map' },
				{ name = 'data' },
				{ name = 'key_string' },
			}
		},
		["translate_alt"] = {
			source = 'translate_alt',
			line = 5,
			constructor = false,
			base = nil,
			params = {}
		},
		["translate_default"] = {
			source = 'translate_default',
			line = 4,
			constructor = false,
			base = nil,
			params = {}
		},
		["gml_handle_error"] = {
			source = 'gml_handle_error',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["translate_load_file_internal_array"] = {
			source = 'translate_load_file_internal_array',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'output_map' },
				{ name = 'array' },
				{ name = 'key_string' },
			}
		},
		["turn_towards_advanced"] = {
			source = 'turn_towards_advanced',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'current' },
				{ name = 'target' },
				{ name = 'rate' },
			}
		},
		["translate"] = {
			source = 'translate',
			line = 5,
			constructor = false,
			base = nil,
			params = {}
		},
		["turn_towards"] = {
			source = 'turn_towards',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'current' },
				{ name = 'target' },
			}
		},
		["draw_line3_jelly"] = {
			source = 'draw_line3_jelly',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'x2' },
				{ name = 'y2' },
				{ name = 'x3' },
				{ name = 'y3' },
				{ name = 'width1' },
				{ name = 'width2' },
				{ name = 'width3' },
				{ name = 'num_samples' },
				{ name = 'flash' },
			}
		},
		["translate_lang_is_valid"] = {
			source = 'translate_load_file',
			line = 80,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
			}
		},
		["translate_lang_get_active"] = {
			source = 'translate_load_file',
			line = 85,
			constructor = false,
			base = nil,
			params = {}
		},
		["translate_lang_get_system"] = {
			source = 'translate_load_file',
			line = 100,
			constructor = false,
			base = nil,
			params = {}
		},
		["translate_load_active_language"] = {
			source = 'translate_load_file',
			line = 111,
			constructor = false,
			base = nil,
			params = {}
		},
		["translate_load_file"] = {
			source = 'translate_load_file',
			line = 135,
			constructor = false,
			base = nil,
			params = {
				{ name = 'map' },
				{ name = 'path' },
			}
		},
		["translate_set_active_language"] = {
			source = 'translate_load_file',
			line = 161,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
			}
		},
		["collision_line_advanced"] = {
			source = 'collision_line_advanced',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
				{ name = 'argument5' },
				{ name = 'argument6' },
			}
		},
		["collision_line_advanced_bullet"] = {
			source = 'collision_line_advanced',
			line = 41,
			constructor = false,
			base = nil,
			params = {
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'x2' },
				{ name = 'y2' },
				{ name = 'prec' },
				{ name = 'notme' },
			}
		},
		["draw_missile_indicator"] = {
			source = 'draw_missile_indicator',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["draw_screen"] = {
			source = 'draw_screen',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["draw_lightning"] = {
			source = 'draw_lightning',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
			}
		},
		["draw_ctext"] = {
			source = 'draw_ctext',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["draw_sector"] = {
			source = 'draw_sector',
			line = 10,
			constructor = false,
			base = nil,
			params = {
				{ name = 'centerx' },
				{ name = 'centery' },
				{ name = 'startangle' },
				{ name = 'stopangle' },
				{ name = 'stepangle' },
				{ name = 'innerradius' },
				{ name = 'outerradius' },
			}
		},
		["draw_text_outline"] = {
			source = 'draw_text_outline',
			line = 8,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
			}
		},
		["ctext_normal"] = {
			source = 'ctext_normal',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["input_gamepads_get_status"] = {
			source = 'input_gamepads_get_status',
			line = 18,
			constructor = false,
			base = nil,
			params = {}
		},
		["pal_swap_set"] = {
			source = 'pal_swap_set',
			line = 6,
			constructor = false,
			base = nil,
			params = {}
		},
		["elite_pal_set"] = {
			source = 'elite_pal_set',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["ui_slider_format_value"] = {
			source = 'ui_slider',
			line = 14,
			constructor = false,
			base = nil,
			params = {
				{ name = 'val' },
				{ name = 'type' },
			}
		},
		["ui_slider"] = {
			source = 'ui_slider',
			line = 30,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'width' },
				{ name = 'min_value', value = [=[0]=] },
				{ name = 'max_value', value = [=[1]=] },
				{ name = 'value_display_type', value = [=[UI_SLIDER_VALUE_DISPLAY_TYPE.none]=] },
				{ name = 'int', value = [=[false]=] },
				{ name = 'gp_index', value = [=[undefined]=] },
				{ name = 'flags', value = [=[0]=] },
				{ name = 'style', value = [=[global._ui_style_default]=] },
			}
		},
		["__lf_oEfBanditFlashCircle_create_serialize"] = {
			source = '__lf_oEfBanditFlashCircle_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["pal_swap_reset"] = {
			source = 'pal_swap_reset',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["pal_swap_init_system"] = {
			source = 'pal_swap_init_system',
			line = 5,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oDrifterCube_create_deserialize"] = {
			source = '__lf_oDrifterCube_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["pal_swap_get_pal_count"] = {
			source = 'pal_swap_get_pal_count',
			line = 4,
			constructor = false,
			base = nil,
			params = {}
		},
		["pal_swap_get_color_count"] = {
			source = 'pal_swap_get_color_count',
			line = 4,
			constructor = false,
			base = nil,
			params = {}
		},
		["pal_swap_get_pal_color"] = {
			source = 'pal_swap_get_pal_color',
			line = 6,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oBossSkill3_create_serialize"] = {
			source = '__lf_oBossSkill3_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["pal_swap_draw_palette"] = {
			source = 'pal_swap_draw_palette',
			line = 7,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_combo_get_phase_count"] = {
			source = 'input_combo_get_phase_count',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_name' },
			}
		},
		["pal_swap_enable_override"] = {
			source = 'pal_swap_enable_override',
			line = 4,
			constructor = false,
			base = nil,
			params = {}
		},
		["pal_swap_index_palette"] = {
			source = 'pal_swap_index_palette',
			line = 4,
			constructor = false,
			base = nil,
			params = {}
		},
		["real_int_safe"] = {
			source = 'real_int_safe',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["real_int"] = {
			source = 'real_int',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["rng_double"] = {
			source = 'rng_double',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["gamepad_button_check_pressed_any"] = {
			source = 'gamepad_button_check_pressed_any',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'button', value = [=[undefined]=] },
				{ name = 'gamepad', value = [=[undefined]=] },
			}
		},
		["ground_nearest"] = {
			source = 'ground_nearest',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'target_object', value = [=[oB]=] },
			}
		},
		["rng_float"] = {
			source = 'rng_int',
			line = 12,
			constructor = false,
			base = nil,
			params = {
				{ name = 'this' },
			}
		},
		["new_struct"] = {
			source = 'scr_util',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["texture_flush_group"] = {
			source = 'scr_util',
			line = 8,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
			}
		},
		["select"] = {
			source = 'scr_util',
			line = 20,
			constructor = false,
			base = nil,
			params = {}
		},
		["variable_struct_copy"] = {
			source = 'scr_util',
			line = 27,
			constructor = false,
			base = nil,
			params = {
				{ name = 'source' },
				{ name = 'dest' },
			}
		},
		["array_find_index_OLD"] = {
			source = 'scr_util',
			line = 38,
			constructor = false,
			base = nil,
			params = {
				{ name = 'arr' },
				{ name = 'value' },
				{ name = 'start_index', value = [=[0]=] },
			}
		},
		["array_find_index_2d"] = {
			source = 'scr_util',
			line = 49,
			constructor = false,
			base = nil,
			params = {
				{ name = 'arr' },
				{ name = 'sub' },
				{ name = 'value' },
			}
		},
		["string_format_date_day_and_time"] = {
			source = 'scr_util',
			line = 60,
			constructor = false,
			base = nil,
			params = {
				{ name = 'date' },
			}
		},
		["string_format_date_time"] = {
			source = 'scr_util',
			line = 68,
			constructor = false,
			base = nil,
			params = {
				{ name = 'date' },
			}
		},
		["string_format_date_day"] = {
			source = 'scr_util',
			line = 89,
			constructor = false,
			base = nil,
			params = {
				{ name = 'date' },
			}
		},
		["string_format_commas"] = {
			source = 'scr_util',
			line = 98,
			constructor = false,
			base = nil,
			params = {
				{ name = 'num' },
			}
		},
		["approach"] = {
			source = 'scr_util',
			line = 110,
			constructor = false,
			base = nil,
			params = {
				{ name = '_start' },
				{ name = '_end' },
				{ name = '_amount' },
			}
		},
		["file_text_write_line"] = {
			source = 'scr_util',
			line = 119,
			constructor = false,
			base = nil,
			params = {
				{ name = 'file' },
				{ name = 'line' },
			}
		},
		["struct_clone_and_filter"] = {
			source = 'scr_util',
			line = 127,
			constructor = false,
			base = nil,
			params = {
				{ name = 'struct' },
				{ name = 'func' },
			}
		},
		["array_clone_and_filter"] = {
			source = 'scr_util',
			line = 147,
			constructor = false,
			base = nil,
			params = {
				{ name = 'array' },
				{ name = 'func' },
			}
		},
		["draw_loadscreen_simple"] = {
			source = 'scr_util',
			line = 169,
			constructor = false,
			base = nil,
			params = {
				{ name = 'black_screen' },
				{ name = 'waiting', value = [=[true]=] },
			}
		},
		["rng_create"] = {
			source = 'rng_create',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'seed', value = [=[irandom_range(1]=] },
				{ name = 'rng_maxint32 - 1)' },
			}
		},
		["rng_random_seed"] = {
			source = 'rng_create',
			line = 8,
			constructor = false,
			base = nil,
			params = {}
		},
		["scr_array_delete"] = {
			source = 'scr_array_delete',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["string_trim_OLD"] = {
			source = 'string_trim_OLD',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'str' },
				{ name = 'front', value = [=[true]=] },
				{ name = 'back', value = [=[true]=] },
			}
		},
		["string_is_int"] = {
			source = 'string_is_int',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["log_write"] = {
			source = 'log_write',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["string_trim_width_OLD_AND_BAD"] = {
			source = 'string_trim_width_OLD_AND_BAD',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["string_is_uint"] = {
			source = 'string_is_uint',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["string_append_file"] = {
			source = 'string_append_file',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["log_error"] = {
			source = 'log_error',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["string_read_file"] = {
			source = 'string_read_file',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["string_save_file"] = {
			source = 'string_save_file',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["string_split_OLD"] = {
			source = 'string_split_OLD',
			line = 6,
			constructor = false,
			base = nil,
			params = {}
		},
		["ds_list_build"] = {
			source = 'ds_list_build',
			line = 4,
			constructor = false,
			base = nil,
			params = {}
		},
		["write_classid_direct"] = {
			source = 'scr_buffer_classes',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'v' },
			}
		},
		["read_classid_direct"] = {
			source = 'scr_buffer_classes',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["write_classid"] = {
			source = 'scr_buffer_classes',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = 'v' },
			}
		},
		["read_classid"] = {
			source = 'scr_buffer_classes',
			line = 10,
			constructor = false,
			base = nil,
			params = {}
		},
		["write_elite"] = {
			source = 'scr_buffer_classes',
			line = 12,
			constructor = false,
			base = nil,
			params = {
				{ name = 'v' },
			}
		},
		["read_elite"] = {
			source = 'scr_buffer_classes',
			line = 13,
			constructor = false,
			base = nil,
			params = {}
		},
		["write_elite_direct"] = {
			source = 'scr_buffer_classes',
			line = 14,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'v' },
			}
		},
		["read_elite_direct"] = {
			source = 'scr_buffer_classes',
			line = 15,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["write_item"] = {
			source = 'scr_buffer_classes',
			line = 17,
			constructor = false,
			base = nil,
			params = {
				{ name = 'v' },
			}
		},
		["read_item"] = {
			source = 'scr_buffer_classes',
			line = 18,
			constructor = false,
			base = nil,
			params = {}
		},
		["write_item_direct"] = {
			source = 'scr_buffer_classes',
			line = 19,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'v' },
			}
		},
		["read_item_direct"] = {
			source = 'scr_buffer_classes',
			line = 20,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["write_equipment"] = {
			source = 'scr_buffer_classes',
			line = 22,
			constructor = false,
			base = nil,
			params = {
				{ name = 'v' },
			}
		},
		["read_equipment"] = {
			source = 'scr_buffer_classes',
			line = 23,
			constructor = false,
			base = nil,
			params = {}
		},
		["write_equipment_direct"] = {
			source = 'scr_buffer_classes',
			line = 24,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'v' },
			}
		},
		["read_equipment_direct"] = {
			source = 'scr_buffer_classes',
			line = 25,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["write_buff"] = {
			source = 'scr_buffer_classes',
			line = 27,
			constructor = false,
			base = nil,
			params = {
				{ name = 'v' },
			}
		},
		["read_buff"] = {
			source = 'scr_buffer_classes',
			line = 28,
			constructor = false,
			base = nil,
			params = {}
		},
		["write_buff_direct"] = {
			source = 'scr_buffer_classes',
			line = 29,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'v' },
			}
		},
		["read_buff_direct"] = {
			source = 'scr_buffer_classes',
			line = 30,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["write_artifact"] = {
			source = 'scr_buffer_classes',
			line = 32,
			constructor = false,
			base = nil,
			params = {
				{ name = 'v' },
			}
		},
		["read_artifact"] = {
			source = 'scr_buffer_classes',
			line = 33,
			constructor = false,
			base = nil,
			params = {}
		},
		["write_artifact_direct"] = {
			source = 'scr_buffer_classes',
			line = 34,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'v' },
			}
		},
		["read_artifact_direct"] = {
			source = 'scr_buffer_classes',
			line = 35,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["write_stage"] = {
			source = 'scr_buffer_classes',
			line = 37,
			constructor = false,
			base = nil,
			params = {
				{ name = 'v' },
			}
		},
		["read_stage"] = {
			source = 'scr_buffer_classes',
			line = 38,
			constructor = false,
			base = nil,
			params = {}
		},
		["write_stage_direct"] = {
			source = 'scr_buffer_classes',
			line = 39,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'v' },
			}
		},
		["read_stage_direct"] = {
			source = 'scr_buffer_classes',
			line = 40,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["write_difficulty"] = {
			source = 'scr_buffer_classes',
			line = 42,
			constructor = false,
			base = nil,
			params = {
				{ name = 'v' },
			}
		},
		["read_difficulty"] = {
			source = 'scr_buffer_classes',
			line = 43,
			constructor = false,
			base = nil,
			params = {}
		},
		["write_difficulty_direct"] = {
			source = 'scr_buffer_classes',
			line = 44,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'v' },
			}
		},
		["read_difficulty_direct"] = {
			source = 'scr_buffer_classes',
			line = 45,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["write_survivor"] = {
			source = 'scr_buffer_classes',
			line = 47,
			constructor = false,
			base = nil,
			params = {
				{ name = 'v' },
			}
		},
		["read_survivor"] = {
			source = 'scr_buffer_classes',
			line = 48,
			constructor = false,
			base = nil,
			params = {}
		},
		["write_survivor_direct"] = {
			source = 'scr_buffer_classes',
			line = 49,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'v' },
			}
		},
		["read_survivor_direct"] = {
			source = 'scr_buffer_classes',
			line = 50,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["write_monster_card"] = {
			source = 'scr_buffer_classes',
			line = 52,
			constructor = false,
			base = nil,
			params = {
				{ name = 'v' },
			}
		},
		["read_monster_card"] = {
			source = 'scr_buffer_classes',
			line = 53,
			constructor = false,
			base = nil,
			params = {}
		},
		["write_monster_card_direct"] = {
			source = 'scr_buffer_classes',
			line = 54,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'v' },
			}
		},
		["read_monster_card_direct"] = {
			source = 'scr_buffer_classes',
			line = 55,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["write_achievement"] = {
			source = 'scr_buffer_classes',
			line = 57,
			constructor = false,
			base = nil,
			params = {
				{ name = 'v' },
			}
		},
		["read_achievement"] = {
			source = 'scr_buffer_classes',
			line = 58,
			constructor = false,
			base = nil,
			params = {}
		},
		["write_achievement_direct"] = {
			source = 'scr_buffer_classes',
			line = 59,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'v' },
			}
		},
		["read_achievement_direct"] = {
			source = 'scr_buffer_classes',
			line = 60,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["write_actor_state"] = {
			source = 'scr_buffer_classes',
			line = 62,
			constructor = false,
			base = nil,
			params = {
				{ name = 'v' },
			}
		},
		["read_actor_state"] = {
			source = 'scr_buffer_classes',
			line = 63,
			constructor = false,
			base = nil,
			params = {}
		},
		["write_actor_state_direct"] = {
			source = 'scr_buffer_classes',
			line = 64,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'v' },
			}
		},
		["read_actor_state_direct"] = {
			source = 'scr_buffer_classes',
			line = 65,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["ds_list_random"] = {
			source = 'ds_list_random',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["ds_map_build"] = {
			source = 'ds_map_build',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["console_add_command"] = {
			source = 'console_add_command',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["console_add_message"] = {
			source = 'console_add_message',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["__lf_oEfArtiStar_create_deserialize"] = {
			source = '__lf_oEfArtiStar_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_instance_nearest"] = {
			source = '_mod_instance_nearest',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'robj' },
				{ name = 'rx' },
				{ name = 'ry' },
			}
		},
		["mod_live_track_file"] = {
			source = 'scr_modding_liveLoad',
			line = 11,
			constructor = false,
			base = nil,
			params = {
				{ name = 'file' },
			}
		},
		["mod_live_update_tracked_files"] = {
			source = 'scr_modding_liveLoad',
			line = 25,
			constructor = false,
			base = nil,
			params = {}
		},
		["survivor_log_set_stats"] = {
			source = 'scr_survivorLog',
			line = 101,
			constructor = false,
			base = nil,
			params = {
				{ name = 'l,' },
			}
		},
		["survivor_log_create"] = {
			source = 'scr_survivorLog',
			line = 122,
			constructor = false,
			base = nil,
			params = {
				{ name = 'namespace' },
				{ name = 'name' },
				{ name = 'survivor_id', value = [=[undefined]=] },
				{ name = 'portrait_index', value = [=[0]=] },
			}
		},
		["survivor_log_get_save_key_got"] = {
			source = 'scr_survivorLog',
			line = 173,
			constructor = false,
			base = nil,
			params = {
				{ name = 'log_id' },
			}
		},
		["survivor_log_get_save_key_viewed"] = {
			source = 'scr_survivorLog',
			line = 174,
			constructor = false,
			base = nil,
			params = {
				{ name = 'log_id' },
			}
		},
		["_mod_instance_find"] = {
			source = '_mod_instance_find',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'robj' },
				{ name = 'rn' },
			}
		},
		["_mod_instance_furthest"] = {
			source = '_mod_instance_furthest',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'rx' },
				{ name = 'ry' },
				{ name = 'robj' },
			}
		},
		["lua_instance_place"] = {
			source = 'lua_instance_place',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
			}
		},
		["lua_place_meeting"] = {
			source = 'lua_place_meeting',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["_mod_instance_number"] = {
			source = '_mod_instance_number',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'robj' },
			}
		},
		["lua_instance_position"] = {
			source = 'lua_instance_position',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["lua_instance_exists"] = {
			source = 'lua_instance_exists',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["ending_create"] = {
			source = 'scr_EndingType',
			line = 43,
			constructor = false,
			base = nil,
			params = {
				{ name = 'namespace' },
				{ name = 'name' },
				{ name = 'ending_id', value = [=[undefined,]=] },
			}
		},
		["ending_get_id"] = {
			source = 'scr_EndingType',
			line = 66,
			constructor = false,
			base = nil,
			params = {
				{ name = 'ending' },
			}
		},
		["ending_find"] = {
			source = 'scr_EndingType',
			line = 72,
			constructor = false,
			base = nil,
			params = {
				{ name = 'id_string' },
			}
		},
		["_mod_instance_findAll"] = {
			source = '_mod_instance_findAll',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'obj' },
			}
		},
		["lua_init_custom_instance_internal"] = {
			source = 'lua_init_custom_instance_internal',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["custom_object_event_perform"] = {
			source = 'custom_object_event_perform',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["input_profile_destroy"] = {
			source = 'input_profile_destroy',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_profile_name' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["__lf_oChefJar_create_serialize"] = {
			source = '__lf_oChefJar_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["lua_pop_callback_args"] = {
			source = 'lua_pop_callback_args',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["update_widgets"] = {
			source = 'oOptionsMenu-User Event 1',
			line = 13,
			constructor = false,
			base = nil,
			params = {}
		},
		["update_control_buttons"] = {
			source = 'oOptionsMenu-User Event 1',
			line = 78,
			constructor = false,
			base = nil,
			params = {
				{ name = 'profile' },
				{ name = 'player_index' },
			}
		},
		["directory_files_push_list"] = {
			source = 'directory_files_push_list',
			line = 5,
			constructor = false,
			base = nil,
			params = {}
		},
		["filter_find_matching_op"] = {
			source = 'filter_find_matching_op',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["filter_find_matching"] = {
			source = 'filter_find_matching',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["set_active_page"] = {
			source = 'oOptionsMenu-Create',
			line = 18,
			constructor = false,
			base = nil,
			params = {
				{ name = 'page' },
			}
		},
		["binding_scan_success"] = {
			source = 'oOptionsMenu-Create',
			line = 62,
			constructor = false,
			base = nil,
			params = {
				{ name = 'b' },
			}
		},
		["binding_scan_failure"] = {
			source = 'oOptionsMenu-Create',
			line = 73,
			constructor = false,
			base = nil,
			params = {}
		},
		["update_profile_array"] = {
			source = 'oOptionsMenu-Create',
			line = 78,
			constructor = false,
			base = nil,
			params = {}
		},
		["profile_dropdown_clicked"] = {
			source = 'oOptionsMenu-Create',
			line = 108,
			constructor = false,
			base = nil,
			params = {
				{ name = 'choice' },
			}
		},
		["profile_delete_clicked"] = {
			source = 'oOptionsMenu-Create',
			line = 160,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_set_dynamic_fallback_font"] = {
			source = 'scribble_set_dynamic_fallback_font',
			line = 13,
			constructor = false,
			base = nil,
			params = {
				{ name = 'scribbleFontName' },
				{ name = 'font' },
				{ name = 'character_resolution' },
				{ name = 'texture_size' },
				{ name = 'scale' },
				{ name = 'yoffset' },
				{ name = 'character_map', value = [=[-1]=] },
				{ name = 'shader_steps', value = [=[[]]=] },
				{ name = 'pad_l', value = [=[0]=] },
				{ name = 'pad_u', value = [=[0]=] },
				{ name = 'pad_r', value = [=[0]=] },
				{ name = 'pad_b', value = [=[0]=] },
				{ name = 'separation_delta', value = [=[0]=] },
				{ name = 'render_scale', value = [=[1]=] },
			}
		},
		["_ScribbleFallbackFontStack__push_dynamic_font"] = {
			source = 'scribble_set_dynamic_fallback_font',
			line = 24,
			constructor = false,
			base = nil,
			params = {
				{ name = 's' },
				{ name = 'dynamic_font_renderer' },
			}
		},
		["_ScribbleFallbackFontStack__get_font_for_character"] = {
			source = 'scribble_set_dynamic_fallback_font',
			line = 28,
			constructor = false,
			base = nil,
			params = {
				{ name = 'fnts' },
				{ name = 'char' },
			}
		},
		["_DynamicScribbleFontRenderer__texture_surface_refresh"] = {
			source = 'scribble_set_dynamic_fallback_font',
			line = 48,
			constructor = false,
			base = nil,
			params = {}
		},
		["_DynamicScribbleFontRenderer__render_character"] = {
			source = 'scribble_set_dynamic_fallback_font',
			line = 73,
			constructor = false,
			base = nil,
			params = {
				{ name = 'char_code' },
				{ name = 'i' },
			}
		},
		["DynamicScribbleFontRenderer_has_character"] = {
			source = 'scribble_set_dynamic_fallback_font',
			line = 193,
			constructor = false,
			base = nil,
			params = {
				{ name = 'renderer' },
				{ name = 'char_code' },
			}
		},
		["DynamicScribbleFontRenderer_get_character"] = {
			source = 'scribble_set_dynamic_fallback_font',
			line = 200,
			constructor = false,
			base = nil,
			params = {
				{ name = 'renderer' },
				{ name = 'char_code' },
			}
		},
		["_DynamicScribbleFontRenderer"] = {
			source = 'scribble_set_dynamic_fallback_font',
			line = 253,
			constructor = true,
			base = nil,
			params = {
				{ name = 'font' },
				{ name = 'character_resolution' },
				{ name = 'texture_size' },
				{ name = 'scale' },
				{ name = 'yoffset' },
				{ name = 'character_map' },
				{ name = 'shader_steps' },
				{ name = 'pad_l' },
				{ name = 'pad_u' },
				{ name = 'pad_r' },
				{ name = 'pad_b' },
				{ name = 'separation_delta' },
				{ name = 'render_scale' },
			}
		},
		["_DynamicScribbleFontCharacter"] = {
			source = 'scribble_set_dynamic_fallback_font',
			line = 301,
			constructor = false,
			base = nil,
			params = {
				{ name = 'char_code' },
				{ name = 'character' },
				{ name = 'scribble_character_data' },
			}
		},
		["SurvivorBaseLoadoutFamily"] = {
			source = 'scr_SurvivorLoadoutFamily',
			line = 6,
			constructor = true,
			base = nil,
			params = {
				{ name = 'default_element' },
				{ name = 'family_name' },
			}
		},
		["SurvivorSkillLoadoutFamily"] = {
			source = 'scr_SurvivorLoadoutFamily',
			line = 28,
			constructor = true,
			base = [=[SurvivorBaseLoadoutFamily(default_element, undefined]=],
			params = {
				{ name = 'default_element' },
				{ name = 'skill_slot' },
			}
		},
		["SurvivorSkinLoadoutFamily"] = {
			source = 'scr_SurvivorLoadoutFamily',
			line = 29,
			constructor = true,
			base = [=[SurvivorBaseLoadoutFamily(default_element, "skin"]=],
			params = {
				{ name = 'default_element' },
			}
		},
		["SurvivorBaseLoadoutUnlockable"] = {
			source = 'scr_SurvivorLoadoutFamily',
			line = 51,
			constructor = true,
			base = nil,
			params = {}
		},
		["SurvivorSkillLoadoutUnlockable"] = {
			source = 'scr_SurvivorLoadoutFamily',
			line = 91,
			constructor = true,
			base = [=[SurvivorBaseLoadoutUnlockable(]=],
			params = {
				{ name = 'skill_id' },
				{ name = 'achievement_id', value = [=[-1]=] },
			}
		},
		["SurvivorSkinLoadoutUnlockable"] = {
			source = 'scr_SurvivorLoadoutFamily',
			line = 124,
			constructor = true,
			base = [=[SurvivorBaseLoadoutUnlockable(]=],
			params = {
				{ name = 'skin_id' },
				{ name = 'achievement_id', value = [=[-1]=] },
			}
		},
		["PlayerLoadoutSelection"] = {
			source = 'scr_SurvivorLoadoutFamily',
			line = 153,
			constructor = true,
			base = nil,
			params = {}
		},
		["write_playerloadoutselection"] = {
			source = 'scr_SurvivorLoadoutFamily',
			line = 175,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'pls' },
			}
		},
		["read_playerloadoutselection"] = {
			source = 'scr_SurvivorLoadoutFamily',
			line = 199,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["validate_PlayerLoadoutSelection"] = {
			source = 'scr_SurvivorLoadoutFamily',
			line = 214,
			constructor = false,
			base = nil,
			params = {
				{ name = 'pls' },
				{ name = 'survivor' },
			}
		},
		["array_open_length_sub"] = {
			source = 'array_open_length_sub',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["array_close"] = {
			source = 'array_close',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["array_open_read"] = {
			source = 'array_open_read',
			line = 5,
			constructor = false,
			base = nil,
			params = {}
		},
		["mouse_wheel_value"] = {
			source = 'mouse_wheel_value',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["array_open"] = {
			source = 'array_open',
			line = 5,
			constructor = false,
			base = nil,
			params = {}
		},
		["array_open_length"] = {
			source = 'array_open_length',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["array_global_read"] = {
			source = 'array_global_read',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["instance_exists_lua"] = {
			source = 'instance_exists_lua',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["array_global_write"] = {
			source = 'array_global_write',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["array_open_write"] = {
			source = 'array_open_write',
			line = 6,
			constructor = false,
			base = nil,
			params = {}
		},
		["player_index_is_valid"] = {
			source = 'scr_luaApi_input',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'index' },
			}
		},
		["_mod_mouse_get_x"] = {
			source = 'scr_luaApi_input',
			line = 9,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_mouse_get_y"] = {
			source = 'scr_luaApi_input',
			line = 10,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_keyboard_check"] = {
			source = 'scr_luaApi_input',
			line = 11,
			constructor = false,
			base = nil,
			params = {
				{ name = 'key' },
			}
		},
		["_mod_control_get_player_gamepad_index"] = {
			source = 'scr_luaApi_input',
			line = 14,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player_id' },
			}
		},
		["_mod_control_get_player_keyboard"] = {
			source = 'scr_luaApi_input',
			line = 20,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player_id' },
			}
		},
		["_mod_control__internal"] = {
			source = 'scr_luaApi_input',
			line = 25,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player_id' },
				{ name = 'button' },
				{ name = 'press_type' },
			}
		},
		["_mod_control_isHeld"] = {
			source = 'scr_luaApi_input',
			line = 30,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player_id' },
				{ name = 'button' },
			}
		},
		["_mod_control_isPressed"] = {
			source = 'scr_luaApi_input',
			line = 31,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player_id' },
				{ name = 'button' },
			}
		},
		["_mod_control_isReleased"] = {
			source = 'scr_luaApi_input',
			line = 32,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player_id' },
				{ name = 'button' },
			}
		},
		["ds_map_get_keys"] = {
			source = 'ds_map_get_keys',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["update_scale"] = {
			source = 'oOptionsMenu-User Event 0',
			line = 11,
			constructor = false,
			base = nil,
			params = {}
		},
		["update_widgets"] = {
			source = 'oOptionsMenu-User Event 0',
			line = 16,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfBoss4SliceWindup_create_deserialize"] = {
			source = '__lf_oEfBoss4SliceWindup_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["collision_line_lua"] = {
			source = 'collision_line_lua',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
				{ name = 'argument5' },
				{ name = 'argument6' },
			}
		},
		["collision_point_list_lua"] = {
			source = 'collision_point_list_lua',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
			}
		},
		["collision_point_lua"] = {
			source = 'collision_point_lua',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
			}
		},
		["collision_line_list_lua"] = {
			source = 'collision_line_list_lua',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
				{ name = 'argument5' },
				{ name = 'argument6' },
			}
		},
		["collision_ellipse_list_lua"] = {
			source = 'collision_ellipse_list_lua',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
				{ name = 'argument5' },
				{ name = 'argument6' },
			}
		},
		["input_cursor_coord_space_get"] = {
			source = 'input_cursor_coord_space_get',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["collision_ellipse_lua"] = {
			source = 'collision_ellipse_lua',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
				{ name = 'argument5' },
				{ name = 'argument6' },
			}
		},
		["draw_set_text"] = {
			source = 'draw_set_text',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["collision_rectangle_list_lua"] = {
			source = 'collision_rectangle_list_lua',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
				{ name = 'argument5' },
				{ name = 'argument6' },
			}
		},
		["instance_destroy_lua"] = {
			source = 'instance_destroy_lua',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["collision_rectangle_lua"] = {
			source = 'collision_rectangle_lua',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
				{ name = 'argument5' },
				{ name = 'argument6' },
			}
		},
		["item_spawn_draw"] = {
			source = 'item_spawn_draw',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["read_alarm"] = {
			source = 'read_alarm',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["game_style_kind_get_name"] = {
			source = 'scr_game_styles',
			line = 11,
			constructor = false,
			base = nil,
			params = {
				{ name = 'kind' },
			}
		},
		["LobbyGameStyle"] = {
			source = 'scr_game_styles',
			line = 21,
			constructor = true,
			base = nil,
			params = {}
		},
		["write_lobbygamestyle"] = {
			source = 'scr_game_styles',
			line = 94,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'gs' },
			}
		},
		["read_lobbygamestyle"] = {
			source = 'scr_game_styles',
			line = 103,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["save_lobbygamestyle_struct"] = {
			source = 'scr_game_styles',
			line = 117,
			constructor = false,
			base = nil,
			params = {
				{ name = 'lgs' },
			}
		},
		["read_lobbygamestyle_struct"] = {
			source = 'scr_game_styles',
			line = 126,
			constructor = false,
			base = nil,
			params = {
				{ name = 'struct' },
			}
		},
		["write_alarm"] = {
			source = 'write_alarm',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["control_string"] = {
			source = 'control_string',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'playerIdx' },
				{ name = 'verb_name' },
				{ name = 'size', value = [=[1]=] },
			}
		},
		["menu_key_string"] = {
			source = 'menu_key_string',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'verb_name' },
				{ name = 'xl', value = [=[false]=] },
			}
		},
		["control"] = {
			source = 'control',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'verb' },
				{ name = 'press_type' },
			}
		},
		["input_check_pressed_blocked_by_typing"] = {
			source = 'control',
			line = 20,
			constructor = false,
			base = nil,
			params = {
				{ name = 'verb' },
				{ name = 'player_index' },
			}
		},
		["verb_is_legal_menu_input"] = {
			source = 'menu_key',
			line = 19,
			constructor = false,
			base = nil,
			params = {
				{ name = 'verb' },
			}
		},
		["menu_key"] = {
			source = 'menu_key',
			line = 28,
			constructor = false,
			base = nil,
			params = {
				{ name = 'verb' },
				{ name = 'pressed', value = [=[true]=] },
			}
		},
		["menu_set_cursor_player"] = {
			source = 'menu_key',
			line = 103,
			constructor = false,
			base = nil,
			params = {
				{ name = 'p_index', value = [=[-1]=] },
				{ name = 'input_player_index', value = [=[0]=] },
			}
		},
		["input_mouse_coord_space_get"] = {
			source = 'input_mouse_coord_space_get',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["sound_play_global_networked"] = {
			source = 'sound_play_global_networked',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["sound_play_networked"] = {
			source = 'sound_play_networked',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
			}
		},
		["input_binding_threshold_set"] = {
			source = 'input_binding_threshold_set',
			line = 7,
			constructor = false,
			base = nil,
			params = {
				{ name = '_binding' },
				{ name = '_min' },
				{ name = '_max' },
			}
		},
		["sound_play_global"] = {
			source = 'sound_play_global',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["audio_load_wav"] = {
			source = 'audio_load_wav',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["input_profile_verify"] = {
			source = 'input_profile_verify',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = '_json' },
				{ name = '_profile_name' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["sound_play"] = {
			source = 'sound_play',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sound' },
				{ name = 'vol' },
				{ name = 'pitch' },
			}
		},
		["sound_play_at"] = {
			source = 'sound_play_at',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sound' },
				{ name = 'vol' },
				{ name = 'pitch' },
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'force', value = [=[false]=] },
			}
		},
		["audio_emitter_falloff_auto"] = {
			source = 'sound_play_at',
			line = 36,
			constructor = false,
			base = nil,
			params = {
				{ name = 'emmitterid' },
			}
		},
		["sound_loop"] = {
			source = 'sound_loop',
			line = 6,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfOilPuddle_create_deserialize"] = {
			source = '__lf_oEfOilPuddle_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["screen_shake"] = {
			source = 'screen_shake',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'time' },
				{ name = 'tx', value = [=[x]=] },
				{ name = 'ty', value = [=[y]=] },
			}
		},
		["view_set_pos"] = {
			source = 'view_set_pos',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["view_player"] = {
			source = 'view_player',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_check_double"] = {
			source = 'input_check_double',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb' },
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_buffer_duration', value = [=[0]=] },
			}
		},
		["timestop_active_update"] = {
			source = 'timestop_active_update',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__input_class_binding"] = {
			source = '__input_class_binding',
			line = 1,
			constructor = true,
			base = nil,
			params = {}
		},
		["scale_refresh"] = {
			source = 'scale_refresh',
			line = 7,
			constructor = false,
			base = nil,
			params = {
				{ name = 'full_refresh', value = [=[true]=] },
			}
		},
		["inside_view_large"] = {
			source = 'inside_view_large',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
			}
		},
		["inside_view"] = {
			source = 'inside_view',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
			}
		},
		["move_view"] = {
			source = 'move_view',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["screen_res_options_get_available"] = {
			source = 'screen_res_options_get_available',
			line = 30,
			constructor = false,
			base = nil,
			params = {}
		},
		["hud_draw_health"] = {
			source = 'hud_draw_health',
			line = 8,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player' },
				{ name = '_col' },
				{ name = '_x' },
				{ name = '_y' },
				{ name = '_bar_w' },
				{ name = '_bar_h' },
				{ name = '_show_text' },
				{ name = '_flash_bar_col', value = [=[undefined]=] },
			}
		},
		["hud_draw_use_item"] = {
			source = 'hud_draw_use_item',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player' },
				{ name = 'hud_display_info' },
				{ name = '_x' },
				{ name = '_y' },
				{ name = '_equipment' },
				{ name = '_cooldown' },
				{ name = '_show_hud_control' },
				{ name = '_input_player_index' },
				{ name = '_equipment_blocked' },
			}
		},
		["draw_items_coop"] = {
			source = 'draw_items_coop',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_mouse_coord_space_set"] = {
			source = 'input_mouse_coord_space_set',
			line = 8,
			constructor = false,
			base = nil,
			params = {
				{ name = '_coord_space' },
			}
		},
		["hud_draw_items_regenerate_layout"] = {
			source = 'draw_items',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
			}
		},
		["draw_items"] = {
			source = 'draw_items',
			line = 135,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
				{ name = 'is_drawing_to_hud_surf' },
			}
		},
		["hud_draw_skill_info"] = {
			source = 'hud_draw_skill_info',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
				{ name = 'skill_index' },
			}
		},
		["hud_draw_skills"] = {
			source = 'hud_draw_skills',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'my_p' },
				{ name = 'skill_x' },
				{ name = 'skill_y' },
				{ name = 'hud_display_info' },
				{ name = '_show_hud_control' },
				{ name = '_local_player_index' },
				{ name = 'mini', value = [=[false]=] },
			}
		},
		["input_binding_set_safe"] = {
			source = 'input_binding_set_safe',
			line = 16,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb_name' },
				{ name = '_binding' },
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_alternate', value = [=[0]=] },
				{ name = '_profile_name', value = [=[undefined]=] },
			}
		},
		["shader_gradient_map_set"] = {
			source = 'shader_gradient_map_set',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'spr' },
				{ name = 'subimg', value = [=[0]=] },
			}
		},
		["draw_hud_coop"] = {
			source = 'draw_hud_coop',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_default_joycon_button"] = {
			source = 'input_default_joycon_button',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["get_object_index_self"] = {
			source = 'get_object_index_self',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["draw_hud_animation_update"] = {
			source = 'draw_hud',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player' },
				{ name = 'hud_display_info' },
				{ name = 'xx' },
				{ name = 'yy' },
			}
		},
		["draw_hud"] = {
			source = 'draw_hud',
			line = 76,
			constructor = false,
			base = nil,
			params = {}
		},
		["move_contact_map"] = {
			source = 'move_contact_map',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["map_move_contact"] = {
			source = 'map_move_contact',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["get_object_index"] = {
			source = 'get_object_index',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["instance_destroy_w"] = {
			source = 'instance_destroy_w',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["update_nav_ai_default"] = {
			source = 'update_nav_ai_default',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["nav_check_on_path"] = {
			source = 'update_nav_ai_default',
			line = 226,
			constructor = false,
			base = nil,
			params = {
				{ name = 'connection' },
			}
		},
		["nav_path_is_completable_with_classic_ai"] = {
			source = 'update_nav_ai_default',
			line = 262,
			constructor = false,
			base = nil,
			params = {
				{ name = 'path' },
			}
		},
		["actor_nav_get_active_path"] = {
			source = 'update_nav_ai_default',
			line = 275,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_source_mode_set"] = {
			source = 'input_source_mode_set',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = '_mode' },
				{ name = 'arg', value = [=[undefined]=] },
			}
		},
		["instance_create"] = {
			source = 'instance_create',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["player_ping_frames"] = {
			source = 'player_ping_frames',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["input_player_get_invalid_gamepad_bindings"] = {
			source = 'input_player_get_invalid_gamepad_bindings',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_profile_name', value = [=[undefined]=] },
			}
		},
		["interactable_sync"] = {
			source = 'interactable_sync',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["is_new_monster_log_unlocked"] = {
			source = 'is_new_monster_log_unlocked',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["is_new_survivor_log_unlocked"] = {
			source = 'is_new_monster_log_unlocked',
			line = 11,
			constructor = false,
			base = nil,
			params = {}
		},
		["is_new_environment_log_unlocked"] = {
			source = 'is_new_monster_log_unlocked',
			line = 21,
			constructor = false,
			base = nil,
			params = {}
		},
		["server_send_buffered_updates"] = {
			source = 'server_send_buffered_updates',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'count' },
				{ name = 'reliable_type' },
			}
		},
		["projectile_ghost_update"] = {
			source = 'projectile_ghost_update',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["create_networked_particles"] = {
			source = 'create_networked_particles',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["index_free_ticket"] = {
			source = 'index_free_ticket',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["index_find_ticket"] = {
			source = 'index_find_ticket',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["instance_destroy_sync"] = {
			source = 'instance_destroy_sync',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["projectile_sync"] = {
			source = 'projectile_sync',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["instance_resync"] = {
			source = 'instance_resync',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["instance_sync"] = {
			source = 'instance_sync',
			line = 4,
			constructor = false,
			base = nil,
			params = {}
		},
		["__input_class_gamepad_mapping"] = {
			source = '__input_class_gamepad_mapping',
			line = 6,
			constructor = true,
			base = nil,
			params = {
				{ name = '_gm' },
				{ name = '_raw' },
				{ name = '_type' },
				{ name = '_sdl_name' },
			}
		},
		["set_m_id_projectile"] = {
			source = 'set_m_id_projectile',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["is_authority"] = {
			source = 'is_authority',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["actor_get_sock"] = {
			source = 'is_authority',
			line = 19,
			constructor = false,
			base = nil,
			params = {}
		},
		["m_read_rorml_damage"] = {
			source = 'm_read_rorml_damage',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["m_write_rorml_damage"] = {
			source = 'm_write_rorml_damage',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["key_monster"] = {
			source = 'key_monster',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
				{ name = 'argument5' },
				{ name = 'argument6' },
			}
		},
		["server_new_player"] = {
			source = 'server_new_player',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'new_sock', value = [=[-1]=] },
				{ name = 'ip', value = [=[undefined]=] },
				{ name = 'port', value = [=[undefined]=] },
			}
		},
		["set_m_id"] = {
			source = 'set_m_id',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["room_associate_environment_log"] = {
			source = 'scr_environmentLog',
			line = 64,
			constructor = false,
			base = nil,
			params = {
				{ name = 'rm' },
				{ name = 'log_id' },
				{ name = 'variant_id' },
			}
		},
		["environment_log_create"] = {
			source = 'scr_environmentLog',
			line = 97,
			constructor = false,
			base = nil,
			params = {
				{ name = 'namespace' },
				{ name = 'name,' },
			}
		},
		["environment_log_get_save_key_variant_unlocked"] = {
			source = 'scr_environmentLog',
			line = 162,
			constructor = false,
			base = nil,
			params = {
				{ name = 'log_id' },
				{ name = 'index' },
			}
		},
		["environment_log_get_save_key_got"] = {
			source = 'scr_environmentLog',
			line = 163,
			constructor = false,
			base = nil,
			params = {
				{ name = 'log_id' },
			}
		},
		["environment_log_get_save_key_viewed"] = {
			source = 'scr_environmentLog',
			line = 164,
			constructor = false,
			base = nil,
			params = {
				{ name = 'log_id' },
			}
		},
		["environment_log_get_first_available_variant_id"] = {
			source = 'scr_environmentLog',
			line = 169,
			constructor = false,
			base = nil,
			params = {
				{ name = 'log_id' },
				{ name = 'starting_index' },
				{ name = 'reverse' },
			}
		},
		["ghost_update"] = {
			source = 'ghost_update',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["transport"] = {
			source = 'transport',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'troom' },
				{ name = 'stage_id' },
				{ name = 'player_x' },
				{ name = 'player_y' },
			}
		},
		["init"] = {
			source = 'pInteractableCrate-Create',
			line = 63,
			constructor = false,
			base = nil,
			params = {
				{ name = 'pool_index' },
			}
		},
		["players_ready"] = {
			source = 'players_ready',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["net_refresh_players"] = {
			source = 'net_refresh_players',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["_enemy_tuber_armor_bonus_add"] = {
			source = 'scr_skills_enemy_tuber',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
			}
		},
		["_enemy_tuber_armor_bonus_remove"] = {
			source = 'scr_skills_enemy_tuber',
			line = 11,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
			}
		},
		["draw_p_number_text"] = {
			source = 'draw_p_number_text',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player_p_number' },
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'scale', value = [=[1]=] },
				{ name = 'huge', value = [=[false]=] },
			}
		},
		["find_object"] = {
			source = 'find_object',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["m_spawn_npc"] = {
			source = 'm_spawn_npc',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
				{ name = 'argument5' },
				{ name = 'argument6' },
			}
		},
		["is_local_player"] = {
			source = 'is_local_player',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["input_source_clear"] = {
			source = 'input_source_clear',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["disconnect_client"] = {
			source = 'disconnect_client',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["tutorial_start"] = {
			source = 'scr_tutorial',
			line = 6,
			constructor = false,
			base = nil,
			params = {}
		},
		["tutorial_callbacks_bind"] = {
			source = 'scr_tutorial',
			line = 40,
			constructor = false,
			base = nil,
			params = {}
		},
		["tutorial_callbacks_unbind"] = {
			source = 'scr_tutorial',
			line = 46,
			constructor = false,
			base = nil,
			params = {}
		},
		["_tutorial_onEnemyInit"] = {
			source = 'scr_tutorial',
			line = 58,
			constructor = false,
			base = nil,
			params = {
				{ name = 'e' },
			}
		},
		["_tutorial_onPickupCollected"] = {
			source = 'scr_tutorial',
			line = 66,
			constructor = false,
			base = nil,
			params = {}
		},
		["_tutorial_onStep"] = {
			source = 'scr_tutorial',
			line = 103,
			constructor = false,
			base = nil,
			params = {}
		},
		["_tutorial_onDirectorPopulateSpawnArrays"] = {
			source = 'scr_tutorial',
			line = 281,
			constructor = false,
			base = nil,
			params = {}
		},
		["show_tutorial_text"] = {
			source = 'scr_tutorial',
			line = 302,
			constructor = false,
			base = nil,
			params = {
				{ name = 'key' },
				{ name = 'skills', value = [=[[]]=] },
				{ name = 'special_condition', value = [=[undefined]=] },
			}
		},
		["init_client"] = {
			source = 'init_client',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["scribble_trim_height"] = {
			source = 'scribble_trim_height',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = '_draw_string' },
				{ name = '_max_width' },
				{ name = '_max_height' },
				{ name = '_occurance_name', value = [=[SCRIBBLE_DEFAULT_OCCURANCE_NAME]=] },
				{ name = '_garbage_collect', value = [=[true]=] },
				{ name = '_freeze', value = [=[false]=] },
			}
		},
		["string_format_minutes"] = {
			source = 'string_format_minutes',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = '_seconds' },
			}
		},
		["disconnect_player"] = {
			source = 'disconnect_player',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
				{ name = 'session_ended' },
				{ name = 'force_boot', value = [=[true]=] },
			}
		},
		["disconnect_server"] = {
			source = 'disconnect_server',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["server_message_send_direct"] = {
			source = 'server_message_send_direct',
			line = 6,
			constructor = false,
			base = nil,
			params = {}
		},
		["init_server"] = {
			source = 'init_server',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_profile_get"] = {
			source = 'input_profile_get',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["steammultiplayer_update_ready_list"] = {
			source = 'steammultiplayer_update_ready_list',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'alarm_index' },
			}
		},
		["input_cursor_elastic_set"] = {
			source = 'input_cursor_elastic_set',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = '_x' },
				{ name = '_y' },
				{ name = '_strength' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["steammultiplayer_user_get_profile_picture"] = {
			source = 'steammultiplayer_user_get_profile_picture',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'user_id' },
			}
		},
		["steammultiplayer_get_local_name"] = {
			source = 'steammultiplayer_get_local_name',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["steammultiplayer_draw_ready_list"] = {
			source = 'steammultiplayer_draw_ready_list',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = '_x' },
				{ name = '_y' },
				{ name = '_alarm_index' },
			}
		},
		["__lf_oTelepoison_create_serialize"] = {
			source = '__lf_oTelepoison_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["steammultiplayer_update_lobby_data"] = {
			source = 'steammultiplayer_update_lobby_data',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_binding_key"] = {
			source = 'input_binding_key',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_key' },
			}
		},
		["steammultiplayer_update"] = {
			source = 'steammultiplayer_update',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["steammultiplayer_user_get_name"] = {
			source = 'steammultiplayer_user_get_name',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["input_system_export"] = {
			source = 'input_system_export',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_output_string', value = [=[true]=] },
				{ name = '_prettify', value = [=[false]=] },
			}
		},
		["input_check_repeat_opposing"] = {
			source = 'input_check_repeat_opposing',
			line = 11,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb_negative' },
				{ name = '_verb_positive' },
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_most_recent', value = [=[false]=] },
				{ name = '_delay', value = [=[INPUT_REPEAT_DEFAULT_DELAY]=] },
				{ name = '_predelay', value = [=[INPUT_REPEAT_DEFAULT_PREDELAY]=] },
			}
		},
		["byte_pack"] = {
			source = 'byte_pack',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["multiplayer_ui_draw_user_list"] = {
			source = 'multiplayer_ui_draw_user_list',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = 'list_state' },
			}
		},
		["read_attackinfo"] = {
			source = 'read_attackinfo',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["write_attackinfo"] = {
			source = 'write_attackinfo',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["read_bit_array"] = {
			source = 'read_bit_array',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["read_bit_array_direct"] = {
			source = 'read_bit_array',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["write_bit_array"] = {
			source = 'write_bit_array',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'arr' },
			}
		},
		["write_bit_array_direct"] = {
			source = 'write_bit_array',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'arr' },
			}
		},
		["sendmessage"] = {
			source = 'sendmessage',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'reliable_type' },
				{ name = 'socket', value = [=[-1]=] },
			}
		},
		["server_count_packet_size"] = {
			source = 'sendmessage',
			line = 39,
			constructor = false,
			base = nil,
			params = {}
		},
		["sendmessage_ignore_player"] = {
			source = 'sendmessage',
			line = 51,
			constructor = false,
			base = nil,
			params = {
				{ name = 'ignore' },
				{ name = 'reliable_type' },
			}
		},
		["input_source_get_array"] = {
			source = 'input_source_get_array',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["input_keyboard_check"] = {
			source = 'input_keyboard_check',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_binding' },
			}
		},
		["init_multiplayer_locals"] = {
			source = 'init_multiplayer_locals',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["UI_TRIALS_CELL_STATE_to_animation_priority"] = {
			source = 'scr_trials_ui',
			line = 16,
			constructor = false,
			base = nil,
			params = {
				{ name = 'state' },
			}
		},
		["trials_trial_get_unlocked_state"] = {
			source = 'scr_trials_ui',
			line = 33,
			constructor = false,
			base = nil,
			params = {
				{ name = 'trial_name' },
				{ name = 'trial_data' },
				{ name = 'board_data' },
			}
		},
		["trials_trial_get_unlocked_and_available_state"] = {
			source = 'scr_trials_ui',
			line = 43,
			constructor = false,
			base = nil,
			params = {
				{ name = 'trial_name' },
				{ name = 'board_data' },
			}
		},
		["trials_generate_cell_state_grid"] = {
			source = 'scr_trials_ui',
			line = 52,
			constructor = false,
			base = nil,
			params = {
				{ name = 'board' },
			}
		},
		["TrialsBoardCellAnimation"] = {
			source = 'scr_trials_ui',
			line = 154,
			constructor = true,
			base = nil,
			params = {
				{ name = 'cell_x' },
				{ name = 'cell_y' },
				{ name = 'from_state' },
				{ name = 'to_state' },
			}
		},
		["trials_board_update_animation_queue"] = {
			source = 'scr_trials_ui',
			line = 161,
			constructor = false,
			base = nil,
			params = {
				{ name = 'board' },
			}
		},
		["trials_board_update_cell_state_all"] = {
			source = 'scr_trials_ui',
			line = 205,
			constructor = false,
			base = nil,
			params = {}
		},
		["is_new_trial_unlocked"] = {
			source = 'scr_trials_ui',
			line = 212,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oArtiSnap_create_deserialize"] = {
			source = '__lf_oArtiSnap_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["load_save"] = {
			source = 'load_save',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'cb_func', value = [=[undefined]=] },
			}
		},
		["alarm_knockback_default"] = {
			source = 'alarm_knockback_default',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["draw_chat"] = {
			source = 'draw_chat',
			line = 4,
			constructor = false,
			base = nil,
			params = {}
		},
		["prefs_init"] = {
			source = 'prefs_init',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_attack__instance_error"] = {
			source = 'scr_luaApi_attack',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'fname' },
			}
		},
		["_mod_attack_fire_bullet"] = {
			source = 'scr_luaApi_attack',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'inst' },
				{ name = 'tx' },
				{ name = 'ty' },
				{ name = 'distance' },
				{ name = 'dir' },
				{ name = 'damage_co' },
				{ name = 'sparks_spr' },
				{ name = 'can_pierce' },
				{ name = 'can_proc' },
			}
		},
		["_mod_attack_fire_bullet_noparent"] = {
			source = 'scr_luaApi_attack',
			line = 10,
			constructor = false,
			base = nil,
			params = {
				{ name = 'tx' },
				{ name = 'ty' },
				{ name = 'distance' },
				{ name = 'dir' },
				{ name = 'damage_team' },
				{ name = 'damage' },
				{ name = 'is_crit' },
				{ name = 'sparks_spr' },
				{ name = 'can_pierce' },
			}
		},
		["_mod_attack_fire_explosion"] = {
			source = 'scr_luaApi_attack',
			line = 14,
			constructor = false,
			base = nil,
			params = {
				{ name = 'inst' },
				{ name = 'tx' },
				{ name = 'ty' },
				{ name = 'width' },
				{ name = 'height' },
				{ name = 'damage_co' },
				{ name = 'explo_spr' },
				{ name = 'sparks_spr' },
				{ name = 'can_proc' },
			}
		},
		["_mod_attack_fire_explosion_noparent"] = {
			source = 'scr_luaApi_attack',
			line = 21,
			constructor = false,
			base = nil,
			params = {
				{ name = 'tx' },
				{ name = 'ty' },
				{ name = 'width' },
				{ name = 'height' },
				{ name = 'damage_team' },
				{ name = 'damage' },
				{ name = 'is_crit' },
				{ name = 'explo_spr' },
				{ name = 'sparks_spr' },
			}
		},
		["_mod_attack_fire_direct"] = {
			source = 'scr_luaApi_attack',
			line = 25,
			constructor = false,
			base = nil,
			params = {
				{ name = 'inst' },
				{ name = 'target' },
				{ name = 'tx' },
				{ name = 'ty' },
				{ name = 'dir' },
				{ name = 'damage_co' },
				{ name = 'sparks_spr' },
				{ name = 'can_proc' },
			}
		},
		["_mod_attack_fire_direct_noparent"] = {
			source = 'scr_luaApi_attack',
			line = 32,
			constructor = false,
			base = nil,
			params = {
				{ name = 'target' },
				{ name = 'tx' },
				{ name = 'ty' },
				{ name = 'dir' },
				{ name = 'damage_team' },
				{ name = 'damage' },
				{ name = 'is_crit' },
				{ name = 'sparks_spr' },
			}
		},
		["attack_collision_resolve"] = {
			source = 'attack_collision_resolve',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["attack_collision_canhit"] = {
			source = 'attack_collision_canhit',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["save_save"] = {
			source = 'save_save',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["load_mods"] = {
			source = 'load_mods',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["game_reload_with_mod_list"] = {
			source = 'load_mods',
			line = 100,
			constructor = false,
			base = nil,
			params = {
				{ name = 'mods' },
			}
		},
		["actor_on_damage_raw"] = {
			source = 'actor_on_damage_raw',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["RunInfo"] = {
			source = 'scrGameRun',
			line = 3,
			constructor = true,
			base = nil,
			params = {}
		},
		["run_create"] = {
			source = 'scrGameRun',
			line = 85,
			constructor = false,
			base = nil,
			params = {}
		},
		["run_destroy"] = {
			source = 'scrGameRun',
			line = 101,
			constructor = false,
			base = nil,
			params = {}
		},
		["run_set_time_stop"] = {
			source = 'scrGameRun',
			line = 129,
			constructor = false,
			base = nil,
			params = {
				{ name = 'value' },
			}
		},
		["run_set_time_stop_internal"] = {
			source = 'scrGameRun',
			line = 137,
			constructor = false,
			base = nil,
			params = {
				{ name = 'value' },
			}
		},
		["step_actor"] = {
			source = 'step_actor',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["__step_actor_dead"] = {
			source = 'step_actor',
			line = 49,
			constructor = false,
			base = nil,
			params = {}
		},
		["damage_inflict"] = {
			source = 'damage_inflict',
			line = 15,
			constructor = false,
			base = nil,
			params = {}
		},
		["actor_contact_damage"] = {
			source = 'actor_contact_damage',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["actor_set_stun_immune"] = {
			source = 'actor_set_stun_immune',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["actor_queue_dirty"] = {
			source = 'recalculate_stats',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
			}
		},
		["recalculate_stats"] = {
			source = 'recalculate_stats',
			line = 13,
			constructor = false,
			base = nil,
			params = {}
		},
		["init_actor_sync"] = {
			source = 'init_actor_sync',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["step_default"] = {
			source = 'step_default',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["equipment_get"] = {
			source = 'equipment_get',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["draw_hp_bar"] = {
			source = 'draw_hp_bar',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = '_tx', value = [=[ghost_x]=] },
				{ name = '_ty', value = [=[ghost_y - sprite_get_yoffset(sprite_idle) * image_yscale]=] },
			}
		},
		["draw_hp_bar_ally"] = {
			source = 'draw_hp_bar',
			line = 10,
			constructor = false,
			base = nil,
			params = {
				{ name = '_tx', value = [=[ghost_x]=] },
				{ name = '_ty', value = [=[ghost_y - sprite_get_yoffset(sprite_idle) * image_yscale]=] },
			}
		},
		["_draw_hp_bar_internal"] = {
			source = 'draw_hp_bar',
			line = 18,
			constructor = false,
			base = nil,
			params = {
				{ name = '_tx' },
				{ name = '_ty' },
			}
		},
		["teleport_nearby"] = {
			source = 'teleport_nearby',
			line = 5,
			constructor = false,
			base = nil,
			params = {}
		},
		["init_actor_late"] = {
			source = 'init_actor_late',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["actor_proc_on_damage"] = {
			source = 'actor_proc_on_damage',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'hit_info' },
			}
		},
		["equipment_set"] = {
			source = 'equipment_set',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["init_actor_default"] = {
			source = 'init_actor_default',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["equipment_set_internal"] = {
			source = 'equipment_set_internal',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["input_combo_create"] = {
			source = 'input_combo_create',
			line = 28,
			constructor = false,
			base = [=[20]=],
			params = {
				{ name = '_name' },
				{ name = '_default_timeout', value = [=[INPUT_TIMER_MILLISECONDS? 33]=] },
			}
		},
		["item_take_internal"] = {
			source = 'item_take_internal',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'item_id' },
				{ name = 'count' },
				{ name = 'stack_kind' },
			}
		},
		["item_take"] = {
			source = 'item_take',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'item_id' },
				{ name = 'count' },
				{ name = 'stack_kind', value = [=[ITEM_STACK_KIND.normal]=] },
			}
		},
		["item_give"] = {
			source = 'item_give',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'item_id' },
				{ name = 'count' },
				{ name = 'stack_kind', value = [=[ITEM_STACK_KIND.normal]=] },
			}
		},
		["item_count"] = {
			source = 'item_count',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'item_id' },
				{ name = 'stack_kind', value = [=[ITEM_STACK_KIND.any]=] },
			}
		},
		["init_player"] = {
			source = 'init_player',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["init_player_late"] = {
			source = 'init_player',
			line = 55,
			constructor = false,
			base = nil,
			params = {}
		},
		["__input_class_source"] = {
			source = '__input_class_source',
			line = 4,
			constructor = true,
			base = nil,
			params = {
				{ name = '_source' },
				{ name = '_gamepad', value = [=[undefined]=] },
			}
		},
		["__input_source_scan_for_binding"] = {
			source = '__input_class_source',
			line = 223,
			constructor = false,
			base = nil,
			params = {
				{ name = '_source' },
				{ name = '_gamepad' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["__input_source_any_input"] = {
			source = '__input_class_source',
			line = 324,
			constructor = false,
			base = nil,
			params = {
				{ name = '_source' },
				{ name = '_gamepad' },
				{ name = '_ignore_analog_input', value = [=[false]=] },
			}
		},
		["item_give_make_stack_temporary_nosync"] = {
			source = 'item_give_internal',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'item_id' },
				{ name = 'count_blue' },
				{ name = 'count_red' },
			}
		},
		["item_give_internal"] = {
			source = 'item_give_internal',
			line = 30,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'item_id' },
				{ name = 'count' },
				{ name = 'stack_kind' },
			}
		},
		["damage_calculate_armor"] = {
			source = 'damage_calculate_armor',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'damage_dealt' },
				{ name = 'target' },
			}
		},
		["actor_drawscript_call"] = {
			source = 'scr_actor_draw',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'draw_x' },
				{ name = 'draw_y' },
				{ name = 'priority_max' },
				{ name = 'priority_min' },
			}
		},
		["draw_actor"] = {
			source = 'scr_actor_draw',
			line = 16,
			constructor = false,
			base = nil,
			params = {}
		},
		["actor_on_dodge"] = {
			source = 'actor_on_dodge',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'target' },
				{ name = 'kind' },
				{ name = 'damage' },
			}
		},
		["init_class"] = {
			source = 'init_class',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["sparks_create_networked"] = {
			source = 'sparks_create_networked',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'tx' },
				{ name = 'ty' },
				{ name = 'sprite' },
				{ name = 'xscale', value = [=[undefined]=] },
				{ name = 'yscale', value = [=[undefined]=] },
				{ name = 'is_explosion', value = [=[false]=] },
				{ name = 'high_depth_priority', value = [=[false]=] },
				{ name = '__ignore_player', value = [=[ALL_PLAYERS]=] },
				{ name = '__spawn_local', value = [=[true]=] },
			}
		},
		["class_can_select_default"] = {
			source = 'class_can_select_default',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["player_survivor_stats_level"] = {
			source = 'player_survivor_stats_level',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
			}
		},
		["actor_check_invincible"] = {
			source = 'actor_check_invincible',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["draw_damage_networked"] = {
			source = 'draw_damage_networked',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
				{ name = 'argument5' },
				{ name = 'argument6' },
			}
		},
		["damager_hit_process"] = {
			source = 'damager_hit_process',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["class_get_index"] = {
			source = 'class_get_index',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["player_survivor_stats_init"] = {
			source = 'player_survivor_stats_init',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["__input_key_name_set"] = {
			source = '__input_key_name_set',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_key' },
				{ name = '_name' },
			}
		},
		["draw_laser"] = {
			source = 'draw_laser',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'type' },
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'x2' },
				{ name = 'y2' },
			}
		},
		["input_profile_create"] = {
			source = 'input_profile_create',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_profile_name' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["damage_default"] = {
			source = 'damage_default',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["fire_direct_noparent_lua"] = {
			source = 'fire_direct_noparent_lua',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
				{ name = 'argument5' },
				{ name = 'argument6' },
				{ name = 'argument7' },
			}
		},
		["draw_damage"] = {
			source = 'draw_damage',
			line = 8,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
				{ name = 'argument5' },
				{ name = 'argument6' },
			}
		},
		["damage_inflict_raw"] = {
			source = 'damage_inflict_raw',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'target' },
				{ name = 'hit_info' },
			}
		},
		["damage_inflict_internal_deduct_hp"] = {
			source = 'damage_inflict_raw',
			line = 73,
			constructor = false,
			base = nil,
			params = {
				{ name = 'damage' },
				{ name = 'doEffects' },
			}
		},
		["fire_direct"] = {
			source = 'fire_direct',
			line = 9,
			constructor = false,
			base = nil,
			params = {}
		},
		["fire_bullet"] = {
			source = 'fire_bullet',
			line = 11,
			constructor = false,
			base = nil,
			params = {}
		},
		["damage_get_dodge"] = {
			source = 'damage_get_dodge',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'targ' },
				{ name = 'block_x' },
				{ name = 'damage_dealt' },
				{ name = 'ignore_invincibility', value = [=[false]=] },
			}
		},
		["check_trace"] = {
			source = 'check_trace',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["fire_direct_noparent"] = {
			source = 'fire_direct_noparent',
			line = 10,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_source_share"] = {
			source = 'input_source_share',
			line = 7,
			constructor = false,
			base = nil,
			params = {
				{ name = '_source' },
				{ name = '_array' },
				{ name = '_auto_profile', value = [=[true]=] },
			}
		},
		["fire_explosion_noparent"] = {
			source = 'fire_explosion_noparent',
			line = 12,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
				{ name = 'argument5' },
				{ name = 'argument6' },
				{ name = 'argument7' },
				{ name = 'argument8' },
			}
		},
		["fire_bullet_noparent"] = {
			source = 'fire_bullet_noparent',
			line = 11,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
				{ name = 'argument5' },
				{ name = 'argument6' },
				{ name = 'argument7' },
				{ name = 'argument8' },
			}
		},
		["__input_gamepad_set_vid_pid"] = {
			source = '__input_gamepad_set_vid_pid',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["fire_bullet_noparent_lua"] = {
			source = 'fire_bullet_noparent_lua',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
				{ name = 'argument5' },
				{ name = 'argument6' },
				{ name = 'argument7' },
				{ name = 'argument8' },
			}
		},
		["fire_explosion_noparent_lua"] = {
			source = 'fire_explosion_noparent_lua',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
				{ name = 'argument4' },
				{ name = 'argument5' },
				{ name = 'argument6' },
				{ name = 'argument7' },
				{ name = 'argument8' },
			}
		},
		["boss_death"] = {
			source = 'boss_death',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_instance_valid"] = {
			source = 'scr_luaApi_instance',
			line = 47,
			constructor = false,
			base = nil,
			params = {
				{ name = 'inst' },
			}
		},
		["lua_classname_instance_object"] = {
			source = 'scr_luaApi_instance',
			line = 51,
			constructor = false,
			base = nil,
			params = {
				{ name = 'obj' },
			}
		},
		["_mod_instance_create"] = {
			source = 'scr_luaApi_instance',
			line = 56,
			constructor = false,
			base = nil,
			params = {
				{ name = 'obj' },
				{ name = 'cx' },
				{ name = 'cy' },
			}
		},
		["_mod_instance_destroy"] = {
			source = 'scr_luaApi_instance',
			line = 62,
			constructor = false,
			base = nil,
			params = {
				{ name = 'inst' },
			}
		},
		["_mod_instance_get_sprite"] = {
			source = 'scr_luaApi_instance',
			line = 69,
			constructor = false,
			base = nil,
			params = {
				{ name = 'inst' },
			}
		},
		["_mod_instance_set_sprite"] = {
			source = 'scr_luaApi_instance',
			line = 72,
			constructor = false,
			base = nil,
			params = {
				{ name = 'inst' },
				{ name = 'sprt' },
			}
		},
		["_mod_instance_get_mask"] = {
			source = 'scr_luaApi_instance',
			line = 75,
			constructor = false,
			base = nil,
			params = {
				{ name = 'inst' },
			}
		},
		["_mod_instance_set_mask"] = {
			source = 'scr_luaApi_instance',
			line = 78,
			constructor = false,
			base = nil,
			params = {
				{ name = 'inst' },
				{ name = 'sprt' },
			}
		},
		["_mod_instance_get_wrap_object"] = {
			source = 'scr_luaApi_instance',
			line = 83,
			constructor = false,
			base = nil,
			params = {
				{ name = 'inst' },
			}
		},
		["_mod_instance_getData"] = {
			source = 'scr_luaApi_instance',
			line = 92,
			constructor = false,
			base = nil,
			params = {
				{ name = 'inst' },
			}
		},
		["init_boss"] = {
			source = 'init_boss',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["enemy_stats_init"] = {
			source = 'enemy_stats_init',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
			}
		},
		["drone_stats_init"] = {
			source = 'enemy_stats_init',
			line = 22,
			constructor = false,
			base = nil,
			params = {
				{ name = '_maxhp' },
				{ name = '_is_super', value = [=[false]=] },
			}
		},
		["item_spawn_step"] = {
			source = 'item_spawn_step',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'rate', value = [=[2]=] },
			}
		},
		["__lf_oEfBossShadow1_create_deserialize"] = {
			source = '__lf_oEfBossShadow1_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["step_ai_default"] = {
			source = 'step_ai_default',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["init_ai_default"] = {
			source = 'init_ai_default',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["alarm_default"] = {
			source = 'alarm_ai_default',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["alarm_ai_default"] = {
			source = 'alarm_ai_default',
			line = 68,
			constructor = false,
			base = nil,
			params = {}
		},
		["alarm_ai_default_do_targetting"] = {
			source = 'alarm_ai_default',
			line = 313,
			constructor = false,
			base = nil,
			params = {}
		},
		["alarm_ai_default_do_handle_despawn"] = {
			source = 'alarm_ai_default',
			line = 329,
			constructor = false,
			base = nil,
			params = {}
		},
		["alarm_ai_default_do_elite_passives"] = {
			source = 'alarm_ai_default',
			line = 403,
			constructor = false,
			base = nil,
			params = {}
		},
		["ai_default_get_nav_properties"] = {
			source = 'alarm_ai_default',
			line = 434,
			constructor = false,
			base = nil,
			params = {}
		},
		["alarm_ai_default_try_find_nav_path"] = {
			source = 'alarm_ai_default',
			line = 444,
			constructor = false,
			base = nil,
			params = {}
		},
		["alarm_ai_default_find_random_nav_path"] = {
			source = 'alarm_ai_default',
			line = 496,
			constructor = false,
			base = nil,
			params = {}
		},
		["ai_default_get_climbable_ropes"] = {
			source = 'alarm_ai_default',
			line = 518,
			constructor = false,
			base = nil,
			params = {
				{ name = 'check_range', value = [=[240]=] },
				{ name = 'xx', value = [=[x]=] },
				{ name = 'y_top', value = [=[bbox_top]=] },
				{ name = 'y_bottom', value = [=[bbox_bottom]=] },
				{ name = 'rope_list', value = [=[undefined]=] },
			}
		},
		["ai_default_rope_is_reachable"] = {
			source = 'alarm_ai_default',
			line = 548,
			constructor = false,
			base = nil,
			params = {
				{ name = 'rope' },
			}
		},
		["ai_default_filter_ropes_to_target"] = {
			source = 'alarm_ai_default',
			line = 563,
			constructor = false,
			base = nil,
			params = {
				{ name = 'rope_list' },
				{ name = 'target_x' },
				{ name = 'target_y' },
				{ name = 'max_iterations' },
				{ name = 'ref_y', value = [=[bbox_bottom]=] },
				{ name = 'check_distance', value = [=[2000]=] },
				{ name = 'ropes_checked', value = [=[undefined]=] },
			}
		},
		["ai_default_rope_reaches_target"] = {
			source = 'alarm_ai_default',
			line = 615,
			constructor = false,
			base = nil,
			params = {
				{ name = 'rope' },
				{ name = 'target_x' },
				{ name = 'target_y' },
			}
		},
		["trigger_activate"] = {
			source = 'trigger_activate',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'trigger_name' },
				{ name = 'cause', value = [=[noone]=] },
			}
		},
		["path_activate_instance"] = {
			source = 'trigger_activate',
			line = 15,
			constructor = false,
			base = nil,
			params = {
				{ name = 'target_instance_id' },
				{ name = 'path_instance_id' },
			}
		},
		["editor_path_object_init"] = {
			source = 'trigger_activate',
			line = 28,
			constructor = false,
			base = nil,
			params = {}
		},
		["set_state"] = {
			source = 'oPilotMine-Create',
			line = 26,
			constructor = false,
			base = nil,
			params = {
				{ name = 'new_state' },
				{ name = 'should_network', value = [=[true]=] },
			}
		},
		["pickup_roll"] = {
			source = 'pickup_roll',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["pickup_init_artifact"] = {
			source = 'pickup_init_artifact',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["init_drone"] = {
			source = 'init_drone',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["pickup_init_from_item"] = {
			source = 'pickup_init_from_item',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["pickup_init_from_equipment"] = {
			source = 'pickup_init_from_equipment',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["step_drone_internal"] = {
			source = 'step_drone',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["step_drone"] = {
			source = 'step_drone',
			line = 37,
			constructor = false,
			base = nil,
			params = {
				{ name = 'allow_state_change', value = [=[true]=] },
			}
		},
		["step_drone_super"] = {
			source = 'step_drone',
			line = 112,
			constructor = false,
			base = nil,
			params = {}
		},
		["drone_targetting_update"] = {
			source = 'step_drone',
			line = 118,
			constructor = false,
			base = nil,
			params = {
				{ name = 'attack_offset' },
				{ name = 'attack_cooldown' },
				{ name = 'attack_collisions', value = [=[true]=] },
				{ name = 'force_check_trace_range', value = [=[-1]=] },
				{ name = 'can_attack', value = [=[true]=] },
			}
		},
		["pickup_get_available"] = {
			source = 'pickup_get_available',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = 'pickup' },
			}
		},
		["__input_system_tick"] = {
			source = '__input_system_tick',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["__item_lizard_loaf_proc_fx"] = {
			source = 'scr_item_proc_rpcs',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'true_target' },
				{ name = 'delay' },
				{ name = 'right' },
				{ name = 'dmg' },
				{ name = 'crit' },
			}
		},
		["__rpc_item_proc_shell_implementation__"] = {
			source = 'scr_item_proc_rpcs',
			line = 27,
			constructor = false,
			base = nil,
			params = {
				{ name = 'target' },
			}
		},
		["__rpc_item_proc_classified_implementation__"] = {
			source = 'scr_item_proc_rpcs',
			line = 43,
			constructor = false,
			base = nil,
			params = {
				{ name = 'target' },
			}
		},
		["__rpc_item_proc_dios_friend_implementation__"] = {
			source = 'scr_item_proc_rpcs',
			line = 55,
			constructor = false,
			base = nil,
			params = {
				{ name = 'target' },
			}
		},
		["__rpc_item_proc_laser_turbine_implementation__"] = {
			source = 'scr_item_proc_rpcs',
			line = 86,
			constructor = false,
			base = nil,
			params = {
				{ name = 'target' },
				{ name = 'xx' },
				{ name = 'yy' },
			}
		},
		["__rpc_item_proc_gold_on_hit_implementation__"] = {
			source = 'scr_item_proc_rpcs',
			line = 99,
			constructor = false,
			base = nil,
			params = {
				{ name = 'target' },
				{ name = 'value' },
				{ name = 'death_blast' },
			}
		},
		["__rpc_item_proc_hitlist_implementation__"] = {
			source = 'scr_item_proc_rpcs',
			line = 106,
			constructor = false,
			base = nil,
			params = {
				{ name = 'owner' },
				{ name = 'mark_target' },
			}
		},
		["__rpc_robobuddy_create_steal_effect_implementation__"] = {
			source = 'scr_item_proc_rpcs',
			line = 118,
			constructor = false,
			base = nil,
			params = {
				{ name = 'robo' },
				{ name = 'xs' },
				{ name = 'ys' },
				{ name = 'iid' },
				{ name = 'icount' },
			}
		},
		["__rpc_rpc_interactable_create_steal_effect_implementation__"] = {
			source = 'scr_item_proc_rpcs',
			line = 134,
			constructor = false,
			base = nil,
			params = {
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'x2' },
				{ name = 'y2' },
				{ name = 'iid' },
			}
		},
		["__rpc_item_proc_construct_implementation__"] = {
			source = 'scr_item_proc_rpcs',
			line = 146,
			constructor = false,
			base = nil,
			params = {
				{ name = 'target' },
			}
		},
		["item_use_equipment_target"] = {
			source = 'item_use_equipment_target',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["item_drop"] = {
			source = 'item_drop',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = '_treasure_kind' },
				{ name = '_x', value = [=[x]=] },
				{ name = '_y', value = [=[y]=] },
				{ name = '_drop_target', value = [=[noone]=] },
				{ name = '_force_drop_double', value = [=[false]=] },
			}
		},
		["item_drop_object"] = {
			source = 'item_drop',
			line = 31,
			constructor = false,
			base = nil,
			params = {
				{ name = '_pickup' },
				{ name = '_x', value = [=[x]=] },
				{ name = '_y', value = [=[y]=] },
				{ name = '_drop_target', value = [=[noone]=] },
				{ name = '_drop_double', value = [=[false]=] },
			}
		},
		["item_use_equipment"] = {
			source = 'item_use_equipment',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'forced' },
				{ name = 'equipment_index', value = [=[-1]=] },
				{ name = 'ignore_cooldown', value = [=[false]=] },
				{ name = 'aim_dir', value = [=[undefined]=] },
				{ name = 'double_effect', value = [=[undefined]=] },
				{ name = 'is_chaos', value = [=[false]=] },
				{ name = 'network', value = [=[true]=] },
			}
		},
		["player_get_equipment_cooldown"] = {
			source = 'item_use_equipment',
			line = 76,
			constructor = false,
			base = nil,
			params = {
				{ name = 'p' },
			}
		},
		["shrine_activated"] = {
			source = 'shrine_activated',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'shrine' },
				{ name = 'result' },
			}
		},
		["item_drop_boss"] = {
			source = 'item_drop_boss',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["interactable_set_active"] = {
			source = 'interactable_set_active',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'interactable' },
				{ name = 'activator' },
				{ name = 'active_value' },
				{ name = 'is_hack', value = [=[false]=] },
				{ name = 'hack_double', value = [=[false]=] },
			}
		},
		["interactable_check_cost"] = {
			source = 'interactable_check_cost',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'type' },
				{ name = 'cost' },
				{ name = 'player' },
			}
		},
		["interactable_pay_cost"] = {
			source = 'interactable_pay_cost',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'type' },
				{ name = 'cost' },
				{ name = 'player' },
			}
		},
		["interactable_draw_prompt"] = {
			source = 'interactable_draw_prompt',
			line = 11,
			constructor = false,
			base = nil,
			params = {}
		},
		["interactable_draw_cost"] = {
			source = 'interactable_draw_cost',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = '_x', value = [=[x]=] },
				{ name = '_y', value = [=[floor(y+8*GAME_SCALE)]=] },
			}
		},
		["interactable_draw_self"] = {
			source = 'interactable_draw_self',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = '_show_outline', value = [=[can_activate_frame == current_frame]=] },
				{ name = '_outline_index', value = [=[interact_scroll_index]=] },
			}
		},
		["interactable_init_name"] = {
			source = 'interactable_init_name',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'inst', value = [=[id]=] },
				{ name = 'name', value = [=[undefined]=] },
			}
		},
		["interactable_init_cost"] = {
			source = 'interactable_init_cost',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'interactable' },
				{ name = 'kind' },
				{ name = 'base' },
				{ name = 'auto_scale', value = [=[true]=] },
			}
		},
		["cost_get_base_gold_price_scale"] = {
			source = 'interactable_init_cost',
			line = 39,
			constructor = false,
			base = nil,
			params = {}
		},
		["interactable_cache_strings"] = {
			source = 'interactable_init_cost',
			line = 44,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_gamepad_get_type"] = {
			source = 'input_gamepad_get_type',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_index' },
			}
		},
		["object_get"] = {
			source = 'object_get',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["interactable_init"] = {
			source = 'interactable_init',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'skip_loot', value = [=[false]=] },
				{ name = 'snap_ground', value = [=[true]=] },
			}
		},
		["object_set_parent"] = {
			source = 'object_set_parent',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["object_get_parent_w"] = {
			source = 'object_get_parent_w',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["object_set_visible_w"] = {
			source = 'object_set_visible_w',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["input_binding_gamepad_axis"] = {
			source = 'input_binding_gamepad_axis',
			line = 8,
			constructor = false,
			base = nil,
			params = {
				{ name = '_axis' },
				{ name = '_negative' },
			}
		},
		["object_set_sprite_w"] = {
			source = 'object_set_sprite_w',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["object_get_sprite_w"] = {
			source = 'object_get_sprite_w',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["object_get_mask_w"] = {
			source = 'object_get_sprite_w',
			line = 15,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["__input_hotswap_tick"] = {
			source = '__input_hotswap_tick',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["__input_hotswap_tick_input"] = {
			source = '__input_hotswap_tick',
			line = 47,
			constructor = false,
			base = nil,
			params = {}
		},
		["object_get_name_w"] = {
			source = 'object_get_name_w',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["object_get_visible_w"] = {
			source = 'object_get_visible_w',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["scribble_set_tags_active"] = {
			source = 'scribble_set_tags_active',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'active', value = [=[true]=] },
			}
		},
		["object_exists_w"] = {
			source = 'object_exists_w',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["clean_instances"] = {
			source = 'clean_instances',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["object_set_depth"] = {
			source = 'object_set_depth',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["object_get_depth"] = {
			source = 'object_get_depth',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["object_get_callback"] = {
			source = 'object_get_callback',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["ui_log"] = {
			source = 'scr_ui',
			line = 11,
			constructor = false,
			base = nil,
			params = {
				{ name = 'str' },
			}
		},
		["ui_style_font_resolve"] = {
			source = 'scr_ui',
			line = 28,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
			}
		},
		["UiStyle"] = {
			source = 'scr_ui',
			line = 36,
			constructor = true,
			base = nil,
			params = {
				{ name = 'props', value = [=[undefined]=] },
			}
		},
		["ui_show_input_prompt"] = {
			source = 'scr_ui',
			line = 168,
			constructor = false,
			base = nil,
			params = {
				{ name = 'verb' },
				{ name = 'size' },
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'input_player_index', value = [=[MENU_ACTIVE_PLAYER_INPUT_INDEX]=] },
			}
		},
		["ui_resolution_update"] = {
			source = 'scr_ui',
			line = 180,
			constructor = false,
			base = nil,
			params = {}
		},
		["_UiState"] = {
			source = 'scr_ui',
			line = 193,
			constructor = true,
			base = nil,
			params = {}
		},
		["_UiElementState"] = {
			source = 'scr_ui',
			line = 759,
			constructor = true,
			base = nil,
			params = {
				{ name = 'frame' },
				{ name = 'key' },
			}
		},
		["_UiHoverTooltipState"] = {
			source = 'scr_ui',
			line = 819,
			constructor = true,
			base = nil,
			params = {}
		},
		["_UIRenderState"] = {
			source = 'scr_ui',
			line = 891,
			constructor = true,
			base = nil,
			params = {
				{ name = 'shared_state', value = [=[undefined]=] },
				{ name = 'render_zoom_info', value = [=[undefined]=] },
			}
		},
		["ui_get_render_state"] = {
			source = 'scr_ui',
			line = 934,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_apply_render_state"] = {
			source = 'scr_ui',
			line = 943,
			constructor = false,
			base = nil,
			params = {
				{ name = 'state' },
			}
		},
		["ui_reset_render_state"] = {
			source = 'scr_ui',
			line = 1001,
			constructor = false,
			base = nil,
			params = {}
		},
		["_ui_update"] = {
			source = 'scr_ui',
			line = 1029,
			constructor = false,
			base = nil,
			params = {}
		},
		["_ui_get_state_key"] = {
			source = 'scr_ui',
			line = 1046,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
			}
		},
		["_ui_get_element_state"] = {
			source = 'scr_ui',
			line = 1055,
			constructor = false,
			base = nil,
			params = {
				{ name = 'key' },
				{ name = 'style', value = [=[undefined]=] },
			}
		},
		["_ui_check_selected"] = {
			source = 'scr_ui',
			line = 1078,
			constructor = false,
			base = nil,
			params = {
				{ name = 'state' },
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'x2' },
				{ name = 'y2' },
				{ name = 'flags', value = [=[0]=] },
				{ name = 'hx1', value = [=[x1]=] },
				{ name = 'hy1', value = [=[y1]=] },
				{ name = 'hx2', value = [=[x2]=] },
				{ name = 'hy2', value = [=[y2]=] },
			}
		},
		["_ui_mouse_in_active_region"] = {
			source = 'scr_ui',
			line = 1175,
			constructor = false,
			base = nil,
			params = {
				{ name = 'ax1' },
				{ name = 'ay1' },
				{ name = 'ax2' },
				{ name = 'ay2' },
			}
		},
		["_UiGamepadSelectionConnectionInfo"] = {
			source = 'scr_ui',
			line = 1185,
			constructor = true,
			base = nil,
			params = {
				{ name = 'copy_from', value = [=[undefined]=] },
			}
		},
		["ui_consume_input"] = {
			source = 'scr_ui',
			line = 1235,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_gp_pos"] = {
			source = 'scr_ui',
			line = 1245,
			constructor = false,
			base = nil,
			params = {
				{ name = 'x_index' },
				{ name = 'y_index' },
				{ name = 'x_sub', value = [=[0]=] },
				{ name = 'y_sub', value = [=[0]=] },
			}
		},
		["_ui_compare_gamepad_selection"] = {
			source = 'scr_ui',
			line = 1256,
			constructor = false,
			base = nil,
			params = {}
		},
		["_ui_update_gamepad_selection"] = {
			source = 'scr_ui',
			line = 1304,
			constructor = false,
			base = nil,
			params = {
				{ name = 'state' },
				{ name = 'gp_pos_array' },
				{ name = 'element_x' },
				{ name = 'element_y' },
				{ name = 'flags', value = [=[0]=] },
			}
		},
		["ui_draw_clip_set"] = {
			source = 'scr_ui',
			line = 1407,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'width' },
				{ name = 'height' },
			}
		},
		["ui_draw_clip_reset"] = {
			source = 'scr_ui',
			line = 1431,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_draw_clip_set_to_surface"] = {
			source = 'scr_ui',
			line = 1441,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'width' },
				{ name = 'height' },
				{ name = 'surf' },
			}
		},
		["ui_draw_clip_reset_to_surface"] = {
			source = 'scr_ui',
			line = 1448,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_draw_alpha_set"] = {
			source = 'scr_ui',
			line = 1465,
			constructor = false,
			base = nil,
			params = {
				{ name = 'value', value = [=[1]=] },
			}
		},
		["ui_draw_alpha_set_raw"] = {
			source = 'scr_ui',
			line = 1474,
			constructor = false,
			base = nil,
			params = {
				{ name = 'value' },
			}
		},
		["ui_draw_scroll_set"] = {
			source = 'scr_ui',
			line = 1479,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xscroll', value = [=[0]=] },
				{ name = 'yscroll', value = [=[0]=] },
			}
		},
		["ui_draw_scroll_set_scrollbar_y"] = {
			source = 'scr_ui',
			line = 1489,
			constructor = false,
			base = nil,
			params = {
				{ name = 'scrollbar_name' },
			}
		},
		["ui_draw_offset_set"] = {
			source = 'scr_ui',
			line = 1496,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xoffset', value = [=[0]=] },
				{ name = 'yoffset', value = [=[0]=] },
			}
		},
		["ui_set_draw_y"] = {
			source = 'scr_ui',
			line = 1507,
			constructor = false,
			base = nil,
			params = {
				{ name = 'yy' },
				{ name = 'pad', value = [=[true]=] },
				{ name = 'style', value = [=[global._ui_style_default]=] },
			}
		},
		["ui_next_y"] = {
			source = 'scr_ui',
			line = 1512,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_padding"] = {
			source = 'scr_ui',
			line = 1517,
			constructor = false,
			base = nil,
			params = {
				{ name = 'style', value = [=[global._ui_style_default]=] },
			}
		},
		["ui_button_height"] = {
			source = 'scr_ui',
			line = 1522,
			constructor = false,
			base = nil,
			params = {
				{ name = 'style', value = [=[global._ui_style_default]=] },
			}
		},
		["ui_margin_update"] = {
			source = 'scr_ui',
			line = 1531,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_margin_left"] = {
			source = 'scr_ui',
			line = 1554,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_margin_top"] = {
			source = 'scr_ui',
			line = 1555,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_margin_right"] = {
			source = 'scr_ui',
			line = 1556,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_margin_bottom"] = {
			source = 'scr_ui',
			line = 1557,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_content_width"] = {
			source = 'scr_ui',
			line = 1558,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_content_height"] = {
			source = 'scr_ui',
			line = 1559,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_xoffset"] = {
			source = 'scr_ui',
			line = 1561,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_yoffset"] = {
			source = 'scr_ui',
			line = 1562,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_push_submenu"] = {
			source = 'scr_ui',
			line = 1565,
			constructor = false,
			base = nil,
			params = {
				{ name = 'value', value = [=[undefined]=] },
				{ name = 'allow_focus', value = [=[true]=] },
			}
		},
		["ui_pop_submenu"] = {
			source = 'scr_ui',
			line = 1580,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_submenu_active"] = {
			source = 'scr_ui',
			line = 1587,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_can_interact"] = {
			source = 'scr_ui',
			line = 1591,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_set_interaction_active"] = {
			source = 'scr_ui',
			line = 1596,
			constructor = false,
			base = nil,
			params = {
				{ name = 'active' },
			}
		},
		["ui_get_element_value"] = {
			source = 'scr_ui',
			line = 1616,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'default_value', value = [=[0]=] },
			}
		},
		["ui_set_element_value"] = {
			source = 'scr_ui',
			line = 1623,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'value' },
			}
		},
		["ui_element_invalidate_resolution"] = {
			source = 'scr_ui',
			line = 1630,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
			}
		},
		["ui_reset_scrollbar_value"] = {
			source = 'scr_ui',
			line = 1638,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'value', value = [=[0]=] },
			}
		},
		["_ui_get_button_subimage"] = {
			source = 'scr_ui',
			line = 1647,
			constructor = false,
			base = nil,
			params = {
				{ name = 'state' },
				{ name = 'active', value = [=[false]=] },
			}
		},
		["_ui_draw_button"] = {
			source = 'scr_ui',
			line = 1652,
			constructor = false,
			base = nil,
			params = {
				{ name = 'state' },
				{ name = 'sprite' },
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'x2' },
				{ name = 'y2' },
				{ name = 'active', value = [=[false]=] },
			}
		},
		["_ui_draw_button_overlay"] = {
			source = 'scr_ui',
			line = 1657,
			constructor = false,
			base = nil,
			params = {
				{ name = 'state' },
				{ name = 'sprite' },
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'x2' },
				{ name = 'y2' },
				{ name = 'flags', value = [=[0]=] },
				{ name = 'subimage', value = [=[0]=] },
			}
		},
		["_ui_draw_box_text"] = {
			source = 'scr_ui',
			line = 1692,
			constructor = false,
			base = nil,
			params = {
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'width' },
				{ name = 'height' },
				{ name = 'text' },
				{ name = 'align' },
				{ name = 'state' },
				{ name = 'style' },
				{ name = 'active_tab', value = [=[false]=] },
				{ name = 'col', value = [=[undefined]=] },
			}
		},
		["_ui_draw_box_text_scrollable"] = {
			source = 'scr_ui',
			line = 1713,
			constructor = false,
			base = nil,
			params = {
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'width' },
				{ name = 'height' },
				{ name = 'selected' },
				{ name = 'align' },
				{ name = 'state' },
				{ name = 'style' },
				{ name = 'active_tab', value = [=[false]=] },
				{ name = 'col', value = [=[undefined]=] },
			}
		},
		["_ui_box_text_scrollable_setup"] = {
			source = 'scr_ui',
			line = 1733,
			constructor = false,
			base = nil,
			params = {
				{ name = 'state' },
				{ name = 'width' },
				{ name = 'text' },
				{ name = 'style' },
			}
		},
		["ui_button_text"] = {
			source = 'scr_ui',
			line = 1756,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'width' },
				{ name = 'text' },
				{ name = 'align', value = [=[fa_left]=] },
				{ name = 'gp_index', value = [=[undefined]=] },
				{ name = 'flags', value = [=[0]=] },
				{ name = 'style', value = [=[global._ui_style_default]=] },
				{ name = 'active_tab', value = [=[false]=] },
				{ name = 'state_key', value = [=[_ui_get_state_key(xx]=] },
				{ name = 'yy)' },
				{ name = 'icon_sprite', value = [=[-1]=] },
			}
		},
		["ui_scrollbar_reset"] = {
			source = 'scr_ui',
			line = 1793,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
			}
		},
		["_ui_scrollbar_shared_init"] = {
			source = 'scr_ui',
			line = 1797,
			constructor = false,
			base = nil,
			params = {
				{ name = 'state' },
				{ name = 'name' },
			}
		},
		["_ui_scrollbar_shared_update"] = {
			source = 'scr_ui',
			line = 1816,
			constructor = false,
			base = nil,
			params = {
				{ name = 'state' },
				{ name = 'name' },
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'x2' },
				{ name = 'y2' },
				{ name = 'flags' },
				{ name = 'value_max' },
				{ name = 'height' },
				{ name = 'ax1' },
				{ name = 'ay1' },
				{ name = 'ax2' },
				{ name = 'ay2' },
				{ name = 'do_gamepad_scroll' },
			}
		},
		["ui_scrollbar_y"] = {
			source = 'scr_ui',
			line = 1949,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'value_max' },
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'height' },
				{ name = 'width', value = [=[12]=] },
				{ name = 'flags', value = [=[0]=] },
				{ name = 'ax1', value = [=[undefined]=] },
				{ name = 'ay1', value = [=[undefined]=] },
				{ name = 'ax2', value = [=[undefined]=] },
				{ name = 'ay2', value = [=[undefined]=] },
				{ name = 'do_gamepad_scroll', value = [=[false]=] },
				{ name = 'style', value = [=[global._ui_style_default]=] },
			}
		},
		["ui_scrollbar2"] = {
			source = 'scr_ui',
			line = 1968,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'value_max' },
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'height' },
				{ name = 'flags', value = [=[0]=] },
				{ name = 'ax1', value = [=[undefined]=] },
				{ name = 'ay1', value = [=[undefined]=] },
				{ name = 'ax2', value = [=[undefined]=] },
				{ name = 'ay2', value = [=[undefined]=] },
				{ name = 'do_gamepad_scroll', value = [=[0]=] },
				{ name = 'style', value = [=[global._ui_style_default]=] },
			}
		},
		["ui_scrollbar_scroll_to_fit"] = {
			source = 'scr_ui',
			line = 2024,
			constructor = false,
			base = nil,
			params = {
				{ name = 'scrollbar_name' },
				{ name = 'y1' },
				{ name = 'y2' },
			}
		},
		["ui_last_element_is_active_region"] = {
			source = 'scr_ui',
			line = 2033,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_button_toggle"] = {
			source = 'scr_ui',
			line = 2040,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'width' },
				{ name = 'ax1' },
				{ name = 'ay1' },
				{ name = 'ax2' },
				{ name = 'ay2' },
				{ name = 'text' },
				{ name = 'align', value = [=[fa_left]=] },
				{ name = 'gp_index', value = [=[undefined]=] },
				{ name = 'style', value = [=[global._ui_style_default]=] },
			}
		},
		["ui_button_sprite"] = {
			source = 'scr_ui',
			line = 2080,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'sprite' },
				{ name = 'gp_index', value = [=[undefined]=] },
				{ name = 'flags', value = [=[0]=] },
				{ name = 'style', value = [=[global._ui_style_default]=] },
				{ name = '_state_key', value = [=[_ui_get_state_key(xx]=] },
				{ name = 'yy)' },
			}
		},
		["ui_button_sprite_and_text"] = {
			source = 'scr_ui',
			line = 2104,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'sprite' },
				{ name = 'text' },
				{ name = 'align', value = [=[fa_left]=] },
				{ name = 'text_xoffs', value = [=[0]=] },
				{ name = 'text_yoffs', value = [=[0]=] },
				{ name = 'width_add', value = [=[0]=] },
				{ name = 'height_add', value = [=[0]=] },
				{ name = 'gp_index', value = [=[undefined]=] },
				{ name = 'flags', value = [=[0]=] },
				{ name = 'style', value = [=[global._ui_style_default]=] },
				{ name = '_state_key', value = [=[_ui_get_state_key(xx]=] },
				{ name = 'yy)' },
				{ name = 'is_active', value = [=[false]=] },
			}
		},
		["ui_button_sprite_subimage"] = {
			source = 'scr_ui',
			line = 2131,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'sprite' },
				{ name = 'subimage' },
				{ name = 'xscale' },
				{ name = 'yscale' },
				{ name = 'gp_index', value = [=[undefined]=] },
				{ name = 'flags', value = [=[0]=] },
				{ name = 'style', value = [=[global._ui_style_default]=] },
				{ name = '_state_key', value = [=[_ui_get_state_key(xx]=] },
				{ name = 'yy)' },
				{ name = 'dont_draw_base_sprite', value = [=[false]=] },
				{ name = 'blend', value = [=[c_white]=] },
			}
		},
		["ui_checkbox"] = {
			source = 'scr_ui',
			line = 2176,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'gp_index', value = [=[undefined]=] },
				{ name = 'style', value = [=[global._ui_style_default]=] },
				{ name = 'flags', value = [=[0]=] },
			}
		},
		["ui_checkbox_text"] = {
			source = 'scr_ui',
			line = 2208,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'width' },
				{ name = 'text' },
				{ name = 'gp_index', value = [=[undefined]=] },
				{ name = 'style', value = [=[global._ui_style_default]=] },
				{ name = 'flags', value = [=[0]=] },
			}
		},
		["ui_capture_rectangle"] = {
			source = 'scr_ui',
			line = 2242,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'width' },
				{ name = 'height' },
			}
		},
		["ui_hover_tooltip"] = {
			source = 'scr_ui',
			line = 2271,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx', value = [=[undefined]=] },
				{ name = 'yy', value = [=[undefined]=] },
				{ name = 'header' },
				{ name = 'body' },
				{ name = 'header_col', value = [=[c_white]=] },
				{ name = 'body_col', value = [=[c_white]=] },
			}
		},
		["ui_set_gamepad_target_element"] = {
			source = 'scr_ui',
			line = 2308,
			constructor = false,
			base = nil,
			params = {
				{ name = 'gp_index' },
			}
		},
		["ui_reset_selection"] = {
			source = 'scr_ui',
			line = 2323,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_block_mouse"] = {
			source = 'scr_ui',
			line = 2333,
			constructor = false,
			base = nil,
			params = {
				{ name = 'time', value = [=[2]=] },
			}
		},
		["ui_block_gp"] = {
			source = 'scr_ui',
			line = 2341,
			constructor = false,
			base = nil,
			params = {
				{ name = 'time', value = [=[2]=] },
			}
		},
		["api_alias"] = {
			source = 'api_alias',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["input_distance"] = {
			source = 'input_distance',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb_l' },
				{ name = '_verb_r' },
				{ name = '_verb_u' },
				{ name = '_verb_d' },
				{ name = '_player_index', value = [=[undefined]=] },
				{ name = '_most_recent', value = [=[false]=] },
			}
		},
		["api_class_settings"] = {
			source = 'api_class_settings',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["customobject_shared_init"] = {
			source = 'customobject_shared_init',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["object_get_type"] = {
			source = 'object_get_type',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["object_is"] = {
			source = 'object_is',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["object_add_RAW"] = {
			source = 'object_add_RAW',
			line = 4,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_game_ingame"] = {
			source = 'scr_luaApi_game',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_game_getDirector"] = {
			source = 'scr_luaApi_game',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_game_getHUD"] = {
			source = 'scr_luaApi_game',
			line = 4,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_game_getDifficulty"] = {
			source = 'scr_luaApi_game',
			line = 6,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_game_setDifficulty"] = {
			source = 'scr_luaApi_game',
			line = 7,
			constructor = false,
			base = nil,
			params = {
				{ name = 'v' },
			}
		},
		["_mod_game_getAritfactActive"] = {
			source = 'scr_luaApi_game',
			line = 8,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
			}
		},
		["_mod_game_setAritfactActive"] = {
			source = 'scr_luaApi_game',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a,v' },
			}
		},
		["_mod_game_getCurrentStage"] = {
			source = 'scr_luaApi_game',
			line = 11,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_game_gotoStage"] = {
			source = 'scr_luaApi_game',
			line = 12,
			constructor = false,
			base = nil,
			params = {
				{ name = 'stage' },
				{ name = 'variant' },
			}
		},
		["_mod_game_getPlayers"] = {
			source = 'scr_luaApi_game',
			line = 15,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_game_set_timestop"] = {
			source = 'scr_luaApi_game',
			line = 19,
			constructor = false,
			base = nil,
			params = {
				{ name = 'v' },
			}
		},
		["_mod_game_get_timestop"] = {
			source = 'scr_luaApi_game',
			line = 20,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_game_shakeScreen_global"] = {
			source = 'scr_luaApi_game',
			line = 22,
			constructor = false,
			base = nil,
			params = {
				{ name = 'v' },
			}
		},
		["__input_class_chord_definition"] = {
			source = '__input_class_chord_definition',
			line = 1,
			constructor = true,
			base = nil,
			params = {
				{ name = '_name' },
				{ name = '_max_time_between_presses' },
				{ name = '_verb_array' },
			}
		},
		["api_define_end"] = {
			source = 'api_define_end',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["api_define_refgen_get_return_type_string"] = {
			source = 'api_argument',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'return_type' },
				{ name = 'flags' },
			}
		},
		["api_define_refgen_get_type_name"] = {
			source = 'api_argument',
			line = 17,
			constructor = false,
			base = nil,
			params = {
				{ name = 'type' },
			}
		},
		["api_argument"] = {
			source = 'api_argument',
			line = 41,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["api_function"] = {
			source = 'api_function',
			line = 5,
			constructor = false,
			base = nil,
			params = {}
		},
		["api_ctor"] = {
			source = 'api_ctor',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["api_define"] = {
			source = 'api_define_start',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["api_define_start"] = {
			source = 'api_define_start',
			line = 33,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["getID"] = {
			source = 'api_define_start',
			line = 148,
			constructor = false,
			base = nil,
			params = {}
		},
		["api_value"] = {
			source = 'api_value',
			line = 4,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_ignore_key_remove"] = {
			source = 'input_ignore_key_remove',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_key' },
			}
		},
		["api_define_refgen_doc_section"] = {
			source = 'api_define_refgen_doc_section',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["api_define_refgen_type_name"] = {
			source = 'api_define_refgen_type_name',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 't' },
				{ name = 'decorate' },
			}
		},
		["api_method"] = {
			source = 'api_method',
			line = 5,
			constructor = false,
			base = nil,
			params = {}
		},
		["isValid"] = {
			source = 'api_method',
			line = 46,
			constructor = false,
			base = nil,
			params = {}
		},
		["api_define_refgen_write_doc_raw"] = {
			source = 'api_define_refgen_write_doc',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'text' },
			}
		},
		["api_define_refgen_write_doc"] = {
			source = 'api_define_refgen_write_doc',
			line = 10,
			constructor = false,
			base = nil,
			params = {
				{ name = 'text' },
			}
		},
		["api_define_refgen_write_doc_item"] = {
			source = 'api_define_refgen_write_doc',
			line = 24,
			constructor = false,
			base = nil,
			params = {
				{ name = 'kind' },
				{ name = 'name' },
			}
		},
		["api_define_refgen_doc"] = {
			source = 'api_define_refgen_doc',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["api_define_refgen_define"] = {
			source = 'api_define_refgen_define',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
				{ name = 'argument3' },
			}
		},
		["api_property"] = {
			source = 'api_property',
			line = 5,
			constructor = false,
			base = nil,
			params = {}
		},
		["api_getter"] = {
			source = 'api_property',
			line = 38,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'type' },
				{ name = 'getter' },
				{ name = 'setter', value = [=[undefined]=] },
				{ name = 'getter_flags', value = [=[0]=] },
				{ name = 'setter_flags', value = [=[0]=] },
				{ name = 'value_default', value = [=[undefined]=] },
			}
		},
		["__lf_oEfArtiNanobolt_create_serialize"] = {
			source = '__lf_oEfArtiNanobolt_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["damager_attack_process_client"] = {
			source = 'damager_attack_process_client',
			line = 5,
			constructor = false,
			base = nil,
			params = {}
		},
		["api_define_function_end"] = {
			source = 'api_define_function_end',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["api_define_field_start"] = {
			source = 'api_define_field_start',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_oEngiMortar_create_deserialize"] = {
			source = '__lf_oEngiMortar_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["api_define_write_string"] = {
			source = 'api_define_write_string',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["api_define_write_short"] = {
			source = 'api_define_write_short',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["callback_get_lua_types"] = {
			source = 'callback_get_lua_types',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["api_define_write_value"] = {
			source = 'api_define_write_value',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["api_define_write_double"] = {
			source = 'api_define_write_double',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["api_define_init"] = {
			source = 'api_define_init',
			line = 7,
			constructor = false,
			base = nil,
			params = {}
		},
		["api_define_cleanup"] = {
			source = 'api_define_init',
			line = 98,
			constructor = false,
			base = nil,
			params = {}
		},
		["draw_menu_button_prompt"] = {
			source = 'draw_menu_button_prompt',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'verb_name' },
				{ name = 'size', value = [=[2]=] },
				{ name = 'alpha', value = [=[1]=] },
				{ name = 'input_player_index', value = [=[MENU_ACTIVE_PLAYER_INPUT_INDEX]=] },
			}
		},
		["callback_create"] = {
			source = 'callback_create',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_player_ghost_get"] = {
			source = 'input_player_ghost_get',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["callback_execute"] = {
			source = 'callback_execute',
			line = 4,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_player_get_gamepad"] = {
			source = 'input_player_get_gamepad',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_binding', value = [=[undefined]=] },
			}
		},
		["content_added_alert"] = {
			source = 'content_added_alert',
			line = 4,
			constructor = false,
			base = nil,
			params = {}
		},
		["content_id_string"] = {
			source = 'content_id_string',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'namespace' },
				{ name = 'name' },
			}
		},
		["content_id_string_get_namespace"] = {
			source = 'content_id_string',
			line = 8,
			constructor = false,
			base = nil,
			params = {
				{ name = 'str' },
			}
		},
		["content_id_string_get_identifier"] = {
			source = 'content_id_string',
			line = 11,
			constructor = false,
			base = nil,
			params = {
				{ name = 'str' },
			}
		},
		["skill_activate"] = {
			source = 'skill_activate',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'index' },
			}
		},
		["sync_asset_string"] = {
			source = 'sync_asset_string',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["skill_get_index"] = {
			source = 'skill_get_index',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["callback_bind"] = {
			source = 'callback_init',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'callback_id' },
				{ name = 'method_or_script_id' },
			}
		},
		["callback_unbind"] = {
			source = 'callback_init',
			line = 13,
			constructor = false,
			base = nil,
			params = {
				{ name = 'callback_id' },
				{ name = 'method_or_script_id' },
			}
		},
		["callback_is_bound"] = {
			source = 'callback_init',
			line = 32,
			constructor = false,
			base = nil,
			params = {
				{ name = 'cbid' },
			}
		},
		["callback_find"] = {
			source = 'callback_init',
			line = 41,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
			}
		},
		["callback_init"] = {
			source = 'callback_init',
			line = 48,
			constructor = false,
			base = nil,
			params = {}
		},
		["skill_create"] = {
			source = 'skill_create',
			line = 17,
			constructor = false,
			base = nil,
			params = {}
		},
		["skill_get_damage"] = {
			source = 'skill_get_damage',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["_survivor_engi_handle_v_2_skill"] = {
			source = 'scr_ror_init_survivor_engi_alts',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
				{ name = 'skill' },
				{ name = 'scepter' },
			}
		},
		["actor_animation_set"] = {
			source = 'actor_animation_set',
			line = 4,
			constructor = false,
			base = nil,
			params = {}
		},
		["_item_cape_get_effectdisplay"] = {
			source = 'scr_item_cape_display',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["item_cape_register_sprite_offsets"] = {
			source = 'scr_item_cape_display',
			line = 71,
			constructor = false,
			base = nil,
			params = {
				{ name = 'spr' },
				{ name = 'array' },
			}
		},
		["set_player"] = {
			source = 'oPDrone-Create',
			line = 29,
			constructor = false,
			base = nil,
			params = {
				{ name = 'p' },
			}
		},
		["input_player_export"] = {
			source = 'input_player_export',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_output_string', value = [=[true]=] },
				{ name = '_prettify', value = [=[false]=] },
			}
		},
		["input_profile_copy"] = {
			source = 'input_profile_copy',
			line = 7,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player_index_src' },
				{ name = '_profile_name_src' },
				{ name = '_player_index_dst' },
				{ name = '_profile_name_dst' },
			}
		},
		["skill_can_activate"] = {
			source = 'skill_can_activate',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'index' },
			}
		},
		["skill_can_activate_default"] = {
			source = 'skill_can_activate',
			line = 23,
			constructor = false,
			base = nil,
			params = {
				{ name = 'inst' },
				{ name = 'skill' },
			}
		},
		["input_gamepad_get_description"] = {
			source = 'input_gamepad_get_description',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_index' },
			}
		},
		["SURVIVOR_MILESTONE_ID_to_description_token"] = {
			source = 'scr_survivor',
			line = 48,
			constructor = false,
			base = nil,
			params = {
				{ name = 'milestone_id' },
			}
		},
		["survivor_auto_configure_providence_skin"] = {
			source = 'scr_survivor',
			line = 135,
			constructor = false,
			base = nil,
			params = {
				{ name = 'survivor_id,' },
			}
		},
		["survivor_create"] = {
			source = 'scr_survivor',
			line = 169,
			constructor = false,
			base = nil,
			params = {
				{ name = 'namespace' },
				{ name = 'name,' },
			}
		},
		["survivor_get_stat_key"] = {
			source = 'scr_survivor',
			line = 299,
			constructor = false,
			base = nil,
			params = {
				{ name = 'survivor_id' },
			}
		},
		["survivor_get_stat_key_items"] = {
			source = 'scr_survivor',
			line = 303,
			constructor = false,
			base = nil,
			params = {
				{ name = 'survivor_id' },
			}
		},
		["survivor_get_stat_key_kills"] = {
			source = 'scr_survivor',
			line = 306,
			constructor = false,
			base = nil,
			params = {
				{ name = 'survivor_id' },
			}
		},
		["survivor_get_stat_key_stages_passed"] = {
			source = 'scr_survivor',
			line = 309,
			constructor = false,
			base = nil,
			params = {
				{ name = 'survivor_id' },
			}
		},
		["survivor_get_stat_key_games_played"] = {
			source = 'scr_survivor',
			line = 312,
			constructor = false,
			base = nil,
			params = {
				{ name = 'survivor_id' },
			}
		},
		["survivor_get_stat_key_wins"] = {
			source = 'scr_survivor',
			line = 315,
			constructor = false,
			base = nil,
			params = {
				{ name = 'survivor_id' },
			}
		},
		["survivor_get_stat_key_wins_hard"] = {
			source = 'scr_survivor',
			line = 318,
			constructor = false,
			base = nil,
			params = {
				{ name = 'survivor_id' },
			}
		},
		["survivor_get_stat_key_deaths"] = {
			source = 'scr_survivor',
			line = 321,
			constructor = false,
			base = nil,
			params = {
				{ name = 'survivor_id' },
			}
		},
		["survivor_get_save_key_eclipse_level_complete"] = {
			source = 'scr_survivor',
			line = 326,
			constructor = false,
			base = nil,
			params = {
				{ name = 'survivor_id' },
				{ name = 'eclipse_level' },
			}
		},
		["survivor_get_save_key_viewed"] = {
			source = 'scr_survivor',
			line = 331,
			constructor = false,
			base = nil,
			params = {
				{ name = 'survivor_id' },
			}
		},
		["survivor_get_id"] = {
			source = 'scr_survivor',
			line = 336,
			constructor = false,
			base = nil,
			params = {
				{ name = 'survivor' },
			}
		},
		["survivor_find"] = {
			source = 'scr_survivor',
			line = 342,
			constructor = false,
			base = nil,
			params = {
				{ name = 'id_string' },
			}
		},
		["survivor_get_skill_unlockable_index"] = {
			source = 'scr_survivor',
			line = 349,
			constructor = false,
			base = nil,
			params = {
				{ name = 'survivor_id' },
				{ name = 'skill_index' },
				{ name = 'family_element_index' },
			}
		},
		["survivor_get_skin_unlockable_index"] = {
			source = 'scr_survivor',
			line = 352,
			constructor = false,
			base = nil,
			params = {
				{ name = 'survivor_id' },
				{ name = 'skin_index' },
			}
		},
		["__lf_oEfAcidBubble_create_deserialize"] = {
			source = '__lf_oEfAcidBubble_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["_survivor_chef_handle_c_state"] = {
			source = 'scr_ror_init_survivor_chef',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
				{ name = 'empowered' },
			}
		},
		["_survivor_chef_handle_v_skill"] = {
			source = 'scr_ror_init_survivor_chef',
			line = 35,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
			}
		},
		["_survivor_chef_update_skill_empower"] = {
			source = 'scr_ror_init_survivor_chef',
			line = 54,
			constructor = false,
			base = nil,
			params = {
				{ name = 'skill' },
				{ name = 'empowered' },
			}
		},
		["_survivor_chef_update_skill"] = {
			source = 'scr_ror_init_survivor_chef',
			line = 63,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'skill' },
				{ name = 'index' },
			}
		},
		["_survivor_chef_is_empowered"] = {
			source = 'scr_ror_init_survivor_chef',
			line = 74,
			constructor = false,
			base = nil,
			params = {}
		},
		["__rpc_shrine_create_exp_reward_implementation__"] = {
			source = 'scr_network_packets_interactables',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'dir' },
				{ name = 'spd' },
				{ name = 'target' },
			}
		},
		["__net_packet_activate_interactable_write__"] = {
			source = 'scr_network_packets_interactables',
			line = 21,
			constructor = false,
			base = nil,
			params = {
				{ name = 'activator' },
				{ name = 'new_active' },
				{ name = 'success' },
				{ name = 'item_id', value = [=[-1]=] },
			}
		},
		["__net_packet_activate_interactable_read__"] = {
			source = 'scr_network_packets_interactables',
			line = 32,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_update_chest4_write__"] = {
			source = 'scr_network_packets_interactables',
			line = 82,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_update_chest4_read__"] = {
			source = 'scr_network_packets_interactables',
			line = 85,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_update_trishop_write__"] = {
			source = 'scr_network_packets_interactables',
			line = 93,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_update_trishop_read__"] = {
			source = 'scr_network_packets_interactables',
			line = 96,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_shrine_proc_write__"] = {
			source = 'scr_network_packets_interactables',
			line = 106,
			constructor = false,
			base = nil,
			params = {
				{ name = 'result' },
			}
		},
		["__net_packet_shrine_proc_read__"] = {
			source = 'scr_network_packets_interactables',
			line = 109,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_activate_switch_write__"] = {
			source = 'scr_network_packets_interactables',
			line = 116,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_activate_switch_read__"] = {
			source = 'scr_network_packets_interactables',
			line = 118,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_update_vendor_write__"] = {
			source = 'scr_network_packets_interactables',
			line = 125,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_update_vendor_read__"] = {
			source = 'scr_network_packets_interactables',
			line = 128,
			constructor = false,
			base = nil,
			params = {}
		},
		["CustomDataStruct"] = {
			source = 'scr_CustomDataStruct',
			line = 2,
			constructor = true,
			base = nil,
			params = {}
		},
		["_survivor_acrid_handle_v_state"] = {
			source = 'scr_ror_init_survivor_acrid',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
				{ name = 'skill' },
			}
		},
		["input_cursor_limit_get"] = {
			source = 'input_cursor_limit_get',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["_survivor_mercenary_find_ult_target"] = {
			source = 'scr_ror_init_survivor_merc',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["_survivor_mercenary_update_primary_state"] = {
			source = 'scr_ror_init_survivor_merc',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
				{ name = 'data' },
				{ name = 'attack_index' },
				{ name = 'next_state' },
			}
		},
		["_survivor_mercenary_refresh_c"] = {
			source = 'scr_ror_init_survivor_merc',
			line = 52,
			constructor = false,
			base = nil,
			params = {
				{ name = 'is_refund' },
				{ name = 'is_success' },
			}
		},
		["_survivor_mercenary_handle_v_state"] = {
			source = 'scr_ror_init_survivor_merc',
			line = 76,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
				{ name = 'skill' },
			}
		},
		["_mod_camera_get_instance"] = {
			source = 'scr_luaApi_camera',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_camera_set_width"] = {
			source = 'scr_luaApi_camera',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'cam' },
				{ name = 'w' },
			}
		},
		["_mod_camera_set_height"] = {
			source = 'scr_luaApi_camera',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'cam' },
				{ name = 'h' },
			}
		},
		["_mod_camera_set_x"] = {
			source = 'scr_luaApi_camera',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = 'cam' },
				{ name = 'xx' },
			}
		},
		["_mod_camera_set_y"] = {
			source = 'scr_luaApi_camera',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = 'cam' },
				{ name = 'yy' },
			}
		},
		["ProvEdit_level_delete"] = {
			source = 'ProvEdit_level_delete',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["stage_load_room"] = {
			source = 'stage_load_room',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["_survivor_hand_x_skill_find_drone"] = {
			source = 'scr_ror_init_survivor_hand',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
			}
		},
		["_survivor_hand_do_x_skill"] = {
			source = 'scr_ror_init_survivor_hand',
			line = 27,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
				{ name = 'skill' },
				{ name = 'index' },
			}
		},
		["_survivor_hand_x_skill_stock_fix"] = {
			source = 'scr_ror_init_survivor_hand',
			line = 53,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
				{ name = 'skill' },
			}
		},
		["survivor_hand_skill_id_to_drone_type"] = {
			source = 'scr_ror_init_survivor_hand',
			line = 67,
			constructor = false,
			base = nil,
			params = {
				{ name = 'skill_id' },
			}
		},
		["player_get_active_actor"] = {
			source = 'player_get_active_actor',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'p' },
			}
		},
		["_survivor_miner_find_heat_bar"] = {
			source = 'scr_ror_init_survivor_miner',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'parent' },
			}
		},
		["_survivor_miner_heat_add"] = {
			source = 'scr_ror_init_survivor_miner',
			line = 12,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
				{ name = 'amount' },
			}
		},
		["_survivor_miner_heat_set"] = {
			source = 'scr_ror_init_survivor_miner',
			line = 24,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
				{ name = 'amount' },
			}
		},
		["_survivor_miner_heat_get"] = {
			source = 'scr_ror_init_survivor_miner',
			line = 30,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
			}
		},
		["_survivor_miner_update_sprites"] = {
			source = 'scr_ror_init_survivor_miner',
			line = 36,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
			}
		},
		["__rpc_survivor_miner_heat_sync_implementation__"] = {
			source = 'scr_ror_init_survivor_miner',
			line = 92,
			constructor = false,
			base = nil,
			params = {
				{ name = 'target' },
				{ name = 'amount' },
			}
		},
		["_survivor_miner_heat_sync"] = {
			source = 'scr_ror_init_survivor_miner',
			line = 96,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
			}
		},
		["_survivor_miner_create_heat_bar"] = {
			source = 'scr_ror_init_survivor_miner',
			line = 107,
			constructor = false,
			base = nil,
			params = {}
		},
		["boss_unique_killed"] = {
			source = 'scr_ror_init_survivor_huntress',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'flag' },
			}
		},
		["_survivor_huntress_aim"] = {
			source = 'scr_ror_init_survivor_huntress',
			line = 25,
			constructor = false,
			base = nil,
			params = {}
		},
		["_survivor_sniper_ammo_lost"] = {
			source = 'scr_ror_init_survivor_sniper',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["_survivor_sniper_ammo_gained"] = {
			source = 'scr_ror_init_survivor_sniper',
			line = 11,
			constructor = false,
			base = nil,
			params = {}
		},
		["_survivor_sniper_find_drone"] = {
			source = 'scr_ror_init_survivor_sniper',
			line = 16,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
			}
		},
		["_survivor_sniper_v_skill"] = {
			source = 'scr_ror_init_survivor_sniper',
			line = 29,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
			}
		},
		["_survivor_sniper_v_skill_internal"] = {
			source = 'scr_ror_init_survivor_sniper',
			line = 50,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
				{ name = 'target' },
			}
		},
		["_survivor_sniper_recall_internal"] = {
			source = 'scr_ror_init_survivor_sniper',
			line = 76,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
			}
		},
		["_survivor_sniper_set_sniper_bonus"] = {
			source = 'scr_ror_init_survivor_sniper',
			line = 92,
			constructor = false,
			base = nil,
			params = {
				{ name = 'attack' },
				{ name = 'sniper_bonus' },
			}
		},
		["__net_packet_sniper_set_target_write__"] = {
			source = 'scr_ror_init_survivor_sniper',
			line = 105,
			constructor = false,
			base = nil,
			params = {
				{ name = 'target' },
			}
		},
		["__net_packet_sniper_set_target_read__"] = {
			source = 'scr_ror_init_survivor_sniper',
			line = 108,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_sniper_recall_write__"] = {
			source = 'scr_ror_init_survivor_sniper',
			line = 115,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_sniper_recall_read__"] = {
			source = 'scr_ror_init_survivor_sniper',
			line = 116,
			constructor = false,
			base = nil,
			params = {}
		},
		["stage_get_next_stage_index"] = {
			source = 'scr_stage',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'current_level' },
			}
		},
		["stage_get_final_stage_index"] = {
			source = 'scr_stage',
			line = 10,
			constructor = false,
			base = nil,
			params = {}
		},
		["stage_should_spawn_epic_teleporter"] = {
			source = 'scr_stage',
			line = 14,
			constructor = false,
			base = nil,
			params = {
				{ name = 'stages_passed' },
			}
		},
		["stage_roll_next"] = {
			source = 'scr_stage',
			line = 19,
			constructor = false,
			base = nil,
			params = {
				{ name = 'current_level' },
			}
		},
		["_mod_stage_register"] = {
			source = 'scr_stage',
			line = 117,
			constructor = false,
			base = nil,
			params = {
				{ name = 'index' },
				{ name = 'stage' },
			}
		},
		["_mod_stage_get_pool_list"] = {
			source = 'scr_stage',
			line = 123,
			constructor = false,
			base = nil,
			params = {
				{ name = 'index' },
			}
		},
		["stage_create"] = {
			source = 'scr_stage',
			line = 164,
			constructor = false,
			base = nil,
			params = {}
		},
		["stage_get_id"] = {
			source = 'scr_stage',
			line = 240,
			constructor = false,
			base = nil,
			params = {
				{ name = 'stage' },
			}
		},
		["stage_find"] = {
			source = 'scr_stage',
			line = 246,
			constructor = false,
			base = nil,
			params = {
				{ name = 'id_string' },
			}
		},
		["stage_get_save_key_visited"] = {
			source = 'scr_stage',
			line = 252,
			constructor = false,
			base = nil,
			params = {
				{ name = 'stage' },
			}
		},
		["stage_load_room_from_level"] = {
			source = 'stage_load_room_from_level',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["ProvEdit_semver_parse"] = {
			source = 'ProvEdit_semver_parse',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["_survivor_enforcer_update_bunker"] = {
			source = 'scr_ror_init_survivor_enforcer',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'new_bunker' },
			}
		},
		["input_icons"] = {
			source = 'input_icons',
			line = 12,
			constructor = false,
			base = nil,
			params = {
				{ name = '_name' },
			}
		},
		["ProvEdit_level_read_buffer_layer"] = {
			source = 'ProvEdit_level_read_buffer_layer',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["_survivor_commando_slide_step"] = {
			source = 'scr_ror_init_survivor_commando',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'data' },
			}
		},
		["_survivor_commando_exit_state_on_anim_end"] = {
			source = 'scr_ror_init_survivor_commando',
			line = 21,
			constructor = false,
			base = nil,
			params = {}
		},
		["_survivor_commando_reset_activity_state"] = {
			source = 'scr_ror_init_survivor_commando',
			line = 38,
			constructor = false,
			base = nil,
			params = {}
		},
		["_survivor_commando_skill_can_activate_during_slide"] = {
			source = 'scr_ror_init_survivor_commando',
			line = 47,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
			}
		},
		["_survivor_commando_skill_anim_set"] = {
			source = 'scr_ror_init_survivor_commando',
			line = 57,
			constructor = false,
			base = nil,
			params = {
				{ name = 'anim_normal' },
				{ name = 'anim_slide_forward' },
				{ name = 'anim_slide_behind' },
			}
		},
		["_survivor_commando_skill_state_exit"] = {
			source = 'scr_ror_init_survivor_commando',
			line = 73,
			constructor = false,
			base = nil,
			params = {}
		},
		["_survivor_commando_pre_set_skill_state"] = {
			source = 'scr_ror_init_survivor_commando',
			line = 78,
			constructor = false,
			base = nil,
			params = {}
		},
		["_survivor_commando_shared_skill_serialize"] = {
			source = 'scr_ror_init_survivor_commando',
			line = 117,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
				{ name = 'data' },
			}
		},
		["_survivor_commando_shared_skill_deserialize"] = {
			source = 'scr_ror_init_survivor_commando',
			line = 121,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
				{ name = 'data' },
			}
		},
		["_survivor_commando_is_sliding"] = {
			source = 'scr_ror_init_survivor_commando',
			line = 127,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_mouse_y"] = {
			source = 'input_mouse_y',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["ProvEdit_semver_get_level_features"] = {
			source = 'ProvEdit_semver_get_level_features',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["ProvEdit_level_read_buffer_collision"] = {
			source = 'ProvEdit_level_read_buffer_collision',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["ProvEdit_level_read_buffer_background"] = {
			source = 'ProvEdit_level_read_buffer_background',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["ProvEdit_level_read_buffer_object"] = {
			source = 'ProvEdit_level_read_buffer_object',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["drop_gold_and_exp"] = {
			source = 'drop_gold_and_exp',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'value,' },
			}
		},
		["_____provedit_levelformatlib_init"] = {
			source = '_____provedit_levelformatlib_init',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["_ProvEdit_resource_resolve"] = {
			source = 'scr_provedit_data_resolvers',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'resource_manager' },
				{ name = 'default_value' },
				{ name = 'ident' },
			}
		},
		["ProvEdit_sprite_find"] = {
			source = 'scr_provedit_data_resolvers',
			line = 19,
			constructor = false,
			base = nil,
			params = {
				{ name = 'i' },
			}
		},
		["ProvEdit_tileset_find"] = {
			source = 'scr_provedit_data_resolvers',
			line = 20,
			constructor = false,
			base = nil,
			params = {
				{ name = 'i' },
			}
		},
		["ProvEdit_background_find"] = {
			source = 'scr_provedit_data_resolvers',
			line = 21,
			constructor = false,
			base = nil,
			params = {
				{ name = 'i' },
			}
		},
		["ProvEdit_object_find"] = {
			source = 'scr_provedit_data_resolvers',
			line = 22,
			constructor = false,
			base = nil,
			params = {
				{ name = 'i' },
			}
		},
		["input_cursor_limit_circle"] = {
			source = 'input_cursor_limit_circle',
			line = 7,
			constructor = false,
			base = nil,
			params = {
				{ name = '_x' },
				{ name = '_y' },
				{ name = '_radius' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["enemy_copy_prefix"] = {
			source = 'enemy_copy_prefix',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["stage_goto"] = {
			source = 'stage_goto',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = 'stage_id' },
				{ name = 'variant_index', value = [=[undefined]=] },
				{ name = 'room_id', value = [=[undefined]=] },
			}
		},
		["director_try_elite_spawn"] = {
			source = 'director_try_elite_spawn',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'spawn' },
				{ name = 'card' },
				{ name = 'is_boss_spawn' },
			}
		},
		["input_player_verify"] = {
			source = 'input_player_verify',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_json' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["instance_spawn_floor_snap"] = {
			source = 'instance_spawn_floor_snap',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'max_fall_range', value = [=[TILE_SIZE * 3]=] },
			}
		},
		["elite_set"] = {
			source = 'elite_set',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["elite_set_internal"] = {
			source = 'elite_set',
			line = 20,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["init_blight_classic"] = {
			source = 'init_blight_classic',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["inventory_items_copy"] = {
			source = 'inventory_items_copy',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'source' },
				{ name = 'dest' },
				{ name = 'compare_against_flags' },
			}
		},
		["elite_type_find"] = {
			source = 'scr_eliteType',
			line = 37,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
			}
		},
		["elite_type_create"] = {
			source = 'scr_eliteType',
			line = 54,
			constructor = false,
			base = nil,
			params = {}
		},
		["elite_generate_palettes"] = {
			source = 'scr_eliteType',
			line = 101,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["elite_can_spawn_blighted_enemies"] = {
			source = 'scr_eliteType',
			line = 153,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_elite_generate_palette_sprite"] = {
			source = 'scr_eliteType',
			line = 160,
			constructor = false,
			base = nil,
			params = {
				{ name = 'spr' },
			}
		},
		["_mod_elite_generate_palette_all"] = {
			source = 'scr_eliteType',
			line = 161,
			constructor = false,
			base = nil,
			params = {}
		},
		["init_elite_classic"] = {
			source = 'init_elite_classic',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = '_' },
				{ name = 'elite' },
			}
		},
		["is_elite"] = {
			source = 'is_elite',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["GlobalModInfo"] = {
			source = 'scr_mod_info',
			line = 9,
			constructor = true,
			base = nil,
			params = {}
		},
		["ModWorkshopInfo"] = {
			source = 'scr_mod_info',
			line = 157,
			constructor = true,
			base = nil,
			params = {
				{ name = 'workshop_id' },
			}
		},
		["ModDisplayInfo"] = {
			source = 'scr_mod_info',
			line = 198,
			constructor = true,
			base = nil,
			params = {
				{ name = 'mod_info' },
			}
		},
		["ModInfo"] = {
			source = 'scr_mod_info',
			line = 282,
			constructor = true,
			base = nil,
			params = {
				{ name = 'path' },
				{ name = 'ident_string' },
				{ name = 'source' },
				{ name = 'workshop_id', value = [=[-1]=] },
			}
		},
		["ModDependencyInfo"] = {
			source = 'scr_mod_info',
			line = 525,
			constructor = true,
			base = nil,
			params = {
				{ name = 'parent_mod_info' },
			}
		},
		["ModSyncInfo"] = {
			source = 'scr_mod_info',
			line = 657,
			constructor = true,
			base = nil,
			params = {
				{ name = 'mod_info' },
			}
		},
		["sync_mod_local_array"] = {
			source = 'scr_mod_info',
			line = 663,
			constructor = false,
			base = nil,
			params = {
				{ name = 'source' },
			}
		},
		["sync_mod_string"] = {
			source = 'scr_mod_info',
			line = 676,
			constructor = false,
			base = nil,
			params = {}
		},
		["sync_mod_parse"] = {
			source = 'scr_mod_info',
			line = 681,
			constructor = false,
			base = nil,
			params = {
				{ name = 'json_string' },
			}
		},
		["sync_mod_error_name"] = {
			source = 'scr_mod_info',
			line = 723,
			constructor = false,
			base = nil,
			params = {
				{ name = 'error_code' },
			}
		},
		["sync_mod_verify"] = {
			source = 'scr_mod_info',
			line = 733,
			constructor = false,
			base = nil,
			params = {
				{ name = 'source_mods' },
				{ name = 'ref_mods' },
			}
		},
		["buff_create"] = {
			source = 'scr_buff',
			line = 52,
			constructor = false,
			base = nil,
			params = {}
		},
		["apply_buff"] = {
			source = 'apply_buff',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'inst' },
				{ name = 'buff_id' },
				{ name = 'time' },
				{ name = 'stack_value', value = [=[1]=] },
			}
		},
		["set_buff_time_nosync"] = {
			source = 'apply_buff',
			line = 10,
			constructor = false,
			base = nil,
			params = {
				{ name = 'inst' },
				{ name = 'buff_id' },
				{ name = 'time' },
			}
		},
		["set_buff_time"] = {
			source = 'update_buff_time',
			line = 4,
			constructor = false,
			base = nil,
			params = {}
		},
		["can_apply_buff"] = {
			source = 'can_apply_buff',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["step_buff"] = {
			source = 'step_buff',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfMedallionPickup_create_serialize"] = {
			source = '__lf_oEfMedallionPickup_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["_ResultsScreen_shared_init"] = {
			source = 'scr_results_screen_shared_logic',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["_ResultsScreen_shared_step"] = {
			source = 'scr_results_screen_shared_logic',
			line = 22,
			constructor = false,
			base = nil,
			params = {}
		},
		["draw_hud_item_pickup_info"] = {
			source = 'draw_hud_item_pickup_info',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'ipx' },
				{ name = 'ipy' },
				{ name = 'hud_display_info' },
			}
		},
		["remove_buff"] = {
			source = 'remove_buff',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'buff_id' },
			}
		},
		["remove_buff_internal"] = {
			source = 'remove_buff',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'buff_id' },
			}
		},
		["get_buff_time"] = {
			source = 'get_buff_time',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["has_buff"] = {
			source = 'has_buff',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["__lf_oDrifterRec_create_serialize"] = {
			source = '__lf_oDrifterRec_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["get_buff_stack"] = {
			source = 'get_buff_stack',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
			}
		},
		["get_buffs"] = {
			source = 'get_buffs',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["set_buff_time_internal"] = {
			source = 'update_buff_time_internal',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
				{ name = 'argument1' },
				{ name = 'argument2' },
			}
		},
		["apply_buff_internal"] = {
			source = 'apply_buff_internal',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'inst' },
				{ name = 'buff_id' },
				{ name = 'time' },
				{ name = 'stack_value' },
			}
		},
		["input_binding_scan_in_progress"] = {
			source = 'input_binding_scan_in_progress',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["input_axis_threshold_set"] = {
			source = 'input_axis_threshold_set',
			line = 8,
			constructor = false,
			base = nil,
			params = {
				{ name = '_axis' },
				{ name = '_min' },
				{ name = '_max' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["monster_log_create"] = {
			source = 'scr_monsterLog',
			line = 107,
			constructor = false,
			base = nil,
			params = {}
		},
		["monster_log_get_save_key_got"] = {
			source = 'scr_monsterLog',
			line = 204,
			constructor = false,
			base = nil,
			params = {
				{ name = 'log_id' },
			}
		},
		["monster_log_get_save_key_viewed"] = {
			source = 'scr_monsterLog',
			line = 205,
			constructor = false,
			base = nil,
			params = {
				{ name = 'log_id' },
			}
		},
		["difficulty_get_current_enemy_damage_scale"] = {
			source = 'difficulty_get_current_enemy_damage_scale',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_binding_empty"] = {
			source = 'input_binding_empty',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["difficulty_get_current_enemy_hp_scale"] = {
			source = 'difficulty_get_current_enemy_hp_scale',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["difficulty_get_current_base_scale"] = {
			source = 'difficulty_get_current_base_scale',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["draw_set_font_w"] = {
			source = 'scr_text_function_replacements',
			line = 8,
			constructor = false,
			base = nil,
			params = {
				{ name = 'font' },
			}
		},
		["draw_text_w"] = {
			source = 'scr_text_function_replacements',
			line = 17,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'text' },
			}
		},
		["string_width_w"] = {
			source = 'scr_text_function_replacements',
			line = 45,
			constructor = false,
			base = nil,
			params = {
				{ name = 'text' },
			}
		},
		["string_height_w"] = {
			source = 'scr_text_function_replacements',
			line = 62,
			constructor = false,
			base = nil,
			params = {
				{ name = 'text' },
			}
		},
		["draw_text_ext_w"] = {
			source = 'scr_text_function_replacements',
			line = 79,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'text' },
				{ name = 'sep' },
				{ name = 'w' },
			}
		},
		["string_width_ext_w"] = {
			source = 'scr_text_function_replacements',
			line = 110,
			constructor = false,
			base = nil,
			params = {
				{ name = 'text' },
				{ name = 'sep' },
				{ name = 'w' },
			}
		},
		["string_height_ext_w"] = {
			source = 'scr_text_function_replacements',
			line = 131,
			constructor = false,
			base = nil,
			params = {
				{ name = 'text' },
				{ name = 'sep' },
				{ name = 'w' },
			}
		},
		["__input_class_chord_state"] = {
			source = '__input_class_chord_state',
			line = 1,
			constructor = true,
			base = nil,
			params = {
				{ name = '_name' },
				{ name = '_chord_definition_struct' },
			}
		},
		["difficulty_eclipse_get_max_available_level_for_survivor"] = {
			source = 'scr_ror_init_difficulty',
			line = 56,
			constructor = false,
			base = nil,
			params = {
				{ name = 'survivor_id' },
				{ name = 'client_id' },
			}
		},
		["difficulty_eclipse_get_level"] = {
			source = 'scr_ror_init_difficulty',
			line = 67,
			constructor = false,
			base = nil,
			params = {
				{ name = 'difficulty_id' },
			}
		},
		["input_source_mode_get"] = {
			source = 'input_source_mode_get',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["item_equipment_enigma_reroll"] = {
			source = 'item_equipment_enigma_reroll',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["monster_card_create"] = {
			source = 'scr_monsterCard',
			line = 61,
			constructor = false,
			base = nil,
			params = {
				{ name = 'namespace' },
				{ name = 'name,' },
			}
		},
		["monster_card_find"] = {
			source = 'scr_monsterCard',
			line = 112,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
			}
		},
		["__artifact_spirit_tick5"] = {
			source = 'scr_ror_init_artifacts',
			line = 106,
			constructor = false,
			base = nil,
			params = {}
		},
		["difficulty_create"] = {
			source = 'scr_difficulty',
			line = 46,
			constructor = false,
			base = nil,
			params = {}
		},
		["difficulty_set_active"] = {
			source = 'scr_difficulty',
			line = 107,
			constructor = false,
			base = nil,
			params = {
				{ name = 'difficulty' },
			}
		},
		["difficulty_get_hover_text"] = {
			source = 'scr_difficulty',
			line = 116,
			constructor = false,
			base = nil,
			params = {
				{ name = 'ind' },
			}
		},
		["difficulty_get_id"] = {
			source = 'scr_difficulty',
			line = 121,
			constructor = false,
			base = nil,
			params = {
				{ name = 'diff' },
			}
		},
		["difficulty_find"] = {
			source = 'scr_difficulty',
			line = 127,
			constructor = false,
			base = nil,
			params = {
				{ name = 'id_string' },
			}
		},
		["interactable_card_create"] = {
			source = 'scr_interactableCard',
			line = 28,
			constructor = false,
			base = nil,
			params = {
				{ name = 'namespace' },
				{ name = 'name,' },
			}
		},
		["interactable_card_find"] = {
			source = 'scr_interactableCard',
			line = 70,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
			}
		},
		["item_player_scrap_get_id"] = {
			source = 'scr_ror_items_init_misc',
			line = 71,
			constructor = false,
			base = nil,
			params = {
				{ name = 'index_from_0' },
			}
		},
		["item_player_scrap_get_id_for_player"] = {
			source = 'scr_ror_items_init_misc',
			line = 82,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player_index_from_0' },
				{ name = 'max_players' },
			}
		},
		["item_player_scrap_init"] = {
			source = 'scr_ror_items_init_misc',
			line = 91,
			constructor = false,
			base = nil,
			params = {}
		},
		["item_player_scrap_init_from_run_report"] = {
			source = 'scr_ror_items_init_misc',
			line = 110,
			constructor = false,
			base = nil,
			params = {
				{ name = 'run_report' },
			}
		},
		["_item_player_scrap_init_internal"] = {
			source = 'scr_ror_items_init_misc',
			line = 122,
			constructor = false,
			base = nil,
			params = {}
		},
		["artifact_create"] = {
			source = 'scr_artifact',
			line = 50,
			constructor = false,
			base = nil,
			params = {}
		},
		["artifact_get_hover_text"] = {
			source = 'scr_artifact',
			line = 113,
			constructor = false,
			base = nil,
			params = {
				{ name = 'argument0' },
			}
		},
		["artifact_is_available"] = {
			source = 'scr_artifact',
			line = 121,
			constructor = false,
			base = nil,
			params = {
				{ name = 'artifact_id' },
			}
		},
		["artifact_get_lobby_rule_key"] = {
			source = 'scr_artifact',
			line = 126,
			constructor = false,
			base = nil,
			params = {
				{ name = 'artifact_id' },
			}
		},
		["artifact_get_save_key_viewed"] = {
			source = 'scr_artifact',
			line = 132,
			constructor = false,
			base = nil,
			params = {
				{ name = 'artifact_id' },
			}
		},
		["artifact_get_id"] = {
			source = 'scr_artifact',
			line = 137,
			constructor = false,
			base = nil,
			params = {
				{ name = 'artifact' },
			}
		},
		["artifact_find"] = {
			source = 'scr_artifact',
			line = 143,
			constructor = false,
			base = nil,
			params = {
				{ name = 'id_string' },
			}
		},
		["artifact_dissonance_get_shard_save_key"] = {
			source = 'scr_artifact',
			line = 150,
			constructor = false,
			base = nil,
			params = {
				{ name = 'index' },
			}
		},
		["artifact_dissonance_shard_grant"] = {
			source = 'scr_artifact',
			line = 153,
			constructor = false,
			base = nil,
			params = {
				{ name = 'index' },
			}
		},
		["artifact_dissonance_shard_remaining_count"] = {
			source = 'scr_artifact',
			line = 162,
			constructor = false,
			base = nil,
			params = {}
		},
		["artifact_dissonance_shard_pickup_init"] = {
			source = 'scr_artifact',
			line = 171,
			constructor = false,
			base = nil,
			params = {
				{ name = 'index' },
			}
		},
		["artifact_set_active"] = {
			source = 'scr_artifact',
			line = 192,
			constructor = false,
			base = nil,
			params = {
				{ name = 'artifact' },
				{ name = 'active' },
				{ name = 'sync', value = [=[true]=] },
			}
		},
		["__lf_oEfBoss4SliceDoT_create_deserialize"] = {
			source = '__lf_oEfBoss4SliceDoT_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oFlashCircle_create_serialize"] = {
			source = '__lf_oFlashCircle_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["get_prefs_file_path"] = {
			source = 'MACROS',
			line = 228,
			constructor = false,
			base = nil,
			params = {}
		},
		["achievement_update_display_order_to_be_after"] = {
			source = 'scr_achievement',
			line = 17,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achievement' },
				{ name = 'achievement_to_be_after' },
			}
		},
		["achievement_create"] = {
			source = 'scr_achievement',
			line = 105,
			constructor = false,
			base = nil,
			params = {}
		},
		["achievement_set_alt_milestone_unlock"] = {
			source = 'scr_achievement',
			line = 188,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achiev_id' },
				{ name = 'survivor_id' },
				{ name = 'milestone_id' },
			}
		},
		["achievement_get_unlocked_string"] = {
			source = 'scr_achievement',
			line = 195,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achiev_id' },
			}
		},
		["achievement_is_skin_unlock"] = {
			source = 'scr_achievement',
			line = 204,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achievement_id' },
			}
		},
		["achievement_is_skill_unlock"] = {
			source = 'scr_achievement',
			line = 211,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achievement_id' },
			}
		},
		["achievement_get_gameover_string"] = {
			source = 'scr_achievement',
			line = 219,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achiev_id' },
			}
		},
		["achievement_get_unlock_header_string"] = {
			source = 'scr_achievement',
			line = 223,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achiev_id' },
			}
		},
		["achievement_get_type_string"] = {
			source = 'scr_achievement',
			line = 226,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achiev_id' },
			}
		},
		["achievement_get_save_key_completed"] = {
			source = 'scr_achievement',
			line = 243,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achiev_id' },
			}
		},
		["achievement_get_save_key_progress"] = {
			source = 'scr_achievement',
			line = 247,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achiev_id' },
			}
		},
		["achievement_get_save_key_viewed"] = {
			source = 'scr_achievement',
			line = 251,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achiev_id' },
			}
		},
		["achievement_is_unlocked"] = {
			source = 'scr_achievement',
			line = 256,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achiev_id' },
			}
		},
		["achievement_is_unlocked_or_null"] = {
			source = 'scr_achievement',
			line = 261,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achiev_id' },
			}
		},
		["achievement_is_NOT_unlocked_any_player"] = {
			source = 'scr_achievement',
			line = 266,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achiev_id' },
			}
		},
		["achievement_is_unlocked_any_player"] = {
			source = 'scr_achievement',
			line = 271,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achiev_id' },
			}
		},
		["achievement_is_unlocked_or_null_any_player"] = {
			source = 'scr_achievement',
			line = 276,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achiev_id' },
			}
		},
		["achievement_set_requirement"] = {
			source = 'scr_achievement',
			line = 281,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achiev_id' },
				{ name = 'requirement' },
			}
		},
		["achievement_force_set_unlocked"] = {
			source = 'scr_achievement',
			line = 286,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achiev_id' },
				{ name = 'unlocked' },
			}
		},
		["achievement_add_progress"] = {
			source = 'scr_achievement',
			line = 297,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achiev_id' },
				{ name = 'amount' },
				{ name = 'force', value = [=[false]=] },
				{ name = 'silent', value = [=[false]=] },
				{ name = 'show_alt_unlock_text_on_completion', value = [=[false]=] },
			}
		},
		["achievement_on_unlocked"] = {
			source = 'scr_achievement',
			line = 335,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achiev_id' },
			}
		},
		["achievement_progress_player"] = {
			source = 'scr_achievement',
			line = 345,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
				{ name = 'achiev_id' },
				{ name = 'amount' },
				{ name = 'force', value = [=[false]=] },
			}
		},
		["achievement_get_id"] = {
			source = 'scr_achievement',
			line = 363,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achievement' },
			}
		},
		["achievement_find"] = {
			source = 'scr_achievement',
			line = 369,
			constructor = false,
			base = nil,
			params = {
				{ name = 'id_string' },
			}
		},
		["achievement_get_desc_translated"] = {
			source = 'scr_achievement',
			line = 378,
			constructor = false,
			base = nil,
			params = {
				{ name = 'ach_id' },
				{ name = 'allow_colour_tag_in_return_string', value = [=[true]=] },
				{ name = 'show_only_alt_or_main_condition', value = [=[-1]=] },
			}
		},
		["achievement_associate_trial"] = {
			source = 'scr_achievement',
			line = 404,
			constructor = false,
			base = nil,
			params = {
				{ name = 'ach_id' },
			}
		},
		["achievement_is_parent_unlocked_or_null"] = {
			source = 'scr_achievement',
			line = 412,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achievement_id' },
			}
		},
		["achievement_get_content_name"] = {
			source = 'scr_achievement',
			line = 427,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achievement_id' },
			}
		},
		["achievement_get_content_description"] = {
			source = 'scr_achievement',
			line = 443,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achievement_id' },
			}
		},
		["achievement_get_content_name_color"] = {
			source = 'scr_achievement',
			line = 459,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achievement_id' },
				{ name = 'survivor_id_for_unlockable_kind', value = [=[-1]=] },
			}
		},
		["achievement_get_unlock_kind_name_key"] = {
			source = 'scr_achievement',
			line = 476,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achievement_id' },
			}
		},
		["achievement_get_should_show_trial_unlock"] = {
			source = 'scr_achievement',
			line = 492,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achievement_id' },
			}
		},
		["achievement_reset_unlock"] = {
			source = 'scr_achievement',
			line = 517,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achievement_id' },
			}
		},
		["achievement_set_unlock_survivor"] = {
			source = 'scr_achievement',
			line = 556,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achievement_id' },
				{ name = 'unlock_id' },
			}
		},
		["achievement_set_unlock_equipment"] = {
			source = 'scr_achievement',
			line = 569,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achievement_id' },
				{ name = 'unlock_id' },
			}
		},
		["achievement_set_unlock_item"] = {
			source = 'scr_achievement',
			line = 586,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achievement_id' },
				{ name = 'unlock_id' },
			}
		},
		["achievement_set_unlock_artifact"] = {
			source = 'scr_achievement',
			line = 602,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achievement_id' },
				{ name = 'unlock_id' },
			}
		},
		["achievement_set_unlock_survivor_loadout_unlockable"] = {
			source = 'scr_achievement',
			line = 614,
			constructor = false,
			base = nil,
			params = {
				{ name = 'achievement_id' },
				{ name = 'unlock_id' },
			}
		},
		["achievement_auto_configure_prism"] = {
			source = 'scr_achievement',
			line = 634,
			constructor = false,
			base = nil,
			params = {
				{ name = 'survivor_id' },
				{ name = 'skin_index' },
				{ name = 'primary_col' },
				{ name = 'ach_suffix_name', value = [=[""]=] },
			}
		},
		["_mod_achievement_get_unlock_kind"] = {
			source = 'scr_achievement',
			line = 653,
			constructor = false,
			base = nil,
			params = {
				{ name = 'ach' },
			}
		},
		["_mod_achievement_get_requirement"] = {
			source = 'scr_achievement',
			line = 654,
			constructor = false,
			base = nil,
			params = {
				{ name = 'ach' },
			}
		},
		["__lf_oShamBMissile_create_serialize"] = {
			source = '__lf_oShamBMissile_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["lua_call"] = {
			source = 'scr_code_inject',
			line = 5,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_cursor_x"] = {
			source = 'input_cursor_x',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["input_profile_import"] = {
			source = 'input_profile_import',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = '_json' },
				{ name = '_profile_name' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["string_no_trailing_zeros"] = {
			source = 'string_no_trailing_zeros',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'number' },
			}
		},
		["menu_tab_switch_animation_update"] = {
			source = 'ui_draw_header_menu_tabs',
			line = 8,
			constructor = false,
			base = nil,
			params = {}
		},
		["menu_tab_switch_animation_init"] = {
			source = 'ui_draw_header_menu_tabs',
			line = 21,
			constructor = false,
			base = nil,
			params = {}
		},
		["menu_tab_animation_switch_choice"] = {
			source = 'ui_draw_header_menu_tabs',
			line = 32,
			constructor = false,
			base = nil,
			params = {
				{ name = 'header_choice' },
			}
		},
		["ui_draw_header_menu_tabs"] = {
			source = 'ui_draw_header_menu_tabs',
			line = 48,
			constructor = false,
			base = nil,
			params = {
				{ name = 'header_icon' },
				{ name = 'buttons' },
				{ name = 'choice_index' },
				{ name = 'open_animation', value = [=[0]=] },
				{ name = 'allow_back_key_press', value = [=[true]=] },
				{ name = 'disabled', value = [=[false]=] },
				{ name = 'trials_style', value = [=[false]=] },
				{ name = 'menu_specific_draw_setting', value = [=[0]=] },
			}
		},
		["input_player_copy"] = {
			source = 'input_player_copy',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player_index_src' },
				{ name = '_player_index_dst' },
			}
		},
		["hud_draw_command_menu"] = {
			source = 'hud_draw_command_menu',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["actor_mark_as_crown_boss"] = {
			source = 'actor_mark_as_crown_boss',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'should_drop_item', value = [=[1]=] },
			}
		},
		["actor_mark_as_crown_boss_internal"] = {
			source = 'actor_mark_as_crown_boss',
			line = 11,
			constructor = false,
			base = nil,
			params = {
				{ name = 'should_drop_item' },
			}
		},
		["instance_nearest_array"] = {
			source = 'instance_nearest_array',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'arr' },
			}
		},
		["input_binding_get_icon"] = {
			source = 'input_binding_get_icon',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_binding' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["director_do_teleporter_boss_spawn"] = {
			source = 'director_do_boss_spawn',
			line = 8,
			constructor = false,
			base = nil,
			params = {}
		},
		["director_do_boss_spawn"] = {
			source = 'director_do_boss_spawn',
			line = 32,
			constructor = false,
			base = nil,
			params = {
				{ name = 'spawn_target_x' },
				{ name = 'spawn_target_y' },
				{ name = 'boss_spawn_points' },
				{ name = 'candidate_array,' },
			}
		},
		["input_value_is_binding"] = {
			source = 'input_value_is_binding',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_value' },
			}
		},
		["__lf_oChefPot_create_deserialize"] = {
			source = '__lf_oChefPot_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oFlashCircle_create_deserialize"] = {
			source = '__lf_oFlashCircle_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["Bezier_Point"] = {
			source = 'scrBezierCurve',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 't' },
				{ name = 'p0x' },
				{ name = 'p0y' },
				{ name = 'p1x' },
				{ name = 'p1y' },
				{ name = 'p2x' },
				{ name = 'p2y' },
				{ name = 'p3x' },
				{ name = 'p3y' },
			}
		},
		["curveCoordUpdate"] = {
			source = 'scrBezierCurve',
			line = 24,
			constructor = false,
			base = nil,
			params = {
				{ name = 'x1,y1,x2,y2,x3,y3,x4,y4,nA', value = [=[undefined]=] },
			}
		},
		["__lf_oEfMissileSuper_create_serialize"] = {
			source = '__lf_oEfMissileSuper_create_serialize',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["director_spawn_monster_card"] = {
			source = 'director_spawn_monster_card',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'spawn_target_x' },
				{ name = 'spawn_target_y' },
				{ name = 'card_choice' },
				{ name = 'bonus_rate', value = [=[1]=] },
			}
		},
		["LegacyClassManager"] = {
			source = 'scr_LegacyClassManager',
			line = 4,
			constructor = true,
			base = [=[BaseClassManager(]=],
			params = {
				{ name = 'master_array_name' },
				{ name = 'enum_name_index' },
				{ name = 'enum_namespace_index' },
			}
		},
		["__lf_oArtiNanobomb_create_serialize"] = {
			source = '__lf_oArtiNanobomb_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_get_icon"] = {
			source = 'input_get_icon',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = '_name' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["__lf_oEfBossShadowTracer_create_deserialize"] = {
			source = '__lf_oEfBossShadowTracer_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_button_key_rebind"] = {
			source = 'ui_button_key_rebind',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'width' },
				{ name = 'text' },
				{ name = 'key' },
				{ name = 'align', value = [=[fa_left]=] },
				{ name = 'gp_index', value = [=[undefined]=] },
				{ name = 'flags', value = [=[0]=] },
				{ name = 'style', value = [=[global._ui_style_default]=] },
				{ name = 'active_tab', value = [=[false]=] },
				{ name = 'element_key', value = [=[_ui_get_state_key(xx]=] },
				{ name = 'yy)' },
			}
		},
		["ui_button_control_toggle"] = {
			source = 'ui_button_key_rebind',
			line = 39,
			constructor = false,
			base = nil,
			params = {
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'width' },
				{ name = 'text' },
				{ name = 'align', value = [=[fa_left]=] },
				{ name = 'gp_index', value = [=[undefined]=] },
				{ name = 'flags', value = [=[0]=] },
				{ name = 'style', value = [=[global._ui_style_default]=] },
				{ name = 'active_tab', value = [=[false]=] },
				{ name = 'element_key', value = [=[_ui_get_state_key(xx]=] },
				{ name = 'yy)' },
			}
		},
		["__lf_oPilotRaidDamager_create_serialize"] = {
			source = '__lf_oPilotRaidDamager_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["_survivor_miner_get_angle"] = {
			source = 'scr_ror_init_survivor_miner_alts',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["_survivor_miner_check_for_drill_target"] = {
			source = 'scr_ror_init_survivor_miner_alts',
			line = 12,
			constructor = false,
			base = nil,
			params = {
				{ name = 'range' },
			}
		},
		["input_clear_momentary"] = {
			source = 'input_clear_momentary',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_state' },
			}
		},
		["input_players_connected"] = {
			source = 'input_players_connected',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_get_control_type_subimage"] = {
			source = 'input_get_control_type_subimage',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'input_player_index' },
			}
		},
		["__net_packet_create_object_write__"] = {
			source = 'scr_network_packets_objects',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = 'obj' },
				{ name = 'm_id' },
				{ name = 'xx' },
				{ name = 'yy' },
			}
		},
		["__net_packet_create_object_read__"] = {
			source = 'scr_network_packets_objects',
			line = 12,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_client_create_pickup_write__"] = {
			source = 'scr_network_packets_objects',
			line = 24,
			constructor = false,
			base = nil,
			params = {
				{ name = 'obj' },
				{ name = 'xx' },
				{ name = 'yy' },
			}
		},
		["__net_packet_client_create_pickup_read__"] = {
			source = 'scr_network_packets_objects',
			line = 29,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_item_set_force_pickup_write__"] = {
			source = 'scr_network_packets_objects',
			line = 42,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player_mid' },
			}
		},
		["__net_packet_item_set_force_pickup_read__"] = {
			source = 'scr_network_packets_objects',
			line = 45,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_client_equipment_swap_write__"] = {
			source = 'scr_network_packets_objects',
			line = 52,
			constructor = false,
			base = nil,
			params = {
				{ name = 'equip' },
			}
		},
		["__net_packet_client_equipment_swap_read__"] = {
			source = 'scr_network_packets_objects',
			line = 55,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_create_drone_write__"] = {
			source = 'scr_network_packets_objects',
			line = 64,
			constructor = false,
			base = nil,
			params = {
				{ name = 'drone_obj' },
				{ name = 'drone_mid' },
				{ name = 'spawn_x' },
				{ name = 'spawn_y' },
				{ name = 'offs_x' },
				{ name = 'offs_y' },
				{ name = 'master' },
			}
		},
		["__net_packet_create_drone_read__"] = {
			source = 'scr_network_packets_objects',
			line = 73,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_interactable_set_cost_write__"] = {
			source = 'scr_network_packets_objects',
			line = 92,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_interactable_set_cost_read__"] = {
			source = 'scr_network_packets_objects',
			line = 96,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_orbiter_sync_write__"] = {
			source = 'scr_network_packets_objects',
			line = 106,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_orbiter_sync_read__"] = {
			source = 'scr_network_packets_objects',
			line = 109,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_vfx_tracer_write__"] = {
			source = 'scr_network_packets_objects',
			line = 119,
			constructor = false,
			base = nil,
			params = {
				{ name = 'kind' },
				{ name = 'col' },
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'x2' },
				{ name = 'y2' },
			}
		},
		["__net_packet_vfx_tracer_read__"] = {
			source = 'scr_network_packets_objects',
			line = 139,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_pickup_set_no_gravity_write__"] = {
			source = 'scr_network_packets_objects',
			line = 167,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_packet_pickup_set_no_gravity_read__"] = {
			source = 'scr_network_packets_objects',
			line = 171,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_direction"] = {
			source = 'input_direction',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb_l' },
				{ name = '_verb_r' },
				{ name = '_verb_u' },
				{ name = '_verb_d' },
				{ name = '_player_index', value = [=[undefined]=] },
				{ name = '_most_recent', value = [=[false]=] },
			}
		},
		["input_cursor_limit_remove"] = {
			source = 'input_cursor_limit_remove',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["tick_actor_collision"] = {
			source = 'tick_actor_collision',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_binding_mouse_wheel_down"] = {
			source = 'input_binding_mouse_wheel_down',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["survivor_get_final_trial_skin_unlock_achievement_id"] = {
			source = 'scr_trials_data',
			line = 31,
			constructor = false,
			base = nil,
			params = {
				{ name = 'class_id' },
			}
		},
		["TrialsGameBoardSaveData"] = {
			source = 'scr_trials_data',
			line = 36,
			constructor = true,
			base = nil,
			params = {}
		},
		["trials_score_is_better"] = {
			source = 'scr_trials_data',
			line = 129,
			constructor = false,
			base = nil,
			params = {
				{ name = 'new_score' },
				{ name = 'old_score' },
				{ name = 'is_min_better' },
			}
		},
		["trials_score_is_better_equal"] = {
			source = 'scr_trials_data',
			line = 134,
			constructor = false,
			base = nil,
			params = {
				{ name = 'new_score' },
				{ name = 'old_score' },
				{ name = 'is_min_better' },
			}
		},
		["save_TrialsGameBoardSaveData_struct"] = {
			source = 'scr_trials_data',
			line = 140,
			constructor = false,
			base = nil,
			params = {
				{ name = 'm' },
			}
		},
		["read_TrialsGameBoardSaveData_struct"] = {
			source = 'scr_trials_data',
			line = 156,
			constructor = false,
			base = nil,
			params = {
				{ name = 'struct' },
			}
		},
		["draw_line4_jelly"] = {
			source = 'draw_line4_jelly',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'p0x' },
				{ name = 'p0y' },
				{ name = 'p1x' },
				{ name = 'p1y' },
				{ name = 'p2x' },
				{ name = 'p2y' },
				{ name = 'p3x' },
				{ name = 'p3y' },
				{ name = 'width0' },
				{ name = 'width1' },
				{ name = 'width2' },
				{ name = 'width3' },
				{ name = 'num_samples' },
				{ name = 'flash' },
			}
		},
		["GameSave"] = {
			source = 'scr_gameSave',
			line = 2,
			constructor = true,
			base = nil,
			params = {}
		},
		["save_file_serialize"] = {
			source = 'scr_gameSave',
			line = 27,
			constructor = false,
			base = nil,
			params = {
				{ name = 'save' },
			}
		},
		["save_file_deserialize"] = {
			source = 'scr_gameSave',
			line = 61,
			constructor = false,
			base = nil,
			params = {
				{ name = 'str' },
			}
		},
		["save_stat_get"] = {
			source = 'scr_gameSave',
			line = 213,
			constructor = false,
			base = nil,
			params = {
				{ name = 'key' },
			}
		},
		["save_stat_set"] = {
			source = 'scr_gameSave',
			line = 217,
			constructor = false,
			base = nil,
			params = {
				{ name = 'key' },
				{ name = 'value' },
			}
		},
		["save_stat_increment"] = {
			source = 'scr_gameSave',
			line = 223,
			constructor = false,
			base = nil,
			params = {
				{ name = 'key' },
			}
		},
		["save_stat_max"] = {
			source = 'scr_gameSave',
			line = 227,
			constructor = false,
			base = nil,
			params = {
				{ name = 'key' },
				{ name = 'value' },
			}
		},
		["save_stat_min"] = {
			source = 'scr_gameSave',
			line = 234,
			constructor = false,
			base = nil,
			params = {
				{ name = 'key' },
				{ name = 'value' },
			}
		},
		["save_stat_max_and_flag_trophy"] = {
			source = 'scr_gameSave',
			line = 243,
			constructor = false,
			base = nil,
			params = {
				{ name = 'key' },
				{ name = 'value' },
			}
		},
		["save_achievement_progress_get"] = {
			source = 'scr_gameSave',
			line = 252,
			constructor = false,
			base = nil,
			params = {
				{ name = 'key' },
			}
		},
		["save_achievement_progress_set"] = {
			source = 'scr_gameSave',
			line = 257,
			constructor = false,
			base = nil,
			params = {
				{ name = 'key' },
				{ name = 'value' },
			}
		},
		["save_flag_get"] = {
			source = 'scr_gameSave',
			line = 261,
			constructor = false,
			base = nil,
			params = {
				{ name = 'key' },
			}
		},
		["save_flag_set"] = {
			source = 'scr_gameSave',
			line = 264,
			constructor = false,
			base = nil,
			params = {
				{ name = 'key' },
				{ name = 'active' },
			}
		},
		["save_stats_get_favourite_equipment"] = {
			source = 'scr_gameSave',
			line = 275,
			constructor = false,
			base = nil,
			params = {
				{ name = 'save_stats' },
			}
		},
		["save_stats_get_nemesis"] = {
			source = 'scr_gameSave',
			line = 287,
			constructor = false,
			base = nil,
			params = {
				{ name = 'save_stats' },
			}
		},
		["save_write_survivor_loadout"] = {
			source = 'scr_gameSave',
			line = 316,
			constructor = false,
			base = nil,
			params = {
				{ name = 'survivor' },
				{ name = 'pls' },
			}
		},
		["save_get_survivor_loadout"] = {
			source = 'scr_gameSave',
			line = 323,
			constructor = false,
			base = nil,
			params = {
				{ name = 'survivor' },
			}
		},
		["save_get_trials_board_data"] = {
			source = 'scr_gameSave',
			line = 336,
			constructor = false,
			base = nil,
			params = {
				{ name = 'board_name' },
			}
		},
		["save_get_rift_chest_content"] = {
			source = 'scr_gameSave',
			line = 346,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_mouse_check_pressed"] = {
			source = 'input_mouse_check_pressed',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_binding' },
			}
		},
		["__lf_oPilotRaidDamager_create_deserialize"] = {
			source = '__lf_oPilotRaidDamager_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["api_define_write_command"] = {
			source = 'api_define_write_command',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = 'command' },
				{ name = 'str' },
			}
		},
		["_mod_player_get_survivor"] = {
			source = 'player_set_class',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'p' },
			}
		},
		["player_set_class"] = {
			source = 'player_set_class',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = 'p' },
				{ name = 'c' },
				{ name = 'loadout', value = [=[undefined]=] },
			}
		},
		["player_set_class_internal"] = {
			source = 'player_set_class',
			line = 16,
			constructor = false,
			base = nil,
			params = {
				{ name = 'p' },
				{ name = 'c' },
				{ name = 'loadout' },
			}
		},
		["input_check_double_released"] = {
			source = 'input_check_double_released',
			line = 8,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb' },
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_buffer_duration', value = [=[0]=] },
			}
		},
		["update_all_widgets"] = {
			source = 'oOptionsMenuSubmenu-User Event 1',
			line = 7,
			constructor = false,
			base = nil,
			params = {
				{ name = 'skip', value = [=[undefined]=] },
			}
		},
		["NetworkMessageDef"] = {
			source = 'scr_networkMessage',
			line = 24,
			constructor = true,
			base = nil,
			params = {
				{ name = 'permission_level' },
				{ name = 'm_write' },
				{ name = 'm_read' },
			}
		},
		["__packet_rpc_handle_write__"] = {
			source = 'scr_networkMessage',
			line = 46,
			constructor = false,
			base = nil,
			params = {
				{ name = 'func' },
			}
		},
		["__packet_rpc_handle_read__"] = {
			source = 'scr_networkMessage',
			line = 49,
			constructor = false,
			base = nil,
			params = {}
		},
		["net_message_register"] = {
			source = 'scr_networkMessage',
			line = 60,
			constructor = false,
			base = nil,
			params = {}
		},
		["net_instance_message_register"] = {
			source = 'scr_networkMessage',
			line = 76,
			constructor = false,
			base = nil,
			params = {}
		},
		["__net_instance_message_write__"] = {
			source = 'scr_networkMessage',
			line = 84,
			constructor = false,
			base = nil,
			params = {
				{ name = 'inst' },
			}
		},
		["__net_instance_message_read__"] = {
			source = 'scr_networkMessage',
			line = 103,
			constructor = false,
			base = nil,
			params = {}
		},
		["net_message_write"] = {
			source = 'scr_networkMessage',
			line = 126,
			constructor = false,
			base = nil,
			params = {
				{ name = 'packet_id/*' },
				{ name = '...*/' },
			}
		},
		["net_message_read"] = {
			source = 'scr_networkMessage',
			line = 144,
			constructor = false,
			base = nil,
			params = {
				{ name = 'packet_id' },
			}
		},
		["net_send_instance_message"] = {
			source = 'scr_networkMessage',
			line = 164,
			constructor = false,
			base = nil,
			params = {
				{ name = 'packet_id/*' },
				{ name = '...*/' },
			}
		},
		["net_send_instance_message_direct"] = {
			source = 'scr_networkMessage',
			line = 200,
			constructor = false,
			base = nil,
			params = {
				{ name = 'tclient_sock' },
				{ name = 'packet_id/*' },
				{ name = '...*/' },
			}
		},
		["net_send_instance_message_exclude"] = {
			source = 'scr_networkMessage',
			line = 218,
			constructor = false,
			base = nil,
			params = {
				{ name = 'tclient_sock' },
				{ name = 'packet_id/*' },
				{ name = '...*/' },
			}
		},
		["set_brambleFrame"] = {
			source = 'oBramble-Create',
			line = 62,
			constructor = false,
			base = nil,
			params = {
				{ name = 'coordinates' },
			}
		},
		["input_check_any_input"] = {
			source = 'input_check_any_input',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'input_player_index' },
				{ name = 'ignore_analog_input' },
			}
		},
		["scribble_cache_to_surface"] = {
			source = 'scribble_cache_to_surface',
			line = 8,
			constructor = false,
			base = nil,
			params = {
				{ name = 'scribble_elem' },
				{ name = 'old_surf', value = [=[-1]=] },
			}
		},
		["scribble_cache_to_surface_outlined"] = {
			source = 'scribble_cache_to_surface',
			line = 33,
			constructor = false,
			base = nil,
			params = {
				{ name = 'scribble_elem' },
				{ name = 'blend_text' },
				{ name = 'blend_outline' },
			}
		},
		["init_player_loadout"] = {
			source = 'init_player_loadout',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'loadout' },
			}
		},
		["__lf_oEngiTurretB_create_deserialize"] = {
			source = '__lf_oEngiTurretB_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["part_particles_create_cull"] = {
			source = 'scr_vfx',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'system' },
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'particle' },
			}
		},
		["part_particles_create_colour_cull"] = {
			source = 'scr_vfx',
			line = 10,
			constructor = false,
			base = nil,
			params = {
				{ name = 'system' },
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'particle' },
				{ name = 'col' },
			}
		},
		["input_cursor_limit_aabb"] = {
			source = 'input_cursor_limit_aabb',
			line = 8,
			constructor = false,
			base = nil,
			params = {
				{ name = '_l' },
				{ name = '_t' },
				{ name = '_r' },
				{ name = '_b' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["enemy_object_get_spawn_y_offset"] = {
			source = 'scr_enemy_utils',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'obj' },
			}
		},
		["monster_get_stat_key"] = {
			source = 'scr_enemy_utils',
			line = 10,
			constructor = false,
			base = nil,
			params = {
				{ name = 'obj' },
			}
		},
		["monster_get_stat_key_kills"] = {
			source = 'scr_enemy_utils',
			line = 13,
			constructor = false,
			base = nil,
			params = {
				{ name = 'obj' },
			}
		},
		["monster_get_stat_key_elite_kills"] = {
			source = 'scr_enemy_utils',
			line = 16,
			constructor = false,
			base = nil,
			params = {
				{ name = 'obj' },
			}
		},
		["monster_get_stat_key_deaths"] = {
			source = 'scr_enemy_utils',
			line = 19,
			constructor = false,
			base = nil,
			params = {
				{ name = 'obj' },
			}
		},
		["actor_heal_barrier"] = {
			source = 'actor_heal_barrier',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'amount' },
			}
		},
		["actor_heal_barrier_internal"] = {
			source = 'actor_heal_barrier',
			line = 8,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'amount' },
			}
		},
		["actor_set_barrier"] = {
			source = 'actor_heal_barrier',
			line = 40,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
				{ name = 'b' },
			}
		},
		["TICKRATE_to_frame_interval"] = {
			source = 'scr_tickrate',
			line = 13,
			constructor = false,
			base = nil,
			params = {
				{ name = 'v' },
			}
		},
		["execute_rate"] = {
			source = 'scr_tickrate',
			line = 55,
			constructor = false,
			base = nil,
			params = {
				{ name = 'tickrate' },
				{ name = 'mthd' },
			}
		},
		["execute_rate_remove"] = {
			source = 'scr_tickrate',
			line = 59,
			constructor = false,
			base = nil,
			params = {
				{ name = 'tickrate' },
				{ name = 'mthd' },
			}
		},
		["__rpc_mountain_shrine_activate_implementation__"] = {
			source = 'scr_interactable_rpcs',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = 'is_global' },
			}
		},
		["__rpc_drone_recycle_implementation__"] = {
			source = 'scr_interactable_rpcs',
			line = 15,
			constructor = false,
			base = nil,
			params = {
				{ name = 'scrapper' },
				{ name = 'target' },
			}
		},
		["__rpc_drone_upgrade_implementation__"] = {
			source = 'scr_interactable_rpcs',
			line = 42,
			constructor = false,
			base = nil,
			params = {
				{ name = 'upgrader' },
				{ name = 'targ1' },
				{ name = 'targ2' },
				{ name = 'targ3' },
			}
		},
		["stopwatch_create"] = {
			source = 'scr_stopwatch',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = 'time_end' },
				{ name = 'func' },
			}
		},
		["stopwatch_stop"] = {
			source = 'scr_stopwatch',
			line = 24,
			constructor = false,
			base = nil,
			params = {
				{ name = 'stopwatch' },
			}
		},
		["stopwatch_start"] = {
			source = 'scr_stopwatch',
			line = 36,
			constructor = false,
			base = nil,
			params = {
				{ name = 'stopwatch' },
				{ name = 'time_end' },
				{ name = 'time_start', value = [=[current_frame]=] },
			}
		},
		["stopwatch_is_active"] = {
			source = 'scr_stopwatch',
			line = 46,
			constructor = false,
			base = nil,
			params = {
				{ name = 'stopwatch' },
			}
		},
		["stopwatch_get_duration"] = {
			source = 'scr_stopwatch',
			line = 50,
			constructor = false,
			base = nil,
			params = {
				{ name = 'stopwatch' },
			}
		},
		["stopwatch_get_duration_elapsed"] = {
			source = 'scr_stopwatch',
			line = 54,
			constructor = false,
			base = nil,
			params = {
				{ name = 'stopwatch' },
			}
		},
		["stopwatch_get_duration_remaining"] = {
			source = 'scr_stopwatch',
			line = 58,
			constructor = false,
			base = nil,
			params = {
				{ name = 'stopwatch' },
			}
		},
		["stopwatch_get_percent_complete"] = {
			source = 'scr_stopwatch',
			line = 62,
			constructor = false,
			base = nil,
			params = {
				{ name = 'stopwatch' },
			}
		},
		["stopwatch_get_time_end"] = {
			source = 'scr_stopwatch',
			line = 66,
			constructor = false,
			base = nil,
			params = {
				{ name = 'stopwatch' },
			}
		},
		["stopwatch_get_time_start"] = {
			source = 'scr_stopwatch',
			line = 70,
			constructor = false,
			base = nil,
			params = {
				{ name = 'stopwatch' },
			}
		},
		["director_populate_interactable_spawn_array"] = {
			source = 'director_populate_interactable_spawn_array',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'rng' },
			}
		},
		["input_source_is_available"] = {
			source = 'input_source_is_available',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_source' },
			}
		},
		["input_player_swap"] = {
			source = 'input_player_swap',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player_index_a' },
				{ name = '_player_index_b' },
			}
		},
		["input_swap_gamepad_ab"] = {
			source = 'input_swap_gamepad_ab',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_state' },
			}
		},
		["input_mouse_capture_set"] = {
			source = 'input_mouse_capture_set',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_state' },
				{ name = '_sensitivity', value = [=[1]=] },
			}
		},
		["input_check"] = {
			source = 'input_check',
			line = 10,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb' },
				{ name = '_player_index', value = [=[0) //]=] },
				{ name = '_buffer_duration', value = [=[0]=] },
			}
		},
		["__input_keyboard_key"] = {
			source = '__input_keyboard_key',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfMissileSuper_create_deserialize"] = {
			source = '__lf_oEfMissileSuper_create_deserialize',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["__input_player_tick_sources"] = {
			source = '__input_player_tick_sources',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["object_to_equipment"] = {
			source = 'scr_equipment',
			line = 48,
			constructor = false,
			base = nil,
			params = {
				{ name = 'obj' },
			}
		},
		["equipment_create"] = {
			source = 'scr_equipment',
			line = 54,
			constructor = false,
			base = nil,
			params = {
				{ name = 'namespace' },
				{ name = 'name,' },
			}
		},
		["equipment_get_stat_key"] = {
			source = 'scr_equipment',
			line = 150,
			constructor = false,
			base = nil,
			params = {
				{ name = 'object_id' },
			}
		},
		["equipment_get_stat_key_activations"] = {
			source = 'scr_equipment',
			line = 153,
			constructor = false,
			base = nil,
			params = {
				{ name = 'object_id' },
			}
		},
		["equipment_get_stat_key_time_held"] = {
			source = 'scr_equipment',
			line = 156,
			constructor = false,
			base = nil,
			params = {
				{ name = 'object_id' },
			}
		},
		["equipment_is_unlocked"] = {
			source = 'scr_equipment',
			line = 160,
			constructor = false,
			base = nil,
			params = {
				{ name = 'equipment_id' },
			}
		},
		["equipment_get_id"] = {
			source = 'scr_equipment',
			line = 165,
			constructor = false,
			base = nil,
			params = {
				{ name = 'diff' },
			}
		},
		["equipment_find"] = {
			source = 'scr_equipment',
			line = 171,
			constructor = false,
			base = nil,
			params = {
				{ name = 'id_string' },
			}
		},
		["__lf_oChefJar_create_deserialize"] = {
			source = '__lf_oChefJar_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["actor_flying_handle_knockback"] = {
			source = 'actor_flying_handle_knockback',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["actor_flying_can_attack"] = {
			source = 'actor_flying_handle_knockback',
			line = 9,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oShamBMissile_create_deserialize"] = {
			source = '__lf_oShamBMissile_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_mouse_dy"] = {
			source = 'input_mouse_dy',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["game_get_completion_percent"] = {
			source = 'game_get_completion_percent',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["on_input_player_device_update"] = {
			source = 'on_input_player_device_update',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'index' },
			}
		},
		["input_check_press_most_recent"] = {
			source = 'input_check_press_most_recent',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb_array', value = [=[all]=] },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["input_check_released"] = {
			source = 'input_check_released',
			line = 8,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb' },
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_buffer_duration', value = [=[0]=] },
			}
		},
		["aabbmap_create"] = {
			source = 'scr_aabbmap',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'resolution' },
			}
		},
		["aabbmap_destroy"] = {
			source = 'scr_aabbmap',
			line = 12,
			constructor = false,
			base = nil,
			params = {
				{ name = 'aabbmap' },
			}
		},
		["aabbmap_add"] = {
			source = 'scr_aabbmap',
			line = 17,
			constructor = false,
			base = nil,
			params = {
				{ name = 'aabbmap' },
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'x2' },
				{ name = 'y2' },
				{ name = 'element' },
			}
		},
		["aabbmap_point"] = {
			source = 'scr_aabbmap',
			line = 40,
			constructor = false,
			base = nil,
			params = {
				{ name = 'aabbmap' },
				{ name = 'px' },
				{ name = 'py' },
			}
		},
		["buffer_register_type"] = {
			source = 'scr_networkTypes',
			line = 38,
			constructor = false,
			base = nil,
			params = {
				{ name = 'stype' },
				{ name = 'write' },
				{ name = 'read' },
			}
		},
		["buffer_write_type"] = {
			source = 'scr_networkTypes',
			line = 43,
			constructor = false,
			base = nil,
			params = {
				{ name = 'value' },
				{ name = 'stype' },
				{ name = 'buffer' },
			}
		},
		["buffer_read_type"] = {
			source = 'scr_networkTypes',
			line = 46,
			constructor = false,
			base = nil,
			params = {
				{ name = 'stype' },
				{ name = 'buffer' },
			}
		},
		["object_to_item"] = {
			source = 'scr_item',
			line = 62,
			constructor = false,
			base = nil,
			params = {
				{ name = 'obj' },
			}
		},
		["pickup_object_to_tier"] = {
			source = 'scr_item',
			line = 68,
			constructor = false,
			base = nil,
			params = {
				{ name = 'obj' },
			}
		},
		["pickup_object_artifact_translate"] = {
			source = 'scr_item',
			line = 82,
			constructor = false,
			base = nil,
			params = {
				{ name = 't' },
			}
		},
		["item_create"] = {
			source = 'scr_item',
			line = 101,
			constructor = false,
			base = nil,
			params = {
				{ name = 'namespace' },
				{ name = 'name,' },
			}
		},
		["item_set_tier"] = {
			source = 'scr_item',
			line = 198,
			constructor = false,
			base = nil,
			params = {
				{ name = 'item_id' },
				{ name = 'tier' },
			}
		},
		["item_get_stat_key"] = {
			source = 'scr_item',
			line = 219,
			constructor = false,
			base = nil,
			params = {
				{ name = 'object_id' },
			}
		},
		["item_get_stat_key_total_collected"] = {
			source = 'scr_item',
			line = 222,
			constructor = false,
			base = nil,
			params = {
				{ name = 'object_id' },
			}
		},
		["item_get_stat_key_highest_stack"] = {
			source = 'scr_item',
			line = 225,
			constructor = false,
			base = nil,
			params = {
				{ name = 'object_id' },
			}
		},
		["item_get_id"] = {
			source = 'scr_item',
			line = 230,
			constructor = false,
			base = nil,
			params = {
				{ name = 'item' },
			}
		},
		["item_find"] = {
			source = 'scr_item',
			line = 236,
			constructor = false,
			base = nil,
			params = {
				{ name = 'id_string' },
			}
		},
		["__lf_oEngiMine2_create_deserialize"] = {
			source = '__lf_oEngiMine2_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_check_long"] = {
			source = 'input_check_long',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb' },
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_buffer_duration', value = [=[0]=] },
			}
		},
		["__input_source_relinquish"] = {
			source = '__input_source_relinquish',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = '_source' },
			}
		},
		["input_multiplayer_params_get"] = {
			source = 'input_multiplayer_params_get',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_axis_threshold_get"] = {
			source = 'input_axis_threshold_get',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = '_axis' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["_mod_surface_error"] = {
			source = 'scr_luaApi_surface',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_surface_create"] = {
			source = 'scr_luaApi_surface',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'w' },
				{ name = 'h' },
			}
		},
		["_mod_surface_resize"] = {
			source = 'scr_luaApi_surface',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = 'surf' },
				{ name = 'w' },
				{ name = 'h' },
			}
		},
		["_mod_surface_free"] = {
			source = 'scr_luaApi_surface',
			line = 15,
			constructor = false,
			base = nil,
			params = {
				{ name = 'surf' },
			}
		},
		["_mod_surface_get_width"] = {
			source = 'scr_luaApi_surface',
			line = 19,
			constructor = false,
			base = nil,
			params = {
				{ name = 'surf' },
			}
		},
		["_mod_surface_get_height"] = {
			source = 'scr_luaApi_surface',
			line = 23,
			constructor = false,
			base = nil,
			params = {
				{ name = 'surf' },
			}
		},
		["item_pickup_create"] = {
			source = 'item_pickup_create',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = '_drop_x' },
				{ name = '_drop_y' },
				{ name = '_drop_on_player' },
				{ name = '_pickup' },
				{ name = '_drop_y_true', value = [=[_drop_y]=] },
			}
		},
		["input_binding_get_name"] = {
			source = 'input_binding_get_name',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_binding' },
			}
		},
		["set_state"] = {
			source = 'oArtiChakram-Create',
			line = 30,
			constructor = false,
			base = nil,
			params = {
				{ name = 'new_state' },
			}
		},
		["input_accessibility_global_cooldown_get"] = {
			source = 'input_accessibility_global_cooldown_get',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_is_analogue"] = {
			source = 'input_is_analogue',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["input_value"] = {
			source = 'input_value',
			line = 7,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["teasure_weights_find"] = {
			source = 'scr_treasureWeights',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'identifier' },
			}
		},
		["TreasureWeights"] = {
			source = 'scr_treasureWeights',
			line = 12,
			constructor = true,
			base = nil,
			params = {
				{ name = 'index' },
				{ name = 'name' },
				{ name = 'weight_common', value = [=[0]=] },
				{ name = 'weight_uncommon', value = [=[0]=] },
				{ name = 'weight_rare', value = [=[0]=] },
				{ name = 'weight_equipment', value = [=[0]=] },
				{ name = 'weight_empty', value = [=[0]=] },
				{ name = 'required_loot_tags', value = [=[0]=] },
				{ name = 'disallowed_loot_tags', value = [=[0]=] },
			}
		},
		["run_refresh_treasure_rates"] = {
			source = 'scr_treasureWeights',
			line = 160,
			constructor = false,
			base = nil,
			params = {}
		},
		["treasure_weights_roll_pickup_and_handle_artifacts"] = {
			source = 'scr_treasureWeights',
			line = 242,
			constructor = false,
			base = nil,
			params = {
				{ name = '_kind' },
				{ name = '_result_must_be_a_pickup', value = [=[false]=] },
			}
		},
		["treasure_weights_roll_pickup"] = {
			source = 'scr_treasureWeights',
			line = 247,
			constructor = false,
			base = nil,
			params = {
				{ name = '_kind' },
			}
		},
		["_mod_verify_treasure_weight_index"] = {
			source = 'scr_treasureWeights',
			line = 254,
			constructor = false,
			base = nil,
			params = {
				{ name = 'index' },
			}
		},
		["_mod_treasure_weights_get_loot_pool_weight"] = {
			source = 'scr_treasureWeights',
			line = 258,
			constructor = false,
			base = nil,
			params = {
				{ name = 'weights' },
				{ name = 'pool_index' },
			}
		},
		["_mod_treasure_weights_set_loot_pool_weight"] = {
			source = 'scr_treasureWeights',
			line = 262,
			constructor = false,
			base = nil,
			params = {
				{ name = 'weights' },
				{ name = 'pool_index' },
				{ name = 'new_weight' },
			}
		},
		["_mod_treasure_weights_get_all_loot_pools"] = {
			source = 'scr_treasureWeights',
			line = 266,
			constructor = false,
			base = nil,
			params = {
				{ name = 'weights' },
			}
		},
		["input_binding_test_collisions"] = {
			source = 'input_binding_test_collisions',
			line = 7,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb_name' },
				{ name = '_src_binding' },
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_profile_name', value = [=[undefined]=] },
			}
		},
		["is_new_item_log_unlocked"] = {
			source = 'is_new_item_log_unlocked',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["gml_ref_create"] = {
			source = 'scr_gmlref',
			line = 19,
			constructor = false,
			base = nil,
			params = {
				{ name = 'value' },
			}
		},
		["gml_ref_free"] = {
			source = 'scr_gmlref',
			line = 44,
			constructor = false,
			base = nil,
			params = {
				{ name = '_id' },
			}
		},
		["gml_ref_get_value"] = {
			source = 'scr_gmlref',
			line = 56,
			constructor = false,
			base = nil,
			params = {
				{ name = '_id' },
			}
		},
		["get_someStruct"] = {
			source = 'scr_gmlref',
			line = 66,
			constructor = false,
			base = nil,
			params = {}
		},
		["lua_struct_test"] = {
			source = 'scr_gmlref',
			line = 69,
			constructor = false,
			base = nil,
			params = {
				{ name = 'val' },
			}
		},
		["__input_class_gamepad"] = {
			source = '__input_class_gamepad',
			line = 2,
			constructor = true,
			base = nil,
			params = {
				{ name = '_index' },
			}
		},
		["input_gamepad_check_released"] = {
			source = 'input_gamepad_check_released',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_index' },
				{ name = '_gm' },
			}
		},
		["__lf_oPilotMine_create_deserialize"] = {
			source = '__lf_oPilotMine_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__input_initialize"] = {
			source = '__input_initialize',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfDuplicator_create_deserialize"] = {
			source = '__lf_oEfDuplicator_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfBossStar_create_serialize"] = {
			source = '__lf_oEfBossStar_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["trials_game_board_load"] = {
			source = 'scr_trials_board',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'layout_path' },
				{ name = 'trials_path' },
			}
		},
		["trials_game_board_initialize_save_data"] = {
			source = 'scr_trials_board',
			line = 92,
			constructor = false,
			base = nil,
			params = {
				{ name = 'board' },
			}
		},
		["trials_game_board_delete"] = {
			source = 'scr_trials_board',
			line = 99,
			constructor = false,
			base = nil,
			params = {
				{ name = 'trials_board' },
			}
		},
		["trials_trial_info_pre_process"] = {
			source = 'scr_trials_board',
			line = 105,
			constructor = false,
			base = nil,
			params = {
				{ name = 'trial' },
			}
		},
		["trial_get_achievement"] = {
			source = 'scr_trials_board',
			line = 117,
			constructor = false,
			base = nil,
			params = {
				{ name = 'trial' },
			}
		},
		["string_to_TRIALS_OBJECTIVE"] = {
			source = 'scr_trials_board',
			line = 161,
			constructor = false,
			base = nil,
			params = {
				{ name = 'str' },
			}
		},
		["trials_objective_get_score_format"] = {
			source = 'scr_trials_board',
			line = 175,
			constructor = false,
			base = nil,
			params = {
				{ name = 'objective' },
			}
		},
		["TRIALS_SCORE_FORMAT_to_string"] = {
			source = 'scr_trials_board',
			line = 221,
			constructor = false,
			base = nil,
			params = {
				{ name = 'f' },
			}
		},
		["TRIALS_SCORE_FORMAT_is_time_based"] = {
			source = 'scr_trials_board',
			line = 231,
			constructor = false,
			base = nil,
			params = {
				{ name = 'tsf' },
			}
		},
		["TRIALS_SCORE_FORMAT_is_min_better"] = {
			source = 'scr_trials_board',
			line = 235,
			constructor = false,
			base = nil,
			params = {
				{ name = 'tsf' },
			}
		},
		["trials_get_trial_token"] = {
			source = 'scr_trials_board',
			line = 240,
			constructor = false,
			base = nil,
			params = {
				{ name = 'board_name' },
				{ name = 'trial_name' },
			}
		},
		["_mod_actor_get_skill_slot"] = {
			source = 'scr_actor_utils',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'index' },
			}
		},
		["_mod_actor_get_active_skill"] = {
			source = 'scr_actor_utils',
			line = 7,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'index' },
			}
		},
		["_mod_actor_find_active_skill"] = {
			source = 'scr_actor_utils',
			line = 11,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'skill_id' },
			}
		},
		["_mod_actor_setActivity"] = {
			source = 'scr_actor_utils',
			line = 14,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'activity_id' },
				{ name = 'activity_type' },
				{ name = 'auto_end' },
				{ name = 'handler' },
			}
		},
		["actor_is_classic"] = {
			source = 'scr_actor_utils',
			line = 21,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
			}
		},
		["actor_is_boss"] = {
			source = 'scr_actor_utils',
			line = 30,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
			}
		},
		["actor_is_alive"] = {
			source = 'scr_actor_utils',
			line = 37,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
			}
		},
		["actor_is_player"] = {
			source = 'scr_actor_utils',
			line = 42,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
			}
		},
		["actor_roll_crit"] = {
			source = 'scr_actor_utils',
			line = 47,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
			}
		},
		["actor_get_facing_direction"] = {
			source = 'scr_actor_utils',
			line = 55,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
			}
		},
		["actor_heal_raw"] = {
			source = 'scr_actor_utils',
			line = 61,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'amount' },
				{ name = 'is_passive' },
			}
		},
		["actor_heal_networked"] = {
			source = 'scr_actor_utils',
			line = 81,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
				{ name = 'amount' },
				{ name = 'is_passive' },
			}
		},
		["actor_kill"] = {
			source = 'scr_actor_utils',
			line = 89,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
			}
		},
		["actor_get_elite_type"] = {
			source = 'scr_actor_utils',
			line = 95,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
			}
		},
		["actor_is_elite"] = {
			source = 'scr_actor_utils',
			line = 98,
			constructor = false,
			base = nil,
			params = {
				{ name = 'actor' },
			}
		},
		["actor_update_target"] = {
			source = 'scr_actor_utils',
			line = 104,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sync', value = [=[true]=] },
			}
		},
		["actor_transform"] = {
			source = 'scr_actor_utils',
			line = 118,
			constructor = false,
			base = nil,
			params = {
				{ name = 'source' },
				{ name = 'dest' },
			}
		},
		["__input_finalize_default_profiles"] = {
			source = '__input_finalize_default_profiles',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_verb_group_is_active"] = {
			source = 'input_verb_group_is_active',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb_group' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["input_profile_exists"] = {
			source = 'input_profile_exists',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_profile_name' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["gamemode_create"] = {
			source = 'scr_gamemode',
			line = 54,
			constructor = false,
			base = nil,
			params = {
				{ name = 'namespace' },
				{ name = 'name' },
				{ name = 'mode_id', value = [=[undefined]=] },
				{ name = 'count_normal_unlocks', value = [=[true]=] },
				{ name = 'count_towards_games_played', value = [=[true]=] },
			}
		},
		["gamemode_get_id"] = {
			source = 'scr_gamemode',
			line = 74,
			constructor = false,
			base = nil,
			params = {
				{ name = 'ending' },
			}
		},
		["gamemode_find"] = {
			source = 'scr_gamemode',
			line = 80,
			constructor = false,
			base = nil,
			params = {
				{ name = 'id_string' },
			}
		},
		["gamemode_current_are_unlocks_enabled"] = {
			source = 'scr_gamemode',
			line = 87,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oShellMissile_create_deserialize"] = {
			source = '__lf_oShellMissile_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_cursor_speed_set"] = {
			source = 'input_cursor_speed_set',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_speed' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["__lf_oArtiPlatform_create_serialize"] = {
			source = '__lf_oArtiPlatform_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfOverloadingSparking_create_serialize"] = {
			source = '__lf_oEfOverloadingSparking_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oShamGBlock_create_deserialize"] = {
			source = '__lf_oShamGBlock_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__input_load_sdl2_from_file"] = {
			source = '__input_sdl2_database_funcs',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = '_filename' },
			}
		},
		["__input_load_sdl2_from_string"] = {
			source = '__input_sdl2_database_funcs',
			line = 26,
			constructor = false,
			base = nil,
			params = {
				{ name = '_string' },
			}
		},
		["__input_load_sdl2_from_buffer"] = {
			source = '__input_sdl2_database_funcs',
			line = 46,
			constructor = false,
			base = nil,
			params = {
				{ name = '_buffer' },
			}
		},
		["server_sync_queued_instances"] = {
			source = 'server_sync_queued_instances',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["global_events"] = {
			source = 'scr_global_events',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["PlayerInputProfile"] = {
			source = 'scr_player_input_profiles',
			line = 27,
			constructor = true,
			base = nil,
			params = {
				{ name = 'serialized_name', value = [=[undefined]=] },
				{ name = 'name', value = [=[undefined]=] },
				{ name = 'is_guest', value = [=[false]=] },
				{ name = 'is_default', value = [=[false]=] },
			}
		},
		["player_input_profile_name_to_seralized_name"] = {
			source = 'scr_player_input_profiles',
			line = 294,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
			}
		},
		["player_input_profile_name_validate"] = {
			source = 'scr_player_input_profiles',
			line = 299,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
			}
		},
		["player_input_profile_assign_for_player"] = {
			source = 'scr_player_input_profiles',
			line = 322,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player_index' },
				{ name = 'profile' },
			}
		},
		["player_input_profile_unassign_for_player"] = {
			source = 'scr_player_input_profiles',
			line = 337,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player_index' },
			}
		},
		["player_input_profile_get_default_for_player"] = {
			source = 'scr_player_input_profiles',
			line = 346,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player_index' },
			}
		},
		["player_input_profile_clear_local_coop"] = {
			source = 'scr_player_input_profiles',
			line = 356,
			constructor = false,
			base = nil,
			params = {}
		},
		["player_input_profile_restore_local_coop"] = {
			source = 'scr_player_input_profiles',
			line = 373,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player_num' },
			}
		},
		["player_input_profile_try_create_and_assign"] = {
			source = 'scr_player_input_profiles',
			line = 394,
			constructor = false,
			base = nil,
			params = {
				{ name = 'profile_name' },
				{ name = 'player_index' },
			}
		},
		["input_binding_is_valid"] = {
			source = 'input_binding_is_valid',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = '_binding' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["input_verb_group_active"] = {
			source = 'input_verb_group_active',
			line = 7,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb_group' },
				{ name = '_state' },
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_exclusive', value = [=[false]=] },
			}
		},
		["__lf_oEfBoss4SliceDoT_create_serialize"] = {
			source = '__lf_oEfBoss4SliceDoT_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEngiTurretB_create_serialize"] = {
			source = '__lf_oEngiTurretB_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oPilotMine_create_serialize"] = {
			source = '__lf_oPilotMine_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oDrifterJunk_create_serialize"] = {
			source = '__lf_oDrifterJunk_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["skin_prov_register_sprite_offsets"] = {
			source = 'scr_ror_init_skins_special',
			line = 107,
			constructor = false,
			base = nil,
			params = {
				{ name = 'spr' },
				{ name = 'array' },
			}
		},
		["api_instance_start"] = {
			source = 'scr_api_define_instance_class',
			line = 18,
			constructor = false,
			base = nil,
			params = {
				{ name = 'desc' },
			}
		},
		["api_instance_start_internal"] = {
			source = 'scr_api_define_instance_class',
			line = 43,
			constructor = false,
			base = nil,
			params = {}
		},
		["api_instance_var"] = {
			source = 'scr_api_define_instance_class',
			line = 61,
			constructor = false,
			base = nil,
			params = {
				{ name = 'desc' },
				{ name = 'name' },
				{ name = 'kind' },
			}
		},
		["api_instance_section"] = {
			source = 'scr_api_define_instance_class',
			line = 69,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'desc' },
			}
		},
		["api_instance_method"] = {
			source = 'scr_api_define_instance_class',
			line = 82,
			constructor = false,
			base = nil,
			params = {
				{ name = 'desc' },
				{ name = 'name' },
				{ name = 'script_id' },
			}
		},
		["api_instance_method_argument"] = {
			source = 'scr_api_define_instance_class',
			line = 94,
			constructor = false,
			base = nil,
			params = {
				{ name = 'desc' },
				{ name = 'name' },
				{ name = 'kind' },
			}
		},
		["api_instance_getter"] = {
			source = 'scr_api_define_instance_class',
			line = 110,
			constructor = false,
			base = nil,
			params = {
				{ name = 'desc' },
				{ name = 'name' },
				{ name = 'type' },
				{ name = 'get' },
			}
		},
		["api_instance_generate_write_docs_class_tree"] = {
			source = 'scr_api_define_instance_class',
			line = 249,
			constructor = false,
			base = nil,
			params = {
				{ name = 'obj' },
			}
		},
		["api_instance_generate_get_code_generator"] = {
			source = 'scr_api_define_instance_class',
			line = 277,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEngiMine2_create_serialize"] = {
			source = '__lf_oEngiMine2_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["skin_unlockable_icon_sprite_create"] = {
			source = 'skin_unlockable_icon_sprite_create',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'namespace' },
				{ name = 'name' },
				{ name = 'icon_sprite' },
				{ name = 'primary_col' },
			}
		},
		["PlayerBalanceConfig"] = {
			source = 'scr_player_balance_config',
			line = 12,
			constructor = true,
			base = nil,
			params = {}
		},
		["write_playerbalanceconfig"] = {
			source = 'scr_player_balance_config',
			line = 42,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'pbc' },
			}
		},
		["read_playerbalanceconfig"] = {
			source = 'scr_player_balance_config',
			line = 46,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["save_playerbalanceconfig_struct"] = {
			source = 'scr_player_balance_config',
			line = 54,
			constructor = false,
			base = nil,
			params = {
				{ name = 'pbc' },
			}
		},
		["read_playerbalanceconfig_struct"] = {
			source = 'scr_player_balance_config',
			line = 60,
			constructor = false,
			base = nil,
			params = {
				{ name = 'struct' },
			}
		},
		["__input_multiplayer_assignment_tick"] = {
			source = '__input_multiplayer_assignment_tick',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_gamepad_check"] = {
			source = 'input_gamepad_check',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_index' },
				{ name = '_gm' },
			}
		},
		["input_binding_gamepad_button"] = {
			source = 'input_binding_gamepad_button',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_button' },
			}
		},
		["__input_gamepad_set_description"] = {
			source = '__input_gamepad_set_description',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfBoss4SliceWindup_create_serialize"] = {
			source = '__lf_oEfBoss4SliceWindup_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["control_get_styles"] = {
			source = 'control_get_styles',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["_ui_get_free_render_target"] = {
			source = 'ui_force_render_zoom',
			line = 19,
			constructor = false,
			base = nil,
			params = {
				{ name = 'width' },
				{ name = 'height' },
			}
		},
		["_ui_release_render_target"] = {
			source = 'ui_force_render_zoom',
			line = 40,
			constructor = false,
			base = nil,
			params = {
				{ name = 'surf' },
			}
		},
		["_UIForceRenderZoomInfo"] = {
			source = 'ui_force_render_zoom',
			line = 54,
			constructor = true,
			base = nil,
			params = {
				{ name = 'surf' },
				{ name = 'alpha' },
				{ name = 'xoffs' },
				{ name = 'yoffs' },
				{ name = 'scale' },
				{ name = 'flash' },
				{ name = 'allow_reuse' },
			}
		},
		["ui_force_render_zoom"] = {
			source = 'ui_force_render_zoom',
			line = 95,
			constructor = false,
			base = nil,
			params = {
				{ name = 'alpha', value = [=[1]=] },
				{ name = 'xoffs', value = [=[0]=] },
				{ name = 'yoffs', value = [=[0]=] },
				{ name = 'force_new_surface', value = [=[false]=] },
				{ name = 'scale', value = [=[UI_MODE_ZOOM_SCALE]=] },
				{ name = 'flash', value = [=[0]=] },
			}
		},
		["ui_reset_render_zoom"] = {
			source = 'ui_force_render_zoom',
			line = 176,
			constructor = false,
			base = nil,
			params = {}
		},
		["ui_get_current_force_render_zoom_info"] = {
			source = 'ui_force_render_zoom',
			line = 200,
			constructor = false,
			base = nil,
			params = {}
		},
		["world_to_view_x"] = {
			source = 'ui_force_render_zoom',
			line = 206,
			constructor = false,
			base = nil,
			params = {
				{ name = 'v' },
			}
		},
		["world_to_view_y"] = {
			source = 'ui_force_render_zoom',
			line = 209,
			constructor = false,
			base = nil,
			params = {
				{ name = 'v' },
			}
		},
		["update_view_mouse_pos"] = {
			source = 'ui_force_render_zoom',
			line = 213,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lt_list_of__"] = {
			source = 'scr_lua_types',
			line = 39,
			constructor = false,
			base = nil,
			params = {
				{ name = 'type' },
			}
		},
		["_mod_variable_struct_set"] = {
			source = 'scr_lua_types',
			line = 43,
			constructor = false,
			base = nil,
			params = {
				{ name = 's,n,v' },
			}
		},
		["save_coop_init"] = {
			source = 'scr_onlineSaveHandling',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = 'local_player_m_id' },
			}
		},
		["save_coop_cleanup"] = {
			source = 'scr_onlineSaveHandling',
			line = 12,
			constructor = false,
			base = nil,
			params = {}
		},
		["save_coop_add_player"] = {
			source = 'scr_onlineSaveHandling',
			line = 17,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player_m_id' },
				{ name = 'flags' },
			}
		},
		["save_coop_remove_player"] = {
			source = 'scr_onlineSaveHandling',
			line = 24,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player_m_id' },
			}
		},
		["save_coop_get_sync_save_string"] = {
			source = 'scr_onlineSaveHandling',
			line = 42,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player_m_id' },
			}
		},
		["save_coop_add_player_from_sync_save_string"] = {
			source = 'scr_onlineSaveHandling',
			line = 48,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player_m_id' },
				{ name = 'str' },
			}
		},
		["save_flag_set_player"] = {
			source = 'scr_onlineSaveHandling',
			line = 68,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
				{ name = 'key' },
				{ name = 'active' },
			}
		},
		["save_flag_get_player"] = {
			source = 'scr_onlineSaveHandling',
			line = 86,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
				{ name = 'key' },
			}
		},
		["save_flag_get_any_player"] = {
			source = 'scr_onlineSaveHandling',
			line = 97,
			constructor = false,
			base = nil,
			params = {
				{ name = 'key' },
				{ name = 'comparison_value', value = [=[true]=] },
			}
		},
		["save_flag_get_all_players"] = {
			source = 'scr_onlineSaveHandling',
			line = 113,
			constructor = false,
			base = nil,
			params = {
				{ name = 'key' },
			}
		},
		["save_flag_set_all_players"] = {
			source = 'scr_onlineSaveHandling',
			line = 130,
			constructor = false,
			base = nil,
			params = {
				{ name = 'key' },
			}
		},
		["ChatMessage"] = {
			source = 'scr_chat',
			line = 7,
			constructor = true,
			base = nil,
			params = {
				{ name = 'message_text' },
				{ name = 'message_sender_name', value = [=[undefined]=] },
				{ name = 'message_sender_name_colour', value = [=[0]=] },
			}
		},
		["chat_add_message"] = {
			source = 'scr_chat',
			line = 27,
			constructor = false,
			base = nil,
			params = {
				{ name = 'message_struct' },
			}
		},
		["chat_add_user_message"] = {
			source = 'scr_chat',
			line = 36,
			constructor = false,
			base = nil,
			params = {
				{ name = 'user' },
				{ name = 'message' },
			}
		},
		["chat_add_system_message"] = {
			source = 'scr_chat',
			line = 48,
			constructor = false,
			base = nil,
			params = {
				{ name = '_type' },
				{ name = '_msg_token,' },
			}
		},
		["__lf_oEfBossShadow1_create_serialize"] = {
			source = '__lf_oEfBossShadow1_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__input_class_icon_category"] = {
			source = '__input_class_icon_category',
			line = 1,
			constructor = true,
			base = nil,
			params = {
				{ name = '_name' },
			}
		},
		["__input_validate_macros"] = {
			source = '__input_validate_macros',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_net_isHost"] = {
			source = 'scr_luaAPI_net',
			line = 22,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_net_isClient"] = {
			source = 'scr_luaAPI_net',
			line = 23,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_net_isOnline"] = {
			source = 'scr_luaAPI_net',
			line = 24,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_net_isAuthority"] = {
			source = 'scr_luaAPI_net',
			line = 25,
			constructor = false,
			base = nil,
			params = {
				{ name = 'inst' },
			}
		},
		["_mod_net_message_getUniqueID"] = {
			source = 'scr_luaAPI_net',
			line = 27,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_net_message_begin"] = {
			source = 'scr_luaAPI_net',
			line = 30,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_net_message_send"] = {
			source = 'scr_luaAPI_net',
			line = 35,
			constructor = false,
			base = nil,
			params = {
				{ name = 'msg_id' },
				{ name = 'target' },
				{ name = 'target_player' },
			}
		},
		["__input_axis_is_directional"] = {
			source = '__input_system',
			line = 160,
			constructor = false,
			base = nil,
			params = {
				{ name = '_axis' },
			}
		},
		["__input_gamepad_guid_parse"] = {
			source = '__input_system',
			line = 169,
			constructor = false,
			base = nil,
			params = {
				{ name = '_guid' },
				{ name = '_legacy' },
				{ name = '_suppress' },
			}
		},
		["__input_trace"] = {
			source = '__input_system',
			line = 217,
			constructor = false,
			base = nil,
			params = {}
		},
		["__input_trace_loud"] = {
			source = '__input_system',
			line = 238,
			constructor = false,
			base = nil,
			params = {}
		},
		["__input_error"] = {
			source = '__input_system',
			line = 261,
			constructor = false,
			base = nil,
			params = {}
		},
		["__input_ensure_unique_verb_name"] = {
			source = '__input_system',
			line = 281,
			constructor = false,
			base = nil,
			params = {
				{ name = '_name' },
			}
		},
		["__input_get_previous_time"] = {
			source = '__input_system',
			line = 302,
			constructor = false,
			base = nil,
			params = {}
		},
		["__input_get_time"] = {
			source = '__input_system',
			line = 307,
			constructor = false,
			base = nil,
			params = {}
		},
		["__input_update_max_players"] = {
			source = '__input_system',
			line = 312,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfBanditFlashCircle_create_deserialize"] = {
			source = '__lf_oEfBanditFlashCircle_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__input_gamepad_find_in_sdl2_database"] = {
			source = '__input_gamepad_find_in_sdl2_database',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["game_lobby_start"] = {
			source = 'scr_lobby_info',
			line = 10,
			constructor = false,
			base = nil,
			params = {}
		},
		["game_lobby_apply_rules"] = {
			source = 'scr_lobby_info',
			line = 19,
			constructor = false,
			base = nil,
			params = {
				{ name = 'lobby' },
			}
		},
		["LobbyInfo"] = {
			source = 'scr_lobby_info',
			line = 30,
			constructor = true,
			base = nil,
			params = {}
		},
		["SaveLobbyHostSettings"] = {
			source = 'scr_lobby_info',
			line = 68,
			constructor = true,
			base = nil,
			params = {}
		},
		["save_SaveLobbyHostSettings_struct"] = {
			source = 'scr_lobby_info',
			line = 80,
			constructor = false,
			base = nil,
			params = {
				{ name = 'm' },
			}
		},
		["read_SaveLobbyHostSettings_struct"] = {
			source = 'scr_lobby_info',
			line = 86,
			constructor = false,
			base = nil,
			params = {
				{ name = 'struct' },
			}
		},
		["input_multiplayer_params_set"] = {
			source = 'input_multiplayer_params_set',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = '_min' },
				{ name = '_max' },
				{ name = '_drop_down', value = [=[true]=] },
			}
		},
		["input_binding_get"] = {
			source = 'input_binding_get',
			line = 8,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb_name' },
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_alternate', value = [=[0]=] },
				{ name = '_profile_name', value = [=[undefined]=] },
			}
		},
		["input_profile_reset_bindings"] = {
			source = 'input_profile_reset_bindings',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = '_profile_name' },
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_default_profile_struct', value = [=[undefined]=] },
			}
		},
		["online_lobby_start"] = {
			source = 'scr_lobby_host_settings',
			line = 31,
			constructor = false,
			base = nil,
			params = {
				{ name = 'port' },
			}
		},
		["host_reset_default_lobby_options"] = {
			source = 'scr_lobby_host_settings',
			line = 38,
			constructor = false,
			base = nil,
			params = {}
		},
		["host_commit_lobby_options"] = {
			source = 'scr_lobby_host_settings',
			line = 46,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_mouse_x"] = {
			source = 'input_mouse_x',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oDrifterJunk_create_deserialize"] = {
			source = '__lf_oDrifterJunk_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["sound_add_w"] = {
			source = 'scr_audioResource',
			line = 19,
			constructor = false,
			base = nil,
			params = {
				{ name = 'namespace' },
				{ name = 'name' },
				{ name = 'fname' },
			}
		},
		["sound_delete_w"] = {
			source = 'scr_audioResource',
			line = 35,
			constructor = false,
			base = nil,
			params = {
				{ name = 'ind' },
			}
		},
		["_mod_sound_find"] = {
			source = 'scr_audioResource',
			line = 39,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'origin' },
			}
		},
		["_mod_sound_findAll"] = {
			source = 'scr_audioResource',
			line = 40,
			constructor = false,
			base = nil,
			params = {
				{ name = 'origin' },
			}
		},
		["_mod_sound_get_name"] = {
			source = 'scr_audioResource',
			line = 41,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sound' },
			}
		},
		["_mod_sound_get_namespace"] = {
			source = 'scr_audioResource',
			line = 42,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sound' },
			}
		},
		["_mod_sound_get_netID"] = {
			source = 'scr_audioResource',
			line = 43,
			constructor = false,
			base = nil,
			params = {
				{ name = 'sound' },
			}
		},
		["_mod_sound_from_netID"] = {
			source = 'scr_audioResource',
			line = 44,
			constructor = false,
			base = nil,
			params = {
				{ name = 'nid' },
			}
		},
		["_mod_sound_from_id"] = {
			source = 'scr_audioResource',
			line = 45,
			constructor = false,
			base = nil,
			params = {
				{ name = 'nid' },
			}
		},
		["_mod_music_play"] = {
			source = 'scr_audioResource',
			line = 46,
			constructor = false,
			base = nil,
			params = {
				{ name = 'mus' },
			}
		},
		["_mod_music_stop"] = {
			source = 'scr_audioResource',
			line = 47,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_music_getPlaying"] = {
			source = 'scr_audioResource',
			line = 48,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_music_getPlayingSound"] = {
			source = 'scr_audioResource',
			line = 49,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_sound_load"] = {
			source = 'scr_audioResource',
			line = 50,
			constructor = false,
			base = nil,
			params = {
				{ name = 'fname' },
				{ name = 'name' },
			}
		},
		["_mod_sound_play"] = {
			source = 'scr_audioResource',
			line = 65,
			constructor = false,
			base = nil,
			params = {
				{ name = 'snd' },
				{ name = 'pitch' },
				{ name = 'vol' },
			}
		},
		["_mod_sound_playAt"] = {
			source = 'scr_audioResource',
			line = 66,
			constructor = false,
			base = nil,
			params = {
				{ name = 'snd' },
				{ name = '_x' },
				{ name = '_y' },
				{ name = 'pitch' },
				{ name = 'vol' },
			}
		},
		["_mod_sound_gain"] = {
			source = 'scr_audioResource',
			line = 68,
			constructor = false,
			base = nil,
			params = {
				{ name = 'snd' },
				{ name = 'gain' },
				{ name = 'time' },
			}
		},
		["_mod_sound_get_gain"] = {
			source = 'scr_audioResource',
			line = 69,
			constructor = false,
			base = nil,
			params = {
				{ name = 'snd' },
			}
		},
		["_mod_sound_pitch"] = {
			source = 'scr_audioResource',
			line = 72,
			constructor = false,
			base = nil,
			params = {
				{ name = 'snd' },
				{ name = 'p' },
			}
		},
		["_mod_sound_get_pitch"] = {
			source = 'scr_audioResource',
			line = 73,
			constructor = false,
			base = nil,
			params = {
				{ name = 'snd' },
			}
		},
		["_mod_sound_pause"] = {
			source = 'scr_audioResource',
			line = 74,
			constructor = false,
			base = nil,
			params = {
				{ name = 'snd' },
			}
		},
		["_mod_sound_resume"] = {
			source = 'scr_audioResource',
			line = 75,
			constructor = false,
			base = nil,
			params = {
				{ name = 'snd' },
			}
		},
		["_mod_sound_isPaused"] = {
			source = 'scr_audioResource',
			line = 76,
			constructor = false,
			base = nil,
			params = {
				{ name = 'snd' },
			}
		},
		["_mod_sound_isPlaying"] = {
			source = 'scr_audioResource',
			line = 77,
			constructor = false,
			base = nil,
			params = {
				{ name = 'snd' },
			}
		},
		["_mod_sound_stop"] = {
			source = 'scr_audioResource',
			line = 78,
			constructor = false,
			base = nil,
			params = {
				{ name = 'snd' },
			}
		},
		["_mod_sound_exists"] = {
			source = 'scr_audioResource',
			line = 79,
			constructor = false,
			base = nil,
			params = {
				{ name = 'snd' },
			}
		},
		["_mod_sound_get_length"] = {
			source = 'scr_audioResource',
			line = 80,
			constructor = false,
			base = nil,
			params = {
				{ name = 'snd' },
			}
		},
		["readdouble"] = {
			source = 'scr_buffer_primitives',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["writedouble_direct"] = {
			source = 'scr_buffer_primitives',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'val' },
			}
		},
		["readdouble_direct"] = {
			source = 'scr_buffer_primitives',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["writefloat"] = {
			source = 'scr_buffer_primitives',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = 'val' },
			}
		},
		["readfloat"] = {
			source = 'scr_buffer_primitives',
			line = 7,
			constructor = false,
			base = nil,
			params = {}
		},
		["writefloat_direct"] = {
			source = 'scr_buffer_primitives',
			line = 8,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'val' },
			}
		},
		["readfloat_direct"] = {
			source = 'scr_buffer_primitives',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["writehalf"] = {
			source = 'scr_buffer_primitives',
			line = 11,
			constructor = false,
			base = nil,
			params = {
				{ name = 'val' },
			}
		},
		["readhalf"] = {
			source = 'scr_buffer_primitives',
			line = 12,
			constructor = false,
			base = nil,
			params = {}
		},
		["writehalf_direct"] = {
			source = 'scr_buffer_primitives',
			line = 13,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'val' },
			}
		},
		["readhalf_direct"] = {
			source = 'scr_buffer_primitives',
			line = 14,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["writeint"] = {
			source = 'scr_buffer_primitives',
			line = 16,
			constructor = false,
			base = nil,
			params = {
				{ name = 'val' },
			}
		},
		["readint"] = {
			source = 'scr_buffer_primitives',
			line = 17,
			constructor = false,
			base = nil,
			params = {}
		},
		["writeint_direct"] = {
			source = 'scr_buffer_primitives',
			line = 18,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'val' },
			}
		},
		["readint_direct"] = {
			source = 'scr_buffer_primitives',
			line = 19,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["writeuint"] = {
			source = 'scr_buffer_primitives',
			line = 21,
			constructor = false,
			base = nil,
			params = {
				{ name = 'val' },
			}
		},
		["readuint"] = {
			source = 'scr_buffer_primitives',
			line = 22,
			constructor = false,
			base = nil,
			params = {}
		},
		["writeuint_direct"] = {
			source = 'scr_buffer_primitives',
			line = 23,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'val' },
			}
		},
		["readuint_direct"] = {
			source = 'scr_buffer_primitives',
			line = 24,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["writeshort"] = {
			source = 'scr_buffer_primitives',
			line = 26,
			constructor = false,
			base = nil,
			params = {
				{ name = 'val' },
			}
		},
		["readshort"] = {
			source = 'scr_buffer_primitives',
			line = 27,
			constructor = false,
			base = nil,
			params = {}
		},
		["writeshort_direct"] = {
			source = 'scr_buffer_primitives',
			line = 28,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'val' },
			}
		},
		["readshort_direct"] = {
			source = 'scr_buffer_primitives',
			line = 29,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["writeushort"] = {
			source = 'scr_buffer_primitives',
			line = 31,
			constructor = false,
			base = nil,
			params = {
				{ name = 'val' },
			}
		},
		["readushort"] = {
			source = 'scr_buffer_primitives',
			line = 32,
			constructor = false,
			base = nil,
			params = {}
		},
		["writeushort_direct"] = {
			source = 'scr_buffer_primitives',
			line = 33,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'val' },
			}
		},
		["readushort_direct"] = {
			source = 'scr_buffer_primitives',
			line = 34,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["writebyte"] = {
			source = 'scr_buffer_primitives',
			line = 36,
			constructor = false,
			base = nil,
			params = {
				{ name = 'val' },
			}
		},
		["readbyte"] = {
			source = 'scr_buffer_primitives',
			line = 37,
			constructor = false,
			base = nil,
			params = {}
		},
		["writebyte_direct"] = {
			source = 'scr_buffer_primitives',
			line = 38,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'val' },
			}
		},
		["readbyte_direct"] = {
			source = 'scr_buffer_primitives',
			line = 39,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["readbool"] = {
			source = 'scr_buffer_primitives',
			line = 42,
			constructor = false,
			base = nil,
			params = {}
		},
		["readbool_direct"] = {
			source = 'scr_buffer_primitives',
			line = 44,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["writesign"] = {
			source = 'scr_buffer_primitives',
			line = 46,
			constructor = false,
			base = nil,
			params = {
				{ name = 'val' },
			}
		},
		["readsign"] = {
			source = 'scr_buffer_primitives',
			line = 47,
			constructor = false,
			base = nil,
			params = {}
		},
		["writesign_direct"] = {
			source = 'scr_buffer_primitives',
			line = 48,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'val' },
			}
		},
		["readsign_direct"] = {
			source = 'scr_buffer_primitives',
			line = 49,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["writestring"] = {
			source = 'scr_buffer_primitives',
			line = 51,
			constructor = false,
			base = nil,
			params = {
				{ name = 'val' },
			}
		},
		["readstring"] = {
			source = 'scr_buffer_primitives',
			line = 52,
			constructor = false,
			base = nil,
			params = {}
		},
		["writestring_direct"] = {
			source = 'scr_buffer_primitives',
			line = 53,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'val' },
			}
		},
		["readstring_direct"] = {
			source = 'scr_buffer_primitives',
			line = 54,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["write_color"] = {
			source = 'scr_buffer_primitives',
			line = 56,
			constructor = false,
			base = nil,
			params = {
				{ name = 'val' },
			}
		},
		["read_color"] = {
			source = 'scr_buffer_primitives',
			line = 57,
			constructor = false,
			base = nil,
			params = {}
		},
		["write_color_direct"] = {
			source = 'scr_buffer_primitives',
			line = 58,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'val' },
			}
		},
		["read_color_direct"] = {
			source = 'scr_buffer_primitives',
			line = 64,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["write_direction"] = {
			source = 'scr_buffer_primitives',
			line = 80,
			constructor = false,
			base = nil,
			params = {
				{ name = 'val' },
			}
		},
		["read_direction"] = {
			source = 'scr_buffer_primitives',
			line = 81,
			constructor = false,
			base = nil,
			params = {}
		},
		["write_direction_direct"] = {
			source = 'scr_buffer_primitives',
			line = 82,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'val' },
			}
		},
		["read_direction_direct"] = {
			source = 'scr_buffer_primitives',
			line = 89,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["readuint_packed"] = {
			source = 'scr_buffer_primitives',
			line = 93,
			constructor = false,
			base = nil,
			params = {}
		},
		["writeuint_packed"] = {
			source = 'scr_buffer_primitives',
			line = 94,
			constructor = false,
			base = nil,
			params = {
				{ name = 'val' },
			}
		},
		["writeuint_packed_direct"] = {
			source = 'scr_buffer_primitives',
			line = 95,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'val' },
			}
		},
		["readuint_packed_direct"] = {
			source = 'scr_buffer_primitives',
			line = 116,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["writestring_compressed"] = {
			source = 'scr_buffer_primitives',
			line = 135,
			constructor = false,
			base = nil,
			params = {
				{ name = 'str' },
			}
		},
		["readstring_compressed"] = {
			source = 'scr_buffer_primitives',
			line = 136,
			constructor = false,
			base = nil,
			params = {}
		},
		["writestring_compressed_direct"] = {
			source = 'scr_buffer_primitives',
			line = 137,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'str' },
			}
		},
		["readstring_compressed_direct"] = {
			source = 'scr_buffer_primitives',
			line = 168,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["read_damage_color"] = {
			source = 'scr_buffer_primitives',
			line = 219,
			constructor = false,
			base = nil,
			params = {}
		},
		["write_damage_color"] = {
			source = 'scr_buffer_primitives',
			line = 231,
			constructor = false,
			base = nil,
			params = {
				{ name = 'c' },
			}
		},
		["_object_delete_internal"] = {
			source = 'scr_objectResource',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'obj' },
			}
		},
		["object_add_w"] = {
			source = 'scr_objectResource',
			line = 30,
			constructor = false,
			base = nil,
			params = {
				{ name = 'namespace' },
				{ name = 'name' },
				{ name = 'parent' },
			}
		},
		["object_delete_w"] = {
			source = 'scr_objectResource',
			line = 37,
			constructor = false,
			base = nil,
			params = {
				{ name = 'rm' },
			}
		},
		["object_get_id"] = {
			source = 'scr_objectResource',
			line = 42,
			constructor = false,
			base = nil,
			params = {
				{ name = 'obj' },
			}
		},
		["object_find"] = {
			source = 'scr_objectResource',
			line = 48,
			constructor = false,
			base = nil,
			params = {
				{ name = 'id_string' },
			}
		},
		["_mod_object_create"] = {
			source = 'scr_objectResource',
			line = 54,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'parent' },
			}
		},
		["_mod_object_find"] = {
			source = 'scr_objectResource',
			line = 60,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'origin' },
			}
		},
		["_mod_object_findAll"] = {
			source = 'scr_objectResource',
			line = 61,
			constructor = false,
			base = nil,
			params = {
				{ name = 'origin' },
			}
		},
		["_mod_object_get_name"] = {
			source = 'scr_objectResource',
			line = 62,
			constructor = false,
			base = nil,
			params = {
				{ name = 'obj' },
			}
		},
		["_mod_object_get_namespace"] = {
			source = 'scr_objectResource',
			line = 63,
			constructor = false,
			base = nil,
			params = {
				{ name = 'obj' },
			}
		},
		["_mod_object_get_netID"] = {
			source = 'scr_objectResource',
			line = 64,
			constructor = false,
			base = nil,
			params = {
				{ name = 'obj' },
			}
		},
		["_mod_object_from_netID"] = {
			source = 'scr_objectResource',
			line = 65,
			constructor = false,
			base = nil,
			params = {
				{ name = 'nid' },
			}
		},
		["_mod_object_from_id"] = {
			source = 'scr_objectResource',
			line = 66,
			constructor = false,
			base = nil,
			params = {
				{ name = 'nid' },
			}
		},
		["_mod_object_isRestricted"] = {
			source = 'scr_objectResource',
			line = 68,
			constructor = false,
			base = nil,
			params = {
				{ name = 'obj' },
			}
		},
		["input_mouse_moved"] = {
			source = 'input_mouse_moved',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_profile_export"] = {
			source = 'input_profile_export',
			line = 7,
			constructor = false,
			base = nil,
			params = {
				{ name = '_profile_name' },
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_output_string', value = [=[true]=] },
				{ name = '_prettify', value = [=[false]=] },
			}
		},
		["_mod_handle_gml_error"] = {
			source = 'scr_mod_handle_gml_error',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'err' },
			}
		},
		["input_player_reset"] = {
			source = 'input_player_reset',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["__lf_oConsRodB_create_deserialize"] = {
			source = '__lf_oConsRodB_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_mouse_dx"] = {
			source = 'input_mouse_dx',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["damager_proc_onhitactor_clientandserver"] = {
			source = 'damager_proc_onhitactor_clientandserver',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'parent' },
				{ name = 'target' },
				{ name = 'true_target' },
				{ name = 'critical' },
				{ name = 'attack_xscale' },
				{ name = 'attack_flags' },
				{ name = 'hit_x' },
				{ name = 'hit_y' },
				{ name = 'rng' },
				{ name = 'proc' },
				{ name = 'attack_climb' },
				{ name = 'attack_damage' },
				{ name = 'hit_damage_true' },
				{ name = 'attack_team' },
				{ name = 'attack_direction' },
				{ name = 'is_attack_authority' },
			}
		},
		["control_binding_scan_success"] = {
			source = 'control_binding_scan_success',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'verb' },
				{ name = 'new_bind' },
				{ name = 'player_index' },
			}
		},
		["control_binding_is_legal"] = {
			source = 'control_binding_scan_success',
			line = 25,
			constructor = false,
			base = nil,
			params = {
				{ name = 'verb' },
				{ name = 'new_bind' },
				{ name = 'player_index' },
				{ name = 'profile' },
			}
		},
		["sound_play_ui"] = {
			source = 'sound_play_ui',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'snd,pitch_variance', value = [=[0,vol=1]=] },
			}
		},
		["sound_play_ui_checkbox_sound"] = {
			source = 'sound_play_ui',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = 'active' },
			}
		},
		["sound_play_ui_dropdown_sound"] = {
			source = 'sound_play_ui',
			line = 20,
			constructor = false,
			base = nil,
			params = {
				{ name = 'active' },
			}
		},
		["__lf_oEfBossShadowTracer_create_serialize"] = {
			source = '__lf_oEfBossShadowTracer_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__input_class_verb_state"] = {
			source = '__input_class_verb_state',
			line = 1,
			constructor = true,
			base = nil,
			params = {}
		},
		["__input_mouse_button"] = {
			source = '__input_mouse_button',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["__input_class_combo_definition"] = {
			source = '__input_class_combo_definition',
			line = 1,
			constructor = true,
			base = nil,
			params = {
				{ name = '_name' },
				{ name = '_default_timeout' },
			}
		},
		["input_mouse_check"] = {
			source = 'input_mouse_check',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_binding' },
			}
		},
		["input_check_opposing"] = {
			source = 'input_check_opposing',
			line = 7,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb_negative' },
				{ name = '_verb_positive' },
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_most_recent', value = [=[false]=] },
			}
		},
		["__lf_oEfArtiStar_create_serialize"] = {
			source = '__lf_oEfArtiStar_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["_survivor_robomando_interactable_is_hackable"] = {
			source = 'scr_ror_init_survivor_robomando',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'interactable' },
			}
		},
		["_survivor_robomando_hack_find_target"] = {
			source = 'scr_ror_init_survivor_robomando',
			line = 10,
			constructor = false,
			base = nil,
			params = {
				{ name = 'max_range' },
				{ name = 'x_from' },
				{ name = 'y_from' },
			}
		},
		["_survivor_robomand_hack_state_impl_init"] = {
			source = 'scr_ror_init_survivor_robomando',
			line = 241,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
				{ name = 'data' },
			}
		},
		["_survivor_robomand_hack_state_impl_update"] = {
			source = 'scr_ror_init_survivor_robomando',
			line = 251,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
				{ name = 'data' },
			}
		},
		["_survivor_robomand_hack_state_impl_serialize"] = {
			source = 'scr_ror_init_survivor_robomando',
			line = 278,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
				{ name = 'data' },
			}
		},
		["_survivor_robomand_hack_state_impl_deserialize"] = {
			source = 'scr_ror_init_survivor_robomando',
			line = 281,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
				{ name = 'data' },
			}
		},
		["__lf_oTelepoison_create_deserialize"] = {
			source = '__lf_oTelepoison_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_verb_get_group"] = {
			source = 'input_verb_get_group',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb_name' },
			}
		},
		["input_default_mouse_wheel_up"] = {
			source = 'input_default_mouse_wheel_up',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["run_update_available_loot"] = {
			source = 'scr_lootPools',
			line = 43,
			constructor = false,
			base = nil,
			params = {}
		},
		["TreasureLootPool"] = {
			source = 'scr_lootPools',
			line = 69,
			constructor = true,
			base = nil,
			params = {
				{ name = 'pool_id' },
				{ name = 'item_tier_id', value = [=[-1]=] },
				{ name = 'is_equipment_pool', value = [=[false]=] },
				{ name = 'command_crate_sprite_id', value = [=[-1]=] },
				{ name = 'command_sprite_use', value = [=[-1]=] },
				{ name = 'outline_index_inactive', value = [=[0]=] },
				{ name = 'outline_index_active', value = [=[1]=] },
				{ name = 'col_index', value = [=[0]=] },
			}
		},
		["string_to_LOOT_POOL_INDEX"] = {
			source = 'scr_lootPools',
			line = 142,
			constructor = false,
			base = nil,
			params = {
				{ name = 'str' },
			}
		},
		["ITEM_TIER_to_LOOT_POOL_INDEX"] = {
			source = 'scr_lootPools',
			line = 155,
			constructor = false,
			base = nil,
			params = {
				{ name = 'index' },
				{ name = 'equipment', value = [=[false]=] },
			}
		},
		["LOOT_POOL_INDEX_to_itempool"] = {
			source = 'scr_lootPools',
			line = 167,
			constructor = false,
			base = nil,
			params = {
				{ name = 'pool_index' },
			}
		},
		["treasure_loot_pool_roll"] = {
			source = 'scr_lootPools',
			line = 196,
			constructor = false,
			base = nil,
			params = {
				{ name = 'pool_index' },
				{ name = 'required_loot_tags', value = [=[0]=] },
				{ name = 'disallowed_loot_tags', value = [=[0]=] },
				{ name = 'allow_pool_fallback', value = [=[true]=] },
			}
		},
		["treasure_loot_pool_roll_with_blacklisted_pickup"] = {
			source = 'scr_lootPools',
			line = 244,
			constructor = false,
			base = nil,
			params = {
				{ name = 'pool_index' },
				{ name = 'blacklist_pickup' },
			}
		},
		["treasure_filter_loot_pool_by_tags"] = {
			source = 'scr_lootPools',
			line = 253,
			constructor = false,
			base = nil,
			params = {
				{ name = 'pool_index' },
				{ name = 'required_tags' },
				{ name = 'disallowed_tags' },
			}
		},
		["_mod_verify_loot_pool_index"] = {
			source = 'scr_lootPools',
			line = 278,
			constructor = false,
			base = nil,
			params = {
				{ name = 'index' },
			}
		},
		["_mod_verify_loot_pool_index_or_none"] = {
			source = 'scr_lootPools',
			line = 281,
			constructor = false,
			base = nil,
			params = {
				{ name = 'index' },
			}
		},
		["actor_teleport"] = {
			source = 'actor_teleport',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'tx' },
				{ name = 'ty' },
			}
		},
		["input_binding_remove"] = {
			source = 'input_binding_remove',
			line = 7,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb' },
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_alternate', value = [=[0]=] },
				{ name = '_profile_name', value = [=[undefined]=] },
			}
		},
		["SaveRunHistory"] = {
			source = 'scr_runHistory',
			line = 4,
			constructor = true,
			base = nil,
			params = {}
		},
		["write_saverunhistory"] = {
			source = 'scr_runHistory',
			line = 63,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
				{ name = 'run_history' },
			}
		},
		["read_saverunhistory"] = {
			source = 'scr_runHistory',
			line = 85,
			constructor = false,
			base = nil,
			params = {
				{ name = 'buffer' },
			}
		},
		["input_binding_gamepad_get"] = {
			source = 'input_binding_gamepad_get',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_binding' },
			}
		},
		["set_player_viewed"] = {
			source = 'oResultsScreen-Create',
			line = 128,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player_index' },
			}
		},
		["set_run_report"] = {
			source = 'oResultsScreen-Create',
			line = 226,
			constructor = false,
			base = nil,
			params = {
				{ name = 'report' },
			}
		},
		["input_resolve_binding_icon"] = {
			source = 'input_resolve_binding_icon',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'verb' },
				{ name = 'size' },
				{ name = 'to_string', value = [=[true]=] },
				{ name = 'playerIdx', value = [=[0]=] },
			}
		},
		["ui_text_field"] = {
			source = 'ui_text_field',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'xx' },
				{ name = 'yy' },
				{ name = 'width' },
				{ name = 'flags', value = [=[0]=] },
				{ name = 'style', value = [=[global._ui_style_default]=] },
				{ name = 'max_chars', value = [=[250]=] },
				{ name = 'gp_index', value = [=[UI_GP_POS_NONE]=] },
			}
		},
		["switchmultiplayer_update_lobby_data"] = {
			source = 'switchmultiplayer_update_lobby_data',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oDrifterCube_create_serialize"] = {
			source = '__lf_oDrifterCube_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_check_pressed"] = {
			source = 'input_check_pressed',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb' },
				{ name = '_player_index', value = [=[0) //]=] },
				{ name = '_buffer_duration', value = [=[0]=] },
			}
		},
		["input_system_reset"] = {
			source = 'input_system_reset',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_cursor_elastic_get"] = {
			source = 'input_cursor_elastic_get',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_x' },
				{ name = '_y' },
				{ name = '_strength' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["input_check_long_pressed"] = {
			source = 'input_check_long_pressed',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb' },
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_buffer_duration', value = [=[0]=] },
			}
		},
		["lua_ref_wrap"] = {
			source = 'scr_luaref',
			line = 23,
			constructor = false,
			base = nil,
			params = {
				{ name = '_id' },
			}
		},
		["lua_ref_get"] = {
			source = 'scr_luaref',
			line = 50,
			constructor = false,
			base = nil,
			params = {
				{ name = '_ref' },
			}
		},
		["lua_ref_gc_update"] = {
			source = 'scr_luaref',
			line = 60,
			constructor = false,
			base = nil,
			params = {}
		},
		["is_lua_ref"] = {
			source = 'scr_luaref',
			line = 96,
			constructor = false,
			base = nil,
			params = {
				{ name = '_val' },
			}
		},
		["interactable_check_blocked"] = {
			source = 'interactable_check_blocked',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'p' },
			}
		},
		["input_source_using"] = {
			source = 'input_source_using',
			line = 7,
			constructor = false,
			base = nil,
			params = {
				{ name = '_source' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["input_xy"] = {
			source = 'input_xy',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb_l' },
				{ name = '_verb_r' },
				{ name = '_verb_u' },
				{ name = '_verb_d' },
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_most_recent', value = [=[false]=] },
			}
		},
		["__lf_oEfJewel_create_deserialize"] = {
			source = '__lf_oEfJewel_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["steammultiplayer_try_load_avatar"] = {
			source = 'steammultiplayer_try_load_avatar',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'l_img' },
			}
		},
		["__input_fixed_rejoin_tick"] = {
			source = '__input_fixed_rejoin_tick',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["pickup_init_name"] = {
			source = 'pickup_init_name',
			line = 1,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name_key' },
				{ name = 'text_key' },
				{ name = 'name_subkey', value = [=[""]=] },
			}
		},
		["_survivor_pilot_special2_set_scepter"] = {
			source = 'scr_ror_init_survivor_pilot_alts',
			line = 4,
			constructor = false,
			base = nil,
			params = {}
		},
		["_survivor_pilot_skill_can_activate_during_cling"] = {
			source = 'scr_ror_init_survivor_pilot_alts',
			line = 11,
			constructor = false,
			base = nil,
			params = {
				{ name = 'player' },
			}
		},
		["_survivor_pilot_shared_skill_serialize"] = {
			source = 'scr_ror_init_survivor_pilot_alts',
			line = 20,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
				{ name = 'data' },
			}
		},
		["_survivor_pilot_shared_skill_deserialize"] = {
			source = 'scr_ror_init_survivor_pilot_alts',
			line = 24,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
				{ name = 'data' },
			}
		},
		["_survivor_pilot_shared_skill_state_enter"] = {
			source = 'scr_ror_init_survivor_pilot_alts',
			line = 30,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
				{ name = 'data' },
			}
		},
		["_survivor_pilot_shared_skill_state_step"] = {
			source = 'scr_ror_init_survivor_pilot_alts',
			line = 39,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
				{ name = 'data' },
				{ name = 'ignore_wall_check', value = [=[false]=] },
			}
		},
		["_survivor_pilot_cling_wall_check"] = {
			source = 'scr_ror_init_survivor_pilot_alts',
			line = 63,
			constructor = false,
			base = nil,
			params = {}
		},
		["_survivor_pilot_skill_anim_set"] = {
			source = 'scr_ror_init_survivor_pilot_alts',
			line = 67,
			constructor = false,
			base = nil,
			params = {
				{ name = 'anim_normal' },
				{ name = 'anim_cling' },
			}
		},
		["_survivor_pilot_exit_state_on_anim_end"] = {
			source = 'scr_ror_init_survivor_pilot_alts',
			line = 78,
			constructor = false,
			base = nil,
			params = {}
		},
		["_survivor_pilot_pre_set_skill_state"] = {
			source = 'scr_ror_init_survivor_pilot_alts',
			line = 96,
			constructor = false,
			base = nil,
			params = {
				{ name = 'a' },
			}
		},
		["input_check_repeat"] = {
			source = 'input_check_repeat',
			line = 9,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb' },
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_delay', value = [=[INPUT_REPEAT_DEFAULT_DELAY]=] },
				{ name = '_predelay', value = [=[INPUT_REPEAT_DEFAULT_PREDELAY]=] },
			}
		},
		["mapobject_spawn"] = {
			source = 'mapobject_spawn',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["__lf_oEfOverloadingSparking_create_deserialize"] = {
			source = '__lf_oEfOverloadingSparking_create_deserialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["treasure_boss_register"] = {
			source = 'scr_bossTreasure',
			line = 13,
			constructor = false,
			base = nil,
			params = {
				{ name = 'boss_object' },
				{ name = 'pickup_id' },
			}
		},
		["treasure_boss_remove"] = {
			source = 'scr_bossTreasure',
			line = 24,
			constructor = false,
			base = nil,
			params = {
				{ name = 'boss_object' },
				{ name = 'pickup_id' },
			}
		},
		["treasure_boss_clear"] = {
			source = 'scr_bossTreasure',
			line = 42,
			constructor = false,
			base = nil,
			params = {
				{ name = 'boss_object' },
			}
		},
		["treasure_boss_roll"] = {
			source = 'scr_bossTreasure',
			line = 47,
			constructor = false,
			base = nil,
			params = {
				{ name = 'boss_object' },
			}
		},
		["treasure_boss_exists"] = {
			source = 'scr_bossTreasure',
			line = 70,
			constructor = false,
			base = nil,
			params = {
				{ name = 'boss_object' },
			}
		},
		["__lf_oConsRodB_create_serialize"] = {
			source = '__lf_oConsRodB_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["rpc_register"] = {
			source = 'scr_networkMessage_rpc',
			line = 44,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_source_mode_set_auto"] = {
			source = 'input_source_mode_set_auto',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["draw_line3"] = {
			source = 'draw_line3',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'x1' },
				{ name = 'y1' },
				{ name = 'x2' },
				{ name = 'y2' },
				{ name = 'x3' },
				{ name = 'y3' },
				{ name = 'width1' },
				{ name = 'width2' },
				{ name = 'width3' },
				{ name = 'num_samples' },
			}
		},
		["input_source_set"] = {
			source = 'input_source_set',
			line = 7,
			constructor = false,
			base = nil,
			params = {
				{ name = '_source' },
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_auto_profile', value = [=[true]=] },
			}
		},
		["__input_snap_to_json"] = {
			source = '__input_snap_to_json',
			line = 9,
			constructor = false,
			base = nil,
			params = {}
		},
		["__input_snap_to_json_parser"] = {
			source = '__input_snap_to_json',
			line = 18,
			constructor = true,
			base = nil,
			params = {
				{ name = '_ds' },
				{ name = '_pretty' },
				{ name = '_alphabetise' },
			}
		},
		["__lf_oEngiMortar_create_serialize"] = {
			source = '__lf_oEngiMortar_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_keyboard_check_released"] = {
			source = 'input_keyboard_check_released',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_binding' },
			}
		},
		["AudioFalloffStyle"] = {
			source = 'scr_audio_falloff_styles_init',
			line = 2,
			constructor = true,
			base = nil,
			params = {
				{ name = 'falloff_start_mul' },
				{ name = 'falloff_end_mul' },
			}
		},
		["audio_set_falloff_model"] = {
			source = 'scr_audio_falloff_styles_init',
			line = 8,
			constructor = false,
			base = nil,
			params = {
				{ name = 'snd' },
				{ name = 'model' },
			}
		},
		["on_heal"] = {
			source = 'oEfConstruct-Create',
			line = 35,
			constructor = false,
			base = nil,
			params = {}
		},
		["callable_function"] = {
			source = 'scr_GenericCallable',
			line = 3,
			constructor = false,
			base = nil,
			params = {
				{ name = 'func' },
			}
		},
		["callable_function_lua"] = {
			source = 'scr_GenericCallable',
			line = 10,
			constructor = false,
			base = nil,
			params = {
				{ name = 'lua_func' },
			}
		},
		["callable_array_find_index"] = {
			source = 'scr_GenericCallable',
			line = 17,
			constructor = false,
			base = nil,
			params = {
				{ name = 'callables' },
				{ name = 'callable_type' },
				{ name = 'callable_value' },
			}
		},
		["GenericCallable"] = {
			source = 'scr_GenericCallable',
			line = 30,
			constructor = true,
			base = nil,
			params = {}
		},
		["callable_call"] = {
			source = 'scr_GenericCallable',
			line = 54,
			constructor = false,
			base = nil,
			params = {
				{ name = 'callable' },
				{ name = 'argument_types' },
			}
		},
		["input_default_gamepad_axis"] = {
			source = 'input_default_gamepad_axis',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_profile_auto"] = {
			source = 'input_profile_auto',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["hud_draw_start"] = {
			source = 'hud_draw_start',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["hud_draw_stop"] = {
			source = 'hud_draw_start',
			line = 12,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_source_add"] = {
			source = 'input_source_add',
			line = 6,
			constructor = false,
			base = nil,
			params = {
				{ name = '_source' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["__input_gamepad_set_type"] = {
			source = '__input_gamepad_set_type',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_keyboard_check_pressed"] = {
			source = 'input_keyboard_check_pressed',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_binding' },
			}
		},
		["__input_gamepad_set_mapping"] = {
			source = '__input_gamepad_set_mapping',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["perf_mode_enable"] = {
			source = 'scr_prefs',
			line = 35,
			constructor = false,
			base = nil,
			params = {}
		},
		["perf_mode_disable"] = {
			source = 'scr_prefs',
			line = 39,
			constructor = false,
			base = nil,
			params = {}
		},
		["prefs_update_graphics"] = {
			source = 'scr_prefs',
			line = 44,
			constructor = false,
			base = nil,
			params = {}
		},
		["prefs_update_audio"] = {
			source = 'scr_prefs',
			line = 56,
			constructor = false,
			base = nil,
			params = {}
		},
		["prefs_update_alt_font"] = {
			source = 'scr_prefs',
			line = 65,
			constructor = false,
			base = nil,
			params = {}
		},
		["prefs_update_active_input_profile"] = {
			source = 'scr_prefs',
			line = 91,
			constructor = false,
			base = nil,
			params = {}
		},
		["prefs_player_input_profile_exists"] = {
			source = 'scr_prefs',
			line = 99,
			constructor = false,
			base = nil,
			params = {
				{ name = 'serialized_name' },
			}
		},
		["prefs_player_input_profile_get"] = {
			source = 'scr_prefs',
			line = 103,
			constructor = false,
			base = nil,
			params = {
				{ name = 'serialized_name' },
			}
		},
		["prefs_player_input_profile_add"] = {
			source = 'scr_prefs',
			line = 107,
			constructor = false,
			base = nil,
			params = {
				{ name = 'serialized_name' },
				{ name = 'name' },
			}
		},
		["prefs_player_input_profile_delete"] = {
			source = 'scr_prefs',
			line = 114,
			constructor = false,
			base = nil,
			params = {
				{ name = 'serialized_name' },
			}
		},
		["prefs_player_input_profile_mark_recently_used"] = {
			source = 'scr_prefs',
			line = 121,
			constructor = false,
			base = nil,
			params = {
				{ name = 'serialized_name' },
			}
		},
		["save_prefs"] = {
			source = 'scr_prefs',
			line = 129,
			constructor = false,
			base = nil,
			params = {}
		},
		["load_prefs"] = {
			source = 'scr_prefs',
			line = 140,
			constructor = false,
			base = nil,
			params = {
				{ name = 'cb_func', value = [=[undefined]=] },
			}
		},
		["prefs_get_zoom_scale"] = {
			source = 'scr_prefs',
			line = 165,
			constructor = false,
			base = nil,
			params = {}
		},
		["prefs_set_zoom_scale"] = {
			source = 'scr_prefs',
			line = 169,
			constructor = false,
			base = nil,
			params = {
				{ name = 'v' },
			}
		},
		["prefs_get_hud_scale"] = {
			source = 'scr_prefs',
			line = 173,
			constructor = false,
			base = nil,
			params = {}
		},
		["prefs_set_hud_scale"] = {
			source = 'scr_prefs',
			line = 177,
			constructor = false,
			base = nil,
			params = {
				{ name = 'v' },
			}
		},
		["prefs_get_pixel_perfect"] = {
			source = 'scr_prefs',
			line = 181,
			constructor = false,
			base = nil,
			params = {}
		},
		["prefs_set_pixel_perfect"] = {
			source = 'scr_prefs',
			line = 185,
			constructor = false,
			base = nil,
			params = {
				{ name = 'v' },
			}
		},
		["prefs_get_lock_hud_scale"] = {
			source = 'scr_prefs',
			line = 189,
			constructor = false,
			base = nil,
			params = {}
		},
		["prefs_set_lock_hud_scale"] = {
			source = 'scr_prefs',
			line = 193,
			constructor = false,
			base = nil,
			params = {
				{ name = 'v' },
			}
		},
		["prefs_get_ui_scale"] = {
			source = 'scr_prefs',
			line = 198,
			constructor = false,
			base = nil,
			params = {}
		},
		["prefs_set_ui_scale"] = {
			source = 'scr_prefs',
			line = 202,
			constructor = false,
			base = nil,
			params = {
				{ name = 'v' },
			}
		},
		["prefs_get_lock_ui_scale"] = {
			source = 'scr_prefs',
			line = 206,
			constructor = false,
			base = nil,
			params = {}
		},
		["prefs_set_lock_ui_scale"] = {
			source = 'scr_prefs',
			line = 210,
			constructor = false,
			base = nil,
			params = {
				{ name = 'v' },
			}
		},
		["input_player_get_gamepad_type"] = {
			source = 'input_player_get_gamepad_type',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player_index', value = [=[0]=] },
				{ name = '_binding', value = [=[undefined]=] },
			}
		},
		["director_select_elite_type"] = {
			source = 'director_select_elite_type',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = 'card' },
				{ name = 'is_boss_spawn' },
				{ name = 'spawn_points' },
			}
		},
		["input_default_mouse_button"] = {
			source = 'input_default_mouse_button',
			line = 1,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_binding_mouse_wheel_up"] = {
			source = 'input_binding_mouse_wheel_up',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
		["ItemTierDef"] = {
			source = 'scr_itemTiers',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'index,' },
			}
		},
		["item_tier_to_string"] = {
			source = 'scr_itemTiers',
			line = 55,
			constructor = false,
			base = nil,
			params = {
				{ name = 'tier' },
			}
		},
		["item_tier_to_colour"] = {
			source = 'scr_itemTiers',
			line = 60,
			constructor = false,
			base = nil,
			params = {
				{ name = 'tier' },
			}
		},
		["item_tier_to_value"] = {
			source = 'scr_itemTiers',
			line = 65,
			constructor = false,
			base = nil,
			params = {
				{ name = 'tier' },
			}
		},
		["item_tier_get_reroll_pool"] = {
			source = 'scr_itemTiers',
			line = 70,
			constructor = false,
			base = nil,
			params = {
				{ name = 'tier' },
				{ name = 'is_equipment' },
			}
		},
		["input_cursor_elastic_remove"] = {
			source = 'input_cursor_elastic_remove',
			line = 4,
			constructor = false,
			base = nil,
			params = {
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["input_binding_gamepad_set"] = {
			source = 'input_binding_gamepad_set',
			line = 5,
			constructor = false,
			base = nil,
			params = {
				{ name = '_binding' },
				{ name = '_gamepad_index' },
			}
		},
		["__lf_oEfAcidBubble_create_serialize"] = {
			source = '__lf_oEfAcidBubble_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["mod_set_global"] = {
			source = 'scr_modUtils',
			line = 2,
			constructor = false,
			base = nil,
			params = {
				{ name = 'name' },
				{ name = 'value' },
				{ name = 'type' },
			}
		},
		["mod_namespace_current"] = {
			source = 'scr_modUtils',
			line = 9,
			constructor = false,
			base = nil,
			params = {}
		},
		["mod_path_current_mod"] = {
			source = 'scr_modUtils',
			line = 16,
			constructor = false,
			base = nil,
			params = {}
		},
		["mod_path_current_file"] = {
			source = 'scr_modUtils',
			line = 23,
			constructor = false,
			base = nil,
			params = {}
		},
		["mod_path_search_file"] = {
			source = 'scr_modUtils',
			line = 30,
			constructor = false,
			base = nil,
			params = {
				{ name = 'fname' },
				{ name = 'extensions' },
			}
		},
		["mod_add_file_resource"] = {
			source = 'scr_modUtils',
			line = 50,
			constructor = false,
			base = nil,
			params = {
				{ name = '_id' },
				{ name = 'type' },
			}
		},
		["mod_push_value"] = {
			source = 'scr_modUtils',
			line = 55,
			constructor = false,
			base = nil,
			params = {
				{ name = 'value' },
			}
		},
		["mod_push_array"] = {
			source = 'scr_modUtils',
			line = 70,
			constructor = false,
			base = nil,
			params = {
				{ name = 'array' },
			}
		},
		["mod_push_value_typed"] = {
			source = 'scr_modUtils',
			line = 77,
			constructor = false,
			base = nil,
			params = {
				{ name = 'value' },
				{ name = 'type' },
			}
		},
		["lua_table_create"] = {
			source = 'scr_modUtils',
			line = 93,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_test_multiReturnTest"] = {
			source = 'scr_modUtils',
			line = 106,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_test_throwError"] = {
			source = 'scr_modUtils',
			line = 115,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_test_showError"] = {
			source = 'scr_modUtils',
			line = 118,
			constructor = false,
			base = nil,
			params = {}
		},
		["_mod_test_passLuaRef"] = {
			source = 'scr_modUtils',
			line = 121,
			constructor = false,
			base = nil,
			params = {
				{ name = 'ref' },
			}
		},
		["_mod_test_getTrackedLuaRefNumber"] = {
			source = 'scr_modUtils',
			line = 124,
			constructor = false,
			base = nil,
			params = {}
		},
		["input_held_time"] = {
			source = 'input_held_time',
			line = 7,
			constructor = false,
			base = nil,
			params = {
				{ name = '_verb' },
				{ name = '_player_index', value = [=[0]=] },
			}
		},
		["__lf_oHuntressTrirang_create_serialize"] = {
			source = '__lf_oHuntressTrirang_create_serialize',
			line = 2,
			constructor = false,
			base = nil,
			params = {}
		},
		["_survivor_loader_special2_set_scepter"] = {
			source = 'scr_ror_init_survivor_loader_alts',
			line = 3,
			constructor = false,
			base = nil,
			params = {}
		},
	},

	array = {

		CLASS_SKILL = {
			{ name = [=[namespace]=], description = [=[Namespace]=] },
			{ name = [=[identifier]=], description = [=[Internal name string ]=] },
			
			-- Language stuff
			{ name = [=[token_name]=], description = [=[Name of the skill]=] },
			{ name = [=[token_description]=], description = [=[Description ]=] },
			
			-- Image
			{ name = [=[sprite]=], description = [=[Sprite containing the skill icon]=] },
			{ name = [=[subimage]=], description = [=[Subimage of sprite]=] },
			
			-- Stats
			{ name = [=[cooldown]=], description = [=[Skill cooldown in frames]=] },
			{ name = [=[damage]=], description = [=[Damage, only used in skill code itself]=] },
			{ name = [=[max_stock]=], description = [=[Base maximum stock]=] },
			{ name = [=[start_with_stock]=], description = [=[Initial stock]=] },
			{ name = [=[auto_restock]=], description = [=[Whether stock automatically increases on cooldown]=] },
			{ name = [=[required_stock]=], description = [=[Stock needed to activate the skill]=] },
			{ name = [=[require_key_press]=], description = [=[Whether the skill key must be pressed (can't be held) to activate]=] },
			{ name = [=[allow_buffered_input]=], description = [=[whether a buffered key input can activate the skill (true by default)]=] },
			{ name = [=[use_delay]=], description = [=[The minimum time between activations]=] },
			{ name = [=[animation]=], description = [=[Animation used by the actor]=] },
			{ name = [=[is_utility]=], description = [=[Whether the skill is a movement skill, prevents Red Whip deactivation]=] },
			{ name = [=[is_primary]=], description = [=[Whether the skill is a primary skill, affects whether cooldown is displayed and whether reload time scales with attack speed or CDR]=] },
			{ name = [=[required_interrupt_priority]=], description = [=[ACTOR_STATE_INTERRUPT_PRIORITY which this skill is able to override, defaults to ACTOR_STATE_INTERRUPT_PRIORITY.skill_interrupt_period]=] },
			{ name = [=[hold_facing_direction]=], description = [=[Whether this skill waill maintain the facing direction of the actor, typically skills with strafing]=] },
			{ name = [=[override_strafe_direction]=], description = [=[Force this skill to execute in the *moved* direction, even if the player is holding a skill where hold_facing_direction is true]=] },
			{ name = [=[ignore_aim_direction]=], description = [=[don't use the aiming direction]=] },
			{ name = [=[disable_aim_stall]=], description = [=[don't stall if activated in the opposite direction of movement]=] },
			{ name = [=[does_change_activity_state]=], description = [=[whetrher this skill changes the activity of the player, this allows the turn around to occur when activating a skill even if it was activated during another state which was interrupted]=] },
			
			-- Callbacks
			{ name = [=[on_can_activate]=], description = [=[When the skill checks if it can be activated (actor, ActorSkill, skill index)]=] },
			{ name = [=[on_activate]=], description = [=[Skill use callback (actor, ActorSkill, skill index)]=] },
			{ name = [=[on_step]=], description = [=[Called each frame while slotted (actor, ActorSkill, skill index)]=] },
			{ name = [=[on_equipped]=], description = [=[Called when the skill becomes slotted (actor, ActorSkill, skill index)]=] },
			{ name = [=[on_unequipped]=], description = [=[Called when the skill is no longer slotted (actor, ActorSkill, skill index)]=] },
			
			-- Misc
			{ name = [=[upgrade_skill]=], description = [=[Upgrade skill ID for ancient scepter (or undefined)]=] },
			--use_rapid_fire,			-- Whether the rapid fire accessibility option affects this skill
			
		},
		
		ACTIVITY_FLAG = {
			{ name = [=[allow_rope_cancel]=], value = 1 },
			{ name = [=[allow_aim_turn]=], value = 2 },
		},
		
		ACTOR_STATE_INTERRUPT_PRIORITY = {
			{ name = [=[any]=] },
			{ name = [=[skill_interrupt_period]=], description = [=[han-d z skill uses this to not interrupt itself]=] },
			{ name = [=[skill]=], description = [=[default]=] },
			{ name = [=[priority_skill]=] },
			{ name = [=[legacy_activity_state]=], description = [=[used by all 'activity' states not using the actorstate system]=] },
			{ name = [=[climb]=] },
			{ name = [=[pain]=] },
			{ name = [=[frozen]=] },
			{ name = [=[charge]=], description = [=[lemurian rider c charge]=] },
			{ name = [=[vehicle]=], description = [=[unused]=] },
			{ name = [=[burrowed]=], description = [=[tuber burrow]=] },
			{ name = [=[spawn]=] },
			{ name = [=[teleport]=] },
			
		},
		
		SKILL_OVERRIDE_PRIORITY = {
			{ name = [=[upgrade]=] },
			{ name = [=[boosted]=] },
			--lock, -- should handle distortion lock as a skill override with this priority
			{ name = [=[reload]=] },
			{ name = [=[cancel]=] },
		},
		
		CLASS_ITEM_LOG = {
			-- Identification
			{ name = [=[namespace]=], description = [=[Namespace]=] },
			{ name = [=[identifier]=], description = [=[Internal name string]=] },
			
			-- Language stuff
			{ name = [=[token_name]=], description = [=[Name of the log]=] },
			{ name = [=[token_description]=], description = [=[Item description]=] },
			{ name = [=[token_story]=], description = [=[Item lore]=] },
			{ name = [=[token_date]=], description = [=[Shipping estimated delivery]=] },
			{ name = [=[token_destination]=], description = [=[Shipping to location]=] },
			{ name = [=[token_priority]=], description = [=[Priority string ('fragile', 'volatile', etc)]=] },
			
			-- Misc
			{ name = [=[pickup_object_id]=], description = [=[Item pickup object]=] },
			{ name = [=[sprite_id]=], description = [=[Item's sprite]=] },
			{ name = [=[group]=], description = [=[ITEM_LOG_GROUP]=] },
			--shipping_number,
			
			-- Unlocks
			{ name = [=[achievement_id]=], description = [=[Undefined = no unlock]=] },
		
		},
		
		
		CLASS_ACTOR_STATE = {
			-- Identification
			{ name = [=[namespace]=], description = [=[Namespace]=] },
			{ name = [=[identifier]=], description = [=[Internal name string]=] },
			
			{ name = [=[on_enter]=], description = [=[[actor,data] Called when the state starts.]=] },
			{ name = [=[on_exit]=], description = [=[[actor,data] Guaranteed to be called even if the instsance is destroyed.]=] },
			{ name = [=[on_step]=], description = [=[[actor,data] Called each step.]=] },
			{ name = [=[on_get_interrupt_priority]=], description = [=[[actor,data] Called when attempting to use a skill to see if it can cancel this one]=] },
			
			{ name = [=[callable_serialize]=], description = [=[custom functions for writing / reading additional networked info]=] },
			{ name = [=[callable_deserialize]=] },
			
			{ name = [=[is_skill_state]=], description = [=[Used to determine whether this state should charge the Laser Turbine]=] },
			{ name = [=[is_climb_state]=], description = [=[Whether this state is a climbing state]=] },
			
			{ name = [=[activity_flags]=], description = [=[can cancel this state into climbing]=] },
			
		},
		
		CLASS_ACTOR_SKIN = {
			-- Identification
			{ name = [=[namespace]=], description = [=[Namespace]=] },
			{ name = [=[identifier]=], description = [=[Internal name string]=] },
			
			{ name = [=[effect_display]=], description = [=[Effectdisplay for this skin]=] },
			
			{ name = [=[draw_loadout_preview]=], description = [=[Callable -  sprite, subimage, x, y, xscale, yscale, active status (-1, 0, 1), survivor_id]=] },
			{ name = [=[get_skin_sprite]=], description = [=[Callable -  sprite, survivor_id, returns the palette swapped version of the sprite (eg. sCommandoPortrait -> sCommandoPortrait_PAL1 )]=] },
			{ name = [=[draw_skinnable_instance]=], description = [=[Callable -  inst, sprite, subimage, x, y, xscale, yscale, angle, color, alpha]=] },
			--
			--on_skin_assigned,		-- Called when skin is set		(actor)
			--on_skin_removed,		-- Called when skin is unset	(actor)
			
			{ name = [=[skin_type_index]=], description = [=[used for stuff like sparks sprite swaps]=] },
			
		},
		
		
		CLASS_SURVIVOR_LOG = {
			-- Identification
			{ name = [=[namespace]=], description = [=[Namespace]=] },
			{ name = [=[identifier]=], description = [=[Internal name string]=] },
			
			-- Language stuff
			{ name = [=[token_name]=], description = [=[Name of the log]=] },
			{ name = [=[token_story]=], description = [=[Survivor lore]=] },
			{ name = [=[token_id]=], description = [=[Traveller ID]=] },
			{ name = [=[token_departed]=] },
			{ name = [=[token_arrival]=] },
			
			-- Sprite
			{ name = [=[sprite_icon_id]=], description = [=[Sprite of the survivor's icon]=] },
			{ name = [=[sprite_id]=], description = [=[Sprite of the survivor in-game]=] },
			{ name = [=[portrait_id]=], description = [=[Big sprite of the survivor ]=] },
			{ name = [=[portrait_index]=], description = [=[Subimage of portrait to display]=] },
			
			-- Stats
			{ name = [=[stat_hp_base]=] },
			{ name = [=[stat_hp_level]=] },
			{ name = [=[stat_damage_base]=] },
			{ name = [=[stat_damage_level]=] },
			{ name = [=[stat_regen_base]=] },
			{ name = [=[stat_regen_level]=] },
			{ name = [=[stat_armor_base]=] },
			{ name = [=[stat_armor_level]=] },
			
			{ name = [=[survivor_id]=], description = [=[ID of the survivor it belongs to]=] },
		
		},
		
		CLASS_ENDING = {
			-- Identification
			{ name = [=[namespace]=], description = [=[Namespace]=] },
			{ name = [=[identifier]=], description = [=[Internal name string]=] },
			
			{ name = [=[primary_color]=], description = [=[Colour used to represent this ending]=] },
			{ name = [=[is_victory]=], description = [=[Whether this ending signifies the game was won]=] },
			
		},
		
		CLASS_ENVIRONMENT_LOG = {
			-- Identification
			{ name = [=[namespace]=], description = [=[Namespace]=] },
			{ name = [=[identifier]=], description = [=[Internal name string]=] },
			
			-- Language stuff
			{ name = [=[token_name]=], description = [=[Name of the log]=] },
			{ name = [=[token_story]=], description = [=[Environment lore]=] },
			
			{ name = [=[stage_id]=], description = [=[The stage this log corresponds to]=] },
			{ name = [=[display_room_ids]=], description = [=[array of room ids for the log menu display]=] },
			
			{ name = [=[initial_cam_x_1080]=] },
			{ name = [=[initial_cam_y_1080]=] },
			{ name = [=[initial_cam_x_720]=] },
			{ name = [=[initial_cam_y_720]=] },
			{ name = [=[initial_cam_alt_x_1080]=], description = [=[used for any variant >= 4 in-game]=] },
			{ name = [=[initial_cam_alt_y_1080]=] },
			{ name = [=[initial_cam_alt_x_720]=] },
			{ name = [=[initial_cam_alt_y_720]=] },
			
			{ name = [=[is_secret]=], description = [=[hidden if not unlocked, doesn't count towards 100%]=] },
			
			{ name = [=[spr_icon]=] },
			
		},
		
		CLASS_SURVIVOR = {
			-- Identification
			{ name = [=[namespace]=], description = [=[Namespace]=] },
			{ name = [=[identifier]=], description = [=[Internal name string]=] },
			
			-- Language stuff
			{ name = [=[token_name]=], description = [=[The survivor's name]=] },
			{ name = [=[token_name_upper]=], description = [=[The survivor's uppercase name]=] },
			{ name = [=[token_description]=], description = [=[The survivor's description]=] },
			{ name = [=[token_end_quote]=], description = [=[The survivor's victory end quote]=] },
			
			-- Loadout
			{ name = [=[skill_family_z]=], description = [=[Primary skills]=] },
			{ name = [=[skill_family_x]=], description = [=[Secondary skills]=] },
			{ name = [=[skill_family_c]=], description = [=[Utility skills]=] },
			{ name = [=[skill_family_v]=], description = [=[Special skills]=] },
			{ name = [=[skin_family]=], description = [=[Skins]=] },
			{ name = [=[all_loadout_families]=], description = [=[Array of all families for this survivor]=] },
			{ name = [=[all_skill_families]=], description = [=[Array of all families for this survivor that are displayed in the character select skills section]=] },
			
			-- Display
			{ name = [=[sprite_loadout]=], description = [=[The sprite in pod]=] },
			{ name = [=[sprite_title]=], description = [=[The sprite on the title (walk anim)]=] },
			{ name = [=[sprite_idle]=], description = [=[The idle sprite]=] },
			{ name = [=[sprite_portrait]=], description = [=[The big portrait sprite]=] },
			{ name = [=[sprite_portrait_small]=], description = [=[The small portrait sprite]=] },
			{ name = [=[sprite_palette]=], description = [=[The survivor's colour palette for displaying palette swap skins]=] },
			{ name = [=[sprite_portrait_palette]=], description = [=[above but for the portrait]=] },
			{ name = [=[sprite_loadout_palette]=], description = [=[above but for the loadout sprite]=] },
			{ name = [=[sprite_credits]=], description = [=[classic ror1 sprite for beating the game]=] },
			{ name = [=[primary_color]=], description = [=[Survivor's class colour]=] },
			{ name = [=[select_sound_id]=], description = [=[Survivor's character select screen sound]=] },
			
			{ name = [=[log_id]=], description = [=[Survivor log ID, or -1]=] },
			
			-- Unlock
			{ name = [=[achievement_id]=], description = [=[The achievement which unlocks this]=] },
			
			{ name = [=[_SURVIVOR_MILESTONE_FIELDS]=] },
			
			-- Callbacks
			{ name = [=[on_init]=], description = [=[Called when the survivor is set (player, initial set?)]=] },
			{ name = [=[on_step]=], description = [=[Called each frame (player)]=] },
			{ name = [=[on_remove]=], description = [=[Called when the player's survivor is set to something else (player)]=] },
			
			{ name = [=[is_secret]=], description = [=[If set to true, will only appear in character select if unlocked]=] },
			
			{ name = [=[cape_offset]=], description = [=[Offset for prophet's cape]=] },
			
		},
		
		CLASS_STAGE = {
			-- Identification
			{ name = [=[namespace]=], description = [=[Namespace]=] },
			{ name = [=[identifier]=], description = [=[Internal name string]=] },
			
			-- Strings
			{ name = [=[token_name]=], description = [=[Name of the stage]=] },
			{ name = [=[token_subname]=], description = [=[Subname, like "Ground Zero"]=] },
			
			-- Spawning
			{ name = [=[spawn_enemies]=], description = [=[ds_list of MonsterCards to spawn]=] },
			{ name = [=[spawn_enemies_loop]=], description = [=[ds_list of enemies added on loop]=] },
			{ name = [=[spawn_interactables]=], description = [=[ds_list of InteractableCards to spawn]=] },
			{ name = [=[spawn_interactables_loop]=], description = [=[ds_list of interactables added on loop]=] },
			{ name = [=[spawn_interactable_rarity]=], description = [=[ds_map of InteractableCard ID -> spawn """rarity"""]=] },
			{ name = [=[interactable_spawn_points]=], description = [=[director points for spawning interactables]=] },
			{ name = [=[allow_mountain_shrine_spawn]=], description = [=[Whether shrine of the mountain can spawn here]=] },
			{ name = [=[classic_variant_count]=], description = [=[Number of 'classic' variants - variant index will be limited from 0 to classic_variant_count-1 if 'new stages' is disabled]=] },
			{ name = [=[is_new_stage]=], description = [=[Will prevent the stage from being played if 'new stages' is disabled]=] },
			--allow_variance_roll, -- Whether this stage can be picked by the artifact of variance
			
			-- Rooms
			{ name = [=[room_list]=], description = [=[ds_list of the rooms that make up this stage]=] },
			
			-- Misc
			{ name = [=[music_id]=], description = [=[Audio ID of music which plays in this stage, may be undefined]=] },
			{ name = [=[teleporter_index]=], description = [=[Subimage of sTeleporterFake to use for the entrance teleporter]=] },
			{ name = [=[populate_biome_properties]=], description = [=[callable used to populate the biome properties for the titlescreen planet]=] },
			{ name = [=[log_id]=], description = [=[Environment log id for this stage]=] },
			
		},
		
		
		CLASS_ELITE_TYPE = {
			{ name = [=[namespace]=], description = [=[Namespace]=] },
			{ name = [=[identifier]=], description = [=[Internal name string ]=] },
			
			-- Language stuff
			{ name = [=[token_name]=], description = [=[The elite name / prefix (eg. "Volatile")]=] },
			
			-- Colours
			{ name = [=[palette]=], description = [=[Sprite of the elite's palette]=] },
			{ name = [=[blend_col]=], description = [=[Old-style blend coloura]=] },
			
			{ name = [=[healthbar_icon]=], description = [=[Sprite of the elite icon on the healthbar]=] },
			
			{ name = [=[effect_display]=], description = [=[EffectDisplay for this elite or undefined]=] },
			
			-- Callbacks
			{ name = [=[on_apply]=], description = [=[Fired when the elite type is applied to an enemy (actor)]=] },
			
		},
		
		
		CLASS_BUFF = {
			-- Identification
			{ name = [=[namespace]=], description = [=[Namespace]=] },
			{ name = [=[identifier]=], description = [=[Internal name string]=] },
			
			-- Buff icon
			{ name = [=[show_icon]=], description = [=[If false, then no icon is displayed for the buff]=] },
			{ name = [=[icon_sprite]=], description = [=[The buff's icon sprite (sBuffs)]=] },
			{ name = [=[icon_subimage]=], description = [=[The subimage of the sprite to display]=] },
			{ name = [=[icon_frame_speed]=], description = [=[Speed at which to animate (0 for no animation)]=] },
			{ name = [=[icon_stack_subimage]=], description = [=[Whether the subimage should be increased with each stack]=] },
			{ name = [=[draw_stack_number]=], description = [=[Whether to draw the stack number with text]=] },
			{ name = [=[stack_number_col]=], description = [=[Array of colours for stack numbers if draw_stack_number is true]=] },
			
			-- Stacking
			{ name = [=[max_stack]=], description = [=[The maximum stack, -1 for infinite, 1 for no stacking]=] },
			
			-- Callbacks
			{ name = [=[on_apply]=], description = [=[When the buff is added to an actor (actor)]=] },
			{ name = [=[on_remove]=], description = [=[When the buff is removed from an actor (actor)]=] },
			{ name = [=[on_step]=], description = [=[Each frame the buff is on an actor (actor)]=] },
			
			-- Misc
			{ name = [=[is_timed]=], description = [=[If false then the buff timer will not be used]=] },
			{ name = [=[is_debuff]=], description = [=[Whether the effect is considered negative]=] },
			{ name = [=[client_handles_removal]=], description = [=[Whether CLIENT or SERVER is reponsible for removing this buff]=] },
			
			{ name = [=[effect_display]=], description = [=[EffectDisplay for this buff or undefined]=] },
			
		},
		
		
		CLASS_MONSTER_LOG = {
			-- Identification
			{ name = [=[namespace]=], description = [=[Namespace]=] },
			{ name = [=[identifier]=], description = [=[Internal name string]=] },
			
			-- Language stuff
			{ name = [=[token_name]=], description = [=[Name of the log]=] },
			{ name = [=[token_story]=], description = [=[Monster lore]=] },
			
			-- Sprite
			{ name = [=[sprite_id]=], description = [=[Sprite of the enemy in-game]=] },
			{ name = [=[portrait_id]=], description = [=[Big sprite of the enemy (sPortrait)]=] },
			{ name = [=[portrait_index]=], description = [=[Subimage of portrait to display]=] },
			{ name = [=[sprite_offset_x]=], description = [=[Icon offset for logbook]=] },
			{ name = [=[sprite_offset_y]=] },
			{ name = [=[sprite_force_horizontal_align]=], description = [=[Forces the sprite (within the large log view) to be aligned to the left]=] },
			{ name = [=[sprite_height_offset]=], description = [=[Subtracted from the height of the sprite window (within the large log view)]=] },
		
			-- Stats
			{ name = [=[stat_hp]=], description = [=[Enemy's displayed health stat]=] },
			{ name = [=[stat_damage]=], description = [=[Enemy's displayed damage stat]=] },
			{ name = [=[stat_speed]=], description = [=[Enemy's displayed speed stat]=] },
		
			-- Misc
			{ name = [=[log_backdrop_index]=], description = [=[Inex of sUILogMonsterIconBack to use]=] },
			{ name = [=[object_id]=], description = [=[The log's book pickup]=] },
			{ name = [=[enemy_object_ids_kills]=], description = [=[Array of monster object IDs to track kills stats for]=] },
			{ name = [=[enemy_object_ids_deaths]=], description = [=[Array of monster object IDs to track deaths stats for]=] },
		
		},
		
		
		CLASS_ARTIFACT = {
			-- Identification
			{ name = [=[namespace]=], description = [=[Namespace]=] },
			{ name = [=[identifier]=], description = [=[Internal name string]=] },
			
			-- Language stuff
			{ name = [=[token_name]=], description = [=[Artifact's name (without 'artifact of', like 'Spite' or 'Kin')]=] },
			{ name = [=[token_pickup_name]=], description = [=[Artifact's pickup name (with 'artifact of', like 'Artifact of Glass')]=] },
			{ name = [=[token_description]=], description = [=[Artifact's description on the select screen]=] },
			
			-- Misc
			{ name = [=[loadout_sprite_id]=], description = [=[Artifact's loadout sprite]=] },
			{ name = [=[pickup_sprite_id]=], description = [=[Artifact's pickup sprite]=] },
			{ name = [=[on_set_active]=], description = [=[Callback (is_active)]=] },
			
			-- Run
			{ name = [=[active]=], description = [=[Whether the artifact is enabled]=] },
			
			-- Unlocks
			{ name = [=[achievement_id]=], description = [=[unlock]=] },
			
		},
		
		
		CLASS_DIFFICULTY = {
			-- Identification
			{ name = [=[namespace]=], description = [=[Namespace]=] },
			{ name = [=[identifier]=], description = [=[Internal name string]=] },
			
			-- Language stuff
			{ name = [=[token_name]=], description = [=[Difficulty's name]=] },
			{ name = [=[token_description]=], description = [=[Difficulty's description on the select screen]=] },
			
			-- Icon
			{ name = [=[sprite_id]=], description = [=[Difficulty's small sprite]=] },
			{ name = [=[sprite_loadout_id]=], description = [=[Difficulty's large sprite]=] },
			{ name = [=[primary_color]=], description = [=[The colour of the difficulty]=] },
			{ name = [=[sound_id]=], description = [=[Difficulty's selection sound]=] },
			
			-- Scaling
			{ name = [=[diff_scale]=], description = [=[Difficulty scaling per minute]=] },
			{ name = [=[general_scale]=], description = [=[Used for various things, 1, 2, 3 for built-in difficulties]=] },
			{ name = [=[point_scale]=], description = [=[Multiplier for points gained by director]=] },
			{ name = [=[is_monsoon_or_higher]=], description = [=[Whether this difficulty is considered equal or harder to monsoon (monsoon and eclipse)]=] },
				
			-- Enemies
			{ name = [=[allow_blight_spawns]=], description = [=[Whether to allow blighted enemies to spawn]=] },
			
		},
		
		
		CLASS_MONSTER_CARD = {
			-- Identification
			{ name = [=[namespace]=], description = [=[Namespace]=] },
			{ name = [=[identifier]=], description = [=[Internal name string]=] },
			
			-- Spawn info
			{ name = [=[spawn_type]=], description = [=[MONSTER_CARD_SPAWN_TYPE value]=] },
			{ name = [=[spawn_cost]=], description = [=[Point cost to spawn this enemy]=] },
			{ name = [=[object_id]=], description = [=[GM object to spawn the enemy as]=] },
			
			-- Flags
			{ name = [=[is_boss]=], description = [=[Whether the enemy should spawn as teleporter boss]=] },
			
			{ name = [=[is_new_enemy]=], description = [=[Setting this to true prevents spawning with new enemies disabled]=] },
			
			-- Elite info
			{ name = [=[elite_list]=], description = [=[List of available elite types]=] },
			{ name = [=[can_be_blighted]=], description = [=[Whether the enemy is allowed to spawn blighted]=] },
			
		},
		
		
		MONSTER_CARD_SPAWN_TYPE = {
			{ name = [=[classic]=] },
			{ name = [=[nearby]=] },
			{ name = [=[offscreen]=] },
			{ name = [=[origin]=] },
			
		},
		
		
		CLASS_INTERACTABLE_CARD = {
			-- Identification
			{ name = [=[namespace]=], description = [=[Namespace]=] },
			{ name = [=[identifier]=], description = [=[Internal name string]=] },
			
			-- Spawn info
			{ name = [=[spawn_cost]=], description = [=[Point cost to spawn]=] },
			{ name = [=[spawn_weight]=], description = [=[The weight of the object being selected, 6 for most objects]=] },
			{ name = [=[object_id]=], description = [=[The gm object to spawn]=] },
			{ name = [=[required_tile_space]=], description = [=[Number of tiles around the object to check for available space to spawn]=] },
			{ name = [=[spawn_with_sacrifice]=], description = [=[Whether the interactable is allowed to spawn with the artifact of Sacrifice enabled]=] },
			{ name = [=[is_new_interactable]=], description = [=[Setting this to true prevents spawning with new interactables disabled]=] },
			{ name = [=[default_spawn_rarity_override]=], description = [=[The rarity value of this interactable if not set in the stage ds_map]=] },
			{ name = [=[decrease_weight_on_spawn]=], description = [=[If set to true then it will remove itself from the director's spawn array when successfully spawned]=] },
			
		},
		
		CLASS_ACHIEVEMENT = {
			-- Identification
			{ name = [=[namespace]=], description = [=[Namespace]=] },
			{ name = [=[identifier]=], description = [=[Internal name string]=] },
			
			-- Language stuff
			{ name = [=[token_name]=], description = [=[Achievement's name token]=] },
			{ name = [=[token_desc]=], description = [=[The achievement's description (ex. "complete the first stage in under 5 minutes")]=] },
			{ name = [=[token_desc2]=], description = [=[Sub token for description, used by trials descriptions]=] },
			{ name = [=[token_unlock_name]=], description = [=[String token for the name of the thing that this unlocks]=] },
			
			-- Unlock info
			{ name = [=[unlock_kind]=], description = [=[ACHIEVEMENT_UNLOCK_KIND value]=] },
			{ name = [=[unlock_id]=], description = [=[ID of the unlocked thing]=] },
			{ name = [=[sprite_id]=], description = [=[Sprite of the unlocked thing]=] },
			{ name = [=[sprite_subimage]=], description = [=[Subimage of unlock sprite to display]=] },
			{ name = [=[sprite_scale]=], description = [=[Scale of the unlock icon sprite]=] },
			{ name = [=[sprite_scale_ingame]=], description = [=[Scale of the unlock icon sprite on the tiny unlock window]=] },
			{ name = [=[is_hidden]=], description = [=[Hides the achievement until it has been unlocked]=] },
			{ name = [=[is_trial]=], description = [=[Whether this is an unlock associated with a trial]=] },
			{ name = [=[is_server_authorative]=], description = [=[Whether the server controls unlocking this achievement (via achievement_progress_player)]=] },
			
			{ name = [=[milestone_alt_unlock]=], description = [=[Alt unlock type, one of SURVIVOR_MILESTONE_ID]=] },
			{ name = [=[milestone_survivor]=], description = [=[Survivor ID for the milestone if milestone_alt_unlock is set]=] },
			
			-- Progress
			{ name = [=[progress]=], description = [=[Current achievement progress]=] },
			{ name = [=[unlocked]=], description = [=[UNLOCK_STATUS]=] },
			
			-- Requirement info
			{ name = [=[parent_id]=], description = [=[The parent achievement]=] },
			{ name = [=[progress_needed]=], description = [=[Total needed progress to complete]=] },
			{ name = [=[death_reset]=], description = [=[Whether to clear pgoress between runs]=] },
			
			-- Misc
			{ name = [=[group]=], description = [=[ACHIEVEMENT_GROUP : group in highscore page]=] },
			
			-- Callbacks
			{ name = [=[on_completed]=], description = [=[Called when the achievement condition is met (no params)]=] },
			
		},
		
		
		ACHIEVEMENT_UNLOCK_KIND = {
			{ name = [=[none]=] },
			{ name = [=[mode]=] },
			{ name = [=[survivor]=] },
			{ name = [=[item]=] },
			{ name = [=[equipment]=] },
			{ name = [=[artifact]=] },
			{ name = [=[survivor_loadout_unlockable]=] },
			
		},
		
		ACHIEVEMENT_GROUP = {
			{ name = [=[challenge]=] },
			{ name = [=[character]=] },
			{ name = [=[artifact]=] },
			
		},
		
		
		CLASS_EQUIPMENT = {
			-- Identification
			{ name = [=[namespace]=], description = [=[Namespace]=] },
			{ name = [=[identifier]=], description = [=[Internal name string]=] },
			
			-- Language stuff
			{ name = [=[token_name]=], description = [=[Item pickup name]=] },
			{ name = [=[token_text]=], description = [=[Item pickup text]=] },
			
			-- Callbacks
			{ name = [=[on_use]=], description = [=[Fired on equipment use (player, embryo)]=] },
			
			{ name = [=[cooldown]=] },
			
			-- Misc
			{ name = [=[tier]=] },
			{ name = [=[sprite_id]=] },
			{ name = [=[object_id]=] },
			{ name = [=[item_log_id]=] },
			{ name = [=[achievement_id]=] },
			{ name = [=[effect_display]=] },
			{ name = [=[loot_tags]=], description = [=[LOOT_TAG bitflags]=] },
			{ name = [=[is_new_equipment]=], description = [=[Prevents the equipment from spawning if new items are disabled]=] },
			
		},
		
		
		CLASS_ITEM = {
			-- Identification
			{ name = [=[namespace]=], description = [=[Namespace]=] },
			{ name = [=[identifier]=], description = [=[Internal name string]=] },
			
			-- Language stuff
			{ name = [=[token_name]=], description = [=[Item pickup name]=] },
			{ name = [=[token_text]=], description = [=[Item pickup text]=] },
			
			-- Callbacks
			{ name = [=[on_acquired]=], description = [=[Fired on item added to the inventory (player, current stack)]=] },
			{ name = [=[on_removed]=], description = [=[Fired on item removed from the inventory (player, current stack)]=] },
			
			-- Misc
			{ name = [=[tier]=], description = [=[ITEM_TIER value]=] },
			{ name = [=[sprite_id]=], description = [=[Sprite for display on HUD]=] },
			{ name = [=[object_id]=], description = [=[Pickup object]=] },
			{ name = [=[item_log_id]=], description = [=[This item's item log ID]=] },
			{ name = [=[achievement_id]=], description = [=[The achievement that unlocks this item]=] },
			{ name = [=[is_hidden]=], description = [=[If true this item will not be displayed on the HUD]=] },
			{ name = [=[effect_display]=], description = [=[EffectDisplay for this item, or undefined]=] },
			{ name = [=[actor_component]=], description = [=[ActorComponent for this item, or undefined]=] },
			{ name = [=[loot_tags]=], description = [=[LOOT_TAG bitflags]=] },
			{ name = [=[is_new_item]=], description = [=[Prevents the item from dropping if new items are disabled]=] },
			
		},
		
		
		-- Tags that can be applied to items or equipment to filter rolls
		LOOT_TAG = {
			-- Category chest classifications
			{ name = [=[category_damage]=], value = (1 << 0) },
			{ name = [=[category_healing]=], value = (1 << 1) },
			{ name = [=[category_utility]=], value = (1 << 2) },
			-- Equipment, prevent rolling by Artifact of Enigma
			{ name = [=[equipment_blacklist_enigma]=], value = (1 << 3) },
			-- Equipment, prevent rolling by the Bottled Chaos item 
			{ name = [=[equipment_blacklist_chaos]=], value = (1 << 4) },
			-- Equipment, prevent rolling by the activator interactable
			{ name = [=[equipment_blacklist_activator]=], value = (1 << 5) },
			-- Item, prevent copying to engi turrets
			{ name = [=[item_blacklist_engi_turrets]=], value = (1 << 6) },
			-- Item, prevent rolling by the vendor interactable
			{ name = [=[item_blacklist_vendor]=], value = (1 << 7) },
			-- Item, allow this item to be rolled by the infuser shrine
			{ name = [=[item_whitelist_infuser]=], value = (1 << 8) },
		},
		
		LOOT_POOL_INDEX = {
			{ name = [=[common]=] },
			{ name = [=[uncommon]=] },
			{ name = [=[rare]=] },
			{ name = [=[equipment]=] },
			{ name = [=[boss]=] },
			{ name = [=[boss_equipment]=] },
			{ name = [=[food]=] },
		},
		
		ITEM_TIER = {
			{ name = [=[common]=] },
			{ name = [=[uncommon]=] },
			{ name = [=[rare]=] },
			{ name = [=[equipment]=] },
			{ name = [=[boss]=] },
			{ name = [=[special]=] },
			{ name = [=[food]=] },
			{ name = [=[notier]=] },
			
		},
		
		ITEM_STACK_KIND = {
			{ name = [=[normal]=], description = [=[standard item stacks]=] },
			
			{ name = [=[temporary_blue]=], description = [=[blue temp stacks]=] },
			{ name = [=[temporary_red]=], description = [=[red temp stacks]=] },
			
			{ name = [=[any]=], description = [=[combined]=] },
			{ name = [=[temporary_any]=], description = [=[combined red + blue stacks]=] },
			
		},
		
		
		CLASS_GAMEMODE = {
			-- Identification
			{ name = [=[namespace]=], description = [=[Namespace]=] },
			{ name = [=[identifier]=], description = [=[Internal name string]=] },
			{ name = [=[count_normal_unlocks]=], description = [=[Whether unlocks / stat tracking are disabled]=] },
			{ name = [=[count_towards_games_played]=], description = [=[Whether to count total games played + add to game history]=] },
			
		},
		
		
		
		
		
		
		
		ATTACK_TYPE = {
			{ name = [=[bullet]=] },
			{ name = [=[explosion]=] },
			{ name = [=[direct]=] },
			-- expanding this beyond 4 elements require updating read/write attackinfo
			-- they use 2 bits to encode this value
		},
		
		DAMAGE_INFLICT_FLAGS = {
			{ name = [=[ignore_armor]=], value = (1 << 0) },
			{ name = [=[nonlethal]=], value = (1 << 1) },
			{ name = [=[pierce_shield]=], value = (1 << 2) },
			{ name = [=[ignore_invincibility]=], value = (1 << 3) }
		
			-- these values are written to a byte with 3 other flags for networking
			-- if more then 5 flags exist then sync_damage packet will have to be changed accordingly
		},
		
		ATTACK_KILL_CAUSE_SPECIAL = {
			{ name = [=[none]=] },
			
			{ name = [=[spite]=] },
		},
		
		ATTACK_FLAG = {
			{ name = [=[cd_reset_on_kill]=], value = (1 << 0) },
			{ name = [=[inflict_poison_dot]=], value = (1 << 1) },
			{ name = [=[chef_ignite]=], value = (1 << 2) },
			   
			{ name = [=[stun_proc_ef]=], value = (1 << 3), description = [=[Concussion Grenade visual effect]=] },
			{ name = [=[knockback_proc_ef]=], value = (1 << 4), description = [=[Boxing Glove visual effect]=] },
				   
			{ name = [=[spawn_lightning]=], value = (1 << 5) },
				   
			{ name = [=[sniper_bonus_60]=], value = (1 << 6) },
			{ name = [=[sniper_bonus_30]=], value = (1 << 7) },
			
			{ name = [=[hand_steam_1]=], value = (1 << 8) },
			{ name = [=[hand_steam_5]=], value = (1 << 9) },
			
			{ name = [=[drifter_scrap_bit1]=], value = (1 << 10) },
			{ name = [=[drifter_scrap_bit2]=], value = (1 << 11) },
			{ name = [=[drifter_execute]=], value = (1 << 12) },
			
			{ name = [=[miner_heat]=], value = (1 << 13) },
			{ name = [=[commando_wound]=], value = (1 << 14) },
			{ name = [=[commando_wound_damage]=], value = (1 << 15) },
			
			{ name = [=[gain_skull_on_kill]=], value = (1 << 16) },
			{ name = [=[gain_skull_boosted]=], value = (1 << 17) },
			{ name = [=[chef_freeze]=], value = (1 << 18) },
			{ name = [=[chef_bigfreeze]=], value = (1 << 19) },
			{ name = [=[chef_food]=], value = (1 << 20) },
			
			{ name = [=[inflict_armor_strip]=], value = (1 << 21) },
			{ name = [=[inflict_flame_dot]=], value = (1 << 22) },
			{ name = [=[merc_afterimage_nodamage]=], value = (1 << 23) },
			
			{ name = [=[pilot_raid]=], value = (1 << 24) },
			{ name = [=[pilot_raid_boosted]=], value = (1 << 25) },
			
			{ name = [=[pilot_mine]=], value = (1 << 26) },
			
			{ name = [=[inflict_arti_flame_dot]=], value = (1 << 27) },
			{ name = [=[sawmerang]=], value = (1 << 28) },
			
			{ name = [=[force_proc]=], value = (1 << 29) },
		},
		
		ATTACK_TRACER_KIND = { -- this value gets encoded into a 6 bit number
			{ name = [=[none]=] },
			
			{ name = [=[wispg]=] },
			{ name = [=[wispg2]=] },
			
			{ name = [=[pilot_raid]=] },
			{ name = [=[pilot_raid_boosted]=] },
			{ name = [=[pilot_primary]=] },
			{ name = [=[pilot_primary_strong]=] },
			{ name = [=[pilot_primary_alt]=] },
			
			{ name = [=[commando1]=] },
			{ name = [=[commando2]=] },
			{ name = [=[commando3]=] },
			{ name = [=[commando3_r]=] },
			
			{ name = [=[sniper1]=] },
			{ name = [=[sniper2]=] },
			
			{ name = [=[engi_turret]=] },
			
			{ name = [=[enforcer1]=] },
			
			{ name = [=[robomando1]=] },
			{ name = [=[robomando2]=] },
			
			{ name = [=[bandit1]=] },
			{ name = [=[bandit2]=] },
			{ name = [=[bandit2_r]=] },
			{ name = [=[bandit3]=] },
			{ name = [=[bandit3_r]=] },
			
			{ name = [=[acrid]=] },
			
			{ name = [=[no_sparks_on_miss]=] },
			{ name = [=[end_sparks_on_pierce]=] },
			
			{ name = [=[drill]=] },
		
			{ name = [=[player_drone]=] },
		
		},
		
		
		
		
		
		
		
		-- global.class_callback contains an array of these
		CLASS_CALLBACK_CONTAINER = {
			{ name = [=[gml]=], description = [=[gml function to call if any]=] },
			{ name = [=[lua]=], description = [=[lua function ref to call if any (not useful for modding without official tools)]=] },
			{ name = [=[luaTypes]=], description = [=[arg types for conversion]=] },
			{ name = [=[returnType]=] },
		
		},
		
	}
	
}