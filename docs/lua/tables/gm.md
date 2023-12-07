# Table: gm

Table containing helpers for interacting with the game maker engine.

## Functions (5)

### `pre_code_execute(callback)`

Registers a callback that will be called right before any game function is called.

- **Parameters:**
  - `callback` (function): callback that match signature function ( self (CInstance), other (CInstance), code (CCode), result (RValue), flags (number) )

**Example Usage:**
```lua
gm.pre_code_execute(callback)
```

### `post_code_execute(callback)`

Registers a callback that will be called right after any game function is called.

- **Parameters:**
  - `callback` (function): callback that match signature function ( self (CInstance), other (CInstance), code (CCode), result (RValue), flags (number) )

**Example Usage:**
```lua
gm.post_code_execute(callback)
```

### `variable_global_get(name)`

- **Parameters:**
  - `name` (string): name of the variable

- **Returns:**
  - `RValue`: Returns the global variable value.

**Example Usage:**
```lua
RValue = gm.variable_global_get(name)
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
  - `RValue`: Returns the result of the function call if there is one.

**Example Usage:**
```lua
RValue = gm.call(name, self, other, args)
```


