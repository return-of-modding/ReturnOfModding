if inext ~= nil then return end -- don't run this on refresh

-- GLOBAL BASE EXTENSIONS

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
_G.rawnext = next

-- invokes __next
function _G.next( t, k )
	local m = debug.getmetatable( t )
	local f = m and rawget(m,'__next') or rawnext
	return pusherror( f, t, k )
end

-- truly raw pairs, ignores __next and __pairs
function _G.rawpairs( t )
	return rawnext, t, nil
end

-- doesn't invoke __index just like rawnext
function _G.rawinext( t, i )

	if type( t ) ~= "table" then
		error( "bad argument #1 to '" .. getname( ) .. "'(table expected got " .. type( t ) ..")", 2 )
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
function _G.inext( t, i )
	local m = debug.getmetatable( t )
	local f = m and rawget(m,'__inext') or rawinext
	return pusherror( f, t, i )
end

-- truly raw ipairs, ignores __inext and __ipairs
function _G.rawipairs( t )
	return function( self, key )
		return rawinext( self, key )
	end, t, nil
end

local _ipairs = ipairs

-- fix 5.4's ipairs to still respect __ipairs
function _G.ipairs( t )
	local m = debug.getmetatable( t )
	local f = m and rawget(m,'__ipairs') or _ipairs
	return pusherror( f, t, i )
end

function _G.setfenv( fn, env )
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

function _G.getfenv( fn )
	if type( fn ) ~= "function" then
		fn = debug.getinfo( ( fn or 1 ) + 1, "f" ).func
	end
	local i = 0
	repeat
		i = i + 1
		local name, env = debug.getupvalue( fn, i )
		if name == "_ENV" then
			return env
		end
	until not name
end

-- GLOBAL UTILITY EXTENSIONS

_G.util = {}

function util.perform_lookup(t,s,f)
	for k,v in pairs(t) do
		if f ~= nil then v = f(v) end
		if v == s then return k end
	end
	return nil
end

function util.perform_index(t,s,f)
	for k,v in ipairs(t) do
		if f ~= nil then v = f(v) end
		if v == s then return k end
	end
	return nil
end

function util.build_lookup(t,f)
	local l = {}
	for k,v in pairs(t) do
		if f ~= nil then v = f(v) end
		if v ~= nil then l[v] = k end
	end
	return l
end

function util.build_index(t,f)
	local l = {}
	for k,v in ipairs(t) do
		if f ~= nil then v = f(v) end
		if v ~= nil then l[v] = k end
	end
	return l
end

function util.clear(t)
	for k in pairs(t) do
		t[k] = nil
	end
end

function util.iclear(...)
	local n = 0
	for _,t in util.vararg(...) do
		local l = #t
		if l > n then n = l end
	end
	if n == 0 then return end
	for _,t in util.vararg(...) do
		for i = 1, n do
			t[i] = nil
		end
	end
end

function util.merge(m,...)
	for _,t in util.vararg(...) do
		for k,v in pairs(t) do
			m[k] = v
		end
	end
	return m
end

--http://lua-users.org/wiki/VarargTheSecondClassCitizen
do
	function util.vararg(...)
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

-- GLOBAL PROXY EXTENSIONS

_G.proxy = {}

local function null() return nil end

