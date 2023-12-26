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

function new_browser_data(entry)
	local id = #browsers + 1
	browsers[id] = util.merge({},entry,{
		index = id,
		text = '',
		filter = ''
	})
end

function initial_entries()
	local entries = {
		entrify('globals',proxy.globals),
		entrify('instances_all',gm.CInstance.instances_all),
		entrify('instances_active',gm.CInstance.instances_active)
	}
	for i,e in ipairs(entries) do
		e.index = i
	end
	return { entries = entries }
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
		if s then return v end
	end
end

function entrify(k,v)
	local info = type(v)
	local type = nil
	if info == "table" then
		type = "key"
		info = "table[" .. #v .. "]"
	elseif info == "userdata" then
		info = get(v,"type_name")
		if get(v,"type") == RValueType.OBJECT then
			type = "key"
		elseif get(v,"type") == RValueType.ARRAY then
			local n = tostring(gm.array_length(v).value)
			n = n:sub(1,#n-2)
			v = v.array
			info = info .. "[" .. n .. "]"
			type = "index"
		elseif info == nil then
			if tostring(v):match('<') then
				type = "index"
				info = getmetatable(v).__name .. "[" .. #v .. "]"
			elseif getmetatable(v).__next then
				type = "key"
				info = getmetatable(v).__name
				local n = len(v)
				if n then info = info .. "[" .. n .. "]" end
			end
		--elseif get(v,"lua_value") ~= nil then
		--	info = info .. "(" .. tostring(v.lua_value) .. ")"
		else
			info = nil
		end
	--elseif info ~= "function" and info ~= "thread" then
	--	info = info .. "(" .. tostring(v) .. ")"
	else 
		info = nil
	end
	if info == nil then return end
	return {
		name = tostring(k),
		info = info,
		data = v,
		type = type
	}
end

do
	local unfold_type = {
		key = function(data)
			local entries = {}
			local i = 0
			for k,v in pairs(data) do
				local ed = entrify(k,v)
				if ed ~= nil then
					i = i + 1
					ed.index = i
					entries[i] = ed
				end
			end
			return entries
		end,
		index = function(data)
			local entries = {}
			local i = 0
			for k,v in ipairs(data) do
				local ed = entrify(k,v)
				if ed ~= nil then
					i = i + 1
					ed.index = i
					entries[i] = ed
				end
			end
			return entries
		end
	}
	
	function unfold(ed)
		if ed.frozen then return ed.frozen end
		if ed.unfold then return ed.unfold() end
		if ed.type then 
			local unfolder = unfold_type[ed.type]
			if unfolder then
				return unfolder(ed.data)
			end
		end
		return ed.entries
	end
end

function refresh(ed)
	if not ed.frozen then return end
	for _,ed in ipairs(ed.frozen) do
		refresh(ed.frozen)
	end
	ed.frozen = nil
end

function expand(ed)
	new_browser_data(ed)
end

function show_line(ed,ids,filter)
	ids = (ids and (ids .. '.') or '') .. ed.index
	local unfolded = ImGui.TreeNode("##Node" .. ids)
	if not unfolded and #filter > 0 then
		if not ed.name:match(filter) then
			ImGui.SameLine()
			ImGui.Text('...')
			return
		end
	end
	ed.path = ed.path or ed.name
	if ImGui.IsItemHovered() and ImGui.IsItemClicked(ImGuiMouseButton.Right) then
		expand(ed)
		log.info("expand")
	end
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
	if unfolded then
		local entries = unfold(ed)
		ed.frozen = entries
		if entries then
			for _,sd in ipairs(entries) do
				sd.path = ed.path .. '/' .. sd.name
				show_line(sd,ids,filter)
			end
		end
		ImGui.TreePop()
	end
end

function imgui_on_render()
	for bid,bd in pairs(browsers) do
		if bid == 1 and ImGui.Begin("Object Browser") or ImGui.Begin("Object Browser (" .. (bd.path or "???") .. ")", true) then
			bid = tostring(bid)
			local item_spacing_x, item_spacing_y = ImGui.GetStyleVar(ImGuiStyleVar.ItemSpacing)
			local frame_padding_x, frame_padding_y = ImGui.GetStyleVar(ImGuiStyleVar.FramePadding)
			local num, y_max, x_total, x_refresh = calculate_text_sizes('Refresh')
			local x,y = ImGui.GetContentRegionAvail()
			-- height of InputText == font_size + frame_padding.y
			-- and we're going to change frame_padding.y temporarily later on
			-- such that InputText's height == max y
			local y_input = y_max - ImGui.GetFontSize() - frame_padding_y 
			local x_input = x - x_total - item_spacing_x*num
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
			ImGui.SameLine()
			if ImGui.Button("Refresh##" .. bid) then
				refresh(bd)
			end
			ImGui.PushStyleColor(ImGuiCol.FrameBg, 0)
			if ImGui.BeginListBox("##Box" .. bid,x_box,y_box) then
				ImGui.PopStyleColor()
				for _,ed in ipairs(unfold(bd)) do
					show_line(ed,bid,bd.filter)
				end
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

new_browser_data(initial_entries())
gui.add_imgui(imgui_on_render)