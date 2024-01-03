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

browsers = {}
details = {}
local unfolded = {}

local detail_filters = {
	0xFFFFFF20,
	0xFF20FFFF,
	0xFFFF20FF
}

local function create_browser(entry)
	local id = #browsers + 1
	browsers[id] = util.merge({},entry,{
		index = id,
		text = '',
		filter = ''
	})
end

local function create_details(entry)
	local id = #details + 1
	details[id] = util.merge({},entry,{
		index = id,
		text = '',
		filter = '',
		texts = {},
		tooltips = {},
		mode = 1
	})
end

root = {
	lua = _G,
	helpers = {},
	globals = proxy.globals,
	constants = proxy.constants,
	instances = {
		all = gm.CInstance.instances_all,
		active = gm.CInstance.instances_active
	}
}

local function root_entries()
	return { path = 'root', name = 'root', data = root, loop_type = pairs}
end

do
	local skill_family_id_register = setmetatable({},{__mode="k"})
	local skill_family_proxy_register = setmetatable({},{__mode="v"})
	
	local skill_family_meta = {
		__index = function(s,k)
			local id = skill_family_id_register[s]
			if k == "skill" then
				return hardcoded.class.class_skill[id["skill_id"].value]
			end
			return id[k]
		end,
		__newindex = function(s,k,v)
			id[k] = v
		end,
		__len = function(s)
			local id = skill_family_id_register[s]
			return #id
		end,
		__next = function(s,k)
			local id = skill_family_id_register[s]
			local j = k
			local k,v = next(id,k)
			if k == nil and id[j] ~= nil then
				return "skill", hardcoded.class.class_skill[id["skill_id"].value]
			end
			return k,v
		end,
		__pairs = function(s,k)
			local id = skill_family_id_register[s]
			return function(_,k)
				local j = k
				local k,v = next(id,k)
				if k == nil and id[j] ~= nil then
					return "skill", hardcoded.class.class_skill[id["skill_id"].value]
				end
				return k,v
			end,s,k
		end,
		__inext = function(s,k)
			local id = skill_family_id_register[s]
			return inext(id,k)
		end,
		__ipairs = function(s,k)
			local id = skill_family_id_register[s]
			return ipairs(id,k)
		end
	}

	function root.helpers.proxy_skill_family_element(id)
		local proxy = skill_family_proxy_register[id]
		if proxy then return proxy end
		proxy = setmetatable({},skill_family_meta)
		skill_family_id_register[proxy] = id
		skill_family_proxy_register[id] = proxy
        return proxy
    end
end

local get, len
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

