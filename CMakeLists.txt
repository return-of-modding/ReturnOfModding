cmake_minimum_required(VERSION 3.20)

project(return_of_modding CXX C ASM_MASM)

set(SRC_DIR "${PROJECT_SOURCE_DIR}/src")

# Fetch modules
message("\nFetching modules")
include(cmake_scripts/async-logger.cmake)
include(cmake_scripts/cpp-semver.cmake)
include(cmake_scripts/cxxopts.cmake)
include(cmake_scripts/git.cmake)
include(cmake_scripts/imgui.cmake)
include(cmake_scripts/json.cmake)
include(cmake_scripts/lua.cmake)
include(cmake_scripts/minhook.cmake)
include(cmake_scripts/pugixml.cmake)
include(cmake_scripts/tomlplusplus.cmake)
include(cmake_scripts/zydis.cmake)

message(STATUS "return_of_modding")
file(GLOB_RECURSE SRC_MAIN
    "${SRC_DIR}/**.hpp"
    "${SRC_DIR}/**.h"
    "${SRC_DIR}/**.cpp"
    "${SRC_DIR}/**.cc"
    "${SRC_DIR}/**.cxx"
    "${SRC_DIR}/**.asm"
    "${SRC_DIR}/**.def"
)

if (MSVC)
  add_compile_options(/bigobj)
  add_compile_options("$<$<C_COMPILER_ID:MSVC>:/utf-8>")
  add_compile_options("$<$<CXX_COMPILER_ID:MSVC>:/utf-8>")
else ()
  add_compile_options(-Wa,-mbig-obj)
endif ()

add_library(return_of_modding MODULE "${SRC_MAIN}")

set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set_property(TARGET return_of_modding PROPERTY CXX_STANDARD 23)

source_group(TREE ${SRC_DIR} PREFIX "src" FILES ${SRC_MAIN} )

target_include_directories(return_of_modding PRIVATE
    "${SRC_DIR}"
    "${cxxopts_SOURCE_DIR}/include"
    "${json_SOURCE_DIR}/single_include"
    "${imgui_SOURCE_DIR}"
    "${tomlplusplus_BINARY_DIR}/include"
    "${cpp-semver_SOURCE_DIR}/include"
)

target_precompile_headers(return_of_modding PRIVATE "${SRC_DIR}/common.hpp")

target_link_libraries(return_of_modding PRIVATE pugixml minhook AsyncLogger dbghelp imgui Zydis lua_static tomlplusplus::tomlplusplus)

# Warnings as errors
set_property(TARGET return_of_modding PROPERTY COMPILE_WARNING_AS_ERROR ON)

add_compile_definitions(return_of_modding
    "_CRT_SECURE_NO_WARNINGS"
    "NOMINMAX"
    "WIN32_LEAN_AND_MEAN"
)

set_target_properties(return_of_modding PROPERTIES OUTPUT_NAME "version")