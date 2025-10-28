# Class: CInstance

Class representing a game maker object instance.

You can use most if not all of the builtin game maker variables (For example `myCInstance.x`) [listed here](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Asset_Management/Instances/Instance_Variables/Instance_Variables.htm).

You can call on the `CInstance` any game maker function that would normally be called with `self` as the instance, for example `myCInstance:instance_destroy()`. Object instance methods also work, like Step, Draw, Alarm, KeyPress etc. Note that `other` will always be null when using that syntax.

To know the specific instance variables of a given object defined by the game, call someCInstance:variable_instance_get_names()

## Fields (31)

### `id`

- Type: `number`

### `object_index`

- Type: `number`

### `sprite_index`

- Type: `number`

### `image_index`

- Type: `number`

### `image_speed`

- Type: `number`

### `image_xscale`

- Type: `number`

### `image_yscale`

- Type: `number`

### `image_angle`

- Type: `number`

### `image_alpha`

- Type: `number`

### `image_blend`

- Type: `number`

### `x`

- Type: `number`

### `y`

- Type: `number`

### `xstart`

- Type: `number`

### `ystart`

- Type: `number`

### `xprevious`

- Type: `number`

### `yprevious`

- Type: `number`

### `direction`

- Type: `number`

### `speed`

- Type: `number`

### `friction`

- Type: `number`

### `gravity_direction`

- Type: `number`

### `gravity`

- Type: `number`

### `hspeed`

- Type: `number`

### `vspeed`

- Type: `number`

### `bbox`

- Type: `number[4] array`

### `timer`

- Type: `number[12] array`

### `layer`

- Type: `number`

### `mask_index`

- Type: `number`

### `m_nMouseOver`

- Type: `number`

### `depth`

- Type: `number`

### `i_currentdepth`

- Type: `number`

### `object_name`

- Type: `string`

