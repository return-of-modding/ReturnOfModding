# Table: RValue

Class representing a value coming from the game maker engine

## Functions (1)

### `from_ptr(v)`

Creates an RValue of type PTR from a number that will be used as a pointer.

- **Parameters:**
  - `v` (number): The number that will be used as a pointer.

- **Returns:**
  - `RValue`: The freshly made RValue of type PTR.

**Example Usage:**
```lua
RValue = RValue.from_ptr(v)
```