local function define_proxy_meta(name,get_names,exists,get,set,id_register)
	local _get_names = function(s)
		local id = id_register[s]
		return get_names(id)
	end
	return {
		__name = name,
		__index = function(s,k)
			if type(k) == "number" then
				local names = _get_names(s)
				if names == nil or #names == 0 then return nil end
				k = names[k]
				if k == nil then return nil end
				local id = id_register[s]
				return (get(id,k))
			end
			local id = id_register[s]
			if not exists(id,k) then return nil end
			return (get(id,k))
		end,
		__newindex = function(s,k,v)
			local names = _get_names(s)
			if names == nil or #names == 0 then return end
			if type(k) == "number" then
				k = names[k]
				if k == nil then return end
				local id = id_register[s]
				return set(id,k,(v))
			end
			local id = id_register[s]
			if not exists(id,k) then return end
			return set(id,k,(v))
		end,
		__len = function(s)
			local names = _get_names(s)
			if names == nil or #names == 0 then return 0 end
			return #names
		end,
		__next = function(s,k)
			local names = _get_names(s)
			if names == nil or #names == 0 then return nil end
			local i
			if k == nil then
				i = 0
			elseif type(k) ~= "number" then
				i = util.perform_index(names,k)
			end
			if i == nil then return nil end
			k = names[i+1]
			if k == nil then return nil end
			local id = id_register[s]
			return k, (get(id,k))
		end,
		__pairs = function(s,k)
			local names = _get_names(s)
			if names == nil or #names == 0 then return null end
			local names_lookup = util.build_index(names)
			local id = id_register[s]
			return function(_,k)
				local i
				if k == nil then
					i = 0
				elseif type(k) ~= "number" then
					i = names_lookup[k]
				end
				if i == nil then return nil end
				k = names[i+1]
				if k == nil then return nil end
				return k, (get(id,k))
			end,s,k
		end,
		__inext = function(s,k)
			local names = _get_names(s)
			if names == nil or #names == 0 then return nil end
			local i
			if k == nil then
				i = 0
			elseif type(k) ~= "number" then
				i = util.perform_index(names,k)
			end
			if i == nil then return nil end
			k = names[i+1]
			if k == nil then return nil end
			local id = id_register[s]
			return i, (get(id,k))
		end,
		__ipairs = function(s,k)
			local names = _get_names(s)
			if names == nil or #names == 0 then return null end
			local names_lookup = util.build_index(names)
			local id = id_register[s]
			return function(_,k)
				local i
				if k == nil then
					i = 0
				elseif type(k) ~= "number" then
					i = names_lookup[k]
				end
				if i == nil then return nil end
				k = names[i+1]
				if k == nil then return nil end
				return i, (get(id,k))
			end,s,k
		end
	}
end

local instance_variables_id_register = setmetatable({},{__mode = "k"})
local instance_variables_proxy_register = setmetatable({},{__mode = "v"})

local instance_variables_proxy_meta = define_proxy_meta(
	"Variables",
	gm.variable_instance_get_names,
	gm.variable_instance_exists,
	gm.variable_instance_get,
	gm.variable_instance_set,
	instance_variables_id_register
)

function proxy.variables(id)
	local meta = getmetatable(id)
	if meta and meta.__name and meta.__name:match('CInstance') then id = id.id end
	local proxy = instance_variables_proxy_register[id]
	if proxy then return proxy end
	local proxy = setmetatable({},instance_variables_proxy_meta)
	instance_variables_proxy_register[id] = proxy
	instance_variables_id_register[proxy] = id
	return proxy
end

local struct_id_register = setmetatable({},{__mode = "k"})
local struct_proxy_register = setmetatable({},{__mode = "v"})

local struct_proxy_meta = define_proxy_meta(
	"Struct",
	gm.struct_get_names,
	gm.struct_exists,
	gm.struct_get,
	gm.struct_set,
	struct_id_register
)

proxy.struct = setmetatable({},{
	__call = function(_,id)
		local proxy = struct_proxy_register[id]
		if proxy then return proxy end
		proxy = setmetatable({},struct_proxy_meta)
		struct_proxy_register[id] = proxy
		struct_id_register[proxy] = id
		return proxy
	end
})

local global_variables_proxy_meta = define_proxy_meta(
	"Globals",
	function() return gm.variable_instance_get_names(EVariableType.GLOBAL) end,
	function(_,k) return gm.variable_global_exists(k) end,
	function(_,k) return gm.variable_global_get(k) end,
	function(_,k,v) return gm.variable_global_set(k,v) end,
	{}
)

proxy.globals = setmetatable({},global_variables_proxy_meta)

