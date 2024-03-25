local share_item_enabled = true
gui.add_to_menu_bar(function()
    local new_value, clicked = ImGui.Checkbox("Enable Share Item", share_item_enabled)
    if clicked then
        share_item_enabled = new_value
    end
end)

local function add_chat_message(text)
    gm.chat_add_message(gm["@@NewGMLObject@@"](gm.constants.ChatMessage, text))
end

local currently_giving = false
gm.post_script_hook(gm.constants.item_give, function(self, other, result, args)
    if share_item_enabled and not currently_giving then
        local actor = args[1].value

        if actor.object_index == gm.constants.oP then
            for i = 1, #gm.CInstance.instances_active do
                local inst = gm.CInstance.instances_active[i]
                if inst.object_index == gm.constants.oP and inst.id ~= actor.id then
                    local item_id = args[2].value
                    local count = args[3].value
                    local stack_kind = args[4].value
                    
                    currently_giving = true
                    add_chat_message("Giving item id " .. item_id .. " to " .. inst.user_name .. " (" .. inst.name .. ")")
                    gm.item_give(inst, item_id, count, stack_kind)
                    currently_giving = false
                end
            end
        end
    end
end)

gui.add_imgui(function()
    if ImGui.Begin("Share Item Debug") then
        if ImGui.Button("Give Gold") then
            for i = 1, #gm.CInstance.instances_active do
                local inst = gm.CInstance.instances_active[i]
                if inst.object_index == gm.constants.oP then
                    gm.drop_gold_and_exp(inst.x, inst.y, 500)
                    add_chat_message("Giving gold to " .. inst.user_name .. " (" .. inst.name .. ")")
                    break
                end
            end
        end

        ImGui.End()
    end
end)
