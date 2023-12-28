if inext == nil then -- don't run this on refresh

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

	--[[

	-- quasi-raw pairs, invokes __next but ignores __pairs
	function qrawpairs( t )
		return next, t, nil
	end

	--]]

	-- doesn't invoke __index just like rawnext
	function _G.rawinext( t, i )

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

	--[[

	-- quasi-raw ipairs, invokes __inext but ignores __ipairs
	function _G.qrawipairs( t )
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

end

if util == nil then -- don't run this on refresh

	-- GLOBAL UTILITY EXTENSIONS

	_G.util = {}

	function util.perform_lookup(t,s,f)
		for k,v in pairs(t) do
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

	--http://lua-users.org/wiki/util.varargTheSecondClassCitizen
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
end

if _G.proxy == nil then -- don't do this on refresh

	-- GLOBAL PROXY EXTENSIONS

	_G.proxy = {}

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
	
	local function getobject(o)
		return o.object
	end

	rvalue_marshallers = {
		[RValueType.REAL] = getnumber,
		[RValueType.STRING] = getstring,
		[RValueType.ARRAY] = getarray,
		[RValueType.PTR] = nil,
		[RValueType.VEC3] = nil,
		[RValueType.UNDEFINED] = null,
		[RValueType.OBJECT] = getobject,
		[RValueType.INT32] = getnumber,
		[RValueType.VEC4] = nil,
		[RValueType.MATRIX] = nil,
		[RValueType.INT64] = getnumber,
		[RValueType.ACCESSOR] = nil,
		[RValueType.JSNULL] = nil,
		[RValueType.BOOL] = istrue,
		[RValueType.ITERATOR] = nil,
		[RValueType.REF] = nil,
		[RValueType.UNSET] = null
	}

	function rvalue_marshall(rvalue)
		local m = rvalue_marshallers[rvalue.type]
		if m == nil then return nil end
		return m(rvalue)
	end
	
	local function rvalue_marshall_get(rvalue)
		--in case some massaging is needed
		return rvalue
	end
	
	local function rvalue_marshall_set(rvalue)
		--in case some massaging is needed
		return rvalue
	end

	local function get_name(rvalue)
		return rvalue.tostring
	end

	local function define_proxy_meta(get_names,exists,get,set,id_register)
		local _get_names = function(s)
			local id = id_register[s]
			local names = get_names(id)
			if names.type ~= RValueType.ARRAY then return nil end
			return names.array
		end
		return {
			__index = function(s,k)
				if type(k) == "number" then
					local names = _get_names(s)
					if not names then return nil end
					k = names[k]
					if k == nil then return nil end
					k = k.tostring
					local id = id_register[s]
					return rvalue_marshall_get(get(id,k))
				end
				if not exists(id,k).lua_value then return nil end
				local id = id_register[s]
				return rvalue_marshall_get(get(id,k))
			end,
			__newindex = function(s,k,v)
				local names = _get_names(s)
				if not names then return end
				if type(k) == "number" then
					k = names[k]
					if k == nil then return end
					k = k.tostring
					local id = id_register[s]
					return set(id,k,rvalue_marshall_set(v))
				end
				if not exists(id,k).lua_value then return end
				local id = id_register[s]
				return set(id,k,rvalue_marshall_set(v))
			end,
			__len = function(s)
				local names = _get_names(s)
				if not names then return 0 end
				return #names
			end,
			__next = function(s,k)
				local names = _get_names(s)
				if not names then return nil end
				local i
				if k == nil then
					i = 0
				elseif type(k) ~= "number" then
					i = util.perform_lookup(names,k,get_name)
				end
				if i == nil then return nil end
				k = names[i+1]
				if k == nil then return nil end
				k = k.tostring
				local id = id_register[s]
				return k, rvalue_marshall_get(get(id,k))
			end,
			__pairs = function(s,k)
				local names = _get_names(s)
				if not names then return null end
				local names_lookup = util.build_lookup(names,get_name)
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
					k = k.tostring
					return k, rvalue_marshall_get(get(id,k))
				end,s,k
			end,
			__inext = function(s,k)
				local names = _get_names(s)
				if not names then return nil end
				local i
				if k == nil then
					i = 0
				elseif type(k) ~= "number" then
					i = util.perform_lookup(names,k,get_name)
				end
				if i == nil then return nil end
				k = names[i+1]
				if k == nil then return nil end
				k = k.tostring
				local id = id_register[s]
				return i, rvalue_marshall_get(get(id,k))
			end,
			__ipairs = function(s,k)
				local names = _get_names(s)
				if not names then return null end
				local names_lookup = util.build_lookup(names,get_name)
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
					k = k.tostring
					return i, rvalue_marshall_get(get(id,k))
				end,s,k
			end
		}
	end

	local instance_variables_id_register = setmetatable({},{__mode = "k"})
	local instance_variables_proxy_register = setmetatable({},{__mode = "v"})

	local instance_variables_proxy_meta = define_proxy_meta(
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
		local meta = getmetatable(id)
		instance_variables_proxy_register[id] = proxy
		instance_variables_id_register[proxy] = id
		return proxy
	end

	local struct_id_register = setmetatable({},{__mode = "k"})
	local struct_proxy_register = setmetatable({},{__mode = "v"})

	local struct_proxy_meta = define_proxy_meta(
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

	local struct_variables_id_register = setmetatable({},{__mode = "k"})
	local struct_variables_proxy_register = setmetatable({},{__mode = "v"})

	local struct_variables_proxy_meta = define_proxy_meta(
		gm.variable_struct_get_names,
		gm.variable_struct_exists,
		gm.variable_struct_get,
		gm.variable_struct_set,
		struct_variables_id_register
	)

	function proxy.struct.variables(id)
		local proxy = struct_variables_proxy_register[id]
		if proxy then return proxy end
		proxy = setmetatable({},struct_variables_proxy_meta)
		struct_variables_proxy_register[id] = proxy
		struct_variables_id_register[proxy] = id
		return proxy
	end

	local global_variables_proxy_meta = define_proxy_meta(
		function() return gm.variable_instance_get_names(EVariableType.GLOBAL) end,
		function(_,k) return gm.variable_global_exists(k) end,
		function(_,k) return gm.variable_global_get(k) end,
		function(_,k,v) return gm.variable_global_set(k,v) end,
		{}
	)

	proxy.globals = setmetatable({},global_variables_proxy_meta)

	local function get_asset(asset_name,asset_type)
		if asset_type == 'script' then return gm[asset_name] end
		--return gm.asset_get_index(asset_name)
		return gm.constants[asset_name]
	end

	proxy.constants = {}
	local constants_lookup = {}
	local constants_proxy_meta = {}

	for t,v in pairs(gm.constants_type_sorted) do
		constants_lookup[t] = util.build_lookup(v)
		constants_proxy_meta[t] = {
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

end

if ImGui.GetStyleVar == nil then -- don't do this on refresh

	-- GLOBAL OBJECT EXTENSIONS

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
	
	local function gm_next_delayed_load()
		local gm_rvalue = gm.variable_global_get("init_player")
		local gm_object = gm_rvalue.object
		local gm_container = gm.variable_global_get("_damage_color_array")
		local gm_container_t = gm_container.array[1]
		local gm_instance_list = gm.CInstance.instances_all
		local gm_instance = gm.variable_global_get("__input_blacklist_dictionary").cinstance
		local gm_instance_variables = gm_instance:variable_instance_get_names()

		endow_with_pairs_and_next(getmetatable(gm_instance_list))
		endow_with_pairs_and_next(getmetatable(gm_instance))
		endow_with_pairs_and_next(getmetatable(gm_instance_variables))
		endow_with_pairs_and_next(getmetatable(gm_object))
		endow_with_pairs_and_next(getmetatable(gm_container_t))
		endow_with_pairs_and_next(getmetatable(gm_rvalue))
		endow_with_pairs_and_next(getmetatable(RValueType))
		endow_with_pairs_and_next(getmetatable(YYObjectBaseType))

		local rvalue_lookup = util.build_lookup(RValueType)
		local object_lookup = util.build_lookup(YYObjectBaseType)
		local get_rvalue_type_name = function(s) return rvalue_lookup[s.type] end
		local get_object_type_name = function(s) return object_lookup[s.type] end
		
		endow_with_new_properties(getmetatable(gm_rvalue),{
			type_name = get_rvalue_type_name,
			lua_value = rvalue_marshall,
			struct = proxy.struct
		})
		endow_with_new_properties(getmetatable(gm_container_t),{
			type_name = get_rvalue_type_name,
			lua_value = rvalue_marshall,
			struct = proxy.struct
		})
		endow_with_new_properties(getmetatable(gm_instance),{
			variables = proxy.variables
		})
		endow_with_new_properties(getmetatable(gm_object),{
			type_name = get_object_type_name
		})
	end

	gui.add_imgui( function()
		if imgui_next_delayed_load and imgui_next_delayed_load() ~= true then
			imgui_next_delayed_load = nil
		end
	end )
	gm.pre_code_execute( function()
		if gm_next_delayed_load and gm_next_delayed_load() ~= true then
			gm_next_delayed_load = nil
		end
	end )
end