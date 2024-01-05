-- Load the module
demo = require("./lib_debug", 5, 2)

print("Initializing", nil, 5, "", 5.00000)

demo.hello()

local myArray = gm.array_create(1, 1)

-- local my_file = io.open("thing.json", "a+")
-- my_file:write("hi")
-- log.info(_ENV["!plugins_data_mod_folder_path"])

-- for n in pairs(_G) do
-- 	log.info(n)
-- end

-- for n in pairs(mods["ReturnOfModding-DebugToolkit"]) do
    -- log.info(n)
-- end

-- local xd = gm.variable_instance_get_names(gm.variable_global_get("callback_name_to_id"))
local xd = gm.variable_global_get("callback_names")
for i = 1, #xd do
    print(i .. ": " .. xd[i])
end

gm.post_script_hook(gm.constants.callback_execute, function(self, other, result, args)
    -- local callback_type = xd[args[1].value]
    -- if callback_type ~= nil then
    --     print(callback_type.tostring)
    --     for i = 2, #args do
    --         print(args[i].tostring)
    --     end
    -- end
end)

local new_room = 0
local show_debug_overlay = true

function imgui_dump(cinstance)
    ImGui.Text("Instance ID: " .. cinstance.id)
    ImGui.Text("Position: " .. cinstance.x .. ", " .. cinstance.y)
    ImGui.Text("Gravity: " .. cinstance.gravity .. " (Direction: " .. cinstance.gravity_direction .. ")")
    ImGui.Text("Speed: " .. cinstance.speed)
    ImGui.Text("Object Name: " .. cinstance.object_name .. " (Index: " .. cinstance.object_index .. ")")

    local sprite_index = cinstance.sprite_index
    local sprite_name = gm.sprite_get_name(sprite_index)
    ImGui.Text("Sprite Name: " .. sprite_name ~= nil and sprite_name.tostring or "undefined" .. " (Index: " .. cinstance.sprite_index .. ")")

    local layer_id = cinstance.layer
    local layer_name = gm.layer_get_name(layer_id)
    ImGui.Text("Layer Name: " .. layer_name .. " (Index: " .. cinstance.layer .. ")")

    ImGui.Text("Depth: " .. cinstance.depth .. " | " .. cinstance.i_currentdepth)
end

