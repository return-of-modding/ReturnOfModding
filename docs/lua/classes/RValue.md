# Class: RValue

Class representing a value coming from the game maker engine

## Fields (3)

### `type`

- Type: `RValueType: The actual type behind the RValue`

### `value`

- Type: `any: The actual value behind the RValue, or RValue if the type is not handled yet.`

### `tostring`

- Type: `string: string representation of the RValue`

## Constructors (1)

### `new(value)`

Returns an RValue instance

- **Parameters:**
  - `value` (boolean|number|string): value

**Example Usage:**
```lua
myInstance = RValue:new(value)
```

