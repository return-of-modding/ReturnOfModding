-- BASE EXTENSIONS: Should be rolled into the base API if desired

local unpack = table.unpack

local function getname( )
	return debug.getinfo( 2, "n" ).name or "UNKNOWN"
end

local function pusherror( f, ... )
	local ret = table.pack( pcall( f, ... ) )
	if ret[ 1 ] then return unpack( ret, 2, ret.n ) end
	error( ret[ 2 ], 3 )
end

-- doesn't invoke __index
rawnext = next

-- invokes __next
function next( t, k )
	local m = debug.getmetatable( t )
	local f = m and m.__next or rawnext
	return pusherror( f, t, k )
end

-- truly raw pairs, ignores __next and __pairs
function rawpairs( t )
	return rawnext, t, nil
end

--[[

-- quasi-raw pairs, invokes __next but ignores __pairs
function qrawpairs( t )
    return next, t, nil
end

--]]

-- doesn't invoke __index just like rawnext
function rawinext( t, i )

	if type( t ) ~= "table" then
		error( "bad argument #1 to '" .. getname( ) .. "'(table expected got " .. type( i ) ..")", 2 )
	end

	if i == nil then
		i = 0
	elseif type( i ) ~= "number" then
		error( "bad argument #2 to '" .. getname( ) .. "'(number expected got " .. type( i ) ..")", 2 )
	elseif i < 0 then
		error( "bad argument #2 to '" .. getname( ) .. "'(index out of bounds, too low)", 2 )
	end

	i = i + 1
	local v = rawget( t, i )
	if v ~= nil then
		return i, v
	end
end

-- invokes __inext
function inext( t, i )
	local m = debug.getmetatable( t )
	local f = m and m.__inext or rawinext
	return pusherror( f, t, i )
end

-- truly raw ipairs, ignores __inext and __ipairs
function rawipairs( t )
	return function( self, key )
		return rawinext( self, key )
	end, t, nil
end

--[[

-- quasi-raw ipairs, invokes __inext but ignores __ipairs
function qrawipairs( t )
	return function( self, key )
		return inext( self, key )
	end, t, nil
end

--]]

