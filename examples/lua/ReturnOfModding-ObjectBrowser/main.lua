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

browsers = {}
unfolded = {}

function new_browser_data(entry)
	local id = #browsers + 1
	browsers[id] = util.merge({},entry,{
		index = id,
		text = '',
		filter = ''
	})
end

function root_entries()
	return { path = 'root', name = 'root',
		data = function()
			return {
				entrify("globals",proxy.globals),
				entrify("instances_all",gm.CInstance.instances_all),
				entrify("instances_active",gm.CInstance.instances_active)
			}
		end
	}
end

do
	local function _get(t,k)
		return t[k]
	end
	
	local function _len(t)
		return #t
	end
	
	function get(t,k)
		local s,v = pcall(_get,t,k)
		if s then return v end
	end
	
	function len(t)
		local s,v = pcall(_len,t)
		if s then return math.floor(v) end
	end
end

function entrify(k,v)
	local data_type = type(v)
	local loop_type = nil
	local info = nil
	if data_type == "table" then
		loop_type = pairs
		local meta = getmetatable(v)
		info = meta and meta.__name or data_type
		local n = len(v)
		if n then info = "table[" .. n .. "]" end
	elseif data_type == "userdata" then
		local rvalue_type = get(v,"type_name")
		if rvalue_type == "OBJECT" then
			info = rvalue_type
			loop_type = pairs
		elseif rvalue_type == "ARRAY" then
			local n = math.floor(gm.array_length(v).value)
			v = v.array
			info = rvalue_type .. "[" .. n .. "]"
			loop_type = ipairs
		elseif rvalue_type == nil then
			if tostring(v):match('<') then
				loop_type = ipairs
				info = getmetatable(v).__name or data_type
				local n = math.floor(#v)
				info = info .. "[" .. n .. "]"
			elseif getmetatable(v).__next then
				loop_type = pairs
				info = getmetatable(v).__name or data_type
				local n = len(v)
				if n then info = info .. "[" .. n .. "]" end
			end
		end
	end
	if info == nil then return end
	return {
		name = tostring(k),
		info = info,
		data = v,
		key = k,
		unfolder = loop_type
	}
end

local excludedFieldNames = util.build_lookup{ "and", "break", "do", "else", "elseif", "end", "false", "for", "function", "if", "in", "local", "nil", "not", "or", "repeat", "return", "then", "true", "until", "while" }

local function tostring_literal(value)
	-- TODO: expand tables python-style?
	if type(value) == "string" then
		local lined, _lined = 0, value:gmatch("\n")
		for _ in _lined do lined = lined + 1 end
		local dquoted, _dquoted = 0, value:gmatch([=["]=])
		for _ in _dquoted do dquoted = dquoted + 1 end
		local squoted, _squoted = 0, value:gmatch([=[']=])
		for _ in _squoted do squoted = squoted + 1 end
		local edquoted, _edquoted = 0, value:gmatch([=[\"]=])
		if lined > 0 or (dquoted > 0 and squoted > 0) then
			local special, _special = 0, value:gmatch([=[[=]]=])
			for _ in _special do special = special + 1 end
			local eq = "="
			for i = 1, special do
				eq = eq .. '='
			end
			return '['..eq..'[' .. value .. ']'..eq..']'
		elseif squoted > 0 then
			return '"' .. value .. '"'
		else
			return "'" .. value .. "'"
		end
	end
	return tostring(value)
end

local function path_part(ed)
	local key = ed.key
	if type(key) == "string" then
		if excludedFieldNames[key] or not key:match("^[_%a][_%w]*$") then
			return '[' .. tostring_literal(key) .. ']' 
		end
		return '.' .. key
	end
	return "<" .. ed.name .. ">"
end

toggle_refresh = true

function unfold(ed)
	ed.path = ed.path or path_part(ed)	
	local unfolder = ed.unfolder
	local entries = {}
	if unfolder then
		for k,v in unfolder(ed.data) do
			sd = entrify(k,v)
			if sd ~= nil then
				table.insert(entries,sd)
			end
		end
	else
		for _,sd in ipairs(ed.data()) do
			table.insert(entries,sd)
		end
	end
	for i,sd in ipairs(entries) do
		sd.index = i
		sd.parent = ed
		sd.path = ed.path .. path_part(sd)
	end
	ed.entries = entries
	return entries
end

function refresh(ed)
	if ed == nil then return end
	if ed.entries == nil then return end
	for _,ed in ipairs(ed.entries) do
		refresh(ed.entries)
	end
	ed.entries = nil
end

function expand(ed)
	new_browser_data(ed)
end

function render_tree(ed,filter,bid,ids)
	ids = (ids and (ids .. '.') or '') .. ed.index
	local show = ed.path ~= "root"
	local _unfolded = unfolded[ids] == true
	if show then
		ImGui.Selectable("##Select" .. ids, false)
		if ImGui.IsItemHovered() and ImGui.IsItemClicked(ImGuiMouseButton.Left) then
			_unfolded = not _unfolded
		end
		if ImGui.IsItemHovered() and ImGui.IsItemClicked(ImGuiMouseButton.Right) then
			expand(ed)
		end
		unfolded[ids] = _unfolded
		ImGui.SetNextItemOpen(_unfolded)
		ImGui.SameLine()
		ImGui.TreeNode("##Node" .. ids)
		ImGui.PushStyleColor(ImGuiCol.Text, 0xFFFF20FF)
		ImGui.SameLine()
		ImGui.Text(ed.name)
		ImGui.PopStyleColor()
		if ed.info ~= nil then
			ImGui.PushStyleColor(ImGuiCol.Text, 0xFF20FFFF)
			ImGui.SameLine()
			ImGui.Text(ed.info)
			ImGui.PopStyleColor()
		end
	end
	if _unfolded then
		local entries = unfold(ed)
		if entries then
			local skipped = false
			for _,sd in ipairs(entries) do
				if not unfolded[ids .. '.' .. sd.index] and #filter ~= 0 and not sd.name:match(filter) then
					skipped = true
				else
					render_tree(sd,filter,bid,ids)
				end
			end
			if skipped then ImGui.Text("...") end
		end
		if show then ImGui.TreePop() end
	end
end

function imgui_on_render()
	for bid,bd in pairs(browsers) do
		if bid == 1 and ImGui.Begin("Object Browser") or ImGui.Begin("Object Browser (" .. (bd.path or "???") .. ")", true) then
			local item_spacing_x, item_spacing_y = ImGui.GetStyleVar(ImGuiStyleVar.ItemSpacing)
			local frame_padding_x, frame_padding_y = ImGui.GetStyleVar(ImGuiStyleVar.FramePadding)
			local num, y_max, x_total, x_pad = calculate_text_sizes('|')
			local x,y = ImGui.GetContentRegionAvail()
			-- height of InputText == font_size + frame_padding.y
			-- and we're going to change frame_padding.y temporarily later on
			-- such that InputText's height == max y
			local y_input = y_max - ImGui.GetFontSize() - frame_padding_y 
			local x_input = x --- x_total - item_spacing_x*num
			local y_box = y - y_max - item_spacing_y
			local x_box = x
			ImGui.PushItemWidth(x_input)
			ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, frame_padding_x, y_input)
			local enter_pressed
			bd.text, enter_pressed = ImGui.InputText("##Text" .. bid, bd.text, 65535, ImGuiInputTextFlags.EnterReturnsTrue)
			ImGui.PopStyleVar()
			ImGui.PopItemWidth()
			if enter_pressed then
				bd.filter = bd.text
			end
			ImGui.PushStyleColor(ImGuiCol.FrameBg, 0)
			if ImGui.BeginListBox("##Box" .. bid,x_box,y_box) then
				ImGui.PopStyleColor()
				unfolded[tostring(bid)] = true
				render_tree(bd,bd.filter,bid)
				ImGui.EndListBox()
			else
				ImGui.PopStyleColor()
			end
		else
			browsers[bid] = nil
		end
		ImGui.End()
	end
end

new_browser_data(root_entries())
gui.add_imgui(imgui_on_render)