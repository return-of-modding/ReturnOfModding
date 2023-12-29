return {

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
		
	},
	
}