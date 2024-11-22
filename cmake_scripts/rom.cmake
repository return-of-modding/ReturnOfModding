include(FetchContent)

set(LUA_GIT_HASH 5d708c3f9cae12820e415d4f89c9eacbe2ab964b)

FetchContent_Declare(
	rom
	GIT_REPOSITORY https://github.com/xiaoxiao921/ReturnOfModdingBase.git
	GIT_TAG 2033f0ea6ddfc62c2b036cf7f8cd4500065f5c9f
)
FetchContent_MakeAvailable(rom)
