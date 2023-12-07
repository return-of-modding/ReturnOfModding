# Table: _ENV - Plugin Specific Global Table

Each mod/plugin have their own global table containing helpers, such as:
- Their own guid

- Path to their own folder inside `plugins_data`

- Path to their own folder inside `plugins`

You can access other mods helpers through the `mods[OTHER_MOD_GUID]` table.

**Example Usage:**

```lua
print(_ENV["!guid"])

for n in pairs(mods[_ENV["!guid"]]) do
     log.info(n)
end
```

## Fields (4)

### `!guid`

Guid of the mod.

- Type: `string`

### `!plugins_data_mod_folder_path`

Path to the mod folder inside `plugins_data`

- Type: `string`

### `!plugins_mod_folder_path`

Path to the mod folder inside `plugins`

- Type: `string`

### `!this`

- Type: `lua_module*`

