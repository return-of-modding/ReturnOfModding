#include "renderer.hpp"

#include "file_manager/file_manager.hpp"
#include "fonts/fonts.hpp"
#include "gui.hpp"
#include "hooks/hooking.hpp"
#include "pointers.hpp"

#include <backends/imgui_impl_dx11.h>
#include <backends/imgui_impl_win32.h>

#pragma comment(lib, "d3d11.lib")

IDXGIFactory* gDxgiFactory                        = nullptr;
ID3D11Device* gPd3DDevice                         = nullptr;
ID3D11DeviceContext* gPd3DDeviceContext           = nullptr;
IDXGISwapChain* gPSwapChain                       = nullptr;
ID3D11RenderTargetView* gMainRenderTargetResource = nullptr;

static int get_correct_dxgi_format(int current_format)
{
	switch (current_format)
	{
	case DXGI_FORMAT_R8G8B8A8_UNORM_SRGB: return DXGI_FORMAT_R8G8B8A8_UNORM;
	}

	return current_format;
}

static void create_render_target(IDXGISwapChain* swapchain)
{
	ID3D11Texture2D* back_buffer{};
	swapchain->GetBuffer(0, IID_PPV_ARGS(&back_buffer));
	if (back_buffer)
	{
		DXGI_SWAP_CHAIN_DESC swapchain_desc;
		swapchain->GetDesc(&swapchain_desc);

		D3D11_RENDER_TARGET_VIEW_DESC desc = {};
		desc.Format        = static_cast<DXGI_FORMAT>(get_correct_dxgi_format(swapchain_desc.BufferDesc.Format));
		desc.ViewDimension = D3D11_RTV_DIMENSION_TEXTURE2D;

		gPd3DDevice->CreateRenderTargetView(back_buffer, &desc, &gMainRenderTargetResource);
		back_buffer->Release();
	}
}

static void release_render_target_resources()
{
	if (gMainRenderTargetResource)
	{
		gMainRenderTargetResource->Release();
		gMainRenderTargetResource = nullptr;
	}
}

static HRESULT WINAPI hook_Present(IDXGISwapChain1* swapchain, UINT sync_interval, UINT flags)
{
	if (big::g_running && ((flags & (UINT)DXGI_PRESENT_TEST) != (UINT)DXGI_PRESENT_TEST))
	{
		big::g_renderer->render_imgui_d3d11(swapchain);
	}

	return big::g_hooking->get_original<hook_Present>()(swapchain, sync_interval, flags);
}

static HRESULT WINAPI hook_Present1(IDXGISwapChain1* swapchain, UINT sync_interval, UINT flags, const void* present_parameters)
{
	if (big::g_running && ((flags & (UINT)DXGI_PRESENT_TEST) != (UINT)DXGI_PRESENT_TEST))
	{
		big::g_renderer->render_imgui_d3d11(swapchain);
	}

	return big::g_hooking->get_original<hook_Present1>()(swapchain, sync_interval, flags, present_parameters);
}

static HRESULT WINAPI hook_ResizeBuffers(IDXGISwapChain1* swapchain, UINT BufferCount, UINT Width, UINT Height, DXGI_FORMAT NewFormat, UINT SwapChainFlags)
{
	release_render_target_resources();

	return big::g_hooking->get_original<hook_ResizeBuffers>()(swapchain, BufferCount, Width, Height, NewFormat, SwapChainFlags);
}

static HRESULT WINAPI hook_ResizeBuffers1(IDXGISwapChain1* swapchain, UINT BufferCount, UINT Width, UINT Height, DXGI_FORMAT NewFormat, UINT SwapChainFlags, const UINT* pCreationNodeMask, IUnknown* const* ppPresentQueue)
{
	release_render_target_resources();

	return big::g_hooking->get_original<hook_ResizeBuffers1>()(swapchain, BufferCount, Width, Height, NewFormat, SwapChainFlags, pCreationNodeMask, ppPresentQueue);
}

static HRESULT WINAPI hook_CreateSwapChain(IDXGIFactory* pFactory, IUnknown* pDevice, DXGI_SWAP_CHAIN_DESC* pDesc, IDXGISwapChain** pswapchain)
{
	release_render_target_resources();

	return big::g_hooking->get_original<hook_CreateSwapChain>()(pFactory, pDevice, pDesc, pswapchain);
}

