include(FetchContent)

set(LUA_GIT_HASH 5d708c3f9cae12820e415d4f89c9eacbe2ab964b)

FetchContent_Declare(
	rom
	GIT_REPOSITORY https://github.com/xiaoxiao921/ReturnOfModdingBase.git
	GIT_TAG 685b30b2fcb6876170e0bd1452a4f978f4163eda
)
FetchContent_MakeAvailable(rom)
