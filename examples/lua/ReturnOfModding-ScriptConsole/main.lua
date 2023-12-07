log.info("Script Console Startup...")

local _repl_globals = {}
for k,v in pairs(_G) do
	_repl_globals[k] = v
end
repl_globals = _repl_globals
repl_environment = setmetatable( { }, {
	__index = repl_globals,
	__newindex = repl_globals
} )

function lookup(t)
	local l = {}
	for k,v in pairs(t) do
		l[v] = k
	end
	return l
end

--http://lua-users.org/wiki/VarargTheSecondClassCitizen
do
	local i, t, l = 0, {}
	local function iter(...)
		i = i + 1
		if i > l then return end
		return i, t[i]
	end

	function vararg(...)
		i = 0
		l = select("#", ...)
		for n = 1, l do
			t[n] = select(n, ...)
		end
		for n = l+1, #t do
			t[n] = nil
		end
		return iter
	end
end

do
	local varargmap_buffer = { }
	function varargmap( map, ... )
		for k in pairs(varargmap_buffer) do
			varargmap_buffer[k] = nil
		end
		local n = 0
		for i, a in vararg(...) do
			n = i
			varargmap_buffer[i] = map(a)
		end
		return table.unpack(varargmap_buffer, 1, n)
	end
end

function setfenv( fn, env )
	if type( fn ) ~= "function" then
		fn = debug.getinfo( ( fn or 1 ) + 1, "f" ).func
	end
	local i = 0
	repeat
		i = i + 1
		local name = debug.getupvalue( fn, i )
		if name == "_ENV" then
			debug.upvaluejoin( fn, i, ( function( )
				return env
			end ), 1 )
			return env
		end
	until not name
