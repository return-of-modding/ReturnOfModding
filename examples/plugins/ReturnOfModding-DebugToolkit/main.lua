-- Load the module
demo = require("./lib_debug", 5, 2)

print("Initializing", nil, 5, "", 5.00000)

demo.hello()

-- local myArray = gm.array_create(1, 1)

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
    ImGui.Text("Sprite Name: " .. sprite_name ~= nil and sprite_name or "undefined" .. " (Index: " .. cinstance.sprite_index .. ")")

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

        ImGui.End()
    end

    if ImGui.Begin("Room") then
        local current_room = gm.variable_global_get("room")
        local current_room_name = gm.room_get_name(current_room)
        ImGui.Text("Current Room: " .. current_room_name .. "(" .. current_room .. ")")
        local input_new_room, b = ImGui.InputInt("New Room ID", new_room)
        new_room = input_new_room
        if ImGui.Button("Goto Room (Can Crash You)") then
            gm.room_goto(new_room)
        end
        ImGui.End()
    end

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

        if ImGui.Button("Dump Sprite") then
            -- https://forum.gamemaker.io/index.php?threads/solved-sprite_save-is-not-saving-sprites.69622/
            -- https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Asset_Management/Sprites/Sprite_Manipulation/sprite_duplicate.htm
            -- https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Asset_Management/Sprites/Sprite_Manipulation/sprite_save.htm

            local sprite_var = gm.sprite_duplicate(gm.constants.sSniperWalk)
            local x_offset = gm.sprite_get_xoffset(gm.constants.sSniperWalk)
            local y_offset = gm.sprite_get_yoffset(gm.constants.sSniperWalk)
            local subimage_count = gm.sprite_get_number(sprite_var)
            for i = 0, subimage_count - 1 do
                gm.sprite_save(sprite_var, i, "sSniperWalk_" .. tostring(i) .. "_" .. string.format("%.0f", x_offset) .. "_" .. string.format("%.0f", y_offset) .. ".png")
            end
            -- This will save into %appdata%/Risk_of_Rain_Returns/ folder
        end

        if ImGui.Button("Add New Sprite") then
            local walk_spritesheet_file_path = _ENV["!plugins_data_mod_folder_path"] .. "/spritesheet_sniper_walk_blue.png"
            local new_sprite_index = gm.sprite_add(walk_spritesheet_file_path, 8, false, false, 11, 14)
            if new_sprite_index then
                print(new_sprite_index)
            end
        end

        if ImGui.Button("Create Survivor Entry") then
            gm.survivor_create("My", "SurvivorName")
        end

        if ImGui.Button("Test GML CRASH") then
            gm.survivor_create(41561151.0)
        end
		
		if ImGui.Button("Test Array") then
            local localArray = gm.array_create(2, 4)
            log.info(localArray)

            gm.gc_collect()

            log.info(localArray)

			-- log.info(myArray)
            -- print(collectgarbage("count"))
            -- print(collectgarbage("collect"))
            -- print(collectgarbage("count"))
            -- print(tostring(myArray))
			gm.array_push(myArray, 8)
			log.info(myArray)

            -- local bla = gm.array_create(2, 2)
            -- log.info(bla)
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
                log.info(game_globals[i])
            end
            
            local game_instance_create = gm.variable_global_get("instance_create")
            log.info(game_instance_create)
        end
        ImGui.End()
    end

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
        ImGui.End()
    end

    if ImGui.Begin("Active Instances") then
        for i = 1, #gm.CInstance.instances_active do
            imgui_dump(gm.CInstance.instances_active[i])
            ImGui.Separator()
        end
        ImGui.End()
    end
end)

-- gm.pre_code_execute(function(self, other, code, result, flags)
	-- log.info("GML Script: " .. code.name .. " (" .. code.index .. ")")
-- end)
-- gm.pre_code_execute(function(self, other, code, result, flags)
--     if hooks[code.name] then
--         hooks[code.name](self)
--     end

--     return true
-- end)


-- local my_file = io.open("thing.json", "a+")
-- my_file:write("hi")
-- log.info(_ENV["!plugins_data_mod_folder_path"])

-- for n in pairs(_G) do
-- 	log.info(n)
-- end

-- gui.add_always_draw_imgui(function()
--     if ImGui.IsMouseClicked(ImGuiMouseButton.Left) then
--         log.info("hi")
--     end
-- end)

-- for n in pairs(mods["ReturnOfModding-DebugToolkit"]) do
    -- log.info(n)
-- end

-- local callback_names = gm.variable_global_get("callback_names")
-- for i = 1, #xd do
--     print(i .. ": " .. xd[i])
-- end

