# Return Of Modding

[Risk of Rain Returns Modding Discord](https://discord.gg/VjS57cszMq)

---

Return Of Modding is a modding plugin / framework for Risk of Rain Returns.
(A game made with GameMaker 2023.6 ultimately transpiled from GML to C++ with the GameMaker YYC compiler)

## Manual Installation

- Place the main ReturnOfModding file, called `version.dll`, next to the game executable called `Risk of Rain Returns.exe` inside the game folder.

## User Interface

- Return of Modding ships with a ImGui user interface. The default key for opening the GUI is INSERT

## Creating mods with Return Of Modding

- Define a `main.lua` file in which to code your mod.

- Create a `manifest.json` file that follows the Thunderstore Version 1 Manifest format.

- Create a folder whose name follows the GUID format `TeamName-ModName`, for example: `ReturnOfModding-DebugToolkit`.

- Place the `main.lua` file and the `manifest.json` file in the folder you've just created.

- Place the newly created folder in the `plugins` folder in the Return Of Modding root folder, called `ReturnOfModding`, so the path to your manifest.json should be something like `ReturnOfModding/plugins/ReturnOfModding-DebugToolkit/manifest.json`.

- You can check the existing `examples` in that github repository if you wanna try stuff out.

Interesting folders under the root folder:

- `plugins`: Location of .lua, README, manifest.json files.
- `plugins_data`: Used for data that must persist between sessions but not be manipulated by the user.
- `config`: Used for data that must persist between sessions and that can be manipulated by the user. A TOML library is exposed to Lua and is the preferred method for configuring mods.

## Credits

This project wouldn't have been possible without

- [Archie-osu](https://github.com/Archie-osu) [with their YYToolkit project](https://github.com/AurieFramework/YYToolkit)
- [ModShovel](https://github.com/nkrapivin/modshovel)
- People from the Modding Discord with their feedback.
