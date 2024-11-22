include(FetchContent)

set(LUA_GIT_HASH 5d708c3f9cae12820e415d4f89c9eacbe2ab964b)

FetchContent_Declare(
	rom
	GIT_REPOSITORY https://github.com/xiaoxiao921/ReturnOfModdingBase.git
	GIT_TAG f62b2697c0a4a6ba3b2afa4dbd3d1a06fcc400a9
)
FetchContent_MakeAvailable(rom)
