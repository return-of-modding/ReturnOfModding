---@meta RValue

-- Class representing a value coming from the game maker engine
---@class (exact) RValue
---@field type RValueType: The actual type behind the RValue
---@field value any: The actual value behind the RValue, or RValue if the type is not handled yet.
---@field tostring string: string representation of the RValue

-- Returns an RValue instance
---@param value boolean|number|string value
---@return RValue
function RValue:new(value) end

