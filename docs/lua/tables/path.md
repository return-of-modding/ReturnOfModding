# Table: path

Table containing helpers for manipulating file or directory paths

## Functions (2)

### `combine(path)`

Combines strings into a path.

- **Parameters:**
  - `path` (string): Any amount of string is accepted.

- **Returns:**
  - `string`: Returns the combined path

**Example Usage:**
```lua
string = path.combine(path)
```

### `get_parent(path)`

Retrieves the parent directory of the specified path, including both absolute and relative paths.

- **Parameters:**
  - `path` (string): The path for which to retrieve the parent directory.

- **Returns:**
  - `string`: Returns the parent path

**Example Usage:**
```lua
string = path.get_parent(path)
```


