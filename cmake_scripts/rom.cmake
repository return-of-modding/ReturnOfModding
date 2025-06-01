include(FetchContent)

set(LUA_USE_LUAJIT false)
set(LUA_GIT_HASH 5d708c3f9cae12820e415d4f89c9eacbe2ab964b) # https://github.com/lua/lua/releases/tag/v5.4.4

FetchContent_Declare(
	rom
	GIT_REPOSITORY https://github.com/xiaoxiao921/ReturnOfModdingBase.git
	GIT_TAG 4e66bfbb444ad552441fcf34c638903baf97fdbe
)
FetchContent_MakeAvailable(rom)
