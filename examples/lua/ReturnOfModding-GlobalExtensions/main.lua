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
		return gm.struct_get_from_hash(gm.variable_get_hash(o))
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
		[RValueType.JSNULL] = null,
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
		--return rvalue_marshall(rvalue)
		return rvalue
	end
	
	local function rvalue_marshall_set(rvalue)
		return rvalue
	end

	local function get_name(rvalue)
		return rvalue.tostring
	end

	local instance_variables_id_register = setmetatable({},{__mode = "k"})
	local instance_variables_proxy_register = setmetatable({},{__mode = "v"})

	local instance_variables_proxy_meta = {
		__names = function(s,k)
			local id = instance_variables_id_register[s]
			local names = gm.variable_instance_get_names(id)
			if names.type ~= RValueType.ARRAY then return nil end
			return names.array
		end,
		__index = function(s,k)
			if type(k) == number then
				local names = getmetatable(s).__names(s)
				k = names[k]
				if k == nil then return nil end
				k = k.tostring
				return s[k]
			end
			local id = instance_variables_id_register[s]
			return rvalue_marshall_get(gm.variable_instance_get(id,k))
		end,
		__newindex = function(s,k,v)
			if type(k) == number then
				local names = getmetatable(s).__names(s)
				k = names[k]
				if k == nil then return end
				k = k.tostring
				s[k] = v
				return
			end
			local id = instance_variables_id_register[s]
			return gm.variable_instance_set(id,k,rvalue_marshall_set(v))
		end,
		__len = function(s)
			return #getmetatable(s).__names(s)
		end,
		__next = function(s,k)
			local names = getmetatable(s).__names(s)
			local i = k
			if type(k) ~= "number" then
				i = k and util.perform_lookup(names,k,get_name) or 0
			end
			k = names[i+1]
			if k == nil then return nil end
			k = k.tostring
			return k, rvalue_marshall_get(gm.variable_instance_get(id,k))
		end,
		__pairs = function(s,k)
			local names = getmetatable(s).__names(s)
			local names_lookup = util.build_lookup(names,get_name)
			return function(_,k)
				local i = k
				if type(k) ~= "number" then
					i = k and names_lookup[k] or 0
				end
				k = names[i+1]
				if k == nil then return nil end
				k = k.tostring
				return k, rvalue_marshall_get(gm.variable_instance_get(id,k))
			end,s,k
		end
	}

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

	local struct_proxy_meta = {
		__names = function(s)
			local id = struct_id_register[s]
			local names = gm.struct_get_names(id)
			if names.type ~= RValueType.ARRAY then return nil end
			return names.array
		end,
		__index = function(s,k)
			if type(k) == number then
				local names = getmetatable(s).__names(s)
				k = names[k]
				if k == nil then return nil end
				k = k.tostring
				return s[k]
			end
			local id = struct_id_register[s]
			return rvalue_marshall_get(gm.struct_get(id,k))
		end,
		__newindex = function(s,k,v)
			if type(k) == number then
				local names = getmetatable(s).__names(s)
				k = names[k]
				if k == nil then return end
				k = k.tostring
				s[k] = v
				return
			end
			local id = struct_id_register[s]
			return gm.struct_set(id,k,rvalue_marshall_set(v))
		end,
		__len = function(s)
			return #getmetatable(s).__names(s)
		end,
		__next = function(s,k)
			local names = getmetatable(s).__names(s)
			local i = k
			if type(k) ~= "number" then
				i = k and util.perform_lookup(names,k,get_name) or 0
			end
			k = names[i+1]
			if k == nil then return nil end
			k = k.tostring
			return k, rvalue_marshall_get(gm.struct_get(id,k))
		end,
		__pairs = function(s,k)
			local names = getmetatable(s).__names(s)
			local names_lookup = util.build_lookup(names,get_name)
			return function(_,k)
				local i = k
				if type(k) ~= "number" then
					i = k and names_lookup[k] or 0
				end
				k = names[i+1]
				if k == nil then return nil end
				k = k.tostring
				return k, rvalue_marshall_get(gm.struct_get(id,k))
			end,s,k
		end
	}

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

	local struct_variables_proxy_meta = {
		__names = function(s)
			local id = struct_variables_id_register[s]
			local names = gm.variable_struct_get_names(id)
			if names.type ~= RValueType.ARRAY then return nil end
			return names.array
		end,
		__index = function(s,k)
			if type(k) == number then
				local names = getmetatable(s).__names(s)
				k = names[k]
				if k == nil then return nil end
				k = k.tostring
				return s[k]
			end
			local id = struct_variables_id_register[s]
			return rvalue_marshall_get(gm.variable_struct_get(id,k))
		end,
		__newindex = function(s,k,v)
			if type(k) == number then
				local names = getmetatable(s).__names(s)
				k = names[k]
				if k == nil then return end
				k = k.tostring
				s[k] = v
				return
			end
			local id = struct_variables_id_register[s]
			return gm.variable_struct_set(id,k,rvalue_marshall_set(v))
		end,
		__len = function(s)
			return #getmetatable(s).__names(s)
		end,
		__next = function(s,k)
			local names = getmetatable(s).__names(s)
			local i = k
			if type(k) ~= "number" then
				i = k and util.perform_lookup(names,k,get_name) or 0
			end
			k = names[i+1]
			if k == nil then return nil end
			k = k.tostring
			return k, rvalue_marshall_get(gm.variable_struct_get(id,k))
		end,
		__pairs = function(s,k)
			local names = getmetatable(s).__names(s)
			local names_lookup = util.build_lookup(names,get_name)
			return function(_,k)
				local i = k
				if type(k) ~= "number" then
					i = k and names_lookup[k] or 0
				end
				k = names[i+1]
				if k == nil then return nil end
				k = k.tostring
				return k, rvalue_marshall_get(gm.variable_struct_get(id,k))
			end,s,k
		end
	}

	function proxy.struct.variables(id)
		local proxy = struct_variables_proxy_register[id]
		if proxy then return proxy end
		proxy = setmetatable({},struct_variables_proxy_meta)
		struct_variables_proxy_register[id] = proxy
		struct_variables_id_register[proxy] = id
		return proxy
	end

	local global_variables_proxy_meta = {
		__names = function(s)
			local names = gm.variable_instance_get_names(EVariableType.GLOBAL)
			if names.type ~= RValueType.ARRAY then return nil end
			return names.array
		end,
		__index = function(s,k)
			if type(k) == "number" then
				local names = getmetatable(s).__names(s)
				k = names[k]
				if k == nil then return nil end
				k = k.tostring
				return s[k]
			end
			return rvalue_marshall_get(gm.variable_global_get(k))
		end,
		__newindex = function(s,k,v)
			if type(k) == "number" then
				local names = getmetatable(s).__names(s)
				k = names[k]
				if k == nil then return end
				k = k.tostring
				s[k] = v
				return
			end
			return gm.variable_global_set(k,rvalue_marshall_set(v))
		end,
		__len = function(s)
			return #getmetatable(s).__names(s)
		end,
		__next = function(s,k)
			local names = getmetatable(s).__names(s)
			local i = k
			if type(k) ~= "number" then
				i = k and util.perform_lookup(names,k,get_name) or 0
			end
			k = names[i+1]
			if k == nil then return nil end
			k = k.tostring
			return k, s[k]
		end,
		__pairs = function(s,k)
			local names = getmetatable(s).__names(s)
			local names_lookup = util.build_lookup(names,get_name)
			return function(_,k)
				local i = k
				if type(k) ~= "number" then
					i = k and names_lookup[k] or 0
				end
				k = names[i+1]
				if k == nil then return nil end
				k = k.tostring
				return k, s[k]
			end,s,k
		end
	}

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
					return get_asset(v[k],t)
				end
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

	local function endow_with_pairs_and_next(sol_object)
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

	local function endow_with_new_properties(sol_object,properties)
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

	local function on_delayed_load()
		local gm_instance_list = gm.CInstance.instances_all
		local gm_instance = gm_instance_list[1]
		if not gm_instance then return false end
		local gm_container = gm.variable_global_get("_damage_color_array")
		if not gm_container then return false end
		local gm_container_t = gm_container.array[1]
		if not gm_container_t then return false end
		local gm_rvalue = gm.variable_global_get("mouse_x")

		local imgui_style = ImGui.GetStyle() -- sol.ImGuiStyle*
		local imgui_vector = imgui_style["WindowPadding"] -- sol.ImVec2*
		endow_with_pairs_and_next(imgui_style)
		endow_with_pairs_and_next(imgui_vector)

		endow_with_pairs_and_next(gm_instance_list)
		endow_with_pairs_and_next(gm_instance)
		endow_with_pairs_and_next(gm_container_t)
		endow_with_pairs_and_next(gm_rvalue)
		endow_with_pairs_and_next(RValueType)

		local rvalue_lookup = util.build_lookup(RValueType)
		local get_type_name = function(s) return rvalue_lookup[s.type] end
		
		endow_with_new_properties(gm_rvalue,{
			type_name = get_type_name,
			lua_value = rvalue_marshall,
			struct = proxy.struct
		})
		endow_with_new_properties(gm_container_t,{
			type_name = get_type_name,
			lua_value = rvalue_marshall,
			struct = proxy.struct
		})
		endow_with_new_properties(gm_instance,{
			variables = proxy.variables
		})

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

		return true
	end

	local next_delayed_load = on_delayed_load

	local function imgui_on_render()
		if next_delayed_load and next_delayed_load() then
			next_delayed_load = nil
		end
	end

	gui.add_imgui(imgui_on_render)
end