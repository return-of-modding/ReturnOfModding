local hooks = {}
hooks["gml_Object_oStartMenu_Step_2"] = function() -- mod init
    log.info("initialising coolguy...")
    hooks["gml_Object_oStartMenu_Step_2"] = nil

    local call = gm.call

    -- for interacting with global arrays as classes
    local function gm_array_class(name, fields)
        local mt = {
            __index = function(t, k)
                local f = fields[k]
                if f then
                    local v = call("array_get", t.arr, f.idx)
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
                        return call("array_set", t.arr, f.idx, v)
                    end
                else
                    error("setting unknown field " .. k)
                end
            end
        }
        return function(id)
            local class_arr = call("variable_global_get", name)
            local arr = call("array_get", class_arr, id)
            return setmetatable({id = id, arr = arr}, mt)
        end
    end

    local Skill, Survivor
    local skill_family_mt = {
        __index = function(t,k)
            if type(k) == "number" then
                if k >= 0 and k < call("array_length", t.elements).value then
                    -- the actual value in the array is a 'skill loadout unlockable' object, so get the skill id from it
                    return Skill(tonumber(call("variable_struct_get", call("array_get", t.elements, k), "skill_id").tostring))
                end
            end
            return nil
        end
    }
    local function wrap_skill_family(struct_loadout_family)
        -- too lazy to write a proper wrapper right now sorry
        local elements = call("variable_struct_get", struct_loadout_family, "elements")
        return setmetatable({struct=struct_loadout_family, elements=elements}, skill_family_mt)
    end
    Skill = gm_array_class("class_skill", {
        namespace  = {idx=0,typ="tostring"},
        identifier = {idx=1,typ="tostring"},

        sprite     = {idx=4,typ="value"},
        subimage   = {idx=5,typ="value"},
    })
    Survivor = gm_array_class("class_survivor", {
        namespace  = {idx=0,typ="tostring"},
        identifier = {idx=1,typ="tostring"},
        
        skill_family_z = {idx=6,decode=wrap_skill_family},
        skill_family_x = {idx=7,decode=wrap_skill_family},
        skill_family_c = {idx=8,decode=wrap_skill_family},
        skill_family_v = {idx=9,decode=wrap_skill_family},

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
            language_map = gm.call("variable_global_get", "_language_map").value
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
                call("ds_map_set", language_map, key, tostring(v))
                --log.info(key .. ": " .. tostring(v))
            end
        end
    end

    local coolguy_id = call("survivor_create", "coolguymod", "coolguy").value
    local coolguy = Survivor(coolguy_id)

    -- configure properties
    coolguy.sprite_loadout = call("asset_get_index", "sSelectCommando_PAL4")
    coolguy.sprite_portrait = call("asset_get_index", "sCommandoPortrait_PAL4")
    coolguy.sprite_portrait_small = call("asset_get_index", "sCommandoPortraitSmall_PAL5")
    coolguy.primary_color = 0x70D19D -- gamemaker uses BBGGRR colour

    -- configure skills
    coolguy.skill_family_z[0].sprite = call("asset_get_index", "sMobSkills")
    coolguy.skill_family_x[0].sprite = call("asset_get_index", "sMobSkills")
    coolguy.skill_family_c[0].sprite = call("asset_get_index", "sMobSkills")
    coolguy.skill_family_v[0].sprite = call("asset_get_index", "sMobSkills")

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

    -- can't hook into game callbacks yet, so this will do
    hooks["gml_Object_oP_Step_2"] = function(p)
        local id = p.i_id
        if call("variable_instance_get", id, "class").value == coolguy_id then
            -- do coolguy stuff
            if call("variable_instance_get", id, "local_client_is_authority").value > 0.5 then -- don't call if this isn't our player
                -- spawn a hitbox
                call("_mod_attack_fire_explosion",
                    id, -- owner
                    call("variable_instance_get", id, "x"),
                    call("variable_instance_get", id, "y"),
                    40, 32, -- width / height
                    -- 0.05, -- damage
                    400.05, -- damage
                    -1, --call("asset_get_index", "sLoaderExplode"), -- explosion sprite
                    call("asset_get_index", "sSparks14"), -- sparks sprite
                    1) -- procs?
            end
        end
    end
    --[[hooks["gml_Object_oP_Draw_0"] = function(p)
        local id = p.i_id
        
    end]]

end

gm.pre_code_execute(function(self, other, code, result, flags)
    -- wait for startmenu_step_2 to be called to init to be safe..
    if hooks[code.name] then
        hooks[code.name](self)
    end
end)