---@meta YYObjectBase

-- Class representing an object coming from the game maker engine
---@class (exact) YYObjectBase
---@field type YYObjectBaseType
---@field cinstance CInstance or nil if not a CInstance
---@field script_name string or nil if not a SCRIPTREF # Can be used to then hook the function with a pre / post script hook. The `gml_Script_` prefix may need to be removed for the hook to work.



