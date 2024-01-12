survivor_setup = require("sarn-coolguy_setup/survivor_setup")

-- messing with these two is pretty fun.
local circle_increment = 15
local explosion_radius = 150

local angle_increment = 2 * math.pi / circle_increment
local current_explosion_angle_index = 1
local rotation_direction = 1  -- 1 for clockwise, -1 for counterclockwise
local timer_in_seconds = 0
local rotation_interval_in_seconds = 0.05 -- in seconds

local explosion_sprite = gm.constants.sLoaderExplode

local function delta_time_in_seconds()
    return gm.variable_global_get("delta_time") / 1000000
end

local function rotating_balls_step_logic(self)
    if self.class == survivor_setup.coolguy_id then
        -- do coolguy stuff
        if self.local_client_is_authority then -- don't call if this isn't our player
            timer_in_seconds = timer_in_seconds + delta_time_in_seconds()

            if timer_in_seconds >= rotation_interval_in_seconds then
                local angle = angle_increment * current_explosion_angle_index * rotation_direction
                local offset_x = explosion_radius * math.cos(angle)
                local offset_y = explosion_radius * math.sin(angle)
    
                gm._mod_attack_fire_explosion(
                    self.id,                -- owner
                    self.x + offset_x,       -- x position adjusted based on angle
                    self.y + offset_y,       -- y position adjusted based on angle
                    80, 32,                 -- width / height
                    4,                 -- damage
                    explosion_sprite, -- explosion sprite
                    gm.constants.sSparks14, -- sparks sprite
                    1
                )
    
                -- Increment the explosion index for the next frame
                current_explosion_angle_index = (current_explosion_angle_index % circle_increment) + 1

                timer_in_seconds = 0
            end
        end
    end
end

local function skill_primary_on_activation(self, actor_skill, skill_index)
    if self.class == survivor_setup.coolguy_id then
        -- do coolguy stuff
        if self.local_client_is_authority then -- don't call if this isn't our player
            rotation_direction = -rotation_direction
            explosion_sprite = explosion_sprite + 1
        end
    end
end

local callback_names = gm.variable_global_get("callback_names")
local on_player_init_callback_id = 0
local on_player_step_callback_id = 0
for i = 1, #callback_names do
    local callback_name = callback_names[i]
    if callback_name:match("onPlayerInit") then
        on_player_init_callback_id = i - 1
    end

    if callback_name:match("onPlayerStep") then
        on_player_step_callback_id = i - 1
    end
end

local pre_hooks = {}
gm.pre_script_hook(gm.constants.callback_execute, function(self, other, result, args)
    local callback_id = args[1].value
    if pre_hooks[callback_id] then
        return pre_hooks[callback_id](self, other, result, args)
    end

    return true
end)

local post_hooks = {}
gm.post_script_hook(gm.constants.callback_execute, function(self, other, result, args)
    local callback_id = args[1].value
    if post_hooks[callback_id] then
        post_hooks[callback_id](self, other, result, args)
    end
end)

post_hooks[on_player_step_callback_id] = function(self_, other, result, args)
    local self = args[2].value
    rotating_balls_step_logic(self)
end

local function get_random_sprite(sprite_str)
    local matches = {}
    local i = 1
    for k, v in pairs(gm.constants) do
        if k:match(sprite_str) then
            matches[i] = v
            i = i + 1
        end
    end

    if #matches > 0 then
        local randomed = math.random(1, #matches)
        -- print(randomed, matches[randomed])
        return matches[randomed]
    end

    return gm.constants.sCommandoWalk
end

local function setup_sprites(self)
    local survivors = gm.variable_global_get("class_survivor")
    if survivors ~= nil then
        self.sprite_idle        = get_random_sprite("Idle")
        self.sprite_walk        = get_random_sprite("Walk")
        self.sprite_jump        = get_random_sprite("Jump")
        self.sprite_jump_peak   = get_random_sprite("JumpPeak")
        self.sprite_fall        = get_random_sprite("Fall")
        self.sprite_climb       = get_random_sprite("Climb")
        self.sprite_death       = get_random_sprite("Death")
        self.sprite_decoy       = get_random_sprite("Decoy")
    end
end

local function setup_skills_callbacks()
    local primary = survivor_setup.coolguy.skill_family_z[0]
    if not pre_hooks[primary.on_activate] then
        pre_hooks[primary.on_activate] = function(self, other, result, args)
            skill_primary_on_activation(self)

            -- don't call orig
            return false
        end
    end
end

post_hooks[on_player_init_callback_id] = function(self, other, result, args)
    setup_sprites(self)

    setup_skills_callbacks()
end

local function print_name_of_object(object_id)
    for k, v in pairs(gm.constants) do
        if v == object_id then
            print(k .. ": " .. v)
        end
    end
end

-- print_name_of_object(survivor_setup.coolguy.sprite_title)
-- print_name_of_object(survivor_setup.coolguy.sprite_idle)

gui.add_to_menu_bar(function()
    if ImGui.BeginMenu("Debug Info") then
        ImGui.Text("explosion_sprite: " .. explosion_sprite)

        ImGui.EndMenu()
    end
end)