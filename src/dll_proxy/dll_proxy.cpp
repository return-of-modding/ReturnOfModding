#include "dll_proxy.hpp"

namespace big
{
	static HMODULE dll_proxies[MODULE_MAX]{};
	static LPCWSTR dll_proxy_names[MODULE_MAX]{
	    L"version.dll",
	};

	static FARPROC get_function(dll_proxy index, const char* name)
	{
		if (dll_proxies[index] == nullptr)
		{
			BOOL wow64 = FALSE;
			WCHAR path[MAX_PATH];

			if (IsWow64Process(GetCurrentProcess(), &wow64) && wow64)
			{
				GetSystemWow64DirectoryW(path, MAX_PATH);
			}
			else
			{
				GetSystemDirectoryW(path, MAX_PATH);
			}

			lstrcatW(path, L"\\");
			lstrcatW(path, dll_proxy_names[index]);
			dll_proxies[index] = LoadLibraryW(path);
		}

		return GetProcAddress(dll_proxies[index], name);
	}

	template<typename T>
	static T forward_version_call_internal(dll_proxy index, const char* funcName, T)
	{
		static T proc = nullptr;
		if (proc != nullptr)
		{
			return proc;
		}
		return proc = reinterpret_cast<T>(get_function(index, funcName));
	}

#define forward_version_call(F) forward_version_call_internal(VERSION_DLL, #F, F)

	EXTERN_C BOOL WINAPI GetFileVersionInfoA(LPCSTR lptstrFilename, DWORD dwHandle, DWORD dwLen, LPVOID lpData)
	{
		return forward_version_call(GetFileVersionInfoA)(lptstrFilename, dwHandle, dwLen, lpData);
	}

	EXTERN_C int WINAPI GetFileVersionInfoByHandle(int hMem, LPCWSTR lpFileName, int v2, int v3)
	{
		return forward_version_call(GetFileVersionInfoByHandle)(hMem, lpFileName, v2, v3);
	}

	EXTERN_C BOOL WINAPI GetFileVersionInfoExA(DWORD dwFlags, LPCSTR lpwstrFilename, DWORD dwHandle, DWORD dwLen, LPVOID lpData)
	{
		return forward_version_call(GetFileVersionInfoExA)(dwFlags, lpwstrFilename, dwHandle, dwLen, lpData);
	}

	EXTERN_C BOOL WINAPI GetFileVersionInfoExW(DWORD dwFlags, LPCWSTR lpwstrFilename, DWORD dwHandle, DWORD dwLen, LPVOID lpData)
	{
		return forward_version_call(GetFileVersionInfoExW)(dwFlags, lpwstrFilename, dwHandle, dwLen, lpData);
	}

	EXTERN_C DWORD WINAPI GetFileVersionInfoSizeA(LPCSTR lptstrFilename, LPDWORD lpdwHandle)
	{
		return forward_version_call(GetFileVersionInfoSizeA)(lptstrFilename, lpdwHandle);
	}

	EXTERN_C DWORD WINAPI GetFileVersionInfoSizeExA(DWORD dwFlags, LPCSTR lpwstrFilename, LPDWORD lpdwHandle)
	{
		return forward_version_call(GetFileVersionInfoSizeExA)(dwFlags, lpwstrFilename, lpdwHandle);
	}

	EXTERN_C DWORD WINAPI GetFileVersionInfoSizeExW(DWORD dwFlags, LPCWSTR lpwstrFilename, LPDWORD lpdwHandle)
	{
		return forward_version_call(GetFileVersionInfoSizeExW)(dwFlags, lpwstrFilename, lpdwHandle);
	}

	EXTERN_C DWORD WINAPI GetFileVersionInfoSizeW(LPCWSTR lptstrFilename, LPDWORD lpdwHandle)
	{
		return forward_version_call(GetFileVersionInfoSizeW)(lptstrFilename, lpdwHandle);
	}

	EXTERN_C BOOL WINAPI GetFileVersionInfoW(LPCWSTR lptstrFilename, DWORD dwHandle, DWORD dwLen, LPVOID lpData)
	{
		return forward_version_call(GetFileVersionInfoW)(lptstrFilename, dwHandle, dwLen, lpData);
	}

	EXTERN_C DWORD WINAPI VerFindFileA(DWORD uFlags, LPCSTR szFileName, LPCSTR szWinDir, LPCSTR szAppDir, LPSTR szCurDir, PUINT lpuCurDirLen, LPSTR szDestDir, PUINT lpuDestDirLen)
	{
		return forward_version_call(VerFindFileA)(uFlags, szFileName, szWinDir, szAppDir, szCurDir, lpuCurDirLen, szDestDir, lpuDestDirLen);
	}

	EXTERN_C DWORD WINAPI VerFindFileW(DWORD uFlags, LPCWSTR szFileName, LPCWSTR szWinDir, LPCWSTR szAppDir, LPWSTR szCurDir, PUINT lpuCurDirLen, LPWSTR szDestDir, PUINT lpuDestDirLen)
	{
		return forward_version_call(VerFindFileW)(uFlags, szFileName, szWinDir, szAppDir, szCurDir, lpuCurDirLen, szDestDir, lpuDestDirLen);
	}

	EXTERN_C DWORD WINAPI VerInstallFileA(DWORD uFlags, LPCSTR szSrcFileName, LPCSTR szDestFileName, LPCSTR szSrcDir, LPCSTR szDestDir, LPCSTR szCurDir, LPSTR szTmpFile, PUINT lpuTmpFileLen)
	{
		return forward_version_call(VerInstallFileA)(uFlags, szSrcFileName, szDestFileName, szSrcDir, szDestDir, szCurDir, szTmpFile, lpuTmpFileLen);
	}

	EXTERN_C DWORD WINAPI VerInstallFileW(DWORD uFlags, LPCWSTR szSrcFileName, LPCWSTR szDestFileName, LPCWSTR szSrcDir, LPCWSTR szDestDir, LPCWSTR szCurDir, LPWSTR szTmpFile, PUINT lpuTmpFileLen)
	{
		return forward_version_call(VerInstallFileW)(uFlags, szSrcFileName, szDestFileName, szSrcDir, szDestDir, szCurDir, szTmpFile, lpuTmpFileLen);
	}

	EXTERN_C DWORD WINAPI VerLanguageNameA(DWORD wLang, LPSTR szLang, DWORD cchLang)
	{
		return forward_version_call(VerLanguageNameA)(wLang, szLang, cchLang);
	}

	EXTERN_C DWORD WINAPI VerLanguageNameW(DWORD wLang, LPWSTR szLang, DWORD cchLang)
	{
		return forward_version_call(VerLanguageNameW)(wLang, szLang, cchLang);
	}

	EXTERN_C BOOL WINAPI VerQueryValueA(LPCVOID pBlock, LPCSTR lpSubBlock, LPVOID* lplpBuffer, PUINT puLen)
	{
		return forward_version_call(VerQueryValueA)(pBlock, lpSubBlock, lplpBuffer, puLen);
	}

	EXTERN_C BOOL WINAPI VerQueryValueW(LPCVOID pBlock, LPCWSTR lpSubBlock, LPVOID* lplpBuffer, PUINT puLen)
	{
		return forward_version_call(VerQueryValueW)(pBlock, lpSubBlock, lplpBuffer, puLen);
	}
} // namespace big
