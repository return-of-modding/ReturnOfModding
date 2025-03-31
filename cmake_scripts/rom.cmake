include(FetchContent)

set(LUA_USE_LUAJIT false)
set(LUA_GIT_HASH 5d708c3f9cae12820e415d4f89c9eacbe2ab964b)

FetchContent_Declare(
	rom
	GIT_REPOSITORY https://github.com/xiaoxiao921/ReturnOfModdingBase.git
	GIT_TAG e26dc7080577110c1af78b903c27a284cff10296
)
FetchContent_MakeAvailable(rom)
