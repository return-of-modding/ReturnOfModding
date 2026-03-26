## [1.1.18] - 2026-03-25
- fix(shader): fix `shader_replace` crash. continued
- fix(shader): fix `shader_replace` crash.

## [1.1.17] - 2026-03-21
- Logger::FlushQueue can deadlock, workaround for now.
- fix(shader): - fix shader sig ptr offsets being off since whenever the game updated to 1.1.0 - need a null check when iterating shader pool entries.
- fix(lua): fix jit hook cache not using offset based pointers. Base address of the module can change between launches.

## [1.1.16] - 2026-02-11
- feat(lua): Speed up mod loading time by only suspending threads once than suspending / resuming between every jit hooks

## [1.1.15] - 2026-02-10
- feat(ci): pin msvc
- fix(lua): fix `require` not working inside hooks when hot reloading

## [1.1.14] - 2025-11-13
- ci changelog stuff
- ci: changelog generation
- rombase: try catch stuff inside tomlv1

## [1.1.13] - 2025-11-04
- (no commits logged)

## [1.1.12] - 2025-11-04
- tentative fix for hang while starting the game
- _G._rom_print_raw
- chore doc
- feat: rom build version number shown in log and in the game main menu title screen

## [1.1.11] - 2025-11-02
- (no commits logged)

## [1.1.10] - 2025-11-02
- doc
- gm.call doc
- refactor(gm): support object instance function calls

## [1.1.9] - 2025-10-28
- (no commits logged)

## [1.1.8] - 2025-10-28
- feat(debug): show how much memory there is left for the Lua memory allocator in a Debug tab
- refactor(lua): support adding hooks inside hooks. perf note: add a callback caches to avoid m_enabled checks in hot path
- refactor(lua): better ux enable/disable hook system. perf note: lua_module_data_ext struct inside the vectors are a bit bigger, and an if enabled check is needed when iterating over the vectors.

## [1.1.7] - 2025-10-26
- feat(lua): code_execute_hook_enable, code_execute_hook_disable, script_hook_enable, script_hook_disable
- feat(lua): introduce lua tlsf memory pool

## [1.1.6] - 2025-10-23
- feat(gui): in game gui for configuring rom key