local instance_var_to_input = {}
function imgui_dump_instance_variables(cinstance)
    local instance_variable_names = gm.variable_instance_get_names(cinstance.id)

    ImGui.Text("Instance Variable Count: " .. #instance_variable_names)

    for i = 1, #instance_variable_names do
        local variable_name = instance_variable_names[i].value
        local variable_identifier = variable_name .. cinstance.id

        if instance_var_to_input[variable_identifier] == nil then
            instance_var_to_input[variable_identifier] = gm.variable_instance_get(cinstance.id, variable_name)
        end

        local new_text_value, res = ImGui.InputText(variable_name .. "##input_text" .. variable_identifier, tostring(instance_var_to_input[variable_identifier]), 256)
        instance_var_to_input[variable_identifier] = new_text_value

        if ImGui.Button("Save##btn" .. variable_identifier) then
            local new_value = tonumber(new_text_value)
            if new_value ~= nil then
                gm.variable_instance_set(cinstance.id, variable_name, new_value)
            end
        end
    end
end

gui.add_imgui(function()
    local mouse_x = gm.variable_global_get("mouse_x")
    local mouse_y = gm.variable_global_get("mouse_y")
    if ImGui.Begin("Instance Under Cursor") then
        local instance_nearest = gm.instance_nearest(mouse_x, mouse_y, EVariableType.ALL)
        if instance_nearest ~= nil then
            ImGui.Text("Cursor (" .. mouse_x .. ", " .. mouse_y .. ")")
            ImGui.Separator()
            for i = 1, #gm.CInstance.instances_active do
                if gm.CInstance.instances_active[i].id == instance_nearest.id then
                    imgui_dump(gm.CInstance.instances_active[i])
                    ImGui.Separator()
    
                    break
                end
            end
        end
    end
    ImGui.End()

    if ImGui.Begin("Room") then
        local current_room = gm.variable_global_get("room")
        local current_room_name = gm.room_get_name(current_room)
        ImGui.Text("Current Room: " .. current_room_name .. "(" .. current_room .. ")")
        local input_new_room, b = ImGui.InputInt("New Room ID", new_room)
        new_room = input_new_room
        if ImGui.Button("Goto Room (Can Crash You)") then
            gm.room_goto(new_room)
        end
    end
    ImGui.End()

    if ImGui.Begin("Misc") then
        if ImGui.Button("Print mod info") then
            print(_ENV["!guid"])
            print(_ENV["!plugins_data_mod_folder_path"])
            print(_ENV["!plugins_mod_folder_path"])

            for n in pairs(mods[_ENV["!guid"]]) do
	            log.info(n)
            end 
        end

        if ImGui.Button("Lua Error On Purpose") then
            local ab= 5
            ab(10)
        end

        if ImGui.Button("Show/Hide GameMaker Debug Overlay") then
            gm.show_debug_overlay(show_debug_overlay)
            show_debug_overlay = not show_debug_overlay
        end

        if ImGui.Button("Spawn Wisp") then
            local depth = -200.0
            gm.instance_create_depth(mouse_x, mouse_y, depth, gm.constants.oWisp)
        end

        if ImGui.Button("Dump Wisp Sprite") then
            -- https://forum.gamemaker.io/index.php?threads/solved-sprite_save-is-not-saving-sprites.69622/
            -- https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Asset_Management/Sprites/Sprite_Manipulation/sprite_duplicate.htm
            -- https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Asset_Management/Sprites/Sprite_Manipulation/sprite_save.htm

            local sprite_var = gm.sprite_duplicate(gm.constants.sWispIdle)
            gm.sprite_save(sprite_var, 0, "wisp.png")
            -- This will save into %appdata%/Risk_of_Rain_Returns/wisp.png
        end

        if ImGui.Button("Create Survivor Entry") then
            gm.survivor_create("My", "SurvivorName")
        end

        if ImGui.Button("Test GML CRASH") then
            gm.survivor_create(41561151.0)
        end
		
		if ImGui.Button("Test Array") then
            local localArray = gm.array_create(2, 4)
            log.info(localArray.tostring)

            gm.gc_collect()

            log.info(localArray.tostring)

			-- log.info(myArray.tostring)
            -- print(collectgarbage("count"))
            -- print(collectgarbage("collect"))
            -- print(collectgarbage("count"))
            -- print(tostring(myArray))
			gm.array_push(myArray, 8)
			log.info(myArray.tostring)

            -- local bla = gm.array_create(2, 2)
            -- log.info(bla.tostring)
        end

        if ImGui.Button("Dump Constants") then
            gm._returnofmodding_constants_internal_.update_room_cache()

            local output = ""
            for type_name, type_table in pairs(gm.constants_type_sorted) do
                output = output .. "Type: " .. type_name .. "\n"
                for k, v in pairs(type_table) do
                    output = output .. tostring(k) .. "\t" .. tostring(v) .. "\n"
                end
                output = output .. "\n"
            end
            print(output)
        end

        if ImGui.Button("Dump Game Global Variables") then
            local game_globals = gm.variable_instance_get_names(EVariableType.GLOBAL)
            for i = 1, #game_globals do
                log.info(game_globals[i].tostring)
            end
            
            local game_instance_create = gm.variable_global_get("instance_create")
            log.info(game_instance_create.tostring)
            log.info(game_instance_create.type)
        end
    end
    ImGui.End()

    if ImGui.Begin("Player Object") then
        for i = 1, #gm.CInstance.instances_active do
            if gm.CInstance.instances_active[i].object_index == gm.constants.oP then
                if ImGui.Button("Hp") then
                    print(gm.CInstance.instances_active[i].user_name)
                end

                imgui_dump(gm.CInstance.instances_active[i])
                ImGui.Separator()
                imgui_dump_instance_variables(gm.CInstance.instances_active[i])

                break
            end
        end
    end
    ImGui.End()

    if ImGui.Begin("Active Instances") then
        for i = 1, #gm.CInstance.instances_active do
            imgui_dump(gm.CInstance.instances_active[i])
            ImGui.Separator()
        end
    end
    ImGui.End()
end)

gm.pre_code_execute(function(self, other, code, result, flags)
	-- log.info("GML Script: " .. code.name .. " (" .. code.index .. ")")
end)