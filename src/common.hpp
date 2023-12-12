#ifndef COMMON_INC
#define COMMON_INC

// clang-format off

#include <sdkddkver.h>
#include <winsock2.h>
#include <windows.h>
#include <d3d11.h>

#include <cinttypes>
#include <cstddef>
#include <cstdint>

#include <chrono>
#include <ctime>

#include <filesystem>
#include <fstream>
#include <iostream>
#include <iomanip>

#include <atomic>
#include <mutex>
#include <thread>

#include <memory>
#include <new>

#include <sstream>
#include <string>
#include <string_view>

#include <algorithm>
#include <functional>
#include <utility>

#include <set>
#include <stack>
#include <vector>

#include <typeinfo>
#include <type_traits>

#include <exception>
#include <stdexcept>

#include <any>
#include <optional>
#include <variant>

#include <format>
#include <nlohmann/json.hpp>

#define SOL_SAFE_USERTYPE 1
#include "lua/sol.hpp"

#define IMGUI_DEFINE_MATH_OPERATORS
#include <imgui.h>
#define IMGUI_DEFINE_MATH_OPERATORS
#include <imgui_internal.h>

#include "logger/logger.hpp"

// clang-format on

namespace big
{
	using namespace std::chrono_literals;

	inline HMODULE g_hmodule{};
	inline HANDLE g_main_thread{};
	inline DWORD g_main_thread_id{};
	inline std::atomic_bool g_abort{false};
	inline std::atomic_bool g_running{false};
	inline bool g_gml_safe{false};

	inline constexpr auto g_project_name             = "ReturnOfModding";
	inline constexpr auto g_target_window_class_name = "YYGameMakerYY";
}

#include "config/config.hpp"

#endif
