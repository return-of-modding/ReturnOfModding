include(FetchContent)

set(LUA_GIT_HASH 5d708c3f9cae12820e415d4f89c9eacbe2ab964b)

FetchContent_Declare(
	rom
	GIT_REPOSITORY https://github.com/xiaoxiao921/ReturnOfModdingBase.git
	GIT_TAG 2b7f933f9a186545b5accabd3d5350abec14a1b1
)
FetchContent_MakeAvailable(rom)