static HRESULT WINAPI hook_CreateSwapChainForHwnd(IDXGIFactory* pFactory, IUnknown* pDevice, HWND hWnd, const void* pDesc, const void* pFullscreenDesc, IDXGIOutput* pRestrictToOutput, void** pswapchain)
{
	release_render_target_resources();

	return big::g_hooking->get_original<hook_CreateSwapChainForHwnd>()(pFactory, pDevice, hWnd, pDesc, pFullscreenDesc, pRestrictToOutput, pswapchain);
}

static HRESULT WINAPI hook_CreateSwapChainForCoreWindow(IDXGIFactory* pFactory, IUnknown* pDevice, IUnknown* pWindow, const void* pDesc, IDXGIOutput* pRestrictToOutput, void** pswapchain)
{
	release_render_target_resources();

	return big::g_hooking->get_original<hook_CreateSwapChainForCoreWindow>()(pFactory, pDevice, pWindow, pDesc, pRestrictToOutput, pswapchain);
}

static HRESULT WINAPI hook_CreateSwapChainForComposition(IDXGIFactory* pFactory, IUnknown* pDevice, const void* pDesc, IDXGIOutput* pRestrictToOutput, void** pswapchain)
{
	release_render_target_resources();

	return big::g_hooking->get_original<hook_CreateSwapChainForComposition>()(pFactory, pDevice, pDesc, pRestrictToOutput, pswapchain);
}

IMGUI_IMPL_API LRESULT ImGui_ImplWin32_WndProcHandler(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam);

namespace big
{
	static LRESULT static_wndproc(HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam)
	{
		if (big::g_running)
		{
			g_renderer->wndproc(hwnd, msg, wparam, lparam);
		}

		return CallWindowProcW(g_renderer->m_og_wndproc, hwnd, msg, wparam, lparam);
	}

	void renderer::wndproc(HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam)
	{
		for (const auto& cb : m_wndproc_callbacks)
		{
			cb(hwnd, msg, wparam, lparam);
		}

		ImGui_ImplWin32_WndProcHandler(hwnd, msg, wparam, lparam);
	}

	void init_imgui_context(HWND window_handle)
	{
		if (ImGui::GetCurrentContext())
		{
			return;
		}

		ImGui::CreateContext();
		ImGui_ImplWin32_Init(window_handle);
	}

