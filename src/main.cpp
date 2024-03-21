#include "gui/gui.hpp"
#include "gui/renderer.hpp"
#include "hooks/hooking.hpp"
#include "logger/exception_handler.hpp"
#include "lua/lua_manager.hpp"
#include "memory/byte_patch_manager.hpp"
#include "paths/paths.hpp"
#include "pointers.hpp"
#include "rorr/gm/pin_map.hpp"
#include "threads/thread_pool.hpp"
#include "threads/util.hpp"
#include "version.hpp"
#include "win_registry/win_registry.hpp"

//#include "debug/debug.hpp"

BOOL APIENTRY DllMain(HMODULE hmod, DWORD reason, PVOID)
{
	using namespace big;

	HKEY hKey;
	RegOpenKeyExW(HKEY_CURRENT_USER, L"Software\\Valve\\Steam", 0, KEY_READ, &hKey);
	DWORD running_app_id;
	win_registry::get_dword(hKey, L"RunningAppID", running_app_id, 0);
	constexpr DWORD rorr_app_id = 1'337'520;
	if (running_app_id != rorr_app_id)
	{
		return true;
	}

	if (reason == DLL_PROCESS_ATTACH)
	{
		static auto exception_handling = exception_handler();

		DisableThreadLibraryCalls(hmod);
		g_hmodule     = hmod;
		g_main_thread = CreateThread(
		    nullptr,
		    0,
		    [](PVOID) -> DWORD
		    {
			    /*HWND target_window{};
			    while (target_window = FindWindow(g_target_window_class_name, nullptr), !target_window)
			    {
				    std::this_thread::sleep_for(5ms);
			    }*/

			    //std::this_thread::sleep_for(2000ms);

			    //threads::suspend_all_but_one();
			    //debug::wait_until_debugger();

			    // https://learn.microsoft.com/en-us/cpp/c-runtime-library/reference/setlocale-wsetlocale?view=msvc-170#utf-8-support
			    setlocale(LC_ALL, ".utf8");
			    // This also change things like stringstream outputs and add comma to numbers and things like that, we don't want that, so just set locale on the C apis instead.
			    //std::locale::global(std::locale(".utf8"));

			    std::filesystem::path root_folder = paths::get_project_root_folder();
			    g_file_manager.init(root_folder);
			    paths::init_dump_file_path();

			    constexpr auto is_console_enabled = true;
			    auto logger_instance = std::make_unique<logger>(g_project_name, g_file_manager.get_project_file("./LogOutput.log"), is_console_enabled);

			    std::srand(std::chrono::system_clock::now().time_since_epoch().count());

			    LOG(INFO) << g_project_name;
			    LOGF(INFO, "Build (GIT SHA1): {}", version::GIT_SHA1);

#ifdef FINAL
			    LOG(INFO) << "This is a final build";
#endif

			    auto thread_pool_instance = std::make_unique<thread_pool>();
			    LOG(INFO) << "Thread pool initialized.";

			    auto pointers_instance = std::make_unique<pointers>();
			    LOG(INFO) << "Pointers initialized.";

			    LOG(INFO) << "GameMaker Major Version: " << *g_pointers->m_rorr.m_gamemaker_version_major << " (Found at offset "
			              << HEX_TO_UPPER_OFFSET(g_pointers->m_rorr.m_gamemaker_version_major) << ")";

			    auto byte_patch_manager_instance = std::make_unique<byte_patch_manager>();
			    LOG(INFO) << "Byte Patch Manager initialized.";

			    auto hooking_instance = std::make_unique<hooking>();
			    LOG(INFO) << "Hooking initialized.";

			    //big::threads::resume_all();

			    HWND target_window{};
			    while (target_window = FindWindow(g_target_window_class_name, nullptr), !target_window)
			    {
				    std::this_thread::sleep_for(5ms);
			    }
			    auto renderer_instance = std::make_unique<renderer>(target_window);
			    LOG(INFO) << "Renderer initialized.";
			    auto gui_instance = std::make_unique<gui>();

			    hotkey::init_hotkeys();

			    if (!g_abort)
			    {
				    g_hooking->enable();
				    LOG(INFO) << "Hooking enabled.";

				    std::unique_lock gml_lock(g_gml_safe_mutex);
				    g_gml_safe_notifier.wait_for(gml_lock, 20s);

				    YYObjectPinMap::init_pin_map();
			    }

			    g_running = true;

			    auto lua_manager_instance =
			        std::make_unique<lua_manager>(g_file_manager.get_project_folder("config"),
			                                      g_file_manager.get_project_folder("plugins_data"),
			                                      g_file_manager.get_project_folder("plugins"));
			    LOG(INFO) << "Lua manager initialized.";

			    if (g_abort)
			    {
				    LOG(FATAL) << "ReturnOfModding failed to init properly, exiting.";
				    g_running = false;
			    }

			    while (g_running)
			    {
				    std::this_thread::sleep_for(500ms);
			    }

			    lua_manager_instance.reset();
			    LOG(INFO) << "Lua manager uninitialized.";

			    g_hooking->disable();
			    LOG(INFO) << "Hooking disabled.";

			    // Make sure that all threads created don't have any blocking loops
			    // otherwise make sure that they have stopped executing
			    thread_pool_instance->destroy();
			    LOG(INFO) << "Destroyed thread pool.";

			    YYObjectPinMap::cleanup_pin_map();

			    hooking_instance.reset();
			    LOG(INFO) << "Hooking uninitialized.";

			    renderer_instance.reset();
			    LOG(INFO) << "Renderer uninitialized.";

			    byte_patch_manager_instance.reset();
			    LOG(INFO) << "Byte Patch Manager uninitialized.";

			    pointers_instance.reset();
			    LOG(INFO) << "Pointers uninitialized.";

			    thread_pool_instance.reset();
			    LOG(INFO) << "Thread pool uninitialized.";

			    LOG(INFO) << "Farewell!";
			    logger_instance->destroy();
			    logger_instance.reset();

			    CloseHandle(g_main_thread);
			    FreeLibraryAndExitThread(g_hmodule, 0);
		    },
		    nullptr,
		    0,
		    &g_main_thread_id);
	}

	return true;
}
