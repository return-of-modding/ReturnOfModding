# Class: CInstance

Class representing a game maker object instance.

You can use most if not all of the builtin game maker variables (For example `myCInstance.x`) [listed here](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Asset_Management/Instances/Instance_Variables/Instance_Variables.htm).

To know the specific instance variables of a given object defined by the game call dump_vars() on the instance

## Fields (33)

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

- Type: `number`

### `layer`

- Type: `number`

### `mask_index`

- Type: `number`

### `m_nMouseOver`

- Type: `number`

### `m_pNext`

- Type: `CInstance`

### `m_pPrev`

- Type: `CInstance`

### `depth`

- Type: `number`

### `i_currentdepth`

- Type: `number`

### `object_name`

- Type: `string`

## Functions (1)

### `dump_vars()`

Log dump to the console all the variable names of the given object, for example with an `oP` (Player) object instance you will be able to do `print(myoPInstance.user_name)`

**Example Usage:**
```lua
CInstance:dump_vars()
```


