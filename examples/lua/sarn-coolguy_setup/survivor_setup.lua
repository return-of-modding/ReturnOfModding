if already_init then
    return survivor_setup
end
already_init = true

survivor_setup = {}

local function init()
    log.info("initialising coolguy...")
    
    -- for interacting with global arrays as classes
    local function gm_array_class(name, fields)
        local mt = {
            __index = function(t, k)
                local f = fields[k]
                if f then
                    local v = gm.array_get(t.arr, f.idx)
                    if f.typ then
                        return v
                    elseif f.decode then
                        return f.decode(v)
                    end
                    return v
                end
                return nil
            end,
            __newindex = function(t, k, v)
                local f = fields[k]
                if f then
                    if f.readonly then
                        error("field " .. k .. " is read-only")
                    else
                        return gm.array_set(t.arr, f.idx, v)
                    end
                else
                    error("setting unknown field " .. k)
                end
            end
        }
        return function(id)
            local class_arr = gm.variable_global_get(name)
            local arr = gm.array_get(class_arr, id)
            return setmetatable({id = id, arr = arr}, mt)
        end
    end

    local Skill, Survivor
    local skill_family_mt = {
        __index = function(t,k)
            if type(k) == "number" then
                if k >= 0 and k < gm.array_length(t.elements) then
                    -- the actual value in the array is a 'skill loadout unlockable' object, so get the skill id from it
                    return Skill(gm.variable_struct_get(gm.array_get(t.elements, k), "skill_id"))
                end
            end
            return nil
        end
    }
    local function wrap_skill_family(struct_loadout_family)
        -- too lazy to write a proper wrapper right now sorry
        local elements = gm.variable_struct_get(struct_loadout_family, "elements")
        return setmetatable({struct=struct_loadout_family, elements=elements}, skill_family_mt)
    end
    Skill = gm_array_class("class_skill", {
        namespace  = {idx=0},
        identifier = {idx=1},

        token_name = {idx=2},
        token_description = {idx=3},

        sprite     = {idx=4},
        subimage   = {idx=5},

        cooldown     = {idx=6},
        damage   = {idx=7},
        max_stock   = {idx=8},
        start_with_stock   = {idx=9},
        auto_restock   = {idx=10},
        required_stock   = {idx=11},
        require_key_press   = {idx=12},
        allow_buffered_input   = {idx=13},
        use_delay   = {idx=14},
        animation   = {idx=15},
        is_utility   = {idx=16},
        is_primary   = {idx=17},
        required_interrupt_priority   = {idx=18},
        hold_facing_direction   = {idx=19},
        override_strafe_direction   = {idx=20},
        ignore_aim_direction   = {idx=21},
        disable_aim_stall   = {idx=22},
        does_change_activity_state   = {idx=23},

        on_can_activate   = {idx=24},
        on_activate   = {idx=25},
        on_step   = {idx=26},
        on_equipped   = {idx=27},
        on_unequipped   = {idx=28},

        upgrade_skill   = {idx=29},
    })
    Survivor = gm_array_class("class_survivor", {
        namespace  = {idx=0},
        identifier = {idx=1},

        token_name = {idx=2},
        token_name_upper = {idx=3},
        token_description = {idx=4},
        token_end_quote = {idx=5},
        
        skill_family_z = {idx=6,decode=wrap_skill_family},
        skill_family_x = {idx=7,decode=wrap_skill_family},
        skill_family_c = {idx=8,decode=wrap_skill_family},
        skill_family_v = {idx=9,decode=wrap_skill_family},
        skin_family = {idx=10,decode=nil},
        all_loadout_families = {idx=11,decode=nil},
        all_skill_families = {idx=12,decode=nil},

        sprite_loadout        = {idx=13},
        sprite_title          = {idx=14},
        sprite_idle           = {idx=15},
        sprite_portrait       = {idx=16},
        sprite_portrait_small = {idx=17},
        sprite_palette = {idx=18},
        sprite_portrait_palette = {idx=19},
        sprite_loadout_palette = {idx=20},
        sprite_credits = {idx=21},
        primary_color         = {idx=22},
        select_sound_id         = {idx=23},

        log_id         = {idx=24},

        achievement_id         = {idx=25},

        on_init         = {idx=29},
        on_step         = {idx=30},
        on_remove         = {idx=31},

        is_secret         = {idx=32},

        cape_offset         = {idx=33},
    })

    -- for registering language strings
    -- these will get cleared if u load a new language...
    local language_map
    local function language_register(d, root)
        if language_map == nil then
            language_map = gm.variable_global_get("_language_map")
        end
        if root == nil then
            root = ""
        end
        for k, v in pairs(d) do
            local key = root
            if type(k) == "number" then
                key = key .. "[" .. tostring(k) .. "]"
            else
                if key ~= "" then
                    key = key .. "."
                end
                key = key .. tostring(k)
            end
            if type(v) == "table" then
                language_register(v, key)
            else
                gm.ds_map_set(language_map, key, tostring(v))
                --log.info(key .. ": " .. tostring(v))
            end
        end
    end

    survivor_setup.coolguy_id = gm.survivor_create("coolguymod", "coolguy")
    local coolguy = Survivor(survivor_setup.coolguy_id)
    local commando_survivor_id = 1
    local vanilla_survivor = Survivor(commando_survivor_id)
    survivor_setup.coolguy = coolguy

    -- configure properties
    coolguy.sprite_loadout = vanilla_survivor.sprite_loadout
    coolguy.sprite_title = vanilla_survivor.sprite_title
    coolguy.sprite_idle = vanilla_survivor.sprite_idle
    coolguy.sprite_portrait = vanilla_survivor.sprite_portrait
    coolguy.sprite_portrait_small = vanilla_survivor.sprite_portrait_small
    coolguy.sprite_palette = vanilla_survivor.sprite_palette
    coolguy.sprite_portrait_palette = vanilla_survivor.sprite_portrait_palette
    coolguy.sprite_loadout_palette = vanilla_survivor.sprite_loadout_palette
    coolguy.sprite_credits = vanilla_survivor.sprite_credits
    -- coolguy.primary_color = vanilla_survivor.primary_color
    coolguy.primary_color = 0x70D19D -- gamemaker uses BBGGRR colour

    coolguy.skin_family = vanilla_survivor.skin_family

    -- configure skills
    local skill_primary = coolguy.skill_family_z[0]
    skill_primary.sprite = gm.constants.sMobSkills

    skill_primary.cooldown = 0
    skill_primary.required_stock = 0
    skill_primary.require_key_press = true
    skill_primary.use_delay = 0

    skill_primary.on_can_activate = vanilla_survivor.skill_family_z[0].on_can_activate
    skill_primary.on_activate = vanilla_survivor.skill_family_z[0].on_activate

    coolguy.skill_family_x[0].sprite = gm.constants.sMobSkills
    coolguy.skill_family_c[0].sprite = gm.constants.sMobSkills
    coolguy.skill_family_v[0].sprite = gm.constants.sMobSkills

    coolguy.on_init = vanilla_survivor.on_init
    coolguy.on_step = vanilla_survivor.on_step
    coolguy.on_remove = vanilla_survivor.on_remove

    -- set up strings
    language_register{
        survivor = {
            coolguy = {
                name = "Cool Guy",
                nameUpper = "COOL GUY",
                description = "this is a cool guy to demonstrate how some stuff works",
                endQuote = "awwwwwwwwwwwww yeah"
            }
        },

        skill = {
            coolguyZ = {
                name = "Rotation Switch",
                description = "Switch around the Rotation of the BALLS"
            },
            coolguyX = {
                name = "Secondary move",
                description = "blah blah blah"
            },
            coolguyC = {
                name = "Utility Move",
                description = "blah blah blah"
            },
            coolguyV = {
                name = "Cool Special Move",
                description = "blah blah blah"
            }
        }
    }
end

local hooks = {}
hooks["gml_Object_oStartMenu_Step_2"] = function() -- mod init
    hooks["gml_Object_oStartMenu_Step_2"] = nil

    init()
end

gm.pre_code_execute(function(self, other, code, result, flags)
    if hooks[code.name] then
        hooks[code.name](self)
    end
end)

return survivor_setup
