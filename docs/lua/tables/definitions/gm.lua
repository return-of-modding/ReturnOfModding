---@meta gm

-- Table containing helpers for interacting with the game maker engine.
---@class (exact) gm
---@field constants table of gml/game constants name to their asset index.
---@field constant_types table of gml/game constants name to their type name
---@field constants_type_sorted constants_type_sorted[type_name][i] = constant_name

-- Registers a callback that will be called right before any object function is called. Note: for script functions, use pre_script_hook / post_script_hook
---@param function_name string (optional) Function name to hook. If you pass a valid name, the hook will be a lot faster to execute. Example valid function name: `gml_Object_oStartMenu_Step_2`
---@param callback function callback that match signature function ( self (CInstance), other (CInstance) ) for **fast** overload and ( self (CInstance), other (CInstance), code (CCode), result (RValue), flags (number) ) for **non fast** overload.
function gm.pre_code_execute(function_name, callback) end

-- Registers a callback that will be called right after any object function is called. Note: for script functions, use pre_script_hook / post_script_hook
---@param function_name string (optional) Function name to hook. If you pass a valid name, the hook will be a lot faster to execute. Example valid function name: `gml_Object_oStartMenu_Step_2`
---@param callback function callback that match signature function ( self (CInstance), other (CInstance) ) for **fast** overload and ( self (CInstance), other (CInstance), code (CCode), result (RValue), flags (number) ) for **non fast** overload.
function gm.post_code_execute(function_name, callback) end

-- Registers a callback that will be called right before any script function is called. Note: for object functions, use pre_code_execute / post_code_execute
---@param function_index number index of the game script / builtin game maker function to hook, for example `gm.constants.callback_execute`
---@param callback function callback that match signature function ( self (CInstance), other (CInstance), result (RValue), args (RValue array) ) -> Return true or false depending on if you want the orig method to be called.
function gm.pre_script_hook(function_index, callback) end

-- Registers a callback that will be called right after any script function is called. Note: for object functions, use pre_code_execute / post_code_execute
---@param function_index number index of the game script / builtin game maker function to hook, for example `gm.constants.callback_execute`
---@param callback function callback that match signature function ( self (CInstance), other (CInstance), result (RValue), args (RValue array) )
function gm.post_script_hook(function_index, callback) end

---@param name string name of the variable
---@return value # The actual value behind the RValue, or RValue if the type is not handled yet.
function gm.variable_global_get(name) end

---@param name string name of the variable
---@param new_value any new value
function gm.variable_global_set(name, new_value) end

---@param name string name of the function to call
---@param self CInstance (optional)
---@param other CInstance (optional)
---@param args any (optional)
---@return value # The actual value behind the RValue, or RValue if the type is not handled yet.
function gm.call(name, self, other, args) end

---@return YYObjectBase* # The freshly made empty struct
function gm.struct_create() end

-- **Example Usage**
--```lua
--callable_ref = nil
--gm.pre_script_hook(gm.constants.callable_call, function(self, other, result, args)
--     if callable_ref then
--         if args[1].value == callable_ref then
--             print("GenericCallable ran")
--         end
--     end
--end)
--
--gm.post_code_execute("gml_Object_pAttack_Create_0", function(self, other)
--     gm.instance_callback_set(self.on_hit, gm.get_script_ref(gm.constants.function_dummy))
--     callable_ref = self.on_hit.callables[#self.on_hit.callables]
--end)
--```
---@param function_index number index of the game script / builtin game maker function to make a CScriptRef with.
---@return CScriptRef* # The script reference from the passed function index.
function gm.get_script_ref(function_index) end

-- **Example Usage**
--```lua
--pointer = gm.get_script_function_address(gm.constants.actor_death)
--```
---@param function_index number index of the game script / builtin game maker function.
---@return pointer # A pointer to the found address.
function gm.get_script_function_address(function_index) end

-- **Example Usage**
--```lua
--pointer = gm.get_object_function_address("gml_Object_oStartMenu_Step_2")
--```
---@param function_name string the name of target function.
---@return pointer # A pointer to the found address.
function gm.get_object_function_address(function_name) end


