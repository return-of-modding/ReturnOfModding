# Class: RValue

Class representing a value coming from the game maker engine

## Fields (3)

### `type`

- Type: `RValueType`

### `value`

- Type: `The actual value behind the RValue, or RValue if the type is not handled yet.`

### `tostring`

- Type: `string representation of the RValue`

## Constructors (3)

### `new(value)`

Returns an RValue instance

- **Parameters:**
  - `value` (boolean): value

**Example Usage:**
```lua
myInstance = RValue:new(value)
```

### `new(value)`

Returns an RValue instance

- **Parameters:**
  - `value` (number): value

**Example Usage:**
```lua
myInstance = RValue:new(value)
```

### `new(value)`

Returns an RValue instance

- **Parameters:**
  - `value` (string): value

**Example Usage:**
```lua
myInstance = RValue:new(value)
```

