#pragma once

namespace gm
{
    using debug_console_output_t = void(*)(void* this_, const char* fmt, ...);

    inline void hook_debug_console_output(void* this_, const char* fmt, ...)
	{
		va_list args;

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

		LOG(INFO) << result;

		va_start(args, fmt);
		big::g_hooking->get_original<hook_debug_console_output>()(this_, fmt, args);
		va_end(args);
	}
}