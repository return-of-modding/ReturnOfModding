survivor_setup = require("sarn-coolguy_setup/survivor_setup")

local coolguy = survivor_setup.coolguy
if coolguy ~= nil then
    local survivors = gm.variable_global_get("class_survivor")

    local function set_family_info(surv_skin_family)
        local skin_structs = gm.variable_instance_get(surv_skin_family, "elements")
        local new_struct = gm.struct_create()
        -- local new_struct = gm.array_get(skin_structs, 1)
        gm.struct_set(new_struct, "index", 57)
        gm.struct_set(new_struct, "skin_id", 1)
        gm.struct_set(new_struct, "achievement_id", -1)
        gm.array_push(skin_structs, new_struct)
    end

    local function print_family_info(surv_skin_family)
        local skin_structs = gm.variable_instance_get(surv_skin_family, "elements")
        local skin_struct_fields_names = gm.variable_instance_get_names(skin_structs[1])
        for j = 1, #skin_structs do
            for i = 1, #skin_struct_fields_names do
                local variable_value = gm.variable_instance_get(skin_structs[j], skin_struct_fields_names[i]) or "nil"
                print("["..i.."] " .. skin_struct_fields_names[i] .. ": " .. variable_value)
            end
        end
    end

    local survivor = survivors[3]
    log.warning(survivor[2] .. ".skin_family")
    -- set_family_info(survivor[11])
    print_family_info(survivor[11])
    log.warning("coolguy.skin_family")
    print_family_info(coolguy.skin_family)

    log.warning(survivor[17])
    log.warning(coolguy.namespace)
end

local hooks = {}

-- messing with these two is pretty fun.
local num_explosions = 50
local explosion_radius = 150

local angle_increment = 2 * math.pi / num_explosions
local current_explosion_angle_index = 1
local rotation_direction = 1  -- 1 for clockwise, -1 for counterclockwise
local timer_in_seconds = 0
local rotation_interval_in_seconds = 10  -- in seconds

local function delta_time_in_seconds()
    return gm.variable_global_get("delta_time") / 1000000
end

-- can't hook into game callbacks yet, so this will do
hooks["gml_Object_oP_Step_2"] = function(self)
    if self.class == survivor_setup.coolguy_id then
        -- do coolguy stuff
        if self.local_client_is_authority then -- don't call if this isn't our player
            timer_in_seconds = timer_in_seconds + delta_time_in_seconds()

            if timer_in_seconds >= rotation_interval_in_seconds then
                -- Switch rotation direction
                rotation_direction = -rotation_direction
                timer_in_seconds = 0
                log.info("switched direction!")
            end

            local angle = angle_increment * current_explosion_angle_index * rotation_direction
            local offset_x = explosion_radius * math.cos(angle)
            local offset_y = explosion_radius * math.sin(angle)

            gm._mod_attack_fire_explosion(
                self.id,                -- owner
                self.x + offset_x,       -- x position adjusted based on angle
                self.y + offset_y,       -- y position adjusted based on angle
                80, 32,                 -- width / height
                400.05,                 -- damage
                gm.constants.sLoaderExplode, -- explosion sprite
                gm.constants.sSparks14, -- sparks sprite
                1
            )

            -- Increment the explosion index for the next frame
            current_explosion_angle_index = (current_explosion_angle_index % num_explosions) + 1
        end
    end
end

gm.pre_code_execute(function(self, other, code, result, flags)
    if hooks[code.name] then
        hooks[code.name](self)
    end

    return true
end)