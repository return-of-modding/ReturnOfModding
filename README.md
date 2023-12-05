# Return Of Modding

[Risk of Rain Returns Modding Discord](https://discord.gg/MpFEDAg)

---

Return Of Modding is a modding plugin / framework for Risk of Rain Returns.
(A game made with GameMaker 2023.6 ultimately transpiled from GML to C++ with the GameMaker YYC compiler)

## Manual Installation

- Place the main ReturnOfModding file, called `version.dll`, next to the game executable called `Risk of Rain Returns.exe` inside the game folder.

## Creating mods with Return Of Modding

- Define a `main.lua` file in which to code your mod.

- Create a `manifest.json` file that follows the Thunderstore Version 1 Manifest format.

- Create a folder whose name follows the GUID format `TeamName-ModName`, for example: `ReturnOfModding-DebugToolkit`.

- Place the `main.lua` file and the `manifest.json` file in the folder you've just created.

- Place the newly created folder in the `scripts` folder in the Return Of Modding root folder, called `ReturnOfModding`, so the path to your manifest.json should be something like `ReturnOfModding/scripts/ReturnOfModding-DebugToolkit/manifest.json`.

- You can check the existing `examples` in that github repository if you wanna try stuff out.

## Mod Manager Integration

If you'd like to integrate Return Of Modding into your mod manager, here are the specifications:

Return Of Modding is injected into the game process using DLL hijacking (more precisely, it hijacks the Windows dynamic linked library `version.dll`), which is the same technique used by other bootstrappers such as [UnityDoorstop](https://github.com/NeighTools/UnityDoorstop).

The root folder used by Return Of Modding (which will then be used to load mods from this folder) can be defined in several ways:

- Setting the process environment variable: `return_of_modding_root_folder <CUSTOM_PATH>`

- Command line argument when launching the game executable: `--return_of_modding_root_folder <CUSTOM_PATH>`

- If the process environment variable is not defined, the command line arguments are checked. If neither is defined, the ReturnOfModding folder is placed in the game folder, next to the game executable.

## Credits

This project wouldn't have been possible without

- [Archie-osu](https://github.com/Archie-osu) [with their YYToolkit project](https://github.com/AurieFramework/YYToolkit)
