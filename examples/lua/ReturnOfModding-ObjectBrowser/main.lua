colors = {
	tree = 0xFFFF20FF,
	leaf = 0xFFFFFF20,
	info = 0xFF20FFFF,
	fake = 0xEECCCCCC,
	null = 0xFF2020FF
}

root = {
	lua = _G,
	gm = gm,
	mods = mods,
	colors = colors,
	helpers = {},
	globals = proxy.globals,
	constants = proxy.constants,
	hardcoded = hardcoded,
}

local filter_modes_browser = {
	"tree",
	"info"
}

local filter_modes_details = {
	"leaf",
	"info"
}

browsers = {}
details = {}
local unfolded = {}

local function create_browser(entry)
	local id = #browsers + 1
	unfolded[id..'|root'] = true
	browsers[id] = util.merge({
		index = id,
		filter_text = '',
		filter = '',
		texts = {},
		tooltips = {},
		mode = 1
	},entry)
end

local function create_details(entry)
	local id = #details + 1
	details[id] = util.merge({
		index = id,
		filter_text = '',
		filter = '',
		texts = {},
		tooltips = {},
		mode = 1
	},entry)
end

local function root_entries()
	return { data = root, iter = pairs, chain = {}, funcs = {},
		path = 'root', name = 'root', show = 'root', text = 'root'}
end

function root.helpers.int_to_hex(i)
	return '0x' .. string.format("%x", i):upper()
end

function root.helpers.get_skin_by_id(id)
	if type(id) ~= "number" or id < 0 then return nil end
	return hardcoded.class.class_actor_skin(id)
end

function root.helpers.get_skill_by_id(id)
	if type(id) ~= "number" or id < 0 then return nil end
	return hardcoded.class.class_skill(id)
end

function root.helpers.get_achievement_by_id(id)
	if type(id) ~= "number" or id < 0 then return nil end
	return hardcoded.class.class_achievement(id)
end

local excludedFieldNames = util.build_lookup{ 
	"and", "break", "do", "else", "elseif", "end",
	"false", "for", "function", "if", "in", "local",
	"nil", "not", "or", "repeat", "return", "then",
	"true", "until", "while", "goto", "repeat", "until"
}

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
	path = (path or '')
	if ed.name then
		path = path .. path_part_key(ed.name)
	end
	if ed.keys then
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
				if part == nil then return "<" .. ed.show or '???' .. ">" end
				path = path .. part
			end
		end
	end
	return path
end

