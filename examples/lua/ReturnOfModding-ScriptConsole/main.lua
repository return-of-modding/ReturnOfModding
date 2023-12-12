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
	local f = m and rawget(m,'__next') or rawnext
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
	local f = m and rawget(m,'__inext') or rawinext
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

function perform_lookup(t,s,f)
	for k,v in pairs(t) do
		if f ~= nil then v = f(v) end
		if v == s then return k end
	end
	return nil
end

function build_lookup(t,f)
	local l = {}
	for k,v in pairs(t) do
		if f ~= nil then v = f(v) end
		if v ~= nil then l[v] = k end
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

function merge(m,...)
	for _,t in vararg(...) do
		for k,v in pairs(t) do
			m[k] = v
		end
	end
	return m
end

--http://lua-users.org/wiki/VarargTheSecondClassCitizen
do
	function vararg(...)
		local i, t, l = 0, {}
		local function iter(...)
			i = i + 1
			if i > l then return end
			return i, t[i]
		end
		
		--i = 0
		l = select("#", ...)
		for n = 1, l do
			t[n] = select(n, ...)
		end
		--[[
		for n = l+1, #t do
			t[n] = nil
		end
		--]]
		return iter
	end
end

-- MOD SPECIFIC CODE:

function find_instance(name)
	for k,v in pairs(gm.CInstance.instances_active) do
		if v.object_name == name then return v end
	end
	for k,v in pairs(gm.CInstance.instances_all) do
		if v.object_name == name then return v end
	end
	return nil
end

function variables(...)
	return cinstance_variables_proxy(...)
end

function globals()
	return global_variables_proxy
end

function functions()
	return constants_proxy.scripts
end

local _repl_globals = {}
for k,v in pairs(_G) do
	_repl_globals[k] = v
end
for k,v in pairs(_ENV) do
	_repl_globals[k] = v