--[[

table.rawinsert = table.insert
local rawinsert = table.rawinsert
-- table.insert that respects metamethods
function table.insert( list, pos, value )
	local last = #list
	if value == nil then
		value = pos
		pos = last + 1
	end
	if pos < 1 or pos > last + 1 then
		error( "bad argument #2 to '" .. getname( ) .. "' (position out of bounds)", 2 )
	end
	if pos <= last then
		local i = last
		repeat
			list[ i + 1 ] = list[ i ]
			i = i - 1
		until i < pos
	end
	list[ pos ] = value
end

table.rawremove = table.remove
-- table.remove that respects metamethods
function table.remove( list, pos )
	local last = #list
	if pos == nil then
		pos = last
	end
	if pos < 1 or pos > last then
		error( "bad argument #2 to '" .. getname( ) .. "' (position out of bounds)", 2 )
	end
	local value = list[ pos ]
	if pos <= last then
		local i = pos
		repeat
			list[ i ] = list[ i + 1 ]
			i = i + 1
		until i > last
	end
	return value
end

table.rawunpack = table.unpack
-- table.unpack that respects metamethods
do
	local function unpack( t, m, i, ... )
		if i < m then return ... end
		return unpack( t, m, i - 1, t[ i ], ... )
	end
	
	function table.unpack( list, i, j )
		return unpack( list, i or 1, j or list.n or #list or 1 )
	end
end

local rawconcat = table.concat
table.rawconcat = rawconcat
-- table.concat that respects metamethods and includes more values
do
	local wt = setmetatable( { }, { __mode = 'v' } )
	function table.concat( tbl, sep, i, j )
		i = i or 1
		j = j or tbl.n or #tbl
		if i > j then return "" end
		sep = sep or ""
		local t = rawnext( wt ) or { }
		rawset( wt, 1, t )
		for k = i, j, 1 do
			rawset( t, k, tostring( tbl[ k ] ) )
		end
		return rawconcat( t, sep, i, j )
	end
end

--[[
	NOTE: Other table functions that need to get updated to respect metamethods
	- table.sort
--]]

--]]

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

function lookup(t)
	local l = {}
	for k,v in pairs(t) do
		l[v] = k
	end
	return l
end

function clear(t)
	for k in pairs(t) do
		t[k] = nil
	end
end

function iclear(...)
	local n = 0
	for _,t in vararg(...) do
		local l = #t
		if l > n then n = l end
	end
	if n == 0 then return end
	for _,t in vararg(...) do
		for i = 1, n do
			t[i] = nil
		end
	end
end

--http://lua-users.org/wiki/VarargTheSecondClassCitizen
do -- not thread safe
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

-- MOD SPECIFIC CODE:

local _repl_globals = {}
for k,v in pairs(_G) do
	_repl_globals[k] = v
end
for k,v in pairs(_ENV) do
	_repl_globals[k] = v
end
repl_globals = _repl_globals
repl_environment = setmetatable( { }, {
	__index = repl_globals,
	__newindex = repl_globals
} )

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
		iclear(parse_command_text_buffer)
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
		iclear(parse_multicommand_text_buffer)
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
		text = text:sub(2,#text)
		return mlog.echo(mi,true,text)
	end,
	lua = function(mi,...)
		local text = ""
		for _, arg in vararg(...) do
			text = text .. ' ' .. arg
		end
		text = text:sub(2,#text)
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
		qualpath = _ENV["!plugins_data_mod_folder_path"] .. '/' .. path
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
		qualpath = _ENV["!plugins_data_mod_folder_path"] .. '/' .. path
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
		text = text:sub(2,#text)
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
console_mode_enter_pressed = {}
for mi in ipairs(console_modes_lookup) do
	console_mode_text[mi] = ""
	console_mode_enter_pressed[mi] = false
	console_mode_history[mi] = {}
	console_mode_history_offset[mi] = 0
	console_mode_lines[mi] = {}
	console_mode_raw[mi] = {}
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
		local ret = table.pack(repl_execute_lua(mi, true, text))
		if ret.n <= 1 then return end
		if ret[1] == false then
			return mlog.error( mi, true, ret[2] )
		end
		repl_globals._ = ret[2]
		return mlog.returns(mi, false, table.unpack( ret, 2, ret.n ))
	end
}

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
		for i,t in vararg(...) do
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

function endow_sol_class_with_pairs_and_next(sol_object)
	-- sol objects are userdata or tables that have sol classes as metatables
	-- sol object attributes are functions in their sol class as the same field
	-- sol objects share `new`, `class_check` and `class_cast`
	-- sol classes are metatables that do not themselves have metatables
	-- sol classes have stub __pairs that just errors when called
	-- sol overrides `next` to error when that is used on a sol class
	local sol_meta = getmetatable(sol_object)
	if not sol_meta then return end
	local status, sol_next = pcall(pairs,sol_object)
	if not status then
		function sol_next(s,k)
			local v
			while v == nil do
				k = next(sol_meta,k)
				if k == nil then return nil end
				if k:sub(0,2) ~= "__"
					and k ~= "new"
					and k ~= "class_check" 
					and k ~= "class_cast"
				then
					v = s[k]
				end
			end
			return k,v
		end
		sol_meta.__pairs = function(s,k)
			return sol_next,s,k
		end
	end
	local status = pcall(rawnext,sol_object)
	if not status and sol_next ~= nil and sol_meta.__next == nil then
		sol_meta.__next = sol_next
	end
end

function on_delayed_load()
	local imgui_style = ImGui.GetStyle() -- sol.ImGuiStyle*
	local imgui_vector = imgui_style["WindowPadding"] -- sol.ImVec2*
	local gm_instance_list = gm.CInstance.instances_all
	local gm_instance = gm_instance_list[1]
	local gm_rvalue = gm.variable_global_get("mouse_x")

	endow_sol_class_with_pairs_and_next(imgui_style)
	endow_sol_class_with_pairs_and_next(imgui_vector)
	endow_sol_class_with_pairs_and_next(gm_instance_list)
	endow_sol_class_with_pairs_and_next(gm_instance)
	endow_sol_class_with_pairs_and_next(gm_rvalue)
	
	if ImGui.GetStyleVar == nil then
		local imgui_vector_meta = getmetatable(imgui_vector)
		local imgui_stylevar_lookup = lookup(ImGuiStyleVar)
		imgui_stylevar_lookup[ImGuiStyleVar.COUNT] = nil

		function ImGui.GetStyleVar(var)
			if type(var) == "number" then
				var = imgui_stylevar_lookup[var]
			end
			local s = ImGui.GetStyle()[var]
			if getmetatable(s) ~= imgui_vector_meta then return s end
			return s['x'],s['y']
		end
	end
end

local next_delayed_load = on_delayed_load

function imgui_on_render()
	if next_delayed_load then
		next_delayed_load()
		next_delayed_load = nil
	end
	if ImGui.Begin("Script Console") then
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
			for mi,ds in ipairs(console_modes_lookup) do
				local ms = tostring(mi)
				if ImGui.BeginTabItem(ds) then
					ImGui.EndTabItem()
					if autoexec_name then
						local name = autoexec_name
						autoexec_name = nil
						run_console_command(mi,"exec " .. name)
					end
					ImGui.InvisibleButton("##Spacer" .. ms, x_bar, top_y_max)
					ImGui.SameLine()
					if ImGui.Button("Clear##" .. ms, x_clear, top_y_max) then
						iclear(console_mode_lines[mi],console_mode_raw[mi],console_mode_selected[mi],console_mode_color[mi])
					end
					ImGui.SameLine()
					if ImGui.Button("Copy##" .. ms, x_copy, top_y_max) then
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
					if ImGui.BeginListBox("##Box" .. ms,x,box_y) then
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
					ImGui.PushItemWidth(x_input)
					ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, frame_padding_x, y_input)
					console_mode_text[mi], console_mode_enter_pressed[mi] = ImGui.InputText("##Text" .. ms, console_mode_text[mi], 512, ImGuiInputTextFlags.EnterReturnsTrue)
					ImGui.PopStyleVar()
					ImGui.PopItemWidth()
					local changed_offset
					ImGui.SameLine()
					if ImGui.Button("^##" .. ms, x_up, bot_y_max) then
						console_mode_history_offset[mi] = console_mode_history_offset[mi] + 1
						if console_mode_history_offset[mi] > #console_mode_history[mi] then
							console_mode_history_offset[mi] = #console_mode_history[mi]
						end
						changed_offset = true
					end
					ImGui.SameLine()
					if ImGui.Button("v##" .. ms, x_down, bot_y_max) then
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
				end
			end
			ImGui.EndTabBar()
		end
	end
	ImGui.End()
	-- handling entering input separate from constructing the UI
	-- so actions that use ImGui will be separate from the console's UI
	for mi,pressed in ipairs(console_mode_enter_pressed) do
		if pressed then
			console_mode_enter_pressed[mi] = false
			console_mode_history_offset[mi] = 0
			local text = console_mode_text[mi]
			table.insert(console_mode_history[mi],text)
			console_mode_text[mi] = ""
			console_mode_on_enter[mi](mi, text)
		end
	end
end

gui.add_imgui(imgui_on_render)