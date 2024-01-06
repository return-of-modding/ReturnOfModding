# Table: gm

Table containing helpers for interacting with the game maker engine.

## Fields (3)

### `constants`

- Type: `table of gml/game constants name to their asset index.`

### `constant_types`

- Type: `table of gml/game constants name to their type name`

### `constants_type_sorted`

- Type: `constants_type_sorted[type_name][i] = constant_name`

## Functions (8)

### `pre_code_execute(callback)`

Registers a callback that will be called right before any object function is called.

- **Parameters:**
  - `callback` (function): callback that match signature function, return value can be True if the original method we are hooking should be called, false if it should be skipped ( self (CInstance), other (CInstance), code (CCode), result (RValue), flags (number) )

**Example Usage:**
```lua
gm.pre_code_execute(callback)
```

### `post_code_execute(callback)`

Registers a callback that will be called right after any object function is called.

- **Parameters:**
  - `callback` (function): callback that match signature function ( self (CInstance), other (CInstance), code (CCode), result (RValue), flags (number) )

**Example Usage:**
```lua
gm.post_code_execute(callback)
```

### `pre_script_hook(script_function_index, callback)`

Registers a callback that will be called right before any game script function is called.

- **Parameters:**
  - `script_function_index` (number): index of the game script function to hook, for example `gm.constants.callback_execute`
  - `callback` (function): callback that match signature function ( self (CInstance), other (CInstance), result (RValue), arg_count (number), args (RValue array) ) -> Return true or false depending on if you want the orig method to be called.

**Example Usage:**
```lua
gm.pre_script_hook(script_function_index, callback)
```

### `post_script_hook(script_function_index, callback)`

Registers a callback that will be called right after any game script function is called.

- **Parameters:**
  - `script_function_index` (number): index of the game script function to hook, for example `gm.constants.callback_execute`
  - `callback` (function): callback that match signature function ( self (CInstance), other (CInstance), result (RValue), arg_count (number), args (RValue array) )

**Example Usage:**
```lua
gm.post_script_hook(script_function_index, callback)
```

### `variable_global_get(name)`

- **Parameters:**
  - `name` (string): name of the variable

- **Returns:**
  - `value`: The actual value behind the RValue, or RValue if the type is not handled yet.

**Example Usage:**
```lua
value = gm.variable_global_get(name)
```

### `variable_global_set(name, new_value)`

- **Parameters:**
  - `name` (string): name of the variable
  - `new_value` (any): new value

**Example Usage:**
```lua
gm.variable_global_set(name, new_value)
```

### `call(name, self, other, args)`

- **Parameters:**
  - `name` (string): name of the function to call
  - `self` (CInstance): (optional)
  - `other` (CInstance): (optional)
  - `args` (any): (optional)

- **Returns:**
  - `value`: The actual value behind the RValue, or RValue if the type is not handled yet.

**Example Usage:**
```lua
value = gm.call(name, self, other, args)
```

### `struct_create()`

- **Returns:**
  - `YYObjectBase*`: The freshly made empty struct

**Example Usage:**
```lua
YYObjectBase* = gm.struct_create()
```


