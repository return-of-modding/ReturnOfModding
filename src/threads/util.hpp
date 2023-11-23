#pragma once
#include <tlhelp32.h>

namespace big::threads
{
	inline void resume_all(DWORD target_process_id = GetCurrentProcessId(), DWORD thread_id_to_not_suspend = GetCurrentThreadId())
	{
		HANDLE h = CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 0);
		if (h != INVALID_HANDLE_VALUE)
		{
			THREADENTRY32 te;
			te.dwSize = sizeof(te);
			if (Thread32First(h, &te))
			{
				do
				{
					if (te.dwSize >= FIELD_OFFSET(THREADENTRY32, th32OwnerProcessID) + sizeof(te.th32OwnerProcessID) && te.th32OwnerProcessID == target_process_id)
					{
						HANDLE thread = ::OpenThread(THREAD_ALL_ACCESS, FALSE, te.th32ThreadID);
						if (thread)
						{
							ResumeThread(thread);
							CloseHandle(thread);
						}
					}
				} while (Thread32Next(h, &te));
			}
			CloseHandle(h);
		}
	}

	inline void suspend_all_but_one(DWORD target_process_id = GetCurrentProcessId(), DWORD thread_id_to_not_suspend = GetCurrentThreadId())
	{
		HANDLE h = CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 0);
		if (h != INVALID_HANDLE_VALUE)
		{
			THREADENTRY32 te;
			te.dwSize = sizeof(te);
			if (Thread32First(h, &te))
			{
				do
				{
					if (te.dwSize >= FIELD_OFFSET(THREADENTRY32, th32OwnerProcessID) + sizeof(te.th32OwnerProcessID) && te.th32OwnerProcessID == target_process_id && te.th32ThreadID != thread_id_to_not_suspend)
					{
						HANDLE thread = ::OpenThread(THREAD_ALL_ACCESS, FALSE, te.th32ThreadID);
						if (thread)
						{
							SuspendThread(thread);
							CloseHandle(thread);
						}
					}
				} while (Thread32Next(h, &te));
			}
			CloseHandle(h);
		}
	}
}