local entrify
do
	-- to avoid making these many times
	local keys_hex = {{'root','helpers','int_to_hex'}}
	local keys_map = {{'proxy','map'}}
	local keys_list = {{'proxy','list'}}
	local keys_variables = {{'proxy','variables'}}
	local keys_struct = {{'proxy','struct'}}
	local keys_struct_skin = {{'root','helpers','get_skin_by_id'}}
	local keys_struct_skill = {{'root','helpers','get_skill_by_id'}}
	local keys_struct_achievement = {{'root','helpers','get_achievement_by_id'}}
	
	local extra = {}
	
	function entrify(name,data,base)
		util.clear(extra)
		local data_type, sol_type = type(data)
		local type_name = sol_type or data_type
		local iter = nil
		local keys = nil
		local info = nil
		local func = nil
		if base ~= nil and base.type and (data_type == "number" or data_type == "nil") then
			if name == "id" and base.type:match('instance') then
				table.insert(extra,{
					func = proxy.variables,
					base = base,
					name = name,
					show = "variables",
					keys = keys_variables,
					iter = pairs
				})
			elseif name == "skin_id" and base.type:match('Struct') then
				table.insert(extra,{
					func = root.helpers.get_skin_by_id,
					base = base,
					name = name,
					show = "skin",
					keys = keys_struct_skin,
					iter = pairs,
				})
			elseif name == "skill_id" and base.type:match('Struct') then
				table.insert(extra,{
					func = root.helpers.get_skill_by_id,
					base = base,
					name = name,
					show = "skill",
					keys = keys_struct_skill,
					iter = pairs,
				})
			elseif name == "achievement_id" and base.type:match('Struct') then
				table.insert(extra,{
					func = root.helpers.get_achievement_by_id,
					base = base,
					name = name,
					show = "achievement",
					keys = keys_struct_achievement,
					iter = pairs,
				})
			elseif base.base and base.name == "colors" and base.base.name == "root" then
				table.insert(extra,{
					func = root.helpers.int_to_hex,
					base = base,
					name = name,
					show = "hex",
					keys = keys_hex,
				})
			elseif type(name) == "string" and name:sub(#name-3) == "_map" then
				table.insert(extra,{
					func = proxy.map,
					name = name,
					show = 'data',
					keys = keys_map,
					iter = pairs,
				})
			elseif type(name) == "string" and name:sub(#name-4) == "_list" then
				table.insert(extra,{
					func = proxy.list,
					name = name,
					show = 'data',
					keys = keys_list,
					iter = ipairs,
				})
			end
		elseif data_type == "table" then
			iter = pairs
		elseif sol_type then
			if sol_type:match("Object") then
				iter = pairs
				if data.type == YYObjectBaseType.YYOBJECTBASE then
					func = proxy.struct
					keys = keys_struct
				end
			elseif sol_type:match("Array") then
				iter = ipairs
			elseif tostring(data):match('unordered_map') then
				iter = pairs
			elseif tostring(data):match('<') then -- span or container
				iter = ipairs
			elseif sol_type and sol_type:match("Instance") then
				iter = pairs
				info = data.object_name .." (" .. data.object_index .. " @ " .. data.id .. ")"
			end
		end
		local ed = {
			fake = false,
			info = info,
			base = base,
			func = func,
			name = name,
			keys = keys,
			iter = iter
		}
		if func == nil then ed.data = data end
		for _,sd in ipairs(extra) do
			sd.fake = true
			if not sd.base then sd.base = ed end
		end
		return ed, table.unpack(extra)
	end
end

local function resolve(ed)
	local func = ed.func
	local base = ed.base
	if func then
		if base.iter then
			local data = base.data[ed.name]
			if data then
				ed.data = func(data)
			end
		else
			ed.data = func(base.data)
		end
	elseif base and base.iter then
		ed.data = base and base.data[ed.name]
	end
	return ed
end

local function refresh(ed)
	if ed == nil then return ed end
	if ed.entries == nil then return ed end
	--for _,ed in ipairs(ed.entries) do
	--	refresh(ed)
	--end
	ed.entries = nil
	return ed
end

--[[
local path_cache = setmetatable({},{__mode='v'})
--]]

local unfold
do
	local function type_name(o,t)
		if t == nil then return nil end
		if t:match('DynamicArray') then
			return 'array'
		end
		if t:match('unordered_map') then
			return 'map'
		end
		if t:match('span') then
			return 'span'
		end
		if t:match('vector') then
			return 'vector'
		end
		if t:match('container') then
			return 'container'
		end
		if t:match('CInstance') then
			return 'instance'
		end
		if t:match('Object') then
			if o.type == YYObjectBaseType.SCRIPTREF then
				return 'script'
			end
			return o.type_name
		end
		return t
	end

	local function _len(t)
		return #t
	end
	
	function len(t)
		local s,v = pcall(_len,t)
		if s then return math.floor(v) end
	end

	function unfold(ed)
		if ed.entries then return ed.entries end
		ed.path = ed.path or path_part(ed)
		--path_cache[ed.path] = ed
		local data = ed.data
		if ed.data == nil then data = resolve(ed).data end
		local iter = ed.iter
		local entries = {}
		if iter ~= nil and data ~= nil then
			for k,v in iter(data) do
				for _,sd in util.vararg(entrify(k,v,ed)) do
					if sd ~= nil then
						table.insert(entries,sd)
					end
				end
			end
		end
		for i,sd in ipairs(entries) do
			sd.index = i
			sd.path = path_part(sd,ed.path)
			--sd.chain = util.merge({},ed.chain)
			--table.insert(sd.chain,sd.name)
			--sd.funcs = util.merge({},ed.funcs)
			--if sd.func then
			--	sd.funcs[#sd.chain] = sd.func
			--end
			local data = sd.data
			if data == nil then data = resolve(sd).data end
			local ta,tb = type(data)
			sd.type = sd.type or type_name(data,tb) or ta 
			sd.info = sd.info or sd.type
			local size = len(data)
			if size then
				sd.size = size
				sd.info = sd.info .. '[' .. size .. ']'
			end
			if not sd.show then sd.show = tostring(sd.name) end
			sd.text = sd.info and sd.show .. '|' .. sd.info or sd.show
			if sd.fake then
				local base = sd.base
				local info = base.info
				sd.text = sd.text .. '|' .. (info and (base.show .. '|' .. info) or base.show)
			end
		end
		ed.entries = entries
		return entries
	end
end

function resolve_vararg_simple(...)
	local ed = browsers[1]
	for _,k in util.vararg(...) do
		for j, sd in ipairs(unfold(ed)) do
			if sd.name == k or sd.func == k then
				ed = sd
				break
			end
		end
	end
	return ed
end

--[[

function resolve_vararg(...)
	local ed = browsers[1]
	for _,k in util.vararg(...) do
		for j, sd in ipairs(unfold(ed)) do
			if sd.name == k then
				ed = sd
				break
			end
		end
	end
	return ed
end

function resolve_chain_funcs(chain, funcs)
	local ed = browsers[1]
	for i,k in ipairs(chain) do
		local func
		if funcs then func = funcs[i] end
		for j, sd in ipairs(unfold(ed)) do
			if sd.name == k and sd.func == func then
				ed = sd
				break
			end
		end
	end
	return ed
end

function resolve_path(path)
	local ed = path_cache[path]
	if ed ~= nil then return ed end
	-- TODO: resolve the path using grammar:
	-- PATH = FUNC(PATH) | PATH[KEY] | PATH.FIELD | root
	-- FUNC = FUNC[KEY] | FUNC.FIELD | root
	-- KEY = .*
	-- FIELD = %w+
	-- only works for valid paths that don't use table, userdata, function or thread as keys
	-- as such, disqualify a path if it contains PATH<.+?: [A-F0-9]+>
	local ed = browsers[1]
	for _,k in path:gmatch('%.(.+?)') do
		for j, sd in ipairs(unfold(ed)) do
			if sd.name == k then
				ed = sd
				break
			end
		end
	end
	return ed
end

--]]

local render_details
local render_browser
do
	local script_prefix = "gml_Script_"
	local script_prefix_index = #script_prefix+1

	local function peval(text)
		local func = load("return " .. text)
		if not func then return nil end
		setfenv(func,_G)
		local status, value = pcall(func)
		if not status then return nil end
		return value
	end

	local function try_tooltip(dd,sd,value_part) 
		if ImGui.IsItemHovered() then
			local message
			if value_part then
				if sd.type == "string" then
					message = gm.call('ds_map_find_value',gm.variable_global_get("_language_map"),sd.data)
					if type(message) ~= "string" then message = nil end
				end
			end
			if message == nil then
				local enum = type(dd.name) == "string" and type(sd.data) == "number" and hardcoded.array[dd.name]
				if enum then
					enum = enum[sd.data]
				else
					local _type = select(2,type(dd.data))
					_type = _type and _type:upper()
					if _type and _type:sub(1,6) == "CLASS_" then
						enum = hardcoded.array[_type][hardcoded.enum[_type][sd.show]]
					end
				end
				if not enum then return end
				if enum.value then
					message = tostring_literal(enum.value)
				end
				if enum.description then
					message = (message and message .. ' ' or '') .. '-- ' .. enum.description
				end
			end
			if message ~= nil then
				ImGui.PushStyleColor(ImGuiCol.Text, colors.fake)
				ImGui.SetTooltip(message);
				ImGui.PopStyleColor()
			end
		end
	end

	function render_details(dd)
		local entries = unfold(dd)
		if entries then
			local filter = dd.filter
			local skipped = false
			for _,sd in ipairs(entries) do
				if #filter ~= 0 and not sd.text:match(filter) then
					skipped = true
				else
					local id = dd.index .. '|' .. sd.path
					if sd.iter then
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
							if sd.fake then
								ImGui.PushStyleColor(ImGuiCol.Text, colors.fake)
								ImGui.SameLine()
								ImGui.Text(sd.name)
								ImGui.PopStyleColor()
							end
							ImGui.PushStyleColor(ImGuiCol.Text, colors.tree)
							ImGui.SameLine()
							ImGui.Text(sd.show)
							ImGui.PopStyleColor()
							try_tooltip(dd,sd,false)
							ImGui.PushStyleColor(ImGuiCol.Text, colors.info)
							ImGui.SameLine()
							ImGui.Text(sd.info)
							ImGui.PopStyleColor()
							try_tooltip(dd,sd,true)
						end
					else
						-- not iterable
						ImGui.Text("")
						if sd.fake then
							ImGui.PushStyleColor(ImGuiCol.Text, colors.fake)
							ImGui.SameLine()
							ImGui.Text(sd.name)
							ImGui.PopStyleColor()
						end
						ImGui.SameLine()
						ImGui.PushStyleColor(ImGuiCol.Text, colors.leaf)
						ImGui.Text(sd.show)
						ImGui.PopStyleColor()
						try_tooltip(dd,sd,false)
						if sd.type ~= "function" and sd.type ~= "thread" then
							ImGui.SameLine()
							ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 0, 0)
							ImGui.PushStyleColor(ImGuiCol.FrameBg, 0)
							ImGui.PushStyleColor(ImGuiCol.Text, colors.info)
							ImGui.PushItemWidth(ImGui.GetContentRegionAvail() - ImGui.CalcTextSize('|'))
							local text, enter_pressed = ImGui.InputText("##Text" .. id, dd.texts[id] or tostring_literal(sd.data), 65535, sd.fake and ImGuiInputTextFlags.ReadOnly or ImGuiInputTextFlags.EnterReturnsTrue)
							ImGui.PopItemWidth()
							ImGui.PopStyleColor()
							ImGui.PopStyleColor()
							ImGui.PopStyleVar()
							try_tooltip(dd,sd,true)
							if enter_pressed then
								dd.data[sd.name] = peval(text)
								dd.texts[id] = nil
								refresh(dd)
							elseif text == "" then 
								dd.texts[id] = nil
							else
								dd.texts[id] = text
							end
						else
							ImGui.PushStyleColor(ImGuiCol.Text, colors.null)
							ImGui.SameLine()
							ImGui.Text(tostring(sd.data))
							ImGui.PopStyleColor()
							if sd.type == "function" then
								ImGui.SameLine()
								ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 0, 0)
								ImGui.PushStyleColor(ImGuiCol.FrameBg, 0)
								ImGui.PushStyleColor(ImGuiCol.Text, colors.info)
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
											color = colors.leaf
											message = tostring_vararg(table.unpack(result, 2, result.n))
										else 
											color = colors.null
											message = result[2]
										end
										dd.tooltips[id] = { message = message, color = color }
									end
									dd.texts[id] = nil
								else
									dd.texts[id] = text
								end
								if dd.data and sd.show == "call" then
									local params = dd.data.params
									if params == nil then
										local name = dd.data.name
										if name == nil then
											local script_name = dd.data.script_name
											if script_name ~= nil then
												name = script_name:sub(script_prefix_index)
											end
										end
										if name ~= nil then
											local script = hardcoded.script[name]
											if script then 
												params = script.params
											end
										end
									end
									if params ~= nil then
										ImGui.PushStyleColor(ImGuiCol.Text, colors.fake)
										ImGui.Text("")
										ImGui.SameLine()
										ImGui.Text("")
										ImGui.SameLine()
										ImGui.Text("params:")
										for _,p in ipairs(params) do
											ImGui.SameLine()
											ImGui.Text(p.name)
											if p.value and ImGui.IsItemHovered() then
												ImGui.SetTooltip(p.value);
											end
										end
										ImGui.PopStyleColor()
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

	function render_browser(bd,ed)
		ids = bd.index .. '|' .. ed.path
		local show = ed.path ~= "root"
		local _unfolded = unfolded[ids] == true
		if show then
			if ed.iter then
				-- iterable
				ImGui.PushStyleColor(ImGuiCol.HeaderHovered,0)
				ImGui.PushStyleColor(ImGuiCol.HeaderActive,0)
				ImGui.Selectable("##Select" .. ids, false)
				ImGui.PopStyleColor()
				ImGui.PopStyleColor()
				if ImGui.IsItemHovered() then
					if ImGui.IsItemHovered() and ImGui.IsItemClicked(ImGuiMouseButton.Left) then
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
				if ed.fake then
					ImGui.PushStyleColor(ImGuiCol.Text, colors.fake)
					ImGui.SameLine()
					ImGui.Text(ed.name)
					ImGui.PopStyleColor()
				end
				ImGui.PushStyleColor(ImGuiCol.Text, colors.tree)
				ImGui.SameLine()
				ImGui.Text(ed.show)
				ImGui.PopStyleColor()
				if ed.info ~= nil then
					ImGui.PushStyleColor(ImGuiCol.Text, colors.info)
					ImGui.SameLine()
					ImGui.Text(ed.info)
					ImGui.PopStyleColor()
				end
			else
				-- not iterable
				ImGui.Text("\t")
				ImGui.SameLine()
				ImGui.Text("")
				if ed.fake then
					ImGui.PushStyleColor(ImGuiCol.Text, colors.fake)
					ImGui.SameLine()
					ImGui.Text(ed.name)
					ImGui.PopStyleColor()
				end
				ImGui.SameLine()
				ImGui.PushStyleColor(ImGuiCol.Text, colors.leaf)
				ImGui.Text(ed.show)
				ImGui.PopStyleColor()
				if ed.type ~= "function" and ed.type ~= "thread" then
					ImGui.SameLine()
					ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 0, 0)
					ImGui.PushStyleColor(ImGuiCol.FrameBg, 0)
					ImGui.PushStyleColor(ImGuiCol.Text, colors.info)
					ImGui.PushItemWidth(ImGui.GetContentRegionAvail() - ImGui.CalcTextSize('|'))
					local text, enter_pressed = ImGui.InputText("##Text" .. ids, bd.texts[ids] or tostring_literal(ed.data), 65535, ed.fake and ImGuiInputTextFlags.ReadOnly or ImGuiInputTextFlags.EnterReturnsTrue)
					ImGui.PopItemWidth()
					ImGui.PopStyleColor()
					ImGui.PopStyleColor()
					ImGui.PopStyleVar()
					try_tooltip(bd,ed,true)
					if enter_pressed then
						ed.base.data[ed.name] = peval(text)
						bd.texts[ids] = nil
						refresh(bd)
					elseif text == "" then 
						bd.texts[ids] = nil
					else
						bd.texts[ids] = text
					end
				else
					ImGui.PushStyleColor(ImGuiCol.Text, colors.null)
					ImGui.SameLine()
					ImGui.Text(tostring(ed.data))
					ImGui.PopStyleColor()
					if ed.type == "function" then
						ImGui.SameLine()
						ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 0, 0)
						ImGui.PushStyleColor(ImGuiCol.FrameBg, 0)
						ImGui.PushStyleColor(ImGuiCol.Text, colors.info)
						ImGui.Text("(")
						ImGui.SameLine()
						ImGui.PushItemWidth(ImGui.GetContentRegionAvail() - ImGui.CalcTextSize('(|)'))
						local text, enter_pressed = ImGui.InputText("##Text" .. ids, bd.texts[ids] or '', 65535, ImGuiInputTextFlags.EnterReturnsTrue)
						local tooltip = bd.tooltips[ids]
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
							local result = table.pack(pcall(ed.data, peval(text)))
							if result.n > 1 then
								local color, message
								if result[1] then
									color = colors.leaf
									message = tostring_vararg(table.unpack(result, 2, result.n))
								else 
									color = colors.null
									message = result[2]
								end
								bd.tooltips[ids] = { message = message, color = color }
							end
							bd.texts[ids] = nil
						else
							bd.texts[ids] = text
						end
						if bd.data and ed.show == "call" then
							local params = bd.data.params
							if params == nil then
								local name = bd.data.name
								if name == nil then
									local script_name = bd.data.script_name
									if script_name ~= nil then
										name = script_name:sub(script_prefix_index)
									end
								end
								if name ~= nil then
									local script = hardcoded.script[name]
									if script then 
										params = script.params
									end
								end
							end
							if params ~= nil then
								ImGui.PushStyleColor(ImGuiCol.Text, colors.fake)
								ImGui.Text("")
								ImGui.SameLine()
								ImGui.Text("")
								ImGui.SameLine()
								ImGui.Text("params:")
								for _,p in ipairs(params) do
									ImGui.SameLine()
									ImGui.Text(p.name)
									if p.value and ImGui.IsItemHovered() then
										ImGui.SetTooltip(p.value);
									end
								end
								ImGui.PopStyleColor()
							end
						end
					end
				end
			end
		end
		if _unfolded then
			local filter = bd.filter
			local entries = unfold(ed)
			if entries then
				local skipped = false
				for _,sd in ipairs(entries) do
					if sd.iter or bd.mode == 2 then 
						if not unfolded[bd.index .. '|' .. sd.path] and #filter ~= 0 and not sd.text:match(filter) then
							skipped = true
						else
							render_browser(bd,sd)
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
end

