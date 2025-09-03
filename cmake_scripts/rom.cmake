include(FetchContent)

set(LUA_USE_LUAJIT false)
set(LUA_GIT_HASH 5d708c3f9cae12820e415d4f89c9eacbe2ab964b) # https://github.com/lua/lua/releases/tag/v5.4.4

add_compile_definitions(
    "IMGUI_USER_CONFIG=\"${SRC_DIR}/gui/imgui_config.hpp\""
)

FetchContent_Declare(
	rom
	GIT_REPOSITORY https://github.com/xiaoxiao921/ReturnOfModdingBase.git
	GIT_TAG 85533d92968adb44690034e765a384f38c88ddb6
)
FetchContent_MakeAvailable(rom)