local achievement_unlocker_enabled = false

local self_names = nil
local self_values = {}

local selected_elem = nil
local selected_elem_names = nil
local selected_elem_values = {}

local ui_shared_state = nil

-- gm.post_script_hook(gm.constants._ui_check_selected, function(self, other, result, args)
gm.post_script_hook(gm.constants.anon_gml_Object_oLogMenu_Other_14_55112214_gml_Object_oLogMenu_Other_14, function(self, other, result, args)
    self_names = gm.variable_instance_get_names(args[1].value)
    if self_names then
        for i = 1, #self_names do
            self_values[i] = args[1].value[self_names[i]]
        end    
    end

    ui_shared_state = gm.variable_global_get("_ui_shared_state")

    if ui_shared_state ~= nil then
        selected_elem = ui_shared_state.selected_element
    end

    if selected_elem then
        selected_elem_names = gm.variable_instance_get_names(selected_elem)
        for i = 1, #selected_elem_names do
            selected_elem_values[i] = selected_elem[selected_elem_names[i]]
        end
    end
end)

local currently_holding = false
local currently_holding_achiev_id = -1

local element_key_to_achiev_id = function (elem_key)
    return tonumber(selected_elem.key:sub(3))
end

gui.add_to_menu_bar(function()
    local new_value, clicked = ImGui.Checkbox("Achievement Unlocker", achievement_unlocker_enabled)
    if clicked then
        achievement_unlocker_enabled = new_value
    end
end)

gui.add_always_draw_imgui(function()
    if achievement_unlocker_enabled and ImGui.Begin("Achievement Unlocker (Challenges Tab)") then
        if selected_elem ~= nil and selected_elem.key then
            ImGui.Text("selected: " .. selected_elem.key)

            for i = 1, #selected_elem_names do
                ImGui.Text("selected: " .. selected_elem_names[i] .. ": " .. tostring(selected_elem_values[i]))
            end

            

            local achiev_id = element_key_to_achiev_id(selected_elem.key)
            if achiev_id ~= nil then
                ImGui.Text("selected key: " .. achiev_id)
            end
        end

        if self_names and self_values then
            for i = 1, #self_names do
                ImGui.Text("ui: " .. self_names[i] .. ": " .. tostring(self_values[i]))
            end
        end

        ImGui.End()
    end
end)

gui.add_always_draw_imgui(function()
    if achievement_unlocker_enabled and selected_elem ~= nil and selected_elem.key then

        local achiev_id = element_key_to_achiev_id(selected_elem.key)
        if achiev_id ~= nil then
            if selected_elem.held then
                currently_holding = true
                currently_holding_achiev_id = achiev_id
            end
    
            if selected_elem and currently_holding and selected_elem.held == false and currently_holding_achiev_id == achiev_id and achiev_id ~= nil then
                if gm.achievement_is_unlocked(achiev_id) then
    
                    gm.save_flag_set(gm.achievement_get_save_key_completed(achiev_id), 0.0)
                    gm.save_flag_set(gm.achievement_get_save_key_viewed(achiev_id), 0.0)
                    print("locked again " .. achiev_id)
                    gm.save_save()
                else
                    gm.achievement_add_progress(achiev_id, 1.0)
                    gm.save_flag_set(gm.achievement_get_save_key_completed(achiev_id), 1.0)
                    print("unlocked " .. achiev_id)
                    gm.save_save()
                end
    
                achiev_id = nil
                currently_holding_achiev_id = -1
            end
    
            if selected_elem.held == false then
                currently_holding = false
                selected_elem = nil
            end
        end
    end
end)

-- Inline tables: https://toml.io/en/v1.0.0#inline-table
local inlineTable = {
	a = 1275892,
	b = "Hello, World!",
	c = true,
	d = 124.2548,
}

-- Make the table inline.
setmetatable(inlineTable, { inline = true })

local table = {
	e = {
		f = { 1, 2, 3, "4", 5.142 },
		g = toml.Date.new(1979,   05,     27),
		--                year   month   day

		h = toml.Time.new( 7,     32,      0,        0),
		--                hour   minute  second   nanoSecond

		i = toml.DateTime.new(
			toml.Date.new(1979, 05, 27),
			toml.Time.new(7, 32, 0, 0),

			toml.TimeOffset.new(  -7,     0)
			--                   hour   minute
		)
	},
	inlineTable = inlineTable
}

-- Encode to string
local succeeded, documentOrErrorMessage = pcall(toml.encode, table)

print(documentOrErrorMessage)

mods.on_all_mods_loaded(function ()
    print("all mod loaded.")
end)