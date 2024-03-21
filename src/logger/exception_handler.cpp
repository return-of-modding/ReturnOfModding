#include "exception_handler.hpp"

#include "paths/paths.hpp"
#include "stack_trace.hpp"

#include <DbgHelp.h>

namespace big
{
	inline auto hash_stack_trace(std::vector<uint64_t> stack_trace)
	{
		auto data        = reinterpret_cast<const char*>(stack_trace.data());
		std::size_t size = stack_trace.size() * sizeof(uint64_t);

		return std::hash<std::string_view>()({data, size});
	}

	static HMODULE DbgHelp_module = nullptr;

	exception_handler::exception_handler()
	{
		m_old_error_mode    = SetErrorMode(0);
		m_exception_handler = SetUnhandledExceptionFilter(vectored_exception_handler);

		if (!DbgHelp_module)
		{
			DbgHelp_module = ::LoadLibraryW(L"DBGHELP.DLL");
			if (!DbgHelp_module)
			{
				LOG(FATAL) << "Failed loading DbgHelp";
			}
		}
	}

	exception_handler::~exception_handler()
	{
		MessageBoxA(0, "No more exception handler!!!\nIf this continues to happen, try not launching from the executable but from Steam.", "ReturnOfModding", MB_ICONERROR);

		SetUnhandledExceptionFilter(reinterpret_cast<decltype(&vectored_exception_handler)>(m_exception_handler));
		SetErrorMode(m_old_error_mode);

		if (DbgHelp_module)
		{
			FreeLibrary(DbgHelp_module);
		}
	}

	typedef BOOL(WINAPI* MINIDUMPWRITEDUMP)(HANDLE hProcess, DWORD dwPid, HANDLE hFile, MINIDUMP_TYPE DumpType, const PMINIDUMP_EXCEPTION_INFORMATION ExceptionParam, const PMINIDUMP_USER_STREAM_INFORMATION UserStreamParam, const PMINIDUMP_CALLBACK_INFORMATION CallbackParam);

	static BOOL write_mini_dump(EXCEPTION_POINTERS* exception_info)
	{
		BOOL is_success = FALSE;

		const auto& dump_file_path = paths::remove_and_get_dump_file_path();

		const auto dump_file_handle = CreateFileW(dump_file_path.c_str(), GENERIC_WRITE, 0, 0, CREATE_ALWAYS, 0, 0);

		MINIDUMPWRITEDUMP MiniDumpWriteDump_function = nullptr;
		const auto minidump_type = (MINIDUMP_TYPE)(MiniDumpNormal | MiniDumpWithHandleData | MiniDumpWithProcessThreadData | MiniDumpWithThreadInfo | MiniDumpWithIndirectlyReferencedMemory);

		if (dump_file_handle == INVALID_HANDLE_VALUE)
		{
			std::stringstream error_msg;
			error_msg << "CreateFileW error code: " << HEX_TO_UPPER(GetLastError());
			MessageBoxA(0, error_msg.str().c_str(), "ReturnOfModding", MB_ICONERROR);

			goto cleanup;
		}

		MiniDumpWriteDump_function = (MINIDUMPWRITEDUMP)::GetProcAddress(DbgHelp_module, "MiniDumpWriteDump");
		if (!MiniDumpWriteDump_function)
		{
			std::stringstream error_msg;
			error_msg << "GetProcAddress error code: " << HEX_TO_UPPER(GetLastError());
			MessageBoxA(0, error_msg.str().c_str(), "ReturnOfModding", MB_ICONERROR);

			goto cleanup;
		}

		// Initialize minidump structure
		MINIDUMP_EXCEPTION_INFORMATION mdei;
		mdei.ThreadId          = GetCurrentThreadId();
		mdei.ExceptionPointers = exception_info;
		mdei.ClientPointers    = FALSE;

		is_success = MiniDumpWriteDump_function(GetCurrentProcess(), GetCurrentProcessId(), dump_file_handle, minidump_type, &mdei, 0, NULL);
		if (!is_success)
		{
			std::stringstream error_msg;
			error_msg << "MiniDumpWriteDump_function error code: " << HEX_TO_UPPER(GetLastError());
			MessageBoxA(0, error_msg.str().c_str(), "ReturnOfModding", MB_ICONERROR);

			goto cleanup;
		}

		is_success = TRUE;

	cleanup:

		if (dump_file_handle != INVALID_HANDLE_VALUE)
		{
			CloseHandle(dump_file_handle);
		}

		return is_success;
	}

	LONG vectored_exception_handler(EXCEPTION_POINTERS* exception_info)
	{
		const auto exception_code = exception_info->ExceptionRecord->ExceptionCode;
		if (exception_code == EXCEPTION_BREAKPOINT || exception_code == DBG_PRINTEXCEPTION_C || exception_code == DBG_PRINTEXCEPTION_WIDE_C)
		{
			return EXCEPTION_CONTINUE_SEARCH;
		}

		if (IsDebuggerPresent())
		{
			return EXCEPTION_CONTINUE_SEARCH;
		}

		write_mini_dump(exception_info);

		static std::set<std::size_t> logged_exceptions;

		stack_trace trace;
		trace.new_stack_trace(exception_info);
		const auto trace_hash = hash_stack_trace(trace.frame_pointers());
		if (const auto it = logged_exceptions.find(trace_hash); it == logged_exceptions.end())
		{
			LOG(FATAL) << trace;
			Logger::FlushQueue();

			logged_exceptions.insert(trace_hash);
		}

		return EXCEPTION_CONTINUE_SEARCH;
	}
} // namespace big
