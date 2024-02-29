# Table: paths

Table containing helpers for retrieving ReturnOfModding related IO file/folder paths.

## Functions (2)

### `config()`

Used for data that must persist between sessions and that can be manipulated by the user.

- **Returns:**
  - `string`: Returns the ReturnOfModding/config folder path

**Example Usage:**
```lua
string = paths.config()
```

### `plugins_data()`

Used for data that must persist between sessions but not be manipulated by the user.

- **Returns:**
  - `string`: Returns the ReturnOfModding/plugins_data folder path

**Example Usage:**
```lua
string = paths.plugins_data()
```