local script_call_register = setmetatable({},{__mode="v"})
local asset_register = setmetatable({},{__mode="v"})

function get_script_call(name)
	local call = script_call_register[name]
	if call then return call end
	call = function(...) return gm.call(name,...) end
	script_call_register[name] = call
	return call
end

local function get_asset(asset_name,asset_type)
	local wrap = asset_register[asset_name]
	if wrap then return wrap end
	wrap = { index = gm.constants[asset_name], name = asset_name }
	asset_register[asset_name] = wrap
	if asset_type == "script" or asset_type == "gml_script" then
		wrap.call = get_script_call(asset_name)
	end
	return wrap
end

proxy.constants = {}
local constants_lookup = {}
local constants_proxy_meta = {}

for t,v in pairs(gm.constants_type_sorted) do
	constants_lookup[t] = util.build_lookup(v)
	constants_proxy_meta[t] = {
		__name = "Constants",
		__index = function(s,k)
			if type(k) == 'number' then
				local a = v[k]
				if a == nil then return nil end
				return get_asset(a,t)
			end
			if constants_lookup[t][k] == nil then return nil end
			return get_asset(k,t)
		end,
		__newindex = function(s,k,v)
			error(2,"cannot override gamemaker asset.")
		end,
		__len = function(s)
			return #v
		end,
		__next = function(s,k)
			if type(k) == "number" then
				k = v[k]
			end
			local k = next(constants_lookup[t],k)
			return k, s[k]
		end,
		__pairs = function(s,k)
			return function(s,k)
				if type(k) == "number" then
					k = v[k]
				end
				local k = next(constants_lookup[t],k)
				return k, s[k]
			end,s,k
		end
	}
	proxy.constants[t] = setmetatable({},constants_proxy_meta[t])
end

local ds_map_id_register = setmetatable({},{__mode = "k"})
local ds_map_proxy_register = setmetatable({},{__mode = "v"})

local ds_map_proxy_meta = {
	__name = "DataMap",
	__index = function(s,k)
		local id = ds_map_id_register[s]
		return (gm.call('ds_map_find_value',id,k))
	end,
	__newindex = function(s,k,v)
		local id = ds_map_id_register[s]
		return gm.call('ds_map_set',id,k,(v))
	end,
	__next = function(s,k)
		local id = ds_map_id_register[s]
		if k == nil then
			k = gm.call('ds_map_find_first',id)
		else
			k = gm.call('ds_map_find_next',id,k)
		end
		return k, (gm.call('ds_map_find_value',id,k))
	end,
	__pairs = function(s,k)
		local id = ds_map_id_register[s]
		return function(_,k)
			if k == nil then
				k = gm.call('ds_map_find_first',id)
			else
				k = gm.call('ds_map_find_next',id,k)
			end
			return k, (gm.call('ds_map_find_value',id,k))
		end,s,k
	end
}

function proxy.map(id)
	if type(id) ~= "number" or id < 0 then return nil end
	local proxy = ds_map_proxy_register[id]
	if proxy then return proxy end
	local proxy = setmetatable({},ds_map_proxy_meta)
	ds_map_proxy_register[id] = proxy
	ds_map_id_register[proxy] = id
	return proxy
end

local ds_list_id_register = setmetatable({},{__mode = "k"})
local ds_list_proxy_register = setmetatable({},{__mode = "v"})

