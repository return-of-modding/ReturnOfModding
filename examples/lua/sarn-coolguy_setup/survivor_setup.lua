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
                        return v[f.typ]
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
        namespace  = {idx=0,typ="tostring"},
        identifier = {idx=1,typ="tostring"},

        token_name = {idx=2,typ="tostring"},
        token_description = {idx=3,typ="tostring"},

        sprite     = {idx=4,typ="value"},
        subimage   = {idx=5,typ="value"},

        cooldown     = {idx=6,typ="value"},
        damage   = {idx=7,typ="value"},
        max_stock   = {idx=8,typ="value"},
        start_with_stock   = {idx=9,typ="value"},
        auto_restock   = {idx=10,typ="value"},
        required_stock   = {idx=11,typ="value"},
        require_key_press   = {idx=12,typ="value"},
        allow_buffered_input   = {idx=13,typ="value"},
        use_delay   = {idx=14,typ="value"},
        animation   = {idx=15,typ="value"},
        is_utility   = {idx=16,typ="value"},
        is_primary   = {idx=17,typ="value"},
        required_interrupt_priority   = {idx=18,typ="value"},
        hold_facing_direction   = {idx=19,typ="value"},
        override_strafe_direction   = {idx=20,typ="value"},
        ignore_aim_direction   = {idx=21,typ="value"},
        disable_aim_stall   = {idx=22,typ="value"},
        does_change_activity_state   = {idx=23,typ="value"},

        on_can_activate   = {idx=24,typ="value"},
        on_activate   = {idx=25,typ="value"},
        on_step   = {idx=26,typ="value"},
        on_equipped   = {idx=27,typ="value"},
        on_unequipped   = {idx=28,typ="value"},

        upgrade_skill   = {idx=29,typ="value"},
    })
    Survivor = gm_array_class("class_survivor", {
        namespace  = {idx=0,typ="tostring"},
        identifier = {idx=1,typ="tostring"},

        token_name = {idx=2,typ="tostring"},
        token_name_upper = {idx=3,typ="tostring"},
        token_description = {idx=4,typ="tostring"},
        token_end_quote = {idx=5,typ="tostring"},
        
        skill_family_z = {idx=6,decode=wrap_skill_family},
        skill_family_x = {idx=7,decode=wrap_skill_family},
        skill_family_c = {idx=8,decode=wrap_skill_family},
        skill_family_v = {idx=9,decode=wrap_skill_family},
        skin_family = {idx=10,decode=wrap_skill_family},
        all_loadout_families = {idx=11,decode=wrap_skill_family},
        all_skill_families = {idx=12,decode=wrap_skill_family},

        sprite_loadout        = {idx=13,typ="value"},
        sprite_title          = {idx=14,typ="value"},
        sprite_idle           = {idx=15,typ="value"},
        sprite_portrait       = {idx=16,typ="value"},
        sprite_portrait_small = {idx=17,typ="value"},

        primary_color         = {idx=22,typ="value"},
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
                key = key .. "["..tostring(k).."]"
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

    -- configure properties
    coolguy.sprite_loadout = gm.constants.sSelectCommando_PAL4
    coolguy.sprite_portrait = gm.constants.sCommandoPortrait_PAL4
    coolguy.sprite_portrait_small = gm.constants.sCommandoPortraitSmall_PAL5
    coolguy.primary_color = 0x70D19D -- gamemaker uses BBGGRR colour

    -- configure skills
    coolguy.skill_family_z[0].sprite = gm.constants.sMobSkills
    coolguy.skill_family_x[0].sprite = gm.constants.sMobSkills
    coolguy.skill_family_c[0].sprite = gm.constants.sMobSkills
    coolguy.skill_family_v[0].sprite = gm.constants.sMobSkills

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
                name = "Cool Attack",
                description = "blah blah blah"
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