local frame_period = 60
local frame_counter = 0

local tooltip_flags = --ImGuiWindowFlags.Tooltip |
            ImGuiWindowFlags.NoTitleBar |
            ImGuiWindowFlags.NoMove |
            ImGuiWindowFlags.NoResize |
            ImGuiWindowFlags.NoSavedSettings |
            ImGuiWindowFlags.AlwaysAutoResize |
			ImGuiWindowFlags.AlwaysUseWindowPadding

local function nop() end

local function selector_tooltip(pushc,popc,mouse_x,mouse_y,instance)
	local vars = proxy.variables(instance.id)
	if vars.user_name then 
		pushc(ImGuiCol.Text, colors.fake)
		ImGui.Text(vars.user_name)
		popc()
	end
	pushc(ImGuiCol.Text, colors.tree)
	ImGui.Text(instance.object_name:sub(2))
	ImGui.SameLine()
	popc()
	pushc(ImGuiCol.Text, colors.leaf)
	ImGui.Text(vars.name or '')
	popc()
	ImGui.Separator()
	ImGui.Text('obj:')
	pushc(ImGuiCol.Text, colors.info)
	ImGui.SameLine()
	ImGui.Text(tostring(instance.object_index))
	popc()
	ImGui.SameLine()
	ImGui.Text('id:')
	ImGui.SameLine()
	pushc(ImGuiCol.Text, colors.info)
	ImGui.Text(tostring(instance.id))
	popc()
