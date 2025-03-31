---@meta RValue

-- Class representing a value coming from the game maker engine
---@class (exact) RValue
---@field type RValueType
---@field value The actual value behind the RValue, or RValue if the type is not handled yet.
---@field tostring string representation of the RValue

-- Returns an RValue instance
---@param value boolean value
---@return RValue
function RValue:new(value) end
-- Returns an RValue instance
---@param value number value
---@return RValue
function RValue:new(value) end
-- Returns an RValue instance
---@param value string value
---@return RValue
function RValue:new(value) end