	bool renderer::hook()
	{
		IDXGISwapChain1* swap_chain1{nullptr};
		IDXGISwapChain1* swap_chain{nullptr};
		ID3D11Device* device{};

		D3D_FEATURE_LEVEL feature_level = D3D_FEATURE_LEVEL_11_0;
		DXGI_SWAP_CHAIN_DESC1 swap_chain_desc1;

		ZeroMemory(&swap_chain_desc1, sizeof(swap_chain_desc1));

		swap_chain_desc1.Format           = DXGI_FORMAT_B8G8R8A8_UNORM;
		swap_chain_desc1.BufferUsage      = DXGI_USAGE_RENDER_TARGET_OUTPUT;
		swap_chain_desc1.SwapEffect       = DXGI_SWAP_EFFECT_FLIP_SEQUENTIAL;
		swap_chain_desc1.BufferCount      = 2;
		swap_chain_desc1.SampleDesc.Count = 1;
		swap_chain_desc1.AlphaMode        = DXGI_ALPHA_MODE_PREMULTIPLIED;
		swap_chain_desc1.Width            = 1;
		swap_chain_desc1.Height           = 1;

		// User may be running Windows 7
		const auto d3d11_module = LoadLibraryA("d3d11.dll");
		if (d3d11_module == nullptr)
		{
			LOG(ERROR) << "Failed to load d3d11.dll";
			return false;
		}

		auto d3d11_create_device = (decltype(D3D11CreateDevice)*)GetProcAddress(d3d11_module, "D3D11CreateDevice");
		if (d3d11_create_device == nullptr)
		{
			LOG(ERROR) << "Failed to get D3D11CreateDevice export";
			return false;
		}

		LOG(INFO) << "Creating dummy device";

		HRESULT hr = d3d11_create_device(nullptr, D3D_DRIVER_TYPE_HARDWARE, nullptr, 0, &feature_level, 1, D3D11_SDK_VERSION, &device, nullptr, nullptr);
		if (FAILED(hr))
		{
			// If hardware creation fails, log it and try creating a WARP device instead
			LOG(ERROR) << "Failed to create D3D11 hardware device. HRESULT: " << hr;
			LOG(INFO) << "Falling back to WARP (software) device.";

			hr = d3d11_create_device(nullptr, D3D_DRIVER_TYPE_WARP, nullptr, 0, &feature_level, 1, D3D11_SDK_VERSION, &device, nullptr, nullptr);
			if (FAILED(hr))
			{
				LOG(ERROR) << "Failed to create D3D11 Dummy device with WARP. HRESULT: " << hr;
				return false;
			}

			LOG(INFO) << "Created dummy device using WARP.";
		}
		else
		{
			LOG(INFO) << "Created dummy device using hardware.";
		}

		LOG(INFO) << "Dummy device: " << HEX_TO_UPPER(device);

		// Manually get CreateDXGIFactory export because the user may be running Windows 7
		const auto dxgi_module = LoadLibraryA("dxgi.dll");
		if (dxgi_module == nullptr)
		{
			LOG(ERROR) << "Failed to load dxgi.dll";
			return false;
		}

		auto create_dxgi_factory = (decltype(CreateDXGIFactory)*)GetProcAddress(dxgi_module, "CreateDXGIFactory");

		if (create_dxgi_factory == nullptr)
		{
			LOG(ERROR) << "Failed to get CreateDXGIFactory export";
			return false;
		}

		LOG(INFO) << "Creating dummy DXGI factory";

		IDXGIFactory2* factory{nullptr};
		hr = create_dxgi_factory(IID_PPV_ARGS(&factory));
		if (FAILED(hr))
		{
			LOG(ERROR) << "Failed to create D3D11 Dummy DXGI Factory. HRESULT: " << hr;
			return false;
		}

		LOG(INFO) << "Creating dummy swapchain";

		// used in CreateSwapChainForHwnd fallback
		HWND hwnd = 0;
		WNDCLASSEX wc{};

		auto init_dummy_window = [&]()
		{
			// fallback to CreateSwapChainForHwnd
			wc.cbSize        = sizeof(WNDCLASSEX);
			wc.style         = CS_HREDRAW | CS_VREDRAW;
			wc.lpfnWndProc   = DefWindowProc;
			wc.cbClsExtra    = 0;
			wc.cbWndExtra    = 0;
			wc.hInstance     = GetModuleHandle(NULL);
			wc.hIcon         = NULL;
			wc.hCursor       = NULL;
			wc.hbrBackground = NULL;
			wc.lpszMenuName  = NULL;
			wc.lpszClassName = TEXT("ROM_DX11_DUMMY");
			wc.hIconSm       = NULL;

			::RegisterClassEx(&wc);

			hwnd = ::CreateWindow(wc.lpszClassName, TEXT("ROM Dummy Window"), WS_OVERLAPPEDWINDOW, 0, 0, 100, 100, NULL, NULL, wc.hInstance, NULL);

			swap_chain_desc1.BufferCount        = 3;
			swap_chain_desc1.Width              = 0;
			swap_chain_desc1.Height             = 0;
			swap_chain_desc1.Format             = DXGI_FORMAT_R8G8B8A8_UNORM;
			swap_chain_desc1.Flags              = DXGI_SWAP_CHAIN_FLAG_FRAME_LATENCY_WAITABLE_OBJECT;
			swap_chain_desc1.BufferUsage        = DXGI_USAGE_RENDER_TARGET_OUTPUT;
			swap_chain_desc1.SampleDesc.Count   = 1;
			swap_chain_desc1.SampleDesc.Quality = 0;
			swap_chain_desc1.SwapEffect         = DXGI_SWAP_EFFECT_FLIP_DISCARD;
			swap_chain_desc1.AlphaMode          = DXGI_ALPHA_MODE_UNSPECIFIED;
			swap_chain_desc1.Scaling            = DXGI_SCALING_STRETCH;
			swap_chain_desc1.Stereo             = FALSE;
		};

		std::vector<std::function<bool()>> swapchain_attempts{
		    // we call CreateSwapChainForComposition instead of CreateSwapChainForHwnd
		    // because some overlays will have hooks on CreateSwapChainForHwnd
		    // and all we're doing is creating a dummy swapchain
		    // we don't want to screw up the overlay
		    [&]()
		    {
			    return !FAILED(factory->CreateSwapChainForComposition(device, &swap_chain_desc1, nullptr, &swap_chain1));
		    },
		    [&]()
		    {
			    init_dummy_window();

			    return !FAILED(factory->CreateSwapChainForHwnd(device, hwnd, &swap_chain_desc1, nullptr, nullptr, &swap_chain1));
		    },
		    [&]()
		    {
			    return !FAILED(factory->CreateSwapChainForHwnd(device, GetDesktopWindow(), &swap_chain_desc1, nullptr, nullptr, &swap_chain1));
		    },
		};

		bool any_succeed = false;

		for (auto i = 0; i < swapchain_attempts.size(); i++)
		{
			auto& attempt = swapchain_attempts[i];

			try
			{
				LOG(INFO) << "Trying swapchain attempt " << i;

				if (attempt())
				{
					LOG(INFO) << "Created dummy swapchain on attempt " << i;
					any_succeed = true;
					break;
				}
			}
			catch (std::exception& e)
			{
				LOG(ERROR) << "Failed to create dummy swapchain on attempt " << i << " " << e.what();
			}
			catch (...)
			{
				LOG(ERROR) << "Failed to create dummy swapchain on attempt " << i;
			}

			LOG(ERROR) << "Attempt failed " << i;
		}

		if (!any_succeed)
		{
			LOG(ERROR) << "Failed to create D3D11 Dummy Swap Chain";

			if (hwnd)
			{
				::DestroyWindow(hwnd);
			}

			if (wc.lpszClassName != nullptr)
			{
				::UnregisterClass(wc.lpszClassName, wc.hInstance);
			}

			return false;
		}

		LOG(INFO) << "Querying dummy swapchain";

		hr = swap_chain1->QueryInterface(IID_PPV_ARGS(&swap_chain));
		if (FAILED(hr))
		{
			LOG(ERROR) << "Failed to retrieve D3D11 DXGI SwapChain. HRESULT: " << hr;
			return false;
		}

		try
		{
			const auto& ti = typeid(swap_chain1);

			const std::string swapchain_classname = ti.name() ? ti.name() : "";

			LOG(INFO) << "swapchain classname: " << swapchain_classname;
		}
		catch (const std::exception& e)
		{
			LOG(ERROR) << "Failed to get type info: " << e.what();
		}
		catch (...)
		{
			LOG(ERROR) << "Failed to get type info: unknown exception";
		}

		void** swapchain_vtable    = *reinterpret_cast<void***>(swap_chain);
		void** dxgi_factory_vtable = *reinterpret_cast<void***>(factory);

		device->Release();
		factory->Release();
		swap_chain1->Release();
		swap_chain->Release();

		if (hwnd)
		{
			::DestroyWindow(hwnd);
		}

		if (wc.lpszClassName != nullptr)
		{
			::UnregisterClass(wc.lpszClassName, wc.hInstance);
		}

		hooking::detour_hook_helper::add<hook_CreateSwapChain>("CSC", dxgi_factory_vtable[10]);
		hooking::detour_hook_helper::add<hook_CreateSwapChainForHwnd>("CSCFH", dxgi_factory_vtable[15]);
		hooking::detour_hook_helper::add<hook_CreateSwapChainForCoreWindow>("CSCFCW", dxgi_factory_vtable[16]);
		hooking::detour_hook_helper::add<hook_CreateSwapChainForComposition>("CSCFC", dxgi_factory_vtable[24]);

		hooking::detour_hook_helper::add<hook_Present>("P", swapchain_vtable[8]);
		hooking::detour_hook_helper::add<hook_Present1>("P1", swapchain_vtable[22]);

		hooking::detour_hook_helper::add<hook_ResizeBuffers>("RB", swapchain_vtable[13]);
		hooking::detour_hook_helper::add<hook_ResizeBuffers1>("RB1", swapchain_vtable[39]);

		return true;
	}