end

local function imgui_off_render()
	if root.instances then
		local mouse_x = math.floor(gm.variable_global_get("mouse_x"))
		local mouse_y = math.floor(gm.variable_global_get("mouse_y"))
		local instance = gm.instance_nearest(mouse_x, mouse_y, EVariableType.ALL)
		if instance ~= nil then
			root.instances.nearest = instance
		end
		if ImGui.GetStyleVar and ImGui.IsKeyDown(ImGuiKeyMod.Ctrl) then
			local w,h,x,y = 0,0
			for _,v in pairs(ImGuiCol) do
				ImGui.PushStyleColor(v,0)
			end
			ImGui.SetNextWindowSize(0,0)
			if ImGui.Begin("##Tooltip Position Hack", ImGuiWindowFlags.Tooltip | tooltip_flags ) then
				x,y = ImGui.GetWindowPos()
			end
			if instance ~= nil and ImGui.Begin("##Tooltip Size Hack", ImGuiWindowFlags.Tooltip | tooltip_flags ) then
				selector_tooltip(nop,nop,mouse_x,mouse_y,instance)
				w,h = ImGui.GetWindowSize()
			end
			for _ in pairs(ImGuiCol) do
				ImGui.PopStyleColor()
			end
			
			local _,_y_text = ImGui.CalcTextSize('|')
			local _,_y_frame = ImGui.GetStyleVar(ImGuiStyleVar.FramePadding)
			local _,_y_win = ImGui.GetStyleVar(ImGuiStyleVar.WindowPadding)
			ImGui.SetNextWindowPos(x+5,y+20-2*(_y_text+_y_frame + _y_win))
			if ImGui.Begin("##Instance Selector Position", tooltip_flags ) then
				ImGui.Text('x:')
				ImGui.PushStyleColor(ImGuiCol.Text, colors.leaf)
				ImGui.SameLine()
				ImGui.Text(tostring(mouse_x))
				ImGui.PopStyleColor()
				ImGui.Text('y:')
				ImGui.PushStyleColor(ImGuiCol.Text, colors.leaf)
				ImGui.SameLine()
				ImGui.Text(tostring(mouse_y))
				ImGui.PopStyleColor()
			end
			ImGui.End()
			
			if instance ~= nil then
				ImGui.SetNextWindowPos(x-w/2-12.5,y+20)
				if ImGui.Begin("##Instance Selector", tooltip_flags ) then
					selector_tooltip(ImGui.PushStyleColor,ImGui.PopStyleColor,mouse_x,mouse_y,instance)
				end
				ImGui.End()
			
				if ImGui.IsMouseClicked(ImGuiMouseButton.Left) then
					root.instances.selected = instance
				end
				if ImGui.IsMouseClicked(ImGuiMouseButton.Middle) then
					create_browser(resolve_vararg_simple("instances","stable",instance.id))
				end
				if ImGui.IsMouseClicked(ImGuiMouseButton.Right) then
					create_details(resolve_vararg_simple("instances","stable",instance.id,proxy.variables))
				end
			end
		end
	end
