util.merge(_ENV,util)
util.merge(_ENV,proxy)

function find_instance(name)
	for k,v in pairs(gm.CInstance.instances_active) do
		if v.object_name == name then return v end
	end
	for k,v in pairs(gm.CInstance.instances_all) do
		if v.object_name == name then return v end
	end
	return nil
end

local _repl_globals = {}
util.merge(_repl_globals,_G,_ENV,util,proxy)

-- assume we load later than ObjectBrowser due to alphabetical order
-- (optional dependency)
local browser = mods['ReturnOfModding-ObjectBrowser']
_repl_globals.root = root or browser and browser.root

repl_globals = _repl_globals
repl_environment = setmetatable({},{
	__index = repl_globals,
	__newindex = repl_globals
})

autoexec_name = "autoexec"

function tostring_literal(value)
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

function vararg_tostring(raw, ...)
	s = ""
	for _,v in util.vararg(...) do
		v = raw and tostring(v) or tostring_literal(v)
		s = s .. '\t' .. v
	end
	return s:sub(2,#s)
end

console_logger = {
	error = {
		prefix_debug = "",
		prefix_shown = "",
		logger = log.error,
		color = 0xFF2020EE,
	},
	info = {
		prefix_debug = "",
		prefix_shown = "",
		logger = log.info,
		color = 0xFFEEEEEE,
	},
	warning = {
		prefix_debug = "",
		prefix_shown = "",
		logger = log.warning,
		color = 0xFF20EEEE,
	},
	history = {
		prefix_debug = "",
		prefix_shown = "] ",
		logger = false,
		color = 0xEECCCCCC,
	},
	echo = {
		prefix_debug = "[Echo]:",
		prefix_shown = "",
		logger = log.info,
		color = 0xFFEEEEEE,
	},
	print = {
		prefix_debug = "[Print]:",
		prefix_shown = "",
		logger = log.info,
		color = 0xFFEEEEEE,
	},
	returns = {
		prefix_debug = "[Returns]:",
		prefix_shown = "",
		logger = log.info,
		color = 0xFFFFFF20,
	}
}

console_logger_meta = { __call = function(lg,...) return lg.log(...) end }

for _,lg in pairs(console_logger) do
	lg.log = function(md, raw, ...)
		local text = vararg_tostring(raw, ...)
		table.insert(md.lines_raw, text)
		table.insert(md.lines_shown, lg.prefix_shown .. text)
		md.lines_colors[#md.lines_raw] = lg.color
		if lg.logger then
			return lg.logger( lg.prefix_debug .. md.prefix .. text )
		end
	end
	setmetatable(lg,console_logger_meta)
end

function repl_execute_lua(md, env, text, ...)
	util.merge(repl_globals,md.definitions)
	local func, err = text, ''
	if type(text) == "string" then
		func, err = load( "return " .. text )
		if not func then
			func, err = load( text )
			if not func then
				return false, err
			end
		end
	end
	if env then
		setfenv( func, env == true and repl_environment or env )
	end
	return pcall( func, ... )
end

--https://stackoverflow.com/a/28664691
do 
	-- TODO: This needs to be improved regarding properly handling embedded and mixed quotes!
	local parse_buffer = {}
	function parse_command_text(text)
		util.iclear(parse_buffer)
		local spat, epat, buf, quoted = [=[^(['"])]=], [=[(['"])$]=]
		for str in text:gmatch("%S+") do
			local squoted = str:match(spat)
			local equoted = str:match(epat)
			local escaped = str:match([=[(\*)['"]$]=])
			if squoted and not quoted and not equoted then
				buf, quoted = str, squoted
			elseif buf and equoted == quoted and #escaped % 2 == 0 then
				str, buf, quoted = buf .. ' ' .. str, nil, nil
			elseif buf then
				buf = buf .. ' ' .. str
			end
			if not buf then
				local token = str:gsub(spat,""):gsub(epat,"")
				table.insert(parse_buffer,token)
			end
		end
		if buf then return false, "Missing matching quote for "..buf end
		return true, table.unpack(parse_buffer)
	end
	function parse_multicommand_text(text)
		util.iclear(parse_buffer)
		for mstr in text:gmatch("[^\r\n]+") do
			local pquoted, buf = 0
			for str in mstr:gmatch("[^;]+") do
				str = str:gsub("^%s\\*", "")
				local quoted, _quoted = 0, str:gmatch([=[['"]]=])
				for _ in _quoted do quoted = quoted + 1 end
				local escaped, _escaped = 0, str:gmatch([=[\['"]]=])
				for _ in _escaped do escaped = escaped + 1 end
				pquoted = (pquoted+quoted-escaped) % 2
				if not buf and pquoted == 1 then
					buf = str
				elseif buf and pquoted == 0 then
					str, buf = buf .. ';' .. str, nil
				elseif buf and pquoted == 1 then
					buf = buf .. ';' .. str
					str, buf, quoted = buf .. ';' .. str, nil, 0
				end
				if not buf then
					local token = str
					table.insert(parse_buffer,token)
				end
			end
			if buf then return false, "Missing matching quote for "..buf end
		end
		return true, table.unpack(parse_buffer)
	end
end

function run_console_command(md, text)
		local parse_result = table.pack(parse_command_text(text))
		local status, command_name = parse_result[1], parse_result[2]
		if not status then
			console_logger.error(md, true, command_name)
		end
		local alias = console_aliases[command_name]
		if alias ~= nil then
			return run_console_multicommand(md, alias)
		end
		local command = console_commands[command_name]
		if command == nil then
			return console_logger.error(md, true, 'no command by the name of "' .. command_name .. '" found')
		end
		local ret = table.pack(pcall(command,md,table.unpack(parse_result, 3, parse_result.n)))
		if ret.n <= 1 then return end
		if ret[1] == false then
			return console_logger.error(md, true, ret[2])
		end
		return console_logger.info(md, false, table.unpack(ret, 2, ret.n))
end

function run_console_multicommand(md, text)
		local parse_result = table.pack(parse_multicommand_text(text))
		local status, err = parse_result[1], parse_result[2]
		if not status then
			console_logger.error(md, true, err)
		end
		table.unpack(parse_result, 2, parse_result.n)
		for i = 2, parse_result.n do
			run_console_command(md, parse_result[i])
		end
end

console_aliases = {}

console_commands_help = {
	{"help","[0..1]","lists the available commands"},
	{"echo","[..]","prints a message to the console"},
	{"lua","[1..]","executes lua code and shows the result"},
	{"luae","[1]","executes lua file with args and shows the result"},
	{"exec","[1]","executes a file containing a list of console commands"},
	{"alias","[0..2]","defines a command that acts as a shortcut for other commands"}
}

console_commands = {
	help = function(md,stub)
		if stub then
			local msg = console_commands_help[stub]
			if not msg then 
				return console_logger.error(md, true, 'no command by the name of "' .. stub .. '" found')
			end
			return console_logger.echo(md, true, msg)
		end
		for _,h in ipairs(console_commands_help) do
			console_logger.echo(md, true, table.unpack(h))
		end
	end,
	echo = function(md,...)
		local text = ""
		for _, arg in util.vararg(...) do
			text = text .. ' ' .. arg
		end
		text = text:sub(2,#text)
		return console_logger.echo(md,true,text)
	end,
	lua = function(md,...)
		local text = ""
		for _, arg in util.vararg(...) do
			text = text .. ' ' .. arg
		end
		text = text:sub(2,#text)
		if #text == 0 then
			return console_logger.error(md, true, "cannot execute empty lua code.")
		end
		local ret = table.pack(repl_execute_lua(md, true, text))
		if ret.n <= 1 then return end
		if ret[1] == false then
			return console_logger.error(md, true, ret[2])
		end
		return console_logger.returns(md, false, table.unpack( ret, 2, ret.n ))
	end,
	--https://stackoverflow.com/a/10387949
	luae = function(md,path,...)
		qualpath = _ENV["!plugins_data_mod_folder_path"] .. '/' .. path
		local file = io.open(qualpath,"rb")
		if not file or type(file) == "string" or type(file) == "number" then
			file = io.open(qualpath .. ".lua","rb")
			if not file or type(file) == "string" or type(file) == "number" then
				return console_logger.warning(md, true, 'attempted to read the lua file "' .. path .. '", but failed.')
			end
		end
		local data = file:read("*a")
		file:close()
		local ret = table.pack(repl_execute_lua(md, true, data, ...))
		if ret.n <= 1 then return end
		if ret[1] == false then
			return console_logger.error(md, true, ret[2])
		end
		return console_logger.returns(md, false, table.unpack( ret, 2, ret.n ))
	end,
	exec = function(md,path)
		qualpath = _ENV["!plugins_data_mod_folder_path"] .. '/' .. path
		local file = io.open(qualpath,"rb")
		if not file or type(file) == "string" or type(file) == "number" then
			file = io.open(qualpath .. ".txt","rb")
			if not file or type(file) == "string" or type(file) == "number" then
				return console_logger.warning(md, true, 'attempted to read the batch file "' .. path .. '", but failed.')
			end
		end
		local data = file:read("*a")
		file:close()
		return run_console_multicommand(md,data)
	end,
	alias = function(md,name,...)
		if name == nil then
			for k,v in pairs(console_aliases) do
				console_logger.echo(md, true, k,v)
			end
			return
		end
		local text = ""
		for _, arg in util.vararg(...) do
			text = text .. ' ' .. arg
		end
		text = text:sub(2,#text)
		if #text == 0 then
			local msg = console_aliases[name]
			if not msg then 
				return console_logger.error(md, true, 'no alias by the name of "' .. name .. '" exists')
			end
			return console_logger.echo(md, true, msg)
		end
		console_aliases[name] = text
	end,
}

console_modes = {
	{
		name = "Command Console",
		prefix = "[Console]:",
		on_enter = function(md) return function(text)
			console_logger.history(md, true, text)
			return run_console_multicommand(md, text)
		end end
	},
	{
		name = "Lua Script REPL",
		prefix = "[LuaREPL]:",
		on_enter = function(md) return function(text)
			console_logger.history(md, true, text)
			local ret = table.pack(repl_execute_lua(md, true, text))
			if ret.n <= 1 then return end
			if ret[1] == false then
				return console_logger.error(md, true, ret[2])
			end
			repl_globals._ = ret[2]
			return console_logger.returns(md, false, table.unpack(ret, 2, ret.n))
		end end
	}
}

local function console_mode_definitions(get_md)
	return {
		print = function(...)
			return console_logger.print(get_md(),true,...)
		end,
		tprint = function(...)
			for _,o in util.vararg(...) do
				console_logger.print(get_md(),false,o)
				if type(o) == "table" or type(o) == "userdata" then
					for k,v in pairs(o) do
						console_logger.print(get_md(),false,k,v)
					end
				end
			end
		end,
		mprint = function(m,...)
			for _,o in util.vararg(...) do
				console_logger.print(get_md(),false,o)
				if type(o) == "table" or type(o) == "userdata" then
					for k,v in pairs(o) do
						console_logger.print(get_md(),false,k,m(v))
					end
				end
			end
		end,
		eval = function(...)
			return repl_execute_lua(get_md(), ...)
		end
	}
end

for mi,md in ipairs(console_modes) do
	util.merge(md,{
		current_text = "",
		enter_pressed = false,
		history_offset = 0,
		history = {},
		lines_shown = {},
		lines_raw = {},
		lines_selected = {},
		lines_colors = {},
		index = mi,
		on_enter = md.on_enter(md),
		definitions = console_mode_definitions(function() return md end)
	})
end

console_mode = console_modes[1]
util.merge(_ENV,console_mode_definitions(function() return console_mode end))

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

function imgui_on_render()
	if ImGui.Begin("Script Console", true, ImGuiWindowFlags.NoTitleBar) then
		if ImGui.BeginTabBar("Mode",ImGuiTabBarFlags.Reorderable) then
			local item_spacing_x, item_spacing_y = ImGui.GetStyleVar(ImGuiStyleVar.ItemSpacing)
			local frame_padding_x, frame_padding_y = ImGui.GetStyleVar(ImGuiStyleVar.FramePadding)
			local top_num, top_y_max, top_x_total, x_clear, x_copy = calculate_text_sizes("Clear","Copy")
			local bot_num, bot_y_max, bot_x_total, x_up, x_down = calculate_text_sizes("^","v","|")
			local x,y = ImGui.GetContentRegionAvail()
			local x_bar = x - top_x_total - item_spacing_x*top_num
			local x_input = x - bot_x_total - item_spacing_x*bot_num
			-- height of InputText == font_size + frame_padding.y
			-- and we're going to change frame_padding.y temporarily later on
			-- such that InputText's height == max y
			local y_input = bot_y_max - ImGui.GetFontSize() - frame_padding_y 
			local box_y = y - top_y_max - bot_y_max - item_spacing_y*2
			for mi,md in ipairs(console_modes) do
				local ds = md.name
				local ms = tostring(mi)
				if ImGui.BeginTabItem(ds) then
					ImGui.EndTabItem()
					console_mode = md
					if autoexec_name then
						local name = autoexec_name
						autoexec_name = nil
						run_console_command(md,"exec " .. name)
					end
					ImGui.InvisibleButton("##Spacer" .. ms, x_bar, top_y_max)
					ImGui.SameLine()
					if ImGui.Button("Clear##" .. ms, x_clear, top_y_max) then
						util.iclear(md.lines_shown,md.lines_raw,md.lines_selected,md.lines_colors)
					end
					ImGui.SameLine()
					if ImGui.Button("Copy##" .. ms, x_copy, top_y_max) then
						local text
						for hi,b in ipairs(md.lines_selected) do
							if b then 
								local line = md.lines_raw[hi] or md.lines_shown[hi]
								if text == nil then
									text = line
								else
									text = text .. '\n' .. line
								end
							end
						end
						ImGui.SetClipboardText(text)
					end
					ImGui.PushStyleColor(ImGuiCol.FrameBg, 0)
					if ImGui.BeginListBox("##Box" .. ms,x,box_y) then
						ImGui.PopStyleColor()
						for li,ls in ipairs(md.lines_shown) do
							local tall = select(2,ImGui.CalcTextSize(ls, false, x-frame_padding_x*2-item_spacing_x))
							md.lines_selected[li] = ImGui.Selectable("##Select" .. ms .. tostring(li), md.lines_selected[li] or false, ImGuiSelectableFlags.AllowDoubleClick, 0, tall)
							if ImGui.IsItemHovered() and ImGui.IsItemClicked(ImGuiMouseButton.Right) then
								local selected = not md.lines_selected[li]
								for oli in ipairs(md.lines_selected) do
									md.lines_selected[oli] = selected
								end
							end
							ImGui.SameLine()
							local color = md.lines_colors[li]
							if color ~= nil then ImGui.PushStyleColor(ImGuiCol.Text, color) end
							ImGui.TextWrapped(ls)
							if color ~= nil then ImGui.PopStyleColor() end
						end
						ImGui.EndListBox()
					else
						ImGui.PopStyleColor()
					end
					ImGui.PushItemWidth(x_input)
					ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, frame_padding_x, y_input)
					md.current_text, md.enter_pressed = ImGui.InputText("##Text" .. ms, md.current_text, 65535, ImGuiInputTextFlags.EnterReturnsTrue)
					ImGui.PopStyleVar()
					ImGui.PopItemWidth()
					local changed_offset
					ImGui.SameLine()
					if ImGui.Button("^##" .. ms, x_up, bot_y_max) then
						md.history_offset = md.history_offset + 1
						if md.history_offset > #md.history then
							md.history_offset = #md.history
						end
						changed_offset = true
					end
					ImGui.SameLine()
					if ImGui.Button("v##" .. ms, x_down, bot_y_max) then
						md.history_offset = md.history_offset - 1
						if md.history_offset < 0 then
							md.history_offset = 0
						end
						changed_offset = true
					end
					if changed_offset then
						if md.history_offset == 0 then
							md.current_text = ""
						else
							md.current_text = md.history[#md.history-md.history_offset+1]
						end
					end
				end
			end
			ImGui.EndTabBar()
		end
	end
	ImGui.End()
	-- handling entering input separate from constructing the UI
	-- so actions that use ImGui will be separate from the console's UI
	for mi,md in ipairs(console_modes) do
		if md.enter_pressed then
			md.enter_pressed = false
			md.history_offset = 0
			local text = md.current_text
			table.insert(md.history,text)
			md.current_text = ""
			md.on_enter(text)
		end
	end
end

gui.add_imgui(imgui_on_render)