local ds_list_proxy_meta = {
	__name = "DataList",
	__index = function(s,k)
		if type(k) ~= "number" then return nil end
		local id = ds_list_id_register[s]
		return (gm.call('ds_list_find_value',id,k-1))
	end,
	__newindex = function(s,k,v)
		local id = ds_list_id_register[s]
		return gm.call('ds_list_set',id,k-1,(v))
	end,
	__len = function(s)
		local id = ds_list_id_register[s]
		return math.floor(gm.call('ds_list_size',id))
	end,
	__inext = function(s,k)
		local id = ds_list_id_register[s]
		k = (k or 0)
		if type(k) ~= "number" then return nil end
		local v = gm.call('ds_list_find_value',id,k)
		if v == nil then return end
		return k+1, v
	end,
	__ipairs = function(s,k)
		local id = ds_list_id_register[s]
		return function(_,k)
			k = (k or 0)
			if type(k) ~= "number" then return nil end
			local v = gm.call('ds_list_find_value',id,k)
			if v == nil then return end
			return k+1, v
		end,s,k
	end
}
ds_list_proxy_meta.__next = ds_list_proxy_meta.__inext
ds_list_proxy_meta.__pairs = ds_list_proxy_meta.__ipairs

function proxy.list(id)
	if type(id) ~= "number" or id < 0 then return nil end
	local proxy = ds_list_proxy_register[id]
	if proxy then return proxy end
	local proxy = setmetatable({},ds_list_proxy_meta)
	ds_list_proxy_register[id] = proxy
	ds_list_id_register[proxy] = id
	return proxy
end

_G.hardcoded = hardcoded or require("./hardcoded")
hardcoded.enum = {}
for k,v in pairs(hardcoded.array) do
	local enum = {}
	hardcoded.enum[k] = enum
	for i,w in pairs(v) do
		enum[w.name] = w.value or i
	end
end
for k,v in pairs(hardcoded.script) do
	v.call = get_script_call(k)
end

-- GLOBAL OBJECT EXTENSIONS

local _type = type
local _getmeta = debug.getmetatable

function _G.type(v)
	local t = _type(v)
	local m = _getmeta(v)
	if m then
		return t, m.__name
	end
	return t
end

local function endow_with_pairs_and_next(meta)
	--[[
	context behind this approach:
		sol objects are userdata or tables that have sol classes as metatables
		sol object attributes are functions in their sol class as the same field
		sol class __index function fallsback to itself so objects inherit class members
		sol __index generates a new 'new' function whenever it is requested
		sol classes have stub __pairs that just errors when called
		sol overrides next to error when that is used on a sol class
	--]]
	if not meta then return end
	local status, _next
	--if rawget(meta,'__pairs') or rawget(meta,'__next') then
	--	status, _next = false--pcall(pairs,object)
	--end
	if not status then
		local _index = rawget(meta,'__index')
		if not _index then return end
		if type(_index) ~= 'function' then
			function _next(s,k)
				return next(_index,k)
			end
		else
			function _next(s,k)
				local v,u,w
				while v == nil do
					k,u = rawnext(meta,k)
					if k == nil then return nil end
					-- ignore 'new' and metatable fields
					if k ~= 'new' and k:sub(1,2) ~= '__' then
						w = s[k]
						-- if the object reports a value different to the class
						if u ~= w then
							-- assume it's actually that object's attribute
							v = w
						end
					end
				end
				return k,v
			end
		end
		rawset(meta,'__pairs',function(s,k)
			return _next,s,k
		end)
	end
	-- __next is implemented by a custom implementation of next
	local status = false--pcall(rawnext,object)
	if not status and _next ~= nil and rawget(meta,'__next') == nil then
		rawset(meta,'__next',_next)
	end
end

local function endow_with_new_properties(meta,properties)
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

local function imgui_next_delayed_load()

	local imgui_style = ImGui.GetStyle() -- sol.ImGuiStyle*
	local imgui_vector = imgui_style["WindowPadding"] -- sol.ImVec2*
	endow_with_pairs_and_next(getmetatable(imgui_style))
	endow_with_pairs_and_next(getmetatable(imgui_vector))
	endow_with_pairs_and_next(getmetatable(ImGuiKey))
	endow_with_pairs_and_next(getmetatable(ImGuiKeyMod))
	
	if ImGui.GetStyleVar == nil then
		local imgui_vector_meta = getmetatable(imgui_vector)
		local imgui_stylevar_lookup = util.build_lookup(ImGuiStyleVar)
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

