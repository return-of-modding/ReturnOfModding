
-- assume we load later than ObjectBrowser due to alphabetical order
-- (optional dependency)
local browser = mods['ReturnOfModding-ObjectBrowser']

local sprites_path = _ENV["!plugins_data_mod_folder_path"] .. '/'

local sprites = {}
local sprite_text = ""

overrides = {}
originals = {}

function copy_sprite(gm_sprite)
	if originals[gm_sprite] then return gm_sprite end
	local sprite_copy = overrides[gm_sprite]
	if sprite_copy then return sprite_copy end
	sprite_copy =  gm.sprite_duplicate(gm_sprite)
	overrides[gm_sprite] = sprite_copy
	originals[sprite_copy] = gm_sprite
	return sprite_copy
end

local function copy_file(from,into)
	local lf = io.open(from)
	if not lf then return end
	local fc = lf:read()
	lf:close()
	local sf = io.open(into,"w")
	sf:write(fc)
	sf:close()
end

local calculate_text_sizes
do
	local calculate_text_sizes_x_buffer = {}
	function calculate_text_sizes(...)
		-- don't need to clear the buffer since 
		-- we only iterate over the region we overwrite
		local frame_padding_x, frame_padding_y = ImGui.GetStyleVar(ImGuiStyleVar.FramePadding)
		local frame_padding_x_2 = 2*frame_padding_x
		local frame_padding_y_2 = 2*frame_padding_y
		local my = 0 -- maximum y value in this row
		local sx = 0 -- sum of x values in this row
		local n -- number of items in this row
		for i,t in util.vararg(...) do
			n = i
			local x,y = ImGui.CalcTextSize(t)
			x = x + frame_padding_x_2
			y = y + frame_padding_y_2
			calculate_text_sizes_x_buffer[i] = x
			sx = sx + x
			if y > my then my = y end
		end
		return n, my, sx, table.unpack(calculate_text_sizes_x_buffer, 1, n)
	end
end

function save_by_gm_sprite(gm_sprite,path)
    local sprite_copy = copy_sprite(gm_sprite)
    return gm.sprite_save_strip(sprite_copy, path or sprites_path_save .. tostring(gm_sprite) .. '.png')
end

function load_by_gm_sprite(gm_sprite,path)
    local sprite_copy = copy_sprite(gm_sprite)
    local x_offset = gm.sprite_get_xoffset(sprite_copy)
    local y_offset = gm.sprite_get_yoffset(sprite_copy)
    local subimage_count = gm.sprite_get_number(sprite_copy)
    return gm.sprite_replace(sprite_copy,path or sprites_path_load .. tostring(gm_sprite) .. '.png', subimage_count, false, false, x_offset, y_offset)
end

function save_by_gm_sprite_name(gm_sprite_name,path)
    local gm_sprite = gm.constants[gm_sprite_name]
    local sprite_copy = copy_sprite(gm_sprite)
    return gm.sprite_save_strip(sprite_copy, path or sprites_path_save .. gm_sprite_name .. '.png')
end

function load_by_gm_sprite_name(gm_sprite_name,path)
    local gm_sprite = gm.constants[gm_sprite_name]
    local sprite_copy = copy_sprite(gm_sprite)
    local x_offset = gm.sprite_get_xoffset(sprite_copy)
    local y_offset = gm.sprite_get_yoffset(sprite_copy)
    local subimage_count = gm.sprite_get_number(sprite_copy)
    return gm.sprite_replace(sprite_copy,path or sprites_path_load .. gm_sprite_name .. '.png', subimage_count, false, false, x_offset, y_offset)
end

local function add_sprite(sprite,id)
	local id = id or (#sprites+1)
	local gm_sprite, gm_sprite_name
	if type(sprite) == "string" then
		gm_sprite_name = sprite
		gm_sprite = gm.constants[gm_sprite_name]
	else
		gm_sprite = sprite
		gm_sprite_name = proxy.constants.sprite[sprite].name
	end
	if not gm_sprite then return end
	local path = sprite .. '.png'
	local full_path = sprites_path .. path
	local sprite = {}
	sprite.index = id
	sprite.asset = gm_sprite
	sprite.name = gm_sprite_name
	sprite.path = path
	sprite.save = gm_sprite_name and function() return save_by_gm_sprite_name(gm_sprite_name,full_path) end or function() return save_by_gm_sprite(gm_sprite,full_path) end
	sprite.load = gm_sprite_name and function() return load_by_gm_sprite_name(gm_sprite_name,full_path) end or function() return load_by_gm_sprite(gm_sprite,full_path) end
	sprites[id] = sprite
	return sprite
end

local sprites_to_forget = {}

local function imgui_on_render()
	if ImGui.Begin("Sprite Manipulator") then
		local item_spacing_x, item_spacing_y = ImGui.GetStyleVar(ImGuiStyleVar.ItemSpacing)
		local frame_padding_x, frame_padding_y = ImGui.GetStyleVar(ImGuiStyleVar.FramePadding)
		local bot_num, bot_y_max, bot_x_total, x_focus = calculate_text_sizes("Sprite")
		local x,y = ImGui.GetContentRegionAvail()
		local x_input = x - bot_x_total - item_spacing_x*bot_num
		-- height of InputText == font_size + frame_padding.y
		-- and we're going to change frame_padding.y temporarily later on
		-- such that InputText's height == max y
		local y_input = bot_y_max - ImGui.GetFontSize() - frame_padding_y 
		local box_y = y - bot_y_max - item_spacing_y*2
		ImGui.PushItemWidth(x_input)
		ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, frame_padding_x, y_input)
		local enter_pressed
		sprite_text, enter_pressed = ImGui.InputText("Sprite", sprite_text, 65535, ImGuiInputTextFlags.EnterReturnsTrue)
		ImGui.PopStyleVar()
		ImGui.PopItemWidth()
		if enter_pressed then
			local status, number = pcall(tonumber,sprite_text)
			local sprite = add_sprite(status and number or sprite_text)
		end
		for sid,sd in ipairs(sprites) do
			ImGui.Text(sd.name)
			ImGui.SameLine()
			ImGui.Text(tostring(math.floor(sd.asset)))
			ImGui.SameLine()
			if ImGui.Button("Save##" .. sid) then
				sd.save()
			end
			ImGui.SameLine()
			if ImGui.Button("Load##" .. sid) then
				sd.load()
			end
			ImGui.SameLine()
			if ImGui.Button("X##" .. sid) then
				table.insert(sprites_to_forget,1,sid)
			end
		end
		for _,sid in ipairs(sprites_to_forget) do
			table.remove(sprites,sid)
		end
		util.clear(sprites_to_forget)
		ImGui.End()
	end
end

gui.add_imgui(imgui_on_render)