	void renderer::init_fonts()
	{
		folder windows_fonts(std::filesystem::path(std::getenv("SYSTEMROOT")) / "Fonts");

		file font_file_path = windows_fonts.get_file("./msyh.ttc");
		if (!font_file_path.exists())
		{
			font_file_path = windows_fonts.get_file("./msyh.ttf");
		}

		const auto got_valid_windows_font = std::filesystem::exists(font_file_path.get_path());
		auto font_file                    = std::ifstream(font_file_path.get_path(), std::ios::binary | std::ios::ate);

		const auto font_data_size = got_valid_windows_font ? static_cast<int>(font_file.tellg()) : 0;

		const auto font_data = std::make_unique<uint8_t[]>(font_data_size);

		if (got_valid_windows_font)
		{
			font_file.seekg(0);
			font_file.read(reinterpret_cast<char*>(font_data.get()), font_data_size);
			font_file.close();
		}

		auto& io = ImGui::GetIO();

		io.ConfigFlags &= ~ImGuiConfigFlags_NoMouse;
		io.ConfigFlags &= ~ImGuiConfigFlags_NoMouseCursorChange;

		{
			ImFontConfig fnt_cfg{};
			fnt_cfg.FontDataOwnedByAtlas = false;
			strcpy(fnt_cfg.Name, "Fnt20px");

			io.Fonts->AddFontFromMemoryTTF(const_cast<uint8_t*>(font_storopia),
			                               sizeof(font_storopia),
			                               20.f,
			                               &fnt_cfg,
			                               io.Fonts->GetGlyphRangesDefault());
			fnt_cfg.MergeMode = true;

			if (got_valid_windows_font)
			{
				io.Fonts->AddFontFromMemoryTTF(font_data.get(), font_data_size, 20.f, &fnt_cfg, ImGui::GetIO().Fonts->GetGlyphRangesChineseSimplifiedCommon());
				io.Fonts->AddFontFromMemoryTTF(font_data.get(), font_data_size, 20.f, &fnt_cfg, ImGui::GetIO().Fonts->GetGlyphRangesCyrillic());
			}

			io.Fonts->Build();
		}

		{
			ImFontConfig fnt_cfg{};
			fnt_cfg.FontDataOwnedByAtlas = false;
			strcpy(fnt_cfg.Name, "Fnt28px");

			font_title = io.Fonts->AddFontFromMemoryTTF(const_cast<uint8_t*>(font_storopia), sizeof(font_storopia), 28.f, &fnt_cfg);
			fnt_cfg.MergeMode = true;

			if (got_valid_windows_font)
			{
				io.Fonts->AddFontFromMemoryTTF(font_data.get(), font_data_size, 28.f, &fnt_cfg, ImGui::GetIO().Fonts->GetGlyphRangesChineseSimplifiedCommon());
				io.Fonts->AddFontFromMemoryTTF(font_data.get(), font_data_size, 28.f, &fnt_cfg, ImGui::GetIO().Fonts->GetGlyphRangesCyrillic());
			}

			io.Fonts->Build();
		}

		{
			ImFontConfig fnt_cfg{};
			fnt_cfg.FontDataOwnedByAtlas = false;
			strcpy(fnt_cfg.Name, "Fnt24px");

			font_sub_title = io.Fonts->AddFontFromMemoryTTF(const_cast<uint8_t*>(font_storopia), sizeof(font_storopia), 24.f, &fnt_cfg);
			fnt_cfg.MergeMode = true;

			if (got_valid_windows_font)
			{
				io.Fonts->AddFontFromMemoryTTF(font_data.get(), font_data_size, 24.f, &fnt_cfg, ImGui::GetIO().Fonts->GetGlyphRangesChineseSimplifiedCommon());
				io.Fonts->AddFontFromMemoryTTF(font_data.get(), font_data_size, 24.f, &fnt_cfg, ImGui::GetIO().Fonts->GetGlyphRangesCyrillic());
			}

			io.Fonts->Build();
		}

		{
			ImFontConfig fnt_cfg{};
			fnt_cfg.FontDataOwnedByAtlas = false;
			strcpy(fnt_cfg.Name, "Fnt18px");

			font_small = io.Fonts->AddFontFromMemoryTTF(const_cast<uint8_t*>(font_storopia), sizeof(font_storopia), 18.f, &fnt_cfg);
			fnt_cfg.MergeMode = true;

			if (got_valid_windows_font)
			{
				io.Fonts->AddFontFromMemoryTTF(font_data.get(), font_data_size, 18.f, &fnt_cfg, ImGui::GetIO().Fonts->GetGlyphRangesChineseSimplifiedCommon());
				io.Fonts->AddFontFromMemoryTTF(font_data.get(), font_data_size, 18.f, &fnt_cfg, ImGui::GetIO().Fonts->GetGlyphRangesCyrillic());
			}

			io.Fonts->Build();
		}

		{
			ImFontConfig font_icons_cfg{};
			font_icons_cfg.FontDataOwnedByAtlas = false;
			std::strcpy(font_icons_cfg.Name, "Icons");
			font_icon = io.Fonts->AddFontFromMemoryTTF(const_cast<uint8_t*>(font_icons), sizeof(font_icons), 24.f, &font_icons_cfg);
		}
	}

