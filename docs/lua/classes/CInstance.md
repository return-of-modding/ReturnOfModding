# Class: CInstance

Class representing a game maker object instance

## Functions (5)

### `get(variable_name)`

- **Parameters:**
  - `variable_name` (string): name of the instance variable to get

- **Returns:**
  - `RValue`: Returns the variable value.

**Example Usage:**
```lua
RValue = CInstance:get(variable_name)
```

### `get_bool(variable_name)`

- **Parameters:**
  - `variable_name` (string): name of the instance variable to get

- **Returns:**
  - `boolean`: Returns the variable value.

**Example Usage:**
```lua
boolean = CInstance:get_bool(variable_name)
```

### `get_double(variable_name)`

- **Parameters:**
  - `variable_name` (string): name of the instance variable to get

- **Returns:**
  - `number`: Returns the variable value.

**Example Usage:**
```lua
number = CInstance:get_double(variable_name)
```

### `get_string(variable_name)`

- **Parameters:**
  - `variable_name` (string): name of the instance variable to get

- **Returns:**
  - `string`: Returns the variable value.

**Example Usage:**
```lua
string = CInstance:get_string(variable_name)
```

### `set(variable_name, new_value)`

- **Parameters:**
  - `variable_name` (string): name of the instance variable to set
  - `new_value` (any): new value

**Example Usage:**
```lua
CInstance:set(variable_name, new_value)
```


