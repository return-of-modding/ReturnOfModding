---@meta paths

-- Table containing helpers for retrieving project related IO file/folder paths.
---@class (exact) paths

-- Used for data that must persist between sessions and that can be manipulated by the user.
---@return string # Returns the config folder path
function paths.config() end

-- Used for data that must persist between sessions but not be manipulated by the user.
---@return string # Returns the plugins_data folder path
function paths.plugins_data() end

-- Location of .lua, README, manifest.json files.
---@return string # Returns the plugins folder path
function paths.plugins() end


