#pragma once
#include "debug/debug.hpp"
#include "logger/exception_handler.hpp"
#include "string/string.hpp"

namespace gm
{
	using debug_console_output_t = void (*)(void* this_, const char* fmt, ...);

	inline void log_stacktrace_and_abort()
	{
		__try
		{
			*(int*)0 = 0;
		}
		__except (big::vectored_exception_handler(GetExceptionInformation()), EXCEPTION_EXECUTE_HANDLER)
		{
			Logger::FlushQueue();
			big::debug::wait_until_debugger();
		}
	}

	inline void hook_debug_console_output(void* this_, const char* fmt, ...)
	{
		va_list args;

		// get a stacktrace when this happen, the game triggers a debugbreak on this.
		if (!strcmp("Why are we reallocing a block that we didn't alloc?!\n", fmt))
		{
			va_start(args, fmt);
			big::g_hooking->get_original<hook_debug_console_output>()(this_, fmt, args);
			va_end(args);

			log_stacktrace_and_abort();

			return;
		}

		// bandaid fix cause current debug gui code trigger it through getting layer names
		if (!strcmp("layer_get_all_elements() - can't find specified layer\n", fmt))
		{
			va_start(args, fmt);
			big::g_hooking->get_original<hook_debug_console_output>()(this_, fmt, args);
			va_end(args);
			return;
		}

		va_start(args, fmt);
		int size = vsnprintf(nullptr, 0, fmt, args);
		va_end(args);

		// Allocate a buffer to hold the formatted string
		std::string result(size + 1, '\0'); // +1 for the null terminator

		// Format the string into the buffer
		va_start(args, fmt);
		vsnprintf(&result[0], size + 1, fmt, args);
		va_end(args);
		result.pop_back();
		result.pop_back();

		if (big::string::starts_with("ERROR!!!", result.c_str()))
		{
			LOG(FATAL) << result;
			Logger::FlushQueue();
		}
		else
		{
			LOG(INFO) << result;
		}

		va_start(args, fmt);
		big::g_hooking->get_original<hook_debug_console_output>()(this_, fmt, args);
		va_end(args);
	}
} // namespace gm