local function gm_next_delayed_load(ccode)
	local gm_instance_list = gm.CInstance.instances_all
	local gm_instance = gm_instance_list[1]
	if gm_instance == nil then return true end
	local gm_object = gm.variable_global_get("init_player")
	local gm_instance_variables = gm.variable_instance_get_names(gm_instance)
	
	endow_with_pairs_and_next(getmetatable(gm_instance_list))
	endow_with_pairs_and_next(getmetatable(gm_instance))
	endow_with_pairs_and_next(getmetatable(CInstance))
	endow_with_pairs_and_next(getmetatable(gm_object))
	endow_with_pairs_and_next(getmetatable(ccode))

	local function array_inext(t,k)
		local n = #t
		if n == 0 then return nil end
		if k ~= nil and (type(k) ~= "number" or k < 0) then return nil end
		k = (k or 0) + 1
		if n < k then return nil end
		return k,t[k]
	end
	local function array_ipairs(t,k)
		local n = #t
		if n == 0 then return nil end
		if k ~= nil and (type(k) ~= "number" or k < 0) then return nil end
		return function(_,k)
			k = (k or 0) + 1
			if n < k then return nil end
			return k,t[k]
		end,t,k
	end
	getmetatable(gm_instance_variables).__next = array_inext
	getmetatable(gm_instance_variables).__inext = array_inext
	getmetatable(gm_instance_variables).__pairs = array_ipairs
	getmetatable(gm_instance_variables).__ipairs = array_ipairs
	getmetatable(gm_instance_variables).__newindex = function(s,k,v)
		return gm.array_set(s,k-1,v)
	end
	
	local script_prefix = "gml_Script_"
	local script_prefix_index = #script_prefix+1
	local get_object_script_call = function(s)
		if s.type == YYObjectBaseType.SCRIPTREF then
			local k = s.script_name
			if not k then return nil end
			k = k:sub(script_prefix_index)
			return get_script_call(k)
		end
	end
	
	local object_lookup = util.build_lookup(YYObjectBaseType)
	local get_object_type_name = function(s) return object_lookup[s.type] end
	
	endow_with_new_properties(getmetatable(gm_object),{
		type_name = get_object_type_name,
		call = get_object_script_call
	})

	local gm_instance_id_register = setmetatable({},{__mode='k'})
	local gm_class_name_register = setmetatable({},{__mode='k'})
	local gm_instance_fields_register = setmetatable({},{__mode='k'})

	local gm_instance_meta = {
		__index = function(t,k)
			local field = k
			if type(k) ~= "number" then
				local fields = gm_instance_fields_register[t]
				field = fields[k]
				if field == nil then return nil end
			end
			local array = proxy.globals[gm_class_name_register[t]]
			local id = gm_instance_id_register[t]
			array = array[id]
			if array == nil then return nil end
			return array[field]
		end,
		__newindex = function(t,k,v)
			local fields = gm_instance_fields_register[t]
			local field = fields[k]
			if not field then error("setting unknown field " .. k) end
			local array = proxy.globals[gm_class_name_register[t]]
			local id = gm_instance_id_register[t]
			array = array[id]
			if array == nil then return end
			array[field] = v
		end,
		__len = function(t)
			local array = proxy.globals[gm_class_name_register[t]]
			local id = gm_instance_id_register[t]
			local array = array[id]
			if array == nil then return 0 end
			return #array
		end,
		__next = function(t,k)
			local field
			local fields = gm_instance_fields_register[t]
			k, field = next(fields,k)
			if k == nil then return nil end
			local array = proxy.globals[gm_class_name_register[t]]
			local id = gm_instance_id_register[t]
			array = array[id]
			if array == nil then return nil end
			return k,array[field]
		end,
		__pairs = function(t,k)
			local fields = gm_instance_fields_register[t]
			local array = proxy.globals[gm_class_name_register[t]]
			local id = gm_instance_id_register[t]
			array = array[id]
			if array == nil then return null end
			return function(_,k)
				local field
				k, field = next(fields,k)
				if k == nil then return nil end
				return k,array[field]
			end,t,k
		end,
		__inext = function(t,k)
			local array = proxy.globals[gm_class_name_register[t]]
			local id = gm_instance_id_register[t]
			array = array[id]
			if array == nil then return nil end
			local n = #array
			if n == 0 then return nil end
			if k ~= nil and (type(k) ~= "number" or k < 0 or n <= k) then return nil end
			k = (k or 0) + 1
			if n < k then return nil end
			return k,array[k]
		end,
		__ipairs = function(t,k)
			local array = proxy.globals[gm_class_name_register[t]]
			local id = gm_instance_id_register[t]
			array = array[id]
			if array == nil then return nil end
			local n = #array
			if n == 0 then return null end
			if k ~= nil and (type(k) ~= "number" or k < 0 or n <= k) then return nil end
			return function(_,k)
				k = (k or 0) + 1
				if n < k then return nil end
				return k,array[k]
			end,t,k
		end
	}

	-- for interacting with global arrays as classes
	-- thanks to sarn
	local function gm_array_class(name, array, fields)
		local instances = setmetatable({},{__mode='kv'})
		
		local function get_proxy(id)
			local proxy = instances[id]
			if proxy then return proxy end
			local _name = ''
			for s in name:gmatch('_(%w+)') do
				_name = _name .. s:sub(1,1):upper() .. s:sub(2)
			end
			proxy = setmetatable({}, util.merge({ __name = _name }, gm_instance_meta))
			instances[id] = proxy
			gm_instance_id_register[proxy] = math.floor(id)
			gm_class_name_register[proxy] = name
			gm_instance_fields_register[proxy] = fields
			return proxy
		end
		
		return setmetatable({},{
			__name = "Class",
			__call = function(_,id)
				local n = #array
				if n == 0 then return nil end
				if id ~= nil and (type(id) ~= "number" or id < 0 or n <= id) then return nil end
				return get_proxy(id+1)
			end,
			__index = function(_,id)
				local n = #array
				if n == 0 then return nil end
				if id ~= nil and (type(id) ~= "number" or id < 1 or n < id) then return nil end
				return get_proxy(id)
			end,
			__newindex = function(_,k,v)
				array[k] = v
			end,
			__len = function(_)
				return #array
			end,
			__next = function(s,k)
				local n = #array
				if n == 0 then return nil end
				if k ~= nil and (type(k) ~= "number" or k < 0 or n <= k) then return nil end
				k = (k or 0) + 1
				if n < k then return nil end
				return k,s[k]
			end,
			__pairs = function(s,k)
				local n = #array
				if n == 0 then return null end
				if k ~= nil and (type(k) ~= "number" or k < 0 or n <= k) then return nil end
				return function(_,k)
					k = (k or 0) + 1
					if n < k then return nil end
					return k,s[k]
				end,s,k
			end,
			__inext = function(s,k)
				return getmetatable(s).__next(s,k)
			end,
			__ipairs = function(s,k)
				return getmetatable(s).__pairs(s,k)
			end
		})
	end
	
	hardcoded.class = {}
	for k,v in pairs(hardcoded.enum) do
		local class_name = k:lower()
		local class_array = gm.variable_global_get(class_name)
		if class_array then
			hardcoded.class[class_name] = gm_array_class(class_name,class_array,v)
		end
	end
end

endow_with_pairs_and_next(getmetatable(EVariableType))
endow_with_pairs_and_next(getmetatable(RValueType))
endow_with_pairs_and_next(getmetatable(YYObjectBaseType))

gui.add_always_draw_imgui( function()
	if imgui_next_delayed_load and imgui_next_delayed_load() ~= true then
		imgui_next_delayed_load = nil
	end
end )
gm.pre_code_execute( function(_,_,ccode)
	if gm_next_delayed_load and gm_next_delayed_load(ccode) ~= true then
		gm_next_delayed_load = nil
	end
end )