## [1.1.5] - 2025-09-23
- feat(lua): support `require` returning multiple values, (gmf backport https://github.com/return-of-modding/ReturnOfModding/commit/42f22d6490dce33f3aab87a35805016b2095391a)

## [1.1.4] - 2025-09-17
- feat(gm): restore gm.call syntax sugar helper when passing self and other
- fix(gm): restore Global Instance returning as -4 instead of lua nil

## [1.1.3] - 2025-09-06
- fix(gm): fix wrong bitset flag check on REF, CInstance values

## [1.1.2] - 2025-09-05
- fix(gm): Backcompat hooks for draw_sprite functions

## [1.1.1] - 2025-09-04
- feat(ci): Support custom version number
- fix(gm): update the YYGMLException exception code to the new correct one.
-  fix(gm): cleaner debug code
- remove duplicated function
- fix(gm): Update hardcoded max shader count
- chore(doc): update doc
- chore(doc): update doc
- chore(doc): update doc
- feat(gm): add a way of constructing RValue containing a pointer. An example use case is that in GM 2024.13 vertex_submit the passed texture need to be a RValue PTR because internally it doesn't handle a passed regular GM number and we don't have a way of using game maker function called ptr due to how lua value passing is done.
- bump rombase, lua doc gen support line ending specifier

## [1.1.0] - 2025-09-03
- fix(gm): variable_instance_get and variable_struct_get are no longer interchangeable
- fix(rom): fix compilation failing under release because of _DEBUG being not defined there.
- bump rombase, fixing backup log folder never creating properly
- feat(examples): update debug example
- fix(gm): fix YYObjectBaseLuaWrapper not passing the pointer to the YYObjectBase correctly on struct_get
- fix(rorr): fix sound instance log spam
- feat(gm): debug log pin map
- fix(rorr): fix yysetscriptref pointer

## [1.0.80] - 2025-09-01
- (no commits logged)

## [1.0.79] - 2025-09-01
- (no commits logged)

## [1.0.78] - 2025-09-01
- fix(gm): fix pin map
- fix(rorr): just return as a number for REF others than CInstances
- fix(rorr): fix `room`
- fix(rorr): fix ds list

## [1.0.77] - 2025-08-31
- (no commits logged)

## [1.0.76] - 2025-08-31
- fix(rorr): more fixes for 1.1.0
- readme
- fix(rorr): fixes for game update 1.1.0
- fix(imgui): fix asserts not being disabled in debug mode

## [1.0.75] - 2025-08-30
- (no commits logged)

## [1.0.74] - 2025-06-02
- fix(exception_handler): move SetThreadName to top of triple_exception_handler instead, cause it seems otherwise that lua_print_traceback can crash early.
- feat(gui): Config files menutabbar
- bump rombase, config_file fixes

## [1.0.73] - 2025-06-01
- just log info SetThreadName exception and move on
- bigger buffer for GetModuleFileNameW
- bump rombase (better exception handling)

## [1.0.72] - 2025-05-30
- fix global variable set not allowing new global to be added
- try to fix RefDynamicArrayOfRValue's memory leak (#27)

## [1.0.71] - 2025-05-22
- chore(doc): update doc
- Add shader_add and shader_replace. (#26)

## [1.0.70] - 2025-05-12
- RValue::asBoolean: handle UNDEFINED

## [1.0.69] - 2025-04-26
- null check g_gui

## [1.0.68] - 2025-04-21
- (no commits logged)

## [1.0.67] - 2025-04-20
- bump rombase
- fix(lua): make `require` not hard crash the mod loader on errors

## [1.0.66] - 2025-04-19
- bump rombase: lua memory module overhaul

## [1.0.65] - 2025-04-07
- revert mimalloc implementation, doesn't work under linux wine for some reason

## [1.0.64] - 2025-04-06
- REFACTOR: unordered_map -> ankerl::unordered_dense::map and unordered_set -> ankerl::unordered_dense::set
- REFACTOR: mimalloc for lua allocator and new / delete operators

## [1.0.63] - 2025-04-05
- bump rombase (fuck cmake)
- bump rombase
- bump rombase

## [1.0.62] - 2025-04-01
- bump rombase (file watcher stuff)
- refactor(gm): assigning a bool to a game maker variable will properly keep the boolean type instead of making it into a number.
- bump rombase: mods.loading_order fix
- bump rombase (thread util fixes)

## [1.0.61] - 2025-03-31
- (no commits logged)

## [1.0.60] - 2025-03-31
- (no commits logged)

## [1.0.59] - 2025-03-31
- bump rombase
- fix ci
- doc update
- bump rombase: directory_watcher stuff
- lua doc: definition files
- cscriptref doc
- comment this overload for now, see comment for explanation.
- Merge pull request #23 from hinyb/master
- feat(renderer): attempt to use warp software device if using hardware device fails when creating dummy device.

## [1.0.58] - 2025-01-07
- Fix the gm function can't handle CInstance correctly.
- bump rombase: some internal dynamic hook mid changes, path.exists

## [1.0.57] - 2025-01-04
- revert https://github.com/return-of-modding/ReturnOfModding/commit/f3b1686cafb8084cfebf6bd586f591e5c83ddc63 and update rombase/doc

## [1.0.56] - 2024-12-18
- feat(lua): add _PLUGIN.version

## [1.0.55] - 2024-12-14
- bump rombase, fixing filesystem functions not following symlinks
- remove unused require function

## [1.0.54] - 2024-12-04
- (no commits logged)

## [1.0.53] - 2024-12-04
- refactor(require): Refactored the customized Lua require function to properly handle cases where directory iteration retrieves .lua files from unrelated plugin folders.
- feat(dynamic_hook): add resolve_pointer_to_type

## [1.0.52] - 2024-12-03
- bump rombase, fix for dynamic_hook_mid

## [1.0.51] - 2024-12-01
- (no commits logged)

## [1.0.50] - 2024-11-22
- fix rombase main.cpp file and lib/exe type not in test mode
- fix doc
- feat(lua): make use of latest rombase, dynamic_mid_hook support, expose get_script_function_address and get_object_function_address
- fix compilation latest msvc
- fix(lua): Invalid require lua module cache when hotreloading.

## [1.0.49] - 2024-11-05
- refactor(exception_handler): tentative fix for cases where nothing from the exception would get logged / dumped to disk. Also give a bit more info when the crash happens, last script / code execute calls, and lua traceback.

## [1.0.48] - 2024-10-31
- (no commits logged)

## [1.0.47] - 2024-10-24
- fix(rorr): Don't allow creation of a multiplayer lobby with "Allow Rule Voting" enabled, because custom difficulties will cause a hard crash otherwise.
- feat(gm): expose a way to get CScriptRef just from a function index.

## [1.0.46] - 2024-10-22
- Bunch of changes again on how things are init: - bump rombase, batch pointer scan is no longer a bunch of async std futures - hook game func that create the main swapchain and init renderer based on that - lua manager creation is now directly inside the hooked Code_Execute function instead of signaling through a std condition_variable
- Tentative fix for broken initialization timing in rare cases on some machines (game never launching, pin_map failing to init...): - Move most of the main init code in the main attach thread, making most of the things happen really early in the process lifetime. - debug_console change is because since the logger CONOUT$ stream open first now, the game still has its conout stream happening so we don't call the original game logging func anymore, might have some side effect.

## [1.0.45] - 2024-10-19
- (no commits logged)

## [1.0.44] - 2024-10-19
- feat(icon): new icon thanks to https://github.com/Klehrik
- log in the console that pre/post_code_execute without function name is deprecated and not recommended unless for debugging purposes.
- bump rombase (fix unicode cmd line arg parsing)
- feat(gm): fast object function hooks.

## [1.0.43] - 2024-10-18
- (no commits logged)

## [1.0.42] - 2024-10-18
- previous commit continued: expose the CScriptRef class to lua and document it.
- feat(gm): Allow YYObjectBase script refs to be called

## [1.0.41] - 2024-10-17
- fix(lua): fix `require` impl not properly setting env on the first given require call
- feat(rombase): bump to latest, expose a bunch of things, documented.
- fix(lua): fix require implementation executing the required chunk instead of just returning the res on subsequence calls

## [1.0.40] - 2024-10-10
- (no commits logged)

## [1.0.39] - 2024-10-10
- Update README.md
- rombase: update to latest, check upstream for changelog
- fix asmjit crash
- fix compile for now
- rombase: update to latest (max instance too small)
- feat(init): skip steam check if steam_appid.txt is here
- rom: update to latest (support multiple rom instances running)

## [1.0.38] - 2024-09-10
- (no commits logged)

## [1.0.37] - 2024-09-10
- (no commits logged)

## [1.0.36] - 2024-09-10
- fix(path): tentative fix for file system sandbox bypass not working under wine

## [1.0.35] - 2024-09-04
- feat: further safe check user saves, this time also when they get deserialized.

## [1.0.34] - 2024-07-07
- Merge branch 'master' of https://github.com/return-of-modding/ReturnOfModding
- fix: sanitize user save file from hard crashing modded entries

## [1.0.33] - 2024-06-17
- Update README.md
- Update README.md
- fix doc
- update to latest rombase: mostly for the ImGui.Hotkey exposed lua binding

## [1.0.32] - 2024-06-10
- Merge branch 'master' of https://github.com/return-of-modding/ReturnOfModding
- lua: support dll

## [1.0.31] - 2024-05-29
- (no commits logged)

## [1.0.30] - 2024-05-28
- file_watcher: fixes
- lua: file watcher fixes
- linux: add script for building
- logger: - make the console deactivable via the config file - support old config filter values from config file - fix error log level not working - fix logger worker thread crash on exit

## [1.0.29] - 2024-05-25
- nightly: make it so that the nightly tag release is remade so that the date also get refreshed
- actually fix onboarding text not wrapping
- actually fix onboarding text not wrapping
- fix onboarding text not wrapping
- Works on linux machines

## [1.0.28] - 2024-05-24
- gui: make the onboarding window intent clearer
- - lua: new config system - lua loader: ignore extra '-' from folder names for trying to get a correct guid out of them

## [1.0.27] - 2024-05-19
- update to latest rom base, should fix hotreload

## [1.0.26] - 2024-05-16
- bump rombase

## [1.0.25] - 2024-05-04
- bump rombase
- rom: add is_rom_enabled support
- refactor: move to ReturnOfModdingBase

## [1.0.24] - 2024-05-03
- fix(lua): fix pointer.allocate allocating 1 byte with given "size" as value instead of allocating "size" bytes
- fix(renderer): try to fix the cursor flickering issue
- fix(renderer): try to fix the cursor flickering issue
- fix(renderer): fix dx callback map trash on hot path

## [1.0.23] - 2024-04-11
- fix(lua): actually not use version numbers when loading dependencies. also add extra logging in case stuff is not in the format we want.
- fix(lua): don't do hard version number check for dependencies. Closes #15

## [1.0.22] - 2024-04-08
- (no commits logged)

## [1.0.21] - 2024-04-08
- (no commits logged)

## [1.0.20] - 2024-04-02
- fix(lua): accessing non existing CInstance variable or function would return a lua function object instead of lua nil
- fix(hotkey): handle old config files
- fix(hotkey): null check

## [1.0.19] - 2024-04-01
- (no commits logged)

## [1.0.18] - 2024-04-01
- try to tame the dragons
- fix(hook): suspend threads when enabling / disabling hooks
- use detour_hook wrapper
- remove unused code
- declare a cpp file for threads utils instead of inline functions
- fix(exception_handler): Purposely leak it, we are not unloading ReturnOfModding in any case.
- code quality: don't use uint64_t when dealing with memory addresses but uintptr_t.
- debug code
- chore(gm): remove unused code
- remove superfluous cmake compile directive
- feat(threads): are_suspended for keeping track if we need to do the winapi calls or not
- refactor(lua hooks): Here be dragons

## [1.0.17] - 2024-03-29
- (no commits logged)

## [1.0.16] - 2024-03-29
- fix(exception_handler): the exception handler was getting replaced by some other BS since we now init very early.
- fix(stack_trace): showing symbol name for ReturnOfModding in final builds, not really useful since symbols are never here and it just show the exported func
- fix(lua): final builds need that string copy cause of optimisations it seems
- fix(lua): fix unneeded string copy
- chore(format code)
- fix/feat(lua): allow call to member script function from lua. refactor script_execute mess to use cscript instead

## [1.0.15] - 2024-03-28
- (no commits logged)

## [1.0.14] - 2024-03-28
- (no commits logged)

## [1.0.13] - 2024-03-28
- fix(init): better getenv
- feat(exception_handler): handle abort signals
- fix(examples): fix ShareItem giving one additional item
- fix(lua): cleanup hooks (and other similar data) between hot reloads.
- refacor(lua): rvalue is undefined by default instead of unset. unset are for non existing vars, undefined for null but for existing vars. In our case it makes life easier, most notably for passing undefined for some function parameters for example.

## [1.0.12] - 2024-03-24
- fix(init): much cleaner way again of detecting steam for proper init of ReturnOfModding
- feat(gui): small onboarding system
- refactor(internal-hotkey-system): config file show string equivalent of the vk key code
- ci: remove everyday release schedule because it would make releases even without any change whatsoever with the latest manually triggered release

## [1.0.11] - 2024-03-22
- (no commits logged)

## [1.0.10] - 2024-03-22
- fix(init): don't do anything unless steam set proper running app id
- refactor(lua): change hot reloading: module doesn't get cleared anymore, it just call the main.lua function again on any .lua file change.
- feat(exception_handler): better error message
- add file_watcher

## [1.0.9] - 2024-03-21
- (no commits logged)

## [1.0.8] - 2024-03-21
- (no commits logged)

## [1.0.7] - 2024-03-14
- fix(nightly): seems like we can run bash even under windows jobs
- fix(exception_handler): Message boxes when the mini dump hard fail.
- refactor(init): hopefully much cleaner initialization
- refactor(string): starts_with helper
- Big ol messagebox if the exception handler goes poof
- use chrono_literals
- fix(nightly): ps1 behavior of course different than linux shell... potential fix
- feat(exception_handler): optimize a bit how the dump file stuff is made
- feat(nightly): add version number to dll file

## [1.0.6] - 2024-03-13
- fix(ci): forgot to update the nightly to the new cmake optimisation macro name
- fix(build): properly propagate command line cmake definition to c macro
- add info log when stopping shader constants retrieval
- feat(build): add OPTIMIZE config
- fix(debug): fix pdb name
- fix(lua): Bandaid fix for shader potential hard crash when going outside the maximum shader asset count limit.
- fix(lua): hook: potential fix for original func ptr getting overwritten between stacked calls to the central hook cause it's static and not a stack var
- fix(lua): fix doc being wrong, there is no arg count param since it's already available in the arg array param
- fix(debugging): don't wait for debugger in release builds.
- fix bigobj flag, need to be declared before it seems
- fix bigobj flag, need to be declared before it seems

## [1.0.5] - 2024-03-12
- (no commits logged)

## [1.0.4] - 2024-03-12
- (no commits logged)

## [1.0.3] - 2024-03-12
- (no commits logged)

## [1.0.2] - 2024-03-12
- (no commits logged)

## [1.0.1] - 2024-03-12
- fix(ci): remove bom from utf8
- feat(ci): upload nightly to TS. continued
- feat(ci): upload nightly to TS. continued
- feat(ci): upload nightly to TS. continued
- feat(ci): upload nightly to TS. continued
- feat(ci): upload nightly to TS. continued
- feat(ci): upload nightly to TS. continued 3
- feat(ci): upload nightly to TS. continued
- feat(ci): upload nightly to TS
- cmake: more optimisations
- cmake / nightly: test optimisation stuff
- feat(exception_handler): add mini dump writing
- fix(stacktrace): always print offset
- feat(ci): generate pdb too
- feat(gui): allow edit of the key for opening the mod loader gui. allow edit of whether or not the gui should be open at startup
- barebone hotkey system
- imgui hotkey: disable support for mouse buttons, since the associated hotkey system doesn't support them either currently
- chore: code formatting
- Merge branch 'master' of https://github.com/return-of-modding/ReturnOfModding
- feat(lua): path: filename, stem helpers.
- Update README.md

## [1.0.0] - 2024-03-10
- fix(renderer): another tentative fix for linux
- fix(renderer): continued, forgot to fix function call
- clang-format
- fix(renderer): try to fix linux failing to create dummy swapchain
- fix(hook): fix builtin function hooking not working in Release mode
- Merge branch 'master' of https://github.com/return-of-modding/ReturnOfModding
- feat(lua): support builtin functions hooking
- fix(locale): only change C locale instead of the C++ one. Because C++ one also change things like stringstream outputs and add comma to numbers and things like that, we don't want that, so just set locale on the C apis instead.
- fix(readme): fix risk of rain returns modding discord link
- chore(doc): gen
- lua path: add get_directories, get_files
- force locale to utf8
- chore: gen doc
- keep the array sorted the same as the ide file explorer
- lua path: expose table for manipulating file paths
- lua paths: actually expose it
- lua paths: better doc
- feat(lua): add RValue.value setter
- fix broken clang-format
- feat(mod): ShareItem mod
- add comment on why script_perform branch is empty for the central hook
- feat(lua): allow script hooks to call the same func again within their hook
- fix(gm): fix some weird race conditions on CInstance ctors/dctors
- chore(examples): debugtoolkit: disable achievemnt unlocker by default
- fix(lua): handle nil returns from load_file: 5.1 lua return values are different, or atleast sol doesnt handle them properly
- fix(stack_trace): print exception code as hex instead of int
- remove debug log
- feat(gm): bypass file locations game maker sandbox for returnofmodding purposes
- fix(lua): fix game maker ptr not returned as number to lua but instead as some opaque userdata
- chore(examples): update
- feat(gui): open/close all buttons for windows
- refactor(gui): simplify calls to lua::window serialize/deserialize
- fix(gui): don't show window settings from a mod that doesnt exist in current process
- refactor(gui): Let user manage their window hiding/showing behavior if they want to through using the bool open overloads and ImGuiWindowFlags_NoSavedSettings flag. Also make windows be opened by default instead of closed.
- feat(lua): expose ImGui.ShowDemoWindow
- chore(examples): update
- formatting
- fix(imgui window): don't silence exception
- feat(lua): on all mods loaded callback
- chore(doc): update
- feat(lua): remember gui window opened state
- feat(gui): better gui for opening/closing mod windows
- feat(lua): add_to_menu_bar callbacks
- fix: update for game version 1.0.5
- chore(doc): update
- refactor(lua): make any window hidden by default, user will have to open them from the MainMenuBar
- fix(doc): fix toml file extension
- feat(lua): expose config folder
- fix(lua): remove number precision check
- chore continued: config system was never used
- feat(lua): add toml support.
- fix(exception_handler): vectored means that the exception handler fire no matter what even if the exception is try catched, we don't want that.
- chore: this config folder was never used.
- feat(readme): tell about the folders
- feat(examples): achiev unlocker
- fix(gm): script_execute with 0 args not being handled correctly
- feat(lua): gml_Script hooks: support call r10 from Call_Method
- fix(pin_map): suspecting some free'd memory when we still holding a ref on the lua side since the refactor without the RValue and just DynamicArray being passed
- chore(examples): update
- feat(debug): yygmlexception logging inside code execute
- fix(lua): sol not taking number cause of decimal
- feat(lua): imgui: IsMouseClicked / IsMouseDoubleClicked
- feat(stack_trace): show currently executing code execute event name in case it exception inside those
- feat(gui): always draw rendering
- chore(examples): update
- fix(lua): new_index for CInstance and struts wasnt working properly, embarassing
- fix(lua): return nil if RefDynamicArrayOfRValue index access is not a number
- chore(doc): update
- fix(lua): RefDynamicArrayOfRValue pairs act like ipairs
- feat(lua): yyobjectbase direct access of struct_get and struct_set when it is one
- refactor(lua): struct_create return the yyobjectbase directly
- chore(doc): update
- RefDynamicArrayOfRValue: fix number being passed and treated as invalid
- feat(lua / gm): expose gm struct creation to lua
- chore(examples): update to latest api
- refactor(lua): remove variables_instance_get_names  from CInstance
- refactor(lua / gm): try giving the actual value directly from the RValue so that the api is easier to use in general
- try try catching Code Execute due to that fucking forever waiting error at 100% loading screen stuck
- refactor(gm): expose RefDynamicArrayOfRValue as a sol compatible container, pairs, bracket index operator support etc
- refactor(gm): RValue type object -> type yyobjectbase -> return CInstance??? maybe
- code reuse
- examples: update to latest matching api
- refactor(lua): return the value behind the RValue and just expose .value to lua, to simplify the api usage
- feat(lua): expose Cinstance id to CInstance map
- feat(lua-doc): update
- feat(lua / gm): allow gml script function hooking from lua
- feat(gm): script asset cache
- feat(hooking): add runtime detours support
- refactor(detour_hook): we do a lil change for its move/copy semantics
- refactor(gm): vars renaming
- script_data sigs cont
- more initialization changes
- script_data sig for gml script hooking
- allow usage of hde disasm
- feat(lua): expose script_name for SCRIPTREF yyobjects
- feat(gm): CScriptRef
- fix(lua): just return nil if string is empty
- fix(lua): properly check if it's an rvalue instead of just an userdata
- feat(stack_trace): log rip register
- fix(ci): RelWithDebInfo for symbols
- fix(lua): fix imgui imguikeymod overriding imguikey enums
- feat(lua-doc): better doc for key presses
- fix(lua): make error properly propagate the error on the lua stack like it's normally supposed to
- fix(lua): fix RValue OBJECT always returning a CInstance instead of the base type
- feat(gm): pre_code_execute hooks are able to skip original method call if wanted by returning false
- more initialization timing changes
- feat(lua-doc): imgui input doc
- feat(lua): imgui IsKeyDown, IskeyPressed etc support
- feat(gui): disable game inputs if gui is open
- chore(lua-doc): update
- refactor(lua / CInstance): don't return a raw pointer for arrays but wrap into a span so that sol wrap it as a nice lua table
- refactor(lua): change dump_vars to something that return a vector instead of just printing
- more bandaid fix for init timing
- fix(CInstance): the struct is wrong, remove the fields for now
- more experiment with initialization timing
- sol: enabled safeties
- fix(exception_handler): shared stack_trace across call and threads? what could go wrong
- feat(lua): update coolguy example: hotreload setup and cool ability
- fix(lua): fix incorrect handling of REAL RValues when accessing CInstance instance variables
- fix(lua): fix non local require path stem
- huh
- feat(lua): allow lua getting CInstance object instance from an RValue
- feat(lua): expose YYObjectBase
- fix(gm): fix potential crashes if we fire our code too early by delaying any gm call and lua init until the game process fire atleast one gml function. The game by that time should be initialized properly and the game maker engine have its internals ready
- fix(gm): print a stacktrace when the gm mem manager debugbreak us
- fix(gml_execption): fix includes
- fix(gml_exception): check RValue types before accessing
- chore(examples): update for matching latest api changes.
- feat(lua): constants table now also expose a `constants_type_sorted` table for dumping nicely. Also improve `room` constants dumping by providing an helper for refreshing the room constant cache
- chore(lua doc): regen
- feat(lua / CInstance): allow lua to get/set game defined instance variables through custom metatable index/new_index
- fix(RValue): better logging
- refactor(CInstance): Match GML naming
- readme: add modshovel credit
- fix(doc): make doc a bit clearer for gm.CInstance
- feat(lua): expose gm.constants and gm.constant_types
- feat(gm): exception handler so that we can feed bullshit to gm functions and will let us continue, not sure if smart to have it enabled by default but we'll see. note that it concerns only our calls to gml functions, the game calls to other game functions will still go through the game regular exception handler which abort the process quickly
- chore: formating/naming
- fix(lua): fix array variables in lua land getting gced by gml
- fix(doc) formating
- feat(lua): expose mod specific paths/guid to their env table
- chore(examples): update to latest features (most notably the new way to call gm functions
- chore(lua-doc): generate
- feat(lua): log traceback on function errors.
- feat(lua): expose variable_global_get/variable_global_set. expose way to call gml functions directly through gm.function_name instead of having to do gm.call("function_name")
- fix(gm): global_variable -> variable_global (just so we stick with gml naming)
- fix(gm): global_variable_get/set handle game defined global variables, closes #2
- fix(lua): properly define an error handler for function calls
- fix(lua): fix exception handler so that runtime errors are properly logged
- feat(lua-doc): paths
- feat(lua): expose debug / io. expose load, loadstring, loadfile, dofile
- feat(lua): expose `paths` for config and plugins_data folder, also rename `scripts` to `plugins`
- chore(stack_trace): remove unused func definition
- fix(lua): pointer/memory: correctly expose and document rip_cmp
- fix(lua): fix log adding an extra `\t` at the end of each log.
- chore(example): update example to showcase new `log` and `require`
- chore(lua-doc): gen doc
- fix(gui): when any imgui ui is focused disable game inputs.
- fix(gui): restore theme
- feat(lua): log is now much more lua like. also make lua `print` and `error` work.
- fix(lua): require: warn the user that the env of their dependency won't be correctly set if they happen to require a module where the owning package didnt init yet due to lacking manifest.json level dependency missing.
- fix(lua): `require` now properly support variadic args
- fix(lua): don't log the fact that the mod loader dependency failed to load: it's normal because the mod loader doesnt exist as a lua file
- fix(lua): fix hot-reload which stopped working when user tried to reload their module after it failed to load the first time
- fix(CI): Try swapping to windows because I can't figure out why exports are not being made
- fix(CI): forgot rc compiler path
- fix(CI): CI msvc compiler is still not producing correct exports, trying some more things
- fix(CI): fix rc compiler not being specified, which would then fail to produce valid exports for setting up the dll hjiacking
- fix(CI): fix path of output dll
- feat(CI): Nightly builds
- README: add archie / yytoolkit to credits
- fix(readme): link
- Add MIT License for now
- README: Explain how to install, how to define a mod
- feat(lua doc): Add documentation.
- lua examples: update for current api/bindings. Add sarn example survivor
- feat(lua): implement custom require for dependency between lua modules. Closes #4
- feat(lua): basic dependency system for lua modules.
- fix(stack_trace): Disable logging of C++ std::exception.what() to console until we figure out how to properly type check this. related to issue #1
- chore: remove unused include
- refactor(lua): swap to a single lua state and use sol::environement for no lua global table contamination
- refactor(lua_module): simplify fields
- refactor(gm/lua): rename some variables to snake_case/better names. Simplify bindings
- feat(debug): recognize incoming fatal Code Error and flush the logger when that happens
- fix(lua): fix cases where user would receive bogus value when user try to access the underlying value type from an RValue by properly casting before returning it.
- fix(lua): properly check for the file name to be main.lua and not just main
- lua: remove global table bindings as it is unusued and empty anyway.
- fix(debug): properly fix the bandaid fix for log spam
- trying to debug initialization crash by delaying with thread sleep
- examples: add lua mod debugtoolkit
- lua: only load lua files named `main.lua`, other files can still be loaded through `require` by the user
- - return_of_modding -> ReturnOfModding - remove zydis dependency as it is unused (we don't advance rip register to next instruction anymore)
- debug log: tell what the SHA1 being logged is (with what head commit the dll was built)
- debug log: log how the root folder was built
- feat(gm/lua): expose and fix RValue to string for lua
- fix(debug_console): use strcmp for the bandaid fix log spam
- fix(lua) hotreload not working
- feat(entrypoint): pause all threads so that we get really early launches and then resume them when we need them for rendering
- fix(gui): properly always end imgui::begin with imgui::end
- fix(debug): bandaid fix for log spam
- feat(lua): properly expose RefDynamicArrayOfRValue arrays to lua
- feat(stack_trace): SetThreadName exception support
- feat(debug): hook game maker debug output and redirect to ours.
- feat(lua): expose CInstance instance variable helpers
- feat(lua): expose RefDynamicArrayOfRValue
- feat(lua): expose gm global variable get/set
- feat(lua): support boolean <-> RValue bool args
- refactor(gm): use some classes from libLassebq and YoYo official repos
- fix(lua): only include sol.hpp once
- fix(stack_trace): properly null check returned module info. Also say when it's a c++ msvc exception getting triggered
- refactor(exception_handler): Use Vectored Exception Handling because some exceptions were not logged properly to console/file.
- explain topological_sort
- feat(debug): helper method for waiting until debugger is attached
- feat(lua): support for dependencies
- refactor(gm): overload everything with just `call`
- feat(gm): add support for calling gml script functions without forcing the user to use `script_execute` manually
- fix(CInstance): make object_name return a string ref instead of just the const char*: easier to work with.
- formating
- CInstance: object_name helper func
- feat(lua): add some game maker bindings
- feat(lua): Code_Execute hook: add pre and post lua events
- RValue: add helper method for retrieving const char* from an RValue
- feat(lua): add watcher thread for reloading modified scripts on the fly
- add a warning when a non existing builtin function is trying to be called
- add debug code for showing current room name/index
- feat(lua): draw gui from lua scripts
- debug code for adding a survivor entry to the character selection
- Add project files.
- Add .gitattributes.
## [1.1.19] - 2026-03-26

- CHANGELOG
- fix(ci): another try at fixing changelog gen
- Release v1.1.19