local entrify
function entrify(k,v)
	local data_type = type(v)
	local rvalue_type = nil
	local object_type = nil
	local loop_type = nil
	local keys = nil
	local info = nil
	local meta = getmetatable(v)
	if data_type == "table" then
		loop_type = pairs
		info = meta and meta.__name or data_type
		local n = len(v)
		if n then info = "table[" .. n .. "]" end
	elseif data_type == "userdata" then
		rvalue_type = get(v,"type_name")
		if rvalue_type == "OBJECT" then
			local o = v.object
			object_type = get(o,"type_name")
			loop_type = pairs
			if object_type == "YYOBJECTBASE" then
				v = v.struct
				local n = math.floor(#v)
				info = "STRUCT" .. "[" .. n .. "]"
				local sid = v.skill_id
				sid = sid and sid.value
				if sid then
					keys = {k,'struct',{'root','helpers',"proxy_skill_family_element"}}
					v = root.helpers.proxy_skill_family_element(v)
				else
					keys = {k,'struct'}
				end
			else
				keys = {k,'object'}
				v = o
				info = object_type
			end
		elseif rvalue_type == "ARRAY" then
			local n = math.floor(gm.array_length(v).value)
			v = v.array
			info = rvalue_type .. "[" .. n .. "]"
			loop_type = ipairs
			keys = {k,'array'}
		elseif rvalue_type == nil then
			if tostring(v):match('<') then
				loop_type = ipairs
				info = meta.__name or data_type
				local n = math.floor(#v)
				info = info .. "[" .. n .. "]"
			elseif meta and meta.__next then
				loop_type = pairs
				info = meta.__name or data_type
				if info:match("CInstance") then
					info = v.object_name .." (" .. v.object_index .. " @ " .. v.id .. ")"
				end
				local n = len(v)
				if n then info = info .. "[" .. n .. "]" end
			end
		end
	end
	return {
		name = tostring(k),
		info = info,
		data = v,
		keys = keys or {k},
		loop_type = loop_type,
		data_type = data_type,
		rvalue_type = rvalue_type,
		object_type = object_type
	}
end

local excludedFieldNames = util.build_lookup{ "and", "break", "do", "else", "elseif", "end", "false", "for", "function", "if", "in", "local", "nil", "not", "or", "repeat", "return", "then", "true", "until", "while" }

local function tostring_literal(value)
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

local function tostring_vararg(...)
	local s = ""
	for _,v in util.vararg(...) do
		v = tostring_literal(v)
		s = s .. '\t' .. v
	end
	return s:sub(2,#s)
end

local function path_part_key(key)
	if type(key) == "string" then
		if excludedFieldNames[key] or not key:match("^[_%a][_%w]*$") then
			return '[' .. tostring_literal(key) .. ']' 
		end
		return '.' .. key
	end
	if type(key) == "number" then
		return '[' .. key .. ']' 
	end
end

local function path_part(ed,path)
	path = path or ''
	for _, key in ipairs(ed.keys) do
		if type(key) == "table" then
			-- build new path for a function to wrap over it
			local wrap = nil
			for _, k in ipairs(key) do
				if wrap then
					local part = path_part_key(k)
					if part == nil then part = "[?]" end
					wrap = wrap .. part
				else
					wrap = k
				end
			end
			path = wrap .. '(' .. path .. ')'
		else
			-- extend current path
			local part = path_part_key(key)
			if part == nil then return "<" .. ed.name .. ">" end
			path = path .. part
		end
	end
	return path
end

local function unfold(ed)
	if ed.entries then return ed.entries end
	ed.path = ed.path or path_part(ed)	
	local loop_type = ed.loop_type
	local entries = {}
	if loop_type then
		for k,v in loop_type(ed.data) do
			local sd = entrify(k,v)
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
		sd.path = path_part(sd,ed.path)
	end
	ed.entries = entries
	return entries
end

local function refresh(ed)
	if ed == nil then return end
	if ed.entries == nil then return end
	for _,ed in ipairs(ed.entries) do
		refresh(ed.entries)
	end
	ed.entries = nil
end

local render_details
do
	local function peval(text)
		local func = load("return " .. text)
		if not func then return nil end
		setfenv(func,_G)
		local status, value = pcall(func)
		if not status then return nil end
		return value
	end

	function render_details(dd,filter,did)
		local entries = unfold(dd)
		if entries then
			local skipped = false
			for _,sd in ipairs(entries) do
				if #filter ~= 0 and not sd.name:match(filter) then
					skipped = true
				else
					local id = did .. sd.path
					if sd.info then
						if dd.mode ~= 1 then 
							-- iterable
							ImGui.PushStyleColor(ImGuiCol.HeaderHovered,0)
							ImGui.PushStyleColor(ImGuiCol.HeaderActive,0)
							ImGui.Selectable("##Select" .. id, false)
							ImGui.PopStyleColor()
							ImGui.PopStyleColor()
							if ImGui.IsItemHovered() then
								if ImGui.IsItemClicked(ImGuiMouseButton.Middle) then
									create_browser(sd)
								end
								if ImGui.IsItemClicked(ImGuiMouseButton.Right) then
									create_details(sd)
								end
							end
							ImGui.PushStyleColor(ImGuiCol.Text, 0xFFFF20FF)
							ImGui.SameLine()
							ImGui.Text(sd.name)
							ImGui.PopStyleColor()
							ImGui.PushStyleColor(ImGuiCol.Text, 0xFF20FFFF)
							ImGui.SameLine()
							ImGui.Text(sd.info)
							ImGui.PopStyleColor()
						end
					else
						if dd.mode ~= 3 then
							-- not iterable
							ImGui.Text("")
							ImGui.SameLine()
							ImGui.PushStyleColor(ImGuiCol.Text, 0xFFFFFF20)
							ImGui.Text(sd.name)
							ImGui.PopStyleColor()
							if
								sd.data_type ~= "function" and sd.data_type ~= "thread" and
								(sd.rvalue_type == "UNDEFINED" or (sd.rvalue_type ~= nil and sd.data.lua_value ~= nil) or (sd.data_type ~= "userdata" and sd.data))
							then
								local value = sd.rvalue_type == nil and sd.data or sd.data.lua_value
								local value_text = tostring_literal(value)
								ImGui.SameLine()
								ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 0, 0)
								ImGui.PushStyleColor(ImGuiCol.FrameBg, 0)
								ImGui.PushStyleColor(ImGuiCol.Text, 0xFF20FFFF)
								ImGui.PushItemWidth(ImGui.GetContentRegionAvail() - ImGui.CalcTextSize('|'))
								local text, enter_pressed = ImGui.InputText("##Text" .. id, dd.texts[id] or value_text, 65535, ImGuiInputTextFlags.EnterReturnsTrue)
								ImGui.PopItemWidth()
								ImGui.PopStyleColor()
								ImGui.PopStyleColor()
								ImGui.PopStyleVar()
								if enter_pressed then
									dd.data[sd.key] = peval(text)
									dd.texts[id] = nil
								else
									dd.texts[id] = text
								end
							else
								ImGui.PushStyleColor(ImGuiCol.Text, 0xFF2020FF)
								ImGui.SameLine()
								ImGui.Text(tostring(sd.rvalue_type or sd.data))
								ImGui.PopStyleColor()
								if sd.data_type == "function" then
									ImGui.SameLine()
									ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 0, 0)
									ImGui.PushStyleColor(ImGuiCol.FrameBg, 0)
									ImGui.PushStyleColor(ImGuiCol.Text, 0xFF20FFFF)
									ImGui.Text("(")
									ImGui.SameLine()
									ImGui.PushItemWidth(ImGui.GetContentRegionAvail() - ImGui.CalcTextSize('(|)'))
									local text, enter_pressed = ImGui.InputText("##Text" .. id, dd.texts[id] or '', 65535, ImGuiInputTextFlags.EnterReturnsTrue)
									local tooltip = dd.tooltips[id]
									if tooltip and ImGui.IsItemHovered() then
										ImGui.PushStyleColor(ImGuiCol.Text, tooltip.color)
										ImGui.SetTooltip(tooltip.message);
										ImGui.PopStyleColor()
									end
									ImGui.PopItemWidth()
									ImGui.SameLine()
									ImGui.Text(")")
									ImGui.PopStyleColor()
									ImGui.PopStyleColor()
									ImGui.PopStyleVar()
									if enter_pressed then
										local result = table.pack(pcall(sd.data, peval(text)))
										if result.n > 1 then
											local color, message
											if result[1] then
												color = 0xFFFFFF20
												message = tostring_vararg(table.unpack(result, 2, result.n))
											else 
												color = 0xFF2020FF
												message = result[2]
											end
											dd.tooltips[id] = { message = message, color = color }
										end
										dd.texts[id] = nil
									else
										dd.texts[id] = text
									end
								end
							end
						end
					end
				end
			end
			if skipped then
				ImGui.Text("")
				ImGui.SameLine()
				ImGui.Text("...")
			end
		end
	end
end

local function render_tree(ed,filter,bid,ids)
	local root = ids == nil
	ids = (ids and (ids .. '.') or '') .. ed.index
	local show = ed.path ~= "root"
	local _unfolded = unfolded[ids] == true
	if show then
		ImGui.PushStyleColor(ImGuiCol.HeaderHovered,0)
		ImGui.PushStyleColor(ImGuiCol.HeaderActive,0)
		ImGui.Selectable("##Select" .. ids, false)
		ImGui.PopStyleColor()
		ImGui.PopStyleColor()
		if ImGui.IsItemHovered() then
			if not root and ImGui.IsItemHovered() and ImGui.IsItemClicked(ImGuiMouseButton.Left) then
				_unfolded = not _unfolded
			end
			if ImGui.IsItemClicked(ImGuiMouseButton.Middle) then
				create_browser(ed)
			end
			if ImGui.IsItemClicked(ImGuiMouseButton.Right) then
				create_details(ed)
			end
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
				if sd.info then 
					if not unfolded[ids .. '.' .. sd.index] and #filter ~= 0 and not sd.name:match(filter) then
						skipped = true
					else
						render_tree(sd,filter,bid,ids)
					end
				end
			end
			if skipped then
				ImGui.Text("")
				ImGui.SameLine()
				ImGui.Text("")
				ImGui.SameLine()
				ImGui.Text("...")
			end
		end
		if show then ImGui.TreePop() end
	end
end

local frame_period = 60
local frame_counter = 0

local function imgui_on_render()
	local should_refresh = false
	if frame_counter >= frame_period then
		frame_counter = 0
		should_refresh = true
	end
	frame_counter = frame_counter + 1
	for bid,bd in pairs(browsers) do
		local open
		if bid == 1 and ImGui.Begin("Object Browser") or ImGui.Begin("Object Browser##" .. bid, true) then
			local item_spacing_x, item_spacing_y = ImGui.GetStyleVar(ImGuiStyleVar.ItemSpacing)
			local frame_padding_x, frame_padding_y = ImGui.GetStyleVar(ImGuiStyleVar.FramePadding)
			local num, y_max, x_total, x_filter = calculate_text_sizes('Filter: ')
			local x,y = ImGui.GetContentRegionAvail()
			-- height of InputText == font_size + frame_padding.y
			-- and we're going to change frame_padding.y temporarily later on
			-- such that InputText's height == max y
			local x_input = x - x_total - item_spacing_x*num
			local y_box = y - y_max - item_spacing_y
			local x_box = x
			ImGui.Text("Filter: ")
			ImGui.SameLine()
			ImGui.PushItemWidth(x_input)
			ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 0, 0)
			ImGui.PushStyleColor(ImGuiCol.FrameBg, 0)
			local enter_pressed
			bd.text, enter_pressed = ImGui.InputText("##Text" .. bid, bd.text, 65535, ImGuiInputTextFlags.EnterReturnsTrue)
			ImGui.PopStyleColor()
			ImGui.PopStyleVar()
			ImGui.PopItemWidth()
			if enter_pressed then
				bd.filter = bd.text
			end
			if should_refresh then
				refresh(bd)
			end
			if bid ~= 1 then
				local path = bd.path or "???"
				y_box = y_box - y_max - item_spacing_y
				ImGui.Text("Path: ")
				ImGui.SameLine()
				ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 0, 0)
				ImGui.PushStyleColor(ImGuiCol.FrameBg, 0)
				ImGui.InputText("##Path" .. bid, path, #path, ImGuiInputTextFlags.ReadOnly)
				ImGui.PopStyleColor()
				ImGui.PopStyleVar()
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
	for did,dd in pairs(details) do
		if ImGui.Begin("Object Details##" .. did, true) then
			local item_spacing_x, item_spacing_y = ImGui.GetStyleVar(ImGuiStyleVar.ItemSpacing)
			local frame_padding_x, frame_padding_y = ImGui.GetStyleVar(ImGuiStyleVar.FramePadding)
			local num, y_max, x_total, x_swap, x_filter = calculate_text_sizes('    ','Filter: ')
			local x,y = ImGui.GetContentRegionAvail()
			-- height of InputText == font_size + frame_padding.y
			-- and we're going to change frame_padding.y temporarily later on
			-- such that InputText's height == max y
			local y_input = y_max - ImGui.GetFontSize() - frame_padding_y 
			local x_input = x - x_total - item_spacing_x*num
			local y_box = y - y_max - item_spacing_y
			local x_box = x
			ImGui.Text("Filter: ")
			ImGui.SameLine()
			ImGui.PushItemWidth(x_input)
			ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 0, 0)
			ImGui.PushStyleColor(ImGuiCol.FrameBg, 0)
			local enter_pressed
			dd.text, enter_pressed = ImGui.InputText("##Text" .. did, dd.text, 65535, ImGuiInputTextFlags.EnterReturnsTrue)
			ImGui.PopStyleColor()
			ImGui.PopStyleVar()
			ImGui.PopItemWidth()
			ImGui.PushStyleColor(ImGuiCol.Button, detail_filters[dd.mode])
			ImGui.SameLine()
			if ImGui.Button("    ##Swap" .. did) then
				dd.mode = dd.mode%#detail_filters + 1
			end
			ImGui.PopStyleColor()
			if enter_pressed then
				dd.filter = dd.text
			end
			if should_refresh then
				refresh(dd)
			end
			do
				local path = dd.path or "???"
				y_box = y_box - y_max - item_spacing_y
				ImGui.Text("Path: ")
				ImGui.SameLine()
				ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 0, 0)
				ImGui.PushStyleColor(ImGuiCol.FrameBg, 0)
				ImGui.InputText("##Path" .. did, path, #path, ImGuiInputTextFlags.ReadOnly)
				ImGui.PopStyleColor()
				ImGui.PopStyleVar()
			end
			ImGui.PushStyleColor(ImGuiCol.FrameBg, 0)
			if ImGui.BeginListBox("##Box" .. did,x_box,y_box) then
				ImGui.PopStyleColor()
				render_details(dd,dd.filter,did)
				ImGui.EndListBox()
			else
				ImGui.PopStyleColor()
			end
		else
			details[did] = nil
		end
		ImGui.End()
	end
end

create_browser(root_entries())
gui.add_imgui(imgui_on_render)