#include "config/config.hpp"
#include "gui/gui.hpp"
#include "gui/renderer.hpp"
#include "hooks/hooking.hpp"
#include "logger/exception_handler.hpp"
#include "lua/lua_manager.hpp"
#include "lua/lua_manager_extension.hpp"
#include "memory/byte_patch_manager.hpp"
#include "paths/paths.hpp"
#include "pointers.hpp"
#include "rorr/gm/pin_map.hpp"
#include "rorr/rorr_hooks.hpp"
#include "threads/thread_pool.hpp"
#include "threads/util.hpp"
#include "version.hpp"

#include "debug/debug.hpp"

BOOL APIENTRY DllMain(HMODULE hmod, DWORD reason, PVOID)
{
	using namespace big;

	if (reason == DLL_PROCESS_ATTACH)
	{
		//big::debug::wait_until_debugger();

		bool use_steam = true;
		wchar_t exe_path[1024];
		if (GetModuleFileNameW(nullptr, exe_path, sizeof(exe_path)) > 0)
		{
			std::filesystem::path steam_appid_file_path(exe_path);
			steam_appid_file_path  = steam_appid_file_path.parent_path();
			steam_appid_file_path /= "steam_appid.txt";
			use_steam              = !std::filesystem::exists(steam_appid_file_path);
		}

		if (use_steam)
		{
			const auto steam_env_env_var          = _wgetenv(L"SteamEnv");
			const std::wstring good_steam_env_var = L"1";
			if (!steam_env_env_var || steam_env_env_var != good_steam_env_var)
			{
				return true;
			}
		}

		if (!rom::is_rom_enabled())
		{
			return true;
		}

		rom::init("ReturnOfModding", "Risk of Rain Returns.exe", "");

		// Purposely leak it, we are not unloading this module in any case.
		{
			auto exception_handling = new exception_handler(true, gm::triple_exception_handler);

			// SetUnhandledExceptionFilter is not working correctly it seems,
			// sometimes it's straight up not called even on unhandled exceptions.
			AddVectoredContinueHandler(true, gm::triple_exception_handler);
		}

		// https://learn.microsoft.com/en-us/cpp/c-runtime-library/reference/setlocale-wsetlocale?view=msvc-170#utf-8-support
		setlocale(LC_ALL, ".utf8");
		// This also change things like stringstream outputs and add comma to numbers and things like that, we don't want that, so just set locale on the C apis instead.
		//std::locale::global(std::locale(".utf8"));

		std::filesystem::path root_folder = paths::get_project_root_folder();
		g_file_manager.init(root_folder);
		paths::init_dump_file_path();

		big::config::init_general();

		// Purposely leak it, we are not unloading this module in any case.
		auto logger_instance = new logger(rom::g_project_name, g_file_manager.get_project_file("./LogOutput.log"));

		static struct logger_cleanup
		{
			~logger_cleanup()
			{
				Logger::Destroy();
			}
		} g_logger_cleanup;

		std::srand(std::chrono::system_clock::now().time_since_epoch().count());

		LOG(INFO) << rom::g_project_name;
		LOGF(INFO, "Build v{} (Commit {})", version::VERSION_NUMBER, version::GIT_SHA1);

#ifdef FINAL
		LOG(INFO) << "This is a final build";
#endif

		// Purposely leak it, we are not unloading this module in any case.
		auto thread_pool_instance = new thread_pool();
		LOG(INFO) << "Thread pool initialized.";

		// Purposely leak it, we are not unloading this module in any case.
		auto pointers_instance = new pointers();
		LOG(INFO) << "Pointers initialized.";

		LOG(INFO) << "GameMaker Major Version: " << *g_pointers->m_rorr.m_gamemaker_version_major << " (Found at offset "
		          << HEX_TO_UPPER_OFFSET(g_pointers->m_rorr.m_gamemaker_version_major) << ")";

		// Purposely leak it, we are not unloading this module in any case.
		auto byte_patch_manager_instance = new byte_patch_manager();
		LOG(INFO) << "Byte Patch Manager initialized.";

		Logger::FlushQueue();

		rorr::init_hooks();

		// Purposely leak it, we are not unloading this module in any case.
		auto hooking_instance = new hooking();
		LOG(INFO) << "Hooking initialized.";

		hotkey::init_hotkeys();

		g_hooking->enable();
		LOG(INFO) << "Hooking enabled.";

		DisableThreadLibraryCalls(hmod);
		g_hmodule     = hmod;
		g_main_thread = CreateThread(
		    nullptr,
		    0,
		    [](PVOID) -> DWORD
		    {
			    while (g_running)
			    {
				    std::this_thread::sleep_for(500ms);
			    }

			    CloseHandle(g_main_thread);
			    FreeLibraryAndExitThread(g_hmodule, 0);
		    },
		    nullptr,
		    0,
		    &g_main_thread_id);
	}

	return true;
}
