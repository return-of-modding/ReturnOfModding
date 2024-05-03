include(FetchContent)

set(LUA_GIT_HASH 5d708c3f9cae12820e415d4f89c9eacbe2ab964b)

FetchContent_Declare(
	rom
	GIT_REPOSITORY https://github.com/xiaoxiao921/ReturnOfModdingBase.git
	GIT_TAG e8fed49de9c5478077f601938e50ed5d3bb0b16a
)
FetchContent_MakeAvailable(rom)
