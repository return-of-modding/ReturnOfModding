#include "exception_handler.hpp"

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

	exception_handler::exception_handler()
	{
		m_old_error_mode    = SetErrorMode(0);
		m_exception_handler = SetUnhandledExceptionFilter(vectored_exception_handler);
	}

	exception_handler::~exception_handler()
	{
		SetErrorMode(m_old_error_mode);
		SetUnhandledExceptionFilter(reinterpret_cast<decltype(&vectored_exception_handler)>(m_exception_handler));
	}

	typedef BOOL(WINAPI* MINIDUMPWRITEDUMP)(HANDLE hProcess, DWORD dwPid, HANDLE hFile, MINIDUMP_TYPE DumpType, const PMINIDUMP_EXCEPTION_INFORMATION ExceptionParam, const PMINIDUMP_USER_STREAM_INFORMATION UserStreamParam, const PMINIDUMP_CALLBACK_INFORMATION CallbackParam);

	static bool write_mini_dump(EXCEPTION_POINTERS* exception_info)
	{
		bool returncode = false;

		const std::filesystem::path dumpFileName = g_file_manager.get_project_file("./ReturnOfModding_crash.dmp").get_path();
		if (std::filesystem::exists(dumpFileName))
		{
			std::filesystem::remove(dumpFileName);
		}

		HANDLE hDumpFile = CreateFileW(dumpFileName.c_str(), GENERIC_WRITE, 0, 0, CREATE_ALWAYS, 0, 0);

		HMODULE hDbgHelpDll      = nullptr;
		BOOL bMiniDumpSuccessful = FALSE;
		MINIDUMPWRITEDUMP pDump  = nullptr;
		const MINIDUMP_TYPE minidump_type = static_cast<MINIDUMP_TYPE>(MiniDumpNormal | MiniDumpWithHandleData | MiniDumpWithProcessThreadData | MiniDumpWithThreadInfo | MiniDumpWithIndirectlyReferencedMemory);

		if (hDumpFile == INVALID_HANDLE_VALUE)
		{
			goto cleanup;
		}

		// Load the DBGHELP DLL
		hDbgHelpDll = ::LoadLibraryW(L"DBGHELP.DLL");
		if (!hDbgHelpDll)
		{
			goto cleanup;
		}

		pDump = (MINIDUMPWRITEDUMP)::GetProcAddress(hDbgHelpDll, "MiniDumpWriteDump");
		if (!pDump)
		{
			goto cleanup;
		}

		// Initialize minidump structure
		MINIDUMP_EXCEPTION_INFORMATION mdei;
		mdei.ThreadId          = GetCurrentThreadId();
		mdei.ExceptionPointers = exception_info;
		mdei.ClientPointers    = FALSE;

		bMiniDumpSuccessful = pDump(GetCurrentProcess(), GetCurrentProcessId(), hDumpFile, minidump_type, &mdei, 0, NULL);
		if (!bMiniDumpSuccessful)
		{
			goto cleanup;
		}

		returncode = true;

	cleanup:

		if (hDumpFile != INVALID_HANDLE_VALUE)
		{
			CloseHandle(hDumpFile);
		}

		if (hDbgHelpDll)
		{
			FreeLibrary(hDbgHelpDll);
		}

		return returncode;
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