end

local closable_true = {true}
local closable_false = {}

local function imgui_on_render()
	local should_refresh = false
	if frame_counter >= frame_period then
		frame_counter = 0
		should_refresh = true
	end
	frame_counter = frame_counter + 1
	for bid,bd in pairs(browsers) do
		local closable = closable_false
		if bid ~= 1 then closable = closable_true end
		if ImGui.Begin("Object Browser##" .. bid, table.unpack(closable)) then
			bd.index = bid
			local item_spacing_x, item_spacing_y = ImGui.GetStyleVar(ImGuiStyleVar.ItemSpacing)
			local frame_padding_x, frame_padding_y = ImGui.GetStyleVar(ImGuiStyleVar.FramePadding)
			local num, y_max, x_total, x_swap, x_filter = calculate_text_sizes('...','Filter: ')
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
			bd.filter_text, enter_pressed = ImGui.InputText("##Text" .. bid, bd.filter_text, 65535, ImGuiInputTextFlags.EnterReturnsTrue)
			ImGui.PopStyleColor()
			ImGui.PopStyleVar()
			ImGui.PopItemWidth()
			ImGui.PushStyleColor(ImGuiCol.Button, colors[filter_modes_browser[bd.mode]])
			ImGui.SameLine()
			if ImGui.Button("    ##Swap" .. bid) then
				bd.mode = bd.mode%#filter_modes_browser + 1
			end
			ImGui.PopStyleColor()
			if enter_pressed then
				bd.filter = bd.filter_text
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
				ImGui.PushItemWidth(x_input)
				ImGui.InputText("##Path" .. bid, path, #path, ImGuiInputTextFlags.ReadOnly)
				ImGui.PopItemWidth()
				ImGui.PopStyleColor()
				ImGui.PopStyleVar()
			end
			ImGui.PushStyleColor(ImGuiCol.FrameBg, 0)
			if ImGui.BeginListBox("##Box" .. bid,x_box,y_box) then
				ImGui.PopStyleColor()
				render_browser(bd,bd)
				ImGui.EndListBox()
			else
				ImGui.PopStyleColor()
			end
		elseif closable == closable_true then
			browsers[bid] = nil
		end
		ImGui.End()
	end
	for did,dd in pairs(details) do
		if ImGui.Begin("Object Details##" .. did, true) then
			dd.index = did
			local item_spacing_x, item_spacing_y = ImGui.GetStyleVar(ImGuiStyleVar.ItemSpacing)
			local frame_padding_x, frame_padding_y = ImGui.GetStyleVar(ImGuiStyleVar.FramePadding)
			local num, y_max, x_total, x_swap, x_filter = calculate_text_sizes('...','Filter: ')
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
			dd.filter_text, enter_pressed = ImGui.InputText("##Text" .. did, dd.filter_text, 65535, ImGuiInputTextFlags.EnterReturnsTrue)
			ImGui.PopStyleColor()
			ImGui.PopStyleVar()
			ImGui.PopItemWidth()
			ImGui.PushStyleColor(ImGuiCol.Button, colors[filter_modes_details[dd.mode]])
			ImGui.SameLine()
			if ImGui.Button("    ##Swap" .. did) then
				dd.mode = dd.mode%#filter_modes_details + 1
			end
			ImGui.PopStyleColor()
			do
				local path = dd.path or "???"
				y_box = y_box - y_max - item_spacing_y
				ImGui.Text("Path:  ")
				ImGui.SameLine()
				ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 0, 0)
				ImGui.PushStyleColor(ImGuiCol.FrameBg, 0)
				ImGui.PushItemWidth(x)
				ImGui.InputText("##Path" .. did, path, #path, ImGuiInputTextFlags.ReadOnly)
				ImGui.PopItemWidth()
				ImGui.PopStyleColor()
				ImGui.PopStyleVar()
			end
			if enter_pressed then
				dd.filter = dd.filter_text
			end
			if should_refresh then
				refresh(dd)
			end
			ImGui.PushStyleColor(ImGuiCol.FrameBg, 0)
			if ImGui.BeginListBox("##Box" .. did,x_box,y_box) then
				ImGui.PopStyleColor()
				render_details(dd)
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
gui.add_always_draw_imgui(function() if not gui.is_open() then return imgui_off_render() end end)
gm.pre_code_execute( function(_,_,ccode)
	if not root.instances then
		root.instances = {
			all = gm.CInstance.instances_all,
			active = gm.CInstance.instances_active,
			stable = gm.CInstance.instance_id_to_CInstance
		}
	end
end )