	void renderer::init()
	{
		hook();
	}

	renderer::renderer()
	{
		g_renderer = this;

		init();
	}

	renderer::~renderer()
	{
		g_renderer = nullptr;
	}

	bool renderer::add_init_callback(init_callback callback)
	{
		m_init_callbacks.push_back(callback);

		return true;
	}

	bool renderer::add_dx_callback(dx_callback callback)
	{
		m_dx_callbacks.push_back(callback);

		std::sort(m_dx_callbacks.begin(),
		          m_dx_callbacks.end(),
		          [](dx_callback& a, dx_callback& b)
		          {
			          return a.m_priority < b.m_priority;
		          });

		return true;
	}

	void renderer::remove_wndproc_callback(size_t callback_index)
	{
		m_wndproc_callbacks.erase(m_wndproc_callbacks.begin() + callback_index);
	}

	size_t renderer::add_wndproc_callback(wndproc_callback callback)
	{
		m_wndproc_callbacks.emplace_back(callback);

		// Returns index of the just added element.

		return m_wndproc_callbacks.size() - 1;
	}

	void renderer::render_imgui_d3d11(IDXGISwapChain1* pSwapChain)
	{
		static bool init = true;
		if (init)
		{
			init = false;

			pSwapChain->GetHwnd(&g_renderer->m_window_handle);
			init_imgui_context(g_renderer->m_window_handle);

			auto file_path                             = g_file_manager.get_project_file("./imgui.ini").get_path();
			static std::string path                    = (char*)file_path.u8string().c_str();
			ImGui::GetCurrentContext()->IO.IniFilename = path.c_str();

			g_renderer->init_fonts();

			static gui g_gui{};

			for (const auto& init_cb : g_renderer->m_init_callbacks)
			{
				if (init_cb)
				{
					init_cb();
				}
			}

			g_renderer->m_og_wndproc = WNDPROC(SetWindowLongPtrW(g_renderer->m_window_handle, GWLP_WNDPROC, LONG_PTR(&static_wndproc)));

			LOG(INFO) << "made it";
		}

		if (!ImGui::GetIO().BackendRendererUserData)
		{
			if (SUCCEEDED(pSwapChain->GetDevice(IID_PPV_ARGS(&gPd3DDevice))))
			{
				gPd3DDevice->GetImmediateContext(&gPd3DDeviceContext);
				ImGui_ImplDX11_Init(gPd3DDevice, gPd3DDeviceContext);
			}
		}

		if (!gMainRenderTargetResource)
		{
			create_render_target(pSwapChain);
		}

		if (ImGui::GetCurrentContext() && gMainRenderTargetResource && gPd3DDeviceContext)
		{
			ImGui_ImplDX11_NewFrame();
			ImGui_ImplWin32_NewFrame();
			ImGui::NewFrame();

			for (const auto& cb : m_dx_callbacks)
			{
				cb.m_callback();
			}

			ImGui::Render();

			gPd3DDeviceContext->OMSetRenderTargets(1, &gMainRenderTargetResource, nullptr);
			ImGui_ImplDX11_RenderDrawData(ImGui::GetDrawData());
		}
	}

	__int64 hook_init_renderer_on_CreateSwapChain(HWND a1, int a2, int a3, int a4)
	{
		const auto res = big::g_hooking->get_original<hook_init_renderer_on_CreateSwapChain>()(a1, a2, a3, a4);

		static bool init_once = true;
		if (init_once)
		{
			init_once = false;

			LOG(INFO) << "Renderer is safe to init.";
			Logger::FlushQueue();

			// Purposely leak it, we are not unloading this module in any case.
			auto renderer_instance = new big::renderer();
			LOG(INFO) << "Renderer initialized.";
		}

		return res;
	}
} // namespace big
