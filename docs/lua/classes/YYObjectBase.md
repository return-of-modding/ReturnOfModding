# Class: YYObjectBase

Class representing an object coming from the game maker engine

## Fields (3)

### `type`

- Type: `YYObjectBaseType`

### `cinstance`

- Type: `CInstance or nil if not a CInstance`

### `script_name`

Can be used to then hook the function with a pre / post script hook. The `gml_Script_` prefix may need to be removed for the hook to work.

- Type: `string or nil if not a SCRIPTREF`

