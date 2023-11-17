include(FetchContent)

add_definitions(-DTOML_EXCEPTIONS=0)

FetchContent_Declare(
    tomlplusplus
    GIT_REPOSITORY https://github.com/marzer/tomlplusplus.git
    GIT_TAG        v3.4.0
)

message("tomlplusplus")
FetchContent_MakeAvailable(tomlplusplus)
