include(FetchContent)

message("Lua")
FetchContent_Declare(
    Lua
    GIT_REPOSITORY https://github.com/walterschell/Lua.git
    GIT_TAG a2e0125df529894f5e25d7d477b2df4e37690e0f
    GIT_PROGRESS TRUE
)
FetchContent_MakeAvailable(Lua)

set_property(TARGET lua_static PROPERTY CXX_STANDARD 23)

set(LUA_INCLUDE_DIR "${Lua_SOURCE_DIR}/src")
set(LUA_LIBRARIES Lua)

message("toml++")
FetchContent_Declare(
	toml++
	GIT_REPOSITORY "https://github.com/marzer/tomlplusplus.git"
	GIT_SHALLOW ON
    GIT_SUBMODULES ""
	GIT_TAG "v3.4.0"
)
FetchContent_MakeAvailable(toml++)

message("sol2")
FetchContent_Declare(
	sol2
	GIT_REPOSITORY "https://github.com/ThePhD/sol2.git"
	GIT_SHALLOW ON
    GIT_SUBMODULES ""
	GIT_TAG "v3.3.0"
)
FetchContent_MakeAvailable(sol2)

message("magic_enum")
FetchContent_Declare(
	magic_enum
	GIT_REPOSITORY "https://github.com/Neargye/magic_enum.git"
	GIT_SHALLOW ON
    GIT_SUBMODULES ""
	GIT_TAG "v0.9.5"
)
FetchContent_MakeAvailable(magic_enum)

#include_directories(${LUA_INCLUDE_DIR} src src/include ${${TOML++}_SOURCE_DIR} ${${SOL2}_SOURCE_DIR}/include ${${MAGIC_ENUM}_SOURCE_DIR}/include)

#set(SOURCES
    #src/toml.cpp
    #src/decoding/decoding.cpp
    #src/encoding/encoding.cpp
	#src/DataTypes/DateAndTime/dateAndTime.cpp
	#src/DataTypes/TOMLInt/TOMLInt.cpp
 #   src/utilities/utilities.cpp
#)