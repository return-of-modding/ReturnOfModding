include(FetchContent)

set(LUA_USE_LUAJIT false)
set(LUA_GIT_HASH 5d708c3f9cae12820e415d4f89c9eacbe2ab964b) # https://github.com/lua/lua/releases/tag/v5.4.4

FetchContent_Declare(
	rom
	GIT_REPOSITORY https://github.com/xiaoxiao921/ReturnOfModdingBase.git
	GIT_TAG b835c915d32d9183411f1eea62955c8be0ebf54f
)
FetchContent_MakeAvailable(rom)
