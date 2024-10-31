include(FetchContent)

set(LUA_GIT_HASH 5d708c3f9cae12820e415d4f89c9eacbe2ab964b)

FetchContent_Declare(
	rom
	GIT_REPOSITORY https://github.com/xiaoxiao921/ReturnOfModdingBase.git
	GIT_TAG b0fb7462d1edc43d0dc22d7c8c3840cf940fdeb7
)
FetchContent_MakeAvailable(rom)
