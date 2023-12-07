-- Load the module
demo = require("./lib_debug", 5, 2)

error("Initializing", nil, 5, "", 5.00000)

demo.hello()

-- for n in pairs(_G) do
-- 	log.info(n)
-- end

-- for n in pairs(mods["ReturnOfModding-DebugToolkit"]) do
    -- log.info(n)
-- end

local new_room = 0
local show_debug_overlay = true

function imgui_dump(cinstance)
    ImGui.Text("Instance ID: " .. cinstance.i_id)
    ImGui.Text("Position: " .. cinstance.i_x .. ", " .. cinstance.i_y)
    ImGui.Text("Gravity: " .. cinstance.i_gravity .. " (Direction: " .. cinstance.i_gravitydir .. ")")
    ImGui.Text("Speed: " .. cinstance.i_speed)
    ImGui.Text("Object Name: " .. cinstance.object_name .. " (Index: " .. cinstance.i_objectindex .. ")")

    local sprite_index = cinstance.i_spriteindex
    local sprite_name = gm.sprite_get_name(sprite_index)
    ImGui.Text("Sprite Name: " .. sprite_name.tostring .. " (Index: " .. cinstance.i_spriteindex .. ")")

    local layer_id = cinstance.m_nLayerID
    local layer_name = gm.layer_get_name(layer_id)
        ImGui.Text("Layer Name: " .. layer_name.tostring .. " (Index: " .. cinstance.m_nLayerID .. ")")

    ImGui.Text("Depth: " .. cinstance.i_depth .. " | " .. cinstance.i_currentdepth)
end

local instance_var_to_input = {}
function imgui_dump_instance_variables(cinstance)
    local instance_variable_names = gm.variable_instance_get_names(cinstance.i_id)

    if instance_variable_names.type == RValueType.ARRAY then
        local arr = instance_variable_names.array
        ImGui.Text("Instance Variable Count: " .. #arr)

        for i = 1, #arr do
            local variable_name = arr[i].tostring
            local variable_identifier = variable_name .. cinstance.i_id

            if instance_var_to_input[variable_identifier] == nil then
                instance_var_to_input[variable_identifier] = gm.variable_instance_get(cinstance.i_id, variable_name).tostring
            end

            local new_text_value, res = ImGui.InputText(variable_name .. "##input_text" .. variable_identifier, instance_var_to_input[variable_identifier], 256)
            instance_var_to_input[variable_identifier] = new_text_value

            if ImGui.Button("Save##btn" .. variable_identifier) then
                local new_value = tonumber(new_text_value)
                if new_value ~= nil then
                    gm.variable_instance_set(cinstance.i_id, variable_name, new_value)
                end
            end
        end
    end
end

gui.add_imgui(function()
    local mouse_x = gm.variable_global_get("mouse_x").value
    local mouse_y = gm.variable_global_get("mouse_y").value
    if ImGui.Begin("Instance Under Cursor") then
        local instance_nearest = gm.instance_nearest(mouse_x, mouse_y, EVariableType.ALL)
        ImGui.Text("Cursor (" .. mouse_x .. ", " .. mouse_y .. ")")
        ImGui.Separator()
        if instance_nearest.type == RValueType.REF then
            for i = 1, #gm.CInstance.instances_active do
                if gm.CInstance.instances_active[i].i_id == instance_nearest.value then
                    imgui_dump(gm.CInstance.instances_active[i])
                    ImGui.Separator()

                    break
                end
            end
        end
    end
    ImGui.End()

    if ImGui.Begin("Room") then
        local current_room = gm.variable_global_get("room").value
        local current_room_name = gm.room_get_name(current_room).tostring
        ImGui.Text("Current Room: " .. current_room_name .. "(" .. current_room .. ")")
        local input_new_room, b = ImGui.InputInt("New Room ID", new_room)
        new_room = input_new_room
        if ImGui.Button("Goto Room (Can Crash You)") then
            gm.room_goto(new_room)
        end
    end
    ImGui.End()

    if ImGui.Begin("Misc") then
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
            local wisp_object_index = 324
            gm.instance_create_depth(mouse_x, mouse_y, depth, wisp_object_index)
        end

        if ImGui.Button("Dump Sprite") then
            -- https://forum.gamemaker.io/index.php?threads/solved-sprite_save-is-not-saving-sprites.69622/
            -- https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Asset_Management/Sprites/Sprite_Manipulation/sprite_duplicate.htm
            -- https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Asset_Management/Sprites/Sprite_Manipulation/sprite_save.htm

            local sprite_var = gm.sprite_duplicate(858)
            gm.sprite_save(sprite_var, 0, "wisp.png")
            -- This will save into %appdata%/Risk_of_Rain_Returns/wisp.png
        end

        if ImGui.Button("Create Survivor Entry") then
            gm.survivor_create("My", "SurvivorName")
        end
		
		if ImGui.Button("Test Array") then
            local myArray = gm.array_create(1, 1)
			gm.array_push(myArray, 2)
			log.info(myArray.tostring)
        end
    end
    ImGui.End()

    if ImGui.Begin("Player Object") then
        for i = 1, #gm.CInstance.instances_active do
            if gm.CInstance.instances_active[i].object_name == "oP" then
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