end
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
	for _,v in vararg(...) do
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
	for k,v in pairs(md.definitions) do
		repl_globals[k] = v
	end
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
		iclear(parse_buffer)
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
		iclear(parse_buffer)
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
		for _, arg in vararg(...) do
			text = text .. ' ' .. arg
		end
		text = text:sub(2,#text)
		return console_logger.echo(md,true,text)
	end,
	lua = function(md,...)
		local text = ""
		for _, arg in vararg(...) do
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
		for _, arg in vararg(...) do
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
			for _,o in vararg(...) do
				console_logger.print(get_md(),false,o)
				if type(o) == "table" or type(o) == "userdata" then
					for k,v in pairs(o) do
						console_logger.print(get_md(),false,k,v)
					end
				end
			end
		end,
		mprint = function(m,...)
			for _,o in vararg(...) do
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
	merge(md,{
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
merge(_ENV,console_mode_definitions(function() return console_mode end))

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

function endow_with_pairs_and_next(sol_object)
	-- this should be idempotent (does nothing extra when applied more than once)
	--[[
	context behind this approach:
		sol objects are userdata or tables that have sol classes as metatables
		sol object attributes are functions in their sol class as the same field
		sol class __index function fallsback to itself so objects inherit class members
		sol __index generates a new 'new' function whenever it is requested
		sol classes have stub __pairs that just errors when called
		sol overrides next to error when that is used on a sol class
	--]]
	local sol_meta = getmetatable(sol_object)
	if not sol_meta then return end
	local status, sol_next
	if rawget(sol_meta,'__pairs') or rawget(sol_meta,'__next') then
		status, sol_next = pcall(pairs,sol_object)
	end
	if not status then
		local sol_index = rawget(sol_meta,'__index')
		if not sol_index then return end
		if type(sol_index) ~= 'function' then
            function sol_next(s,k)
                return next(sol_index,k)
            end
        else
			function sol_next(s,k)
				local v,u,w
				while v == nil do
					k,u = rawnext(sol_meta,k)
					if k == nil then return nil end
					w = s[k]
					-- if the object reports a value different to the class
					if u ~= w then
						-- and the value is the same each time it is requested
						u = s[k]
						if u == w then
							-- assume it's actually that object's attribute
							v = w
						end
					end
				end
				return k,v
			end
		end
		rawset(sol_meta,'__pairs',function(s,k)
			return sol_next,s,k
		end)
	end
	-- __next is implemented by a custom implementation of next
	local status = pcall(rawnext,sol_object)
	if not status and sol_next ~= nil and rawget(sol_meta,'__next') == nil then
		rawset(sol_meta,'__next',sol_next)
	end
end

function endow_with_new_properties(sol_object,properties)
	local meta = getmetatable(sol_object)
	local new_properties = {}
	for k,v in pairs(properties) do
		if not rawget(meta,k) then
			new_properties[k] = v
			rawset(meta,k,v)
		end
	end
	local index = meta.__index
	meta.__index = function(s,k)
		local v = new_properties[k]
		if v then return v(s) end
		return index(s,k)
	end
end

do
	local function getstring(o)
		return o.tostring
	end
	
	local function getnumber(o)
		return tonumber(o.tostring)
	end

	local function peval(o)
		local func = load("return " .. o.tostring)
		if not func then return nil end
		local status, value = pcall(func)
		if not status then return nil end
		return value
	end
	
	local function null()
		return nil
	end
	
	local function istrue(o)
		return o.tostring == 'true'
	end

	local function getarray(o)
		return o.array
	end

	rvalue_marshallers = {
		[RValueType.REAL] = getnumber,
		[RValueType.STRING] = getstring,
		[RValueType.ARRAY] = getarray,
		[RValueType.PTR] = nil,
		[RValueType.VEC3] = nil,
		[RValueType.UNDEFINED] = null,
		[RValueType.OBJECT] = nil,
		[RValueType.INT32] = getnumber,
		[RValueType.VEC4] = nil,
		[RValueType.MATRIX] = nil,
		[RValueType.INT64] = getnumber,
		[RValueType.ACCESSOR] = nil,
		[RValueType.JSNULL] = null,
		[RValueType.BOOL] = istrue,
		[RValueType.ITERATOR] = nil,
		[RValueType.REF] = nil,
		[RValueType.UNSET] = null
	}

	function rvalue_marshall(rvalue)
		local m = rvalue_marshallers[rvalue.type]
		if m == nil then return rvalue end
		return m(rvalue)
	end

	local function get_name(rvalue)
		return rvalue.tostring
	end

	local cinstance_variables_id_register = setmetatable({},{__mode = "k"})

	local cinstance_variables_proxy_meta = {
		__index = function(s,k)
			local id = cinstance_variables_id_register[s]
			return rvalue_marshall(gm.variable_instance_get(id,k))
		end,
		__newindex = function(s,k,v)
			local id = cinstance_variables_id_register[s]
			return gm.variable_instance_set(id,k,v)
		end,
		__next = function(s,k)
			local id = cinstance_variables_id_register[s]
			local names = gm.variable_instance_get_names(id)
			if names.type ~= RValueType.ARRAY then return nil end
			names = names.array
			local i = k and perform_lookup(names,k,get_name) or 0
			k = names[i+1]
			if k == nil then return nil end
			k = k.tostring
			return k, rvalue_marshall(gm.variable_instance_get(id,k))
		end,
		__pairs = function(s,k)
			local id = cinstance_variables_id_register[s]
			local names = gm.variable_instance_get_names(id)
			if names.type ~= RValueType.ARRAY then return nil end
			names = names.array
			local names_lookup = build_lookup(names,get_name)
			return function(_,k)
				local i = k and names_lookup[k] or 0
				k = names[i+1]
				if k == nil then return nil end
				k = k.tostring
				return k, rvalue_marshall(gm.variable_instance_get(id,k))
			end,s,k
		end
	}

	function cinstance_variables_proxy(cinstance)
		local proxy = setmetatable({},cinstance_variables_proxy_meta)
		cinstance_variables_id_register[proxy] = cinstance.id
		return proxy
	end

	local global_variables_proxy_meta = {
		__index = function(s,k)
			return rvalue_marshall(gm.variable_instance_get(EVariableType.GLOBAL,k))
		end,
		__newindex = function(s,k,v)
			return gm.variable_instance_set(EVariableType.GLOBAL,k,v)
		end,
		__next = function(s,k)
			local names = gm.variable_instance_get_names(EVariableType.GLOBAL)
			if names.type ~= RValueType.ARRAY then return nil end
			names = names.array
			local i = k and perform_lookup(names,k,get_name) or 0
			k = names[i+1]
			if k == nil then return nil end
			k = k.tostring
			return k, rvalue_marshall(gm.variable_instance_get(EVariableType.GLOBAL,k))
		end,
		__pairs = function(s,k)
			local names = gm.variable_instance_get_names(EVariableType.GLOBAL)
			if names.type ~= RValueType.ARRAY then return nil end
			names = names.array
			local names_lookup = build_lookup(names,get_name)
			return function(_,k)
				local i = k and names_lookup[k] or 0
				k = names[i+1]
				if k == nil then return nil end
				k = k.tostring
				return k, rvalue_marshall(gm.variable_instance_get(EVariableType.GLOBAL,k))
			end,s,k
		end
	}

	global_variables_proxy = setmetatable({},global_variables_proxy_meta)
	
	local constants_scripts_lookup = build_lookup(gm.constants_type_sorted.script)

	local constants_scripts_proxy_meta = {
		__index = function(s,k)
			return gm[k]
		end,
		__newindex = function(s,k,v)
			error(2,"cannot override gamemaker script by assigning to gm.")
		end,
		__next = function(s,k)
			local k = next(constants_scripts_lookup,k)
			return k, gm[k]
		end,
		__pairs = function(s,k)
			return function(s,k)
				local k = next(constants_scripts_lookup,k)
				return k, gm[k]
			end,s,k
		end
	}
	
	constants_proxy = { scripts = setmetatable({},constants_scripts_proxy_meta) }
end

function on_delayed_load()

	local gm_instance_list = gm.CInstance.instances_all
	local gm_instance = gm_instance_list[1]
	if not gm_instance then return false end
	local gm_rvalue = gm.variable_global_get("mouse_x")
	
	local imgui_style = ImGui.GetStyle() -- sol.ImGuiStyle*
	local imgui_vector = imgui_style["WindowPadding"] -- sol.ImVec2*
	endow_with_pairs_and_next(imgui_style)
	endow_with_pairs_and_next(imgui_vector)

	endow_with_pairs_and_next(gm_instance_list)
	endow_with_pairs_and_next(gm_instance)
	endow_with_pairs_and_next(gm_rvalue)
	endow_with_pairs_and_next(RValueType)
	
	local rvalue_lookup = build_lookup(RValueType)
	endow_with_new_properties(gm_rvalue,{
			type_name = function(s) return rvalue_lookup[s.type] end,
			lua_value = rvalue_marshall
	})
	
	if ImGui.GetStyleVar == nil then
		local imgui_vector_meta = getmetatable(imgui_vector)
		local imgui_stylevar_lookup = build_lookup(ImGuiStyleVar)
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
	
	return true
end

local next_delayed_load = on_delayed_load

function imgui_on_render()
	if next_delayed_load and next_delayed_load() then
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
						iclear(md.lines_shown,md.lines_raw,md.lines_selected,md.lines_colors)
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
					if ImGui.BeginListBox("##Box" .. ms,x,box_y) then
						for li,ls in ipairs(md.lines_shown) do
							local _, y = ImGui.CalcTextSize(ls)
							md.lines_selected[li] = ImGui.Selectable("##Select" .. ms .. tostring(li), md.lines_selected[li] or false, ImGuiSelectableFlags.AllowDoubleClick, 0, y)
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
					end
					ImGui.PushItemWidth(x_input)
					ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, frame_padding_x, y_input)
					md.current_text, md.enter_pressed = ImGui.InputText("##Text" .. ms, md.current_text, 512, ImGuiInputTextFlags.EnterReturnsTrue)
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