end

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
	for _,v in vararg(...) do
		v = raw and tostring(v) or tostring_literal(v)
		s = s .. '\t' .. v
	end
	return s:sub(2,#s)
end

mlog_prefixes_debug = {
	error = "",
	info = "",
	warning = "",
	history = "",
	echo = "[Echo]:",
	print = "[Print]:",
	returns = "[Returns]:"
}

mlog_prefixes_shown = {
	error = "",
	info = "",
	warning = "",
	history = "] ",
	echo = "",
	print = "",
	returns = ""
}

mlog_loggers = {
	error = log.error,
	info = log.info,
	warning = log.warning,
	history = false,
	echo = log.info,
	print = log.info,
	returns = log.info
}

mlog_colors = {
	error = 0xFF2020EE,
	info = 0xFFEEEEEE,
	warning = 0xFF20EEEE,
	history = 0xEECCCCCC,
	echo = 0xFFEEEEEE,
	print = 0xFFEEEEEE,
	returns = 0xFFFFFF20
}

mlog = {}
for k in pairs(mlog_colors) do
	mlog[k] = function(mi, raw, ...)
		local text = vararg_tostring(raw, ...)
		table.insert(console_mode_raw[mi], text)
		table.insert(console_mode_lines[mi], mlog_prefixes_shown[k] .. text)
		console_mode_color[mi][#console_mode_lines[mi]] = mlog_colors[k]
		if mlog_loggers[k] then
			return log.error( mlog_prefixes_debug[k] .. console_mode_prefix[mi] .. text )
		end
	end
end

function repl_execute_lua(mi, env, text, ...)
	repl_globals.print = console_mode_print[mi]
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
	local parse_command_text_buffer = {}
	function parse_command_text(text)
		for k in pairs(parse_command_text_buffer) do
			parse_command_text_buffer[k] = nil
		end
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
				table.insert(parse_command_text_buffer,token)
			end
		end
		if buf then return false, "Missing matching quote for "..buf end
		return true, table.unpack(parse_command_text_buffer)
	end
	local parse_multicommand_text_buffer = {}
	function parse_multicommand_text(text)
		for k in pairs(parse_multicommand_text_buffer) do
				parse_multicommand_text_buffer[k] = nil
		end
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
					table.insert(parse_multicommand_text_buffer,token)
				end
			end
			if buf then return false, "Missing matching quote for "..buf end
		end
		return true, table.unpack(parse_multicommand_text_buffer)
	end
end

autoexec_name = "autoexec"

function get_data_path()
	return paths.plugins_data(_ENV)
end

function run_console_command(mi, text)
		local parse_result = table.pack(parse_command_text(text))
		local status, command_name = parse_result[1], parse_result[2]
		if not status then
			mlog.error(mi, true, command_name)
		end
		local alias = console_aliases[command_name]
		if alias ~= nil then
			return run_console_multicommand(mi, alias)
		end
		local command = console_commands[command_name]
		if command == nil then
			return mlog.error(mi, true, 'no command by the name of "' .. command_name .. '" found')
		end
		local ret = table.pack(repl_execute_lua(mi, false, command, mi, table.unpack(parse_result, 3, parse_result.n)))
		if ret.n <= 1 then return end
		if ret[1] == false then
			return mlog.error( mi, true, ret[2] )
		end
		return mlog.info(mi, false, table.unpack( ret, 2, ret.n ))
end

function run_console_multicommand(mi, text)
		local parse_result = table.pack(parse_multicommand_text(text))
		local status, err = parse_result[1], parse_result[2]
		if not status then
			mlog.error(mi, true, err)
		end
		table.unpack(parse_result, 2, parse_result.n)
		for i = 2, parse_result.n do
			run_console_command(mi, parse_result[i])
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
	help = function(mi,stub)
		if stub then
			local msg = console_commands_help[stub]
			if not msg then 
				return mlog.error(mi, true, 'no command by the name of "' .. stub .. '" found')
			end
			return mlog.echo(mi, true, msg)
		end
		for _,h in ipairs(console_commands_help) do
			mlog.echo(mi, true, table.unpack(h))
		end
	end,
	echo = function(mi,...)
		local text = ""
		for _, arg in vararg(...) do
			text = text .. ' ' .. arg
		end
		return mlog.echo(mi,true,text)
	end,
	lua = function(mi,...)
		local text = ""
		for _, arg in vararg(...) do
			text = text .. ' ' .. arg
		end
		if #text == 0 then
			return mlog.error(mi, true, "cannot execute empty lua code.")
		end
		local ret = table.pack(repl_execute_lua(mi, true, text))
		if ret.n <= 1 then return end
		if ret[1] == false then
			return mlog.error( mi, true, ret[2] )
		end
		return mlog.returns(mi, false, table.unpack( ret, 2, ret.n ))
	end,
	--https://stackoverflow.com/a/10387949
	luae = function(mi,path,...)
		qualpath = get_data_path() .. '/' .. path
		local file = io.open(qualpath,"rb")
		if not file or type(file) == "string" or type(file) == "number" then
			file = io.open(qualpath .. ".lua","rb")
			if not file or type(file) == "string" or type(file) == "number" then
				return mlog.warning(mi, true, 'attempted to read the lua file "' .. path .. '", but failed.')
			end
		end
		local data = file:read("*a")
		file:close()
		local ret = table.pack(repl_execute_lua(mi, true, data, ...))
		if ret.n <= 1 then return end
		if ret[1] == false then
			return mlog.error( mi, true, ret[2] )
		end
		return mlog.returns(mi, false, table.unpack( ret, 2, ret.n ))
	end,
	exec = function(mi,path)
		qualpath = get_data_path() .. '/' .. path
		local file = io.open(qualpath,"rb")
		if not file or type(file) == "string" or type(file) == "number" then
			file = io.open(qualpath .. ".txt","rb")
			if not file or type(file) == "string" or type(file) == "number" then
				return mlog.warning(mi, true, 'attempted to read the batch file "' .. path .. '", but failed.')
			end
		end
		local data = file:read("*a")
		file:close()
		return run_console_multicommand(mi,data)
	end,
	alias = function(mi,name,...)
		if name == nil then
			for k,v in pairs(console_aliases) do
				mlog.echo(mi, true, k,v)
			end
			return
		end
		local text = ""
		for _, arg in vararg(...) do
			text = text .. ' ' .. arg
		end
		if #text == 0 then
			local msg = console_aliases[name]
			if not msg then 
				return mlog.error(mi, true, 'no alias by the name of "' .. name .. '" exists')
			end
			return mlog.echo(mi, true, msg)
		end
		console_aliases[name] = text
	end,
}

console_modes_lookup = {
	"Command Console",
	"Lua Script REPL"
}
console_modes = lookup(console_modes_lookup)

console_mode_history = {}
console_mode_history_offset = {}
console_mode_lines = {}
console_mode_raw = {}
console_mode_text = {}
console_mode_selected = {}
console_mode_color = {}
console_mode_print = {}
for mi in ipairs(console_modes_lookup) do
	console_mode_history[mi] = {}
	console_mode_history_offset[mi] = 0
	console_mode_lines[mi] = {}
	console_mode_raw[mi] = {}
	console_mode_text[mi] = ""
	console_mode_selected[mi] = {}
	console_mode_color[mi] = {}
	console_mode_print[mi] = function(...) return mlog.print(mi,true,...) end
end

console_mode_prefix = {
	"[Console]:",
	"[LuaREPL]:",
}

console_mode_on_enter = {
	function(mi,text) -- Command Console
		mlog.history(mi, true, text)
		return run_console_multicommand(mi, text)
	end,
	function(mi,text) -- Lua Script REPL
		mlog.history(mi, true, text)
		local ret = table.pack( repl_execute_lua(mi, true, text) )
		if ret.n <= 1 then return end
		if ret[1] == false then
			return mlog.error( mi, true, ret[2] )
		end
		return mlog.returns(mi, false, table.unpack( ret, 2, ret.n ))
	end
}

function imgui_on_render()
	local tx, ty = ImGui.CalcTextSize('||||||||||||||||||||||');
	local tx2, ty2, tx0_5, tx1_5 = 2*tx, 2*ty, 0.5*tx, 1.5*tx
	if ImGui.Begin("Script Console") then
		if ImGui.BeginTabBar("Mode",ImGuiTabBarFlags.Reorderable) then
			local x,y = ImGui.GetContentRegionAvail()
			for mi,ds in ipairs(console_modes_lookup) do
				local ms = tostring(mi)
				if ImGui.BeginTabItem(ds) then
					ImGui.EndTabItem()
					if autoexec_name then
						local name = autoexec_name
						autoexec_name = nil
						run_console_command(mi,"exec " .. name)
					end
					if ImGui.BeginListBox("##Box" .. ms,x,y-ty2) then
						for li,ls in ipairs(console_mode_lines[mi]) do
							local _, y = ImGui.CalcTextSize(ls)
							console_mode_selected[mi][li] = ImGui.Selectable("##Select" .. ms .. tostring(li), console_mode_selected[mi][li] or false, ImGuiSelectableFlags.AllowDoubleClick, 0, y)
							if ImGui.IsItemHovered() and ImGui.IsItemClicked(ImGuiMouseButton.Right) then
								local selected = not console_mode_selected[mi][li]
								for oli in ipairs(console_mode_lines[mi]) do
									console_mode_selected[mi][oli] = selected
								end
							end
							ImGui.SameLine()
							local color = console_mode_color[mi][li]
							if color ~= nil then ImGui.PushStyleColor(ImGuiCol.Text, color) end
							ImGui.TextWrapped(ls)
							if color ~= nil then ImGui.PopStyleColor() end
						end
						ImGui.EndListBox()
					end
					local enter
					ImGui.PushItemWidth(x-tx1_5)
					console_mode_text[mi], enter = ImGui.InputText("##Text" .. ms, console_mode_text[mi], 512, ImGuiInputTextFlags.EnterReturnsTrue)
					ImGui.PopItemWidth()
					if enter then
						local text = console_mode_text[mi]
						table.insert(console_mode_history[mi],text)
						console_mode_history_offset[mi] = 0
						console_mode_text[mi] = ""
						console_mode_on_enter[mi](mi, text)
					end
					local changed_offset
					ImGui.SameLine()
					if ImGui.Button("^##" .. ms) then
						console_mode_history_offset[mi] = console_mode_history_offset[mi] + 1
						if console_mode_history_offset[mi] > #console_mode_history[mi] then
							console_mode_history_offset[mi] = #console_mode_history[mi]
						end
						changed_offset = true
					end
					ImGui.PushItemWidth(tx0_5)
					ImGui.SameLine()
					if ImGui.Button("v##" .. ms) then
						console_mode_history_offset[mi] = console_mode_history_offset[mi] - 1
						if console_mode_history_offset[mi] < 0 then
							console_mode_history_offset[mi] = 0
						end
						changed_offset = true
					end
					if changed_offset then
						if console_mode_history_offset[mi] == 0 then
							console_mode_text[mi] = ""
						else
							console_mode_text[mi] = console_mode_history[mi][#console_mode_history[mi]-console_mode_history_offset[mi]+1]
						end
					end
					ImGui.PopItemWidth()
					ImGui.PushItemWidth(tx)
					--ImGui.SameLine()
					--if ImGui.Button("< Paste##" .. ms) then
					--	console_mode_text[mi] = ImGui.GetClipboardText()
					--end
					ImGui.SameLine()
					if ImGui.Button("Copy ^##" .. ms) then
						local text
						for hi,b in ipairs(console_mode_selected[mi]) do
							if b then 
								local line = console_mode_raw[mi][hi] or console_mode_lines[mi][hi]
								if text == nil then
									text = line
								else
									text = text .. '\n' .. line
								end
							end
						end
						ImGui.SetClipboardText(text)
					end
					ImGui.PopItemWidth()
				end
			end
			ImGui.EndTabBar()
		end
	end
	ImGui.End()
end

gui.add_imgui(imgui_on_render)