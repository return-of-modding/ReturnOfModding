include(FetchContent)

set(LUA_GIT_HASH 5d708c3f9cae12820e415d4f89c9eacbe2ab964b)

FetchContent_Declare(
	rom
	GIT_REPOSITORY https://github.com/xiaoxiao921/ReturnOfModdingBase.git
	GIT_TAG bc6fda87c436dbb39df8a1a4b3a4b7dda894ee8d
)
FetchContent_MakeAvailable(rom)
