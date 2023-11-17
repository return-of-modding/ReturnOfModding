#include "gui/renderer.hpp"

#include "file_manager/file_manager.hpp"
#include "fonts/fonts.hpp"
#include "gui.hpp"
#include "hooks/hooking.hpp"
#include "pointers.hpp"

#include <backends/imgui_impl_dx11.h>
#include <backends/imgui_impl_win32.h>

#pragma comment(lib, "d3d11.lib")

IMGUI_IMPL_API LRESULT ImGui_ImplWin32_WndProcHandler(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam);

namespace big
{
	static LRESULT static_wndproc(HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam)
	{
		if (g_running)
		{
			g_renderer->wndproc(hwnd, msg, wparam, lparam);
		}

		return CallWindowProcW(g_renderer->m_og_wndproc, hwnd, msg, wparam, lparam);
	}

	void renderer::wndproc(HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam)
	{
		for (const auto& cb : m_wndproc_callbacks)
			cb(hwnd, msg, wparam, lparam);

		ImGui_ImplWin32_WndProcHandler(hwnd, msg, wparam, lparam);
	}

	bool renderer::create_device_d3d11(HWND window_handle)
	{
		// Create the D3DDevice
		DXGI_SWAP_CHAIN_DESC swapchain_desc = {};
		swapchain_desc.Windowed             = TRUE;
		swapchain_desc.BufferCount          = 2;
		swapchain_desc.BufferDesc.Format    = DXGI_FORMAT_R8G8B8A8_UNORM;
		swapchain_desc.BufferUsage          = DXGI_USAGE_RENDER_TARGET_OUTPUT;
		swapchain_desc.OutputWindow         = window_handle;
		swapchain_desc.SampleDesc.Count     = 1;

		const D3D_FEATURE_LEVEL feature_levels[] = {
		    D3D_FEATURE_LEVEL_11_0,
		    D3D_FEATURE_LEVEL_10_0,
		};
		HRESULT hr = D3D11CreateDeviceAndSwapChain(nullptr, D3D_DRIVER_TYPE_NULL, nullptr, 0, feature_levels, 2, D3D11_SDK_VERSION, &swapchain_desc, &m_dxgi_swapchain, &m_d3d_device, nullptr, nullptr);
		if (hr != S_OK)
		{
			LOG(FATAL) << "D3D11CreateDeviceAndSwapChain() failed. [rv: " << hr << "]";
			return false;
		}

		return true;
	}

	static int get_correct_dxgi_format(int current_format)
	{
		switch (current_format)
		{
		case DXGI_FORMAT_R8G8B8A8_UNORM_SRGB: return DXGI_FORMAT_R8G8B8A8_UNORM;
		}

		return current_format;
	}

	void renderer::create_render_target(IDXGISwapChain* swapchain)
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

			m_d3d_device->CreateRenderTargetView(back_buffer, &desc, &m_d3d_render_target);
			back_buffer->Release();
		}
	}

	static HRESULT WINAPI hook_Present(IDXGISwapChain* swapchain, UINT sync_interval, UINT flags)
	{
		if (g_running && ((flags & (UINT)DXGI_PRESENT_TEST) != (UINT)DXGI_PRESENT_TEST))
			g_renderer->render_imgui_d3d11(swapchain);

		return g_hooking->get_original<hook_Present>()(swapchain, sync_interval, flags);
	}

	static HRESULT WINAPI hook_Present1(IDXGISwapChain* swapchain, UINT sync_interval, UINT flags, const void* present_parameters)
	{
		if (g_running && ((flags & (UINT)DXGI_PRESENT_TEST) != (UINT)DXGI_PRESENT_TEST))
			g_renderer->render_imgui_d3d11(swapchain);

		return g_hooking->get_original<hook_Present1>()(swapchain, sync_interval, flags, present_parameters);
	}

	static HRESULT WINAPI hook_ResizeBuffers(IDXGISwapChain* swapchain, UINT BufferCount, UINT Width, UINT Height, DXGI_FORMAT NewFormat, UINT SwapChainFlags)
	{
		g_renderer->cleanup_render_target();

		return g_hooking->get_original<hook_ResizeBuffers>()(swapchain, BufferCount, Width, Height, NewFormat, SwapChainFlags);
	}

	static HRESULT WINAPI hook_ResizeBuffers1(IDXGISwapChain* swapchain, UINT BufferCount, UINT Width, UINT Height, DXGI_FORMAT NewFormat, UINT SwapChainFlags, const UINT* pCreationNodeMask, IUnknown* const* ppPresentQueue)
	{
		g_renderer->cleanup_render_target();

		return g_hooking->get_original<hook_ResizeBuffers1>()(swapchain, BufferCount, Width, Height, NewFormat, SwapChainFlags, pCreationNodeMask, ppPresentQueue);
	}

	static HRESULT WINAPI hook_CreateSwapChain(IDXGIFactory* pFactory, IUnknown* pDevice, DXGI_SWAP_CHAIN_DESC* pDesc, IDXGISwapChain** pswapchain)
	{
		g_renderer->cleanup_render_target();

		return g_hooking->get_original<hook_CreateSwapChain>()(pFactory, pDevice, pDesc, pswapchain);
	}

	static HRESULT WINAPI hook_CreateSwapChainForHwnd(IDXGIFactory* pFactory, IUnknown* pDevice, HWND hWnd, const void* pDesc, const void* pFullscreenDesc, IDXGIOutput* pRestrictToOutput, void** pswapchain)
	{
		g_renderer->cleanup_render_target();

		return g_hooking->get_original<hook_CreateSwapChainForHwnd>()(pFactory, pDevice, hWnd, pDesc, pFullscreenDesc, pRestrictToOutput, pswapchain);
	}

	static HRESULT WINAPI hook_CreateSwapChainForCoreWindow(IDXGIFactory* pFactory, IUnknown* pDevice, IUnknown* pWindow, const void* pDesc, IDXGIOutput* pRestrictToOutput, void** pswapchain)
	{
		g_renderer->cleanup_render_target();

		return g_hooking->get_original<hook_CreateSwapChainForCoreWindow>()(pFactory, pDevice, pWindow, pDesc, pRestrictToOutput, pswapchain);
	}

	static HRESULT WINAPI hook_CreateSwapChainForComposition(IDXGIFactory* pFactory, IUnknown* pDevice, const void* pDesc, IDXGIOutput* pRestrictToOutput, void** pswapchain)
	{
		g_renderer->cleanup_render_target();

		return g_hooking->get_original<hook_CreateSwapChainForComposition>()(pFactory, pDevice, pDesc, pRestrictToOutput, pswapchain);
	}

	void renderer::init_imgui_context(HWND window_handle)
	{
		if (ImGui::GetCurrentContext())
			return;

		ImGui::CreateContext();
		ImGui_ImplWin32_Init(window_handle);
	}

	void renderer::hook(HWND window_handle)
	{
		if (!create_device_d3d11(GetConsoleWindow()))
		{
			LOG(FATAL) << "create_device_d3d11 failed.";
			return;
		}

		if (m_d3d_device)
		{
			init_imgui_context(window_handle);

			IDXGIDevice* dxgi_device{};
			m_d3d_device->QueryInterface(IID_PPV_ARGS(&dxgi_device));

			IDXGIAdapter* dxgi_adapter{};
			dxgi_device->GetAdapter(&dxgi_adapter);

			IDXGIFactory* dxgi_factory{};
			dxgi_adapter->GetParent(IID_PPV_ARGS(&dxgi_factory));

			if (!dxgi_factory)
			{
				LOG(FATAL) << "dxgi_factory is null";
				return;
			}

			dxgi_factory->Release();
			dxgi_adapter->Release();
			dxgi_device->Release();

			void** swapchain_vtable    = *reinterpret_cast<void***>(m_dxgi_swapchain);
			void** dxgi_factory_vtable = *reinterpret_cast<void***>(dxgi_factory);

			cleanup_d3d11_device();

			hooking::detour_hook_helper::add<hook_CreateSwapChain>("CSC", dxgi_factory_vtable[10]);
			hooking::detour_hook_helper::add<hook_CreateSwapChainForHwnd>("CSCFH", dxgi_factory_vtable[15]);
			hooking::detour_hook_helper::add<hook_CreateSwapChainForCoreWindow>("CSCFCW", dxgi_factory_vtable[16]);
			hooking::detour_hook_helper::add<hook_CreateSwapChainForComposition>("CSCFC", dxgi_factory_vtable[24]);

			hooking::detour_hook_helper::add<hook_Present>("P", swapchain_vtable[8]);
			hooking::detour_hook_helper::add<hook_Present1>("P1", swapchain_vtable[22]);

			hooking::detour_hook_helper::add<hook_ResizeBuffers>("RB", swapchain_vtable[13]);
			hooking::detour_hook_helper::add<hook_ResizeBuffers1>("RB1", swapchain_vtable[39]);
		}
	}

	void renderer::cleanup()
	{
		SetWindowLongPtrW(m_hwnd, GWLP_WNDPROC, reinterpret_cast<LONG_PTR>(m_og_wndproc));

		if (ImGui::GetCurrentContext())
		{
			if (ImGui::GetIO().BackendRendererUserData)
				ImGui_ImplDX11_Shutdown();

			if (ImGui::GetIO().BackendPlatformUserData)
				ImGui_ImplWin32_Shutdown();

			ImGui::DestroyContext();
		}

		cleanup_d3d11_device();
	}

	void renderer::cleanup_render_target()
	{
		if (m_d3d_render_target)
		{
			m_d3d_render_target->Release();
			m_d3d_render_target = nullptr;
		}
	}

	void renderer::cleanup_d3d11_device()
	{
		cleanup_render_target();

		if (m_dxgi_swapchain)
		{
			m_dxgi_swapchain->Release();
			m_dxgi_swapchain = nullptr;
		}
		if (m_d3d_device)
		{
			m_d3d_device->Release();
			m_d3d_device = nullptr;
		}
		if (m_d3d_device_context)
		{
			m_d3d_device_context->Release();
			m_d3d_device_context = nullptr;
		}
	}

	void renderer::render_imgui_d3d11(IDXGISwapChain* swapchain)
	{
		if (!ImGui::GetIO().BackendRendererUserData)
		{
			if (SUCCEEDED(swapchain->GetDevice(IID_PPV_ARGS(&m_d3d_device))))
			{
				m_d3d_device->GetImmediateContext(&m_d3d_device_context);
				ImGui_ImplDX11_Init(m_d3d_device, m_d3d_device_context);
			}
		}

		if (g_running)
		{
			if (!m_d3d_render_target)
			{
				create_render_target(swapchain);
			}

			if (ImGui::GetCurrentContext() && m_d3d_render_target)
			{
				ImGui_ImplDX11_NewFrame();
				ImGui_ImplWin32_NewFrame();
				ImGui::NewFrame();

				for (const auto& cb : m_dx_callbacks | std::views::values)
					cb();

				ImGui::Render();

				m_d3d_device_context->OMSetRenderTargets(1, &m_d3d_render_target, nullptr);
				ImGui_ImplDX11_RenderDrawData(ImGui::GetDrawData());
			}
		}
	}

	void renderer::init_fonts()
	{
		folder windows_fonts(std::filesystem::path(std::getenv("SYSTEMROOT")) / "Fonts");

		file font_file_path = windows_fonts.get_file("./msyh.ttc");
		if (!font_file_path.exists())
			font_file_path = windows_fonts.get_file("./msyh.ttf");
		auto font_file            = std::ifstream(font_file_path.get_path(), std::ios::binary | std::ios::ate);
		const auto font_data_size = static_cast<int>(font_file.tellg());
		const auto font_data      = std::make_unique<uint8_t[]>(font_data_size);

		font_file.seekg(0);
		font_file.read(reinterpret_cast<char*>(font_data.get()), font_data_size);
		font_file.close();

		auto& io = ImGui::GetIO();

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
			io.Fonts->AddFontFromMemoryTTF(font_data.get(), font_data_size, 20.f, &fnt_cfg, ImGui::GetIO().Fonts->GetGlyphRangesChineseSimplifiedCommon());
			io.Fonts->AddFontFromMemoryTTF(font_data.get(), font_data_size, 20.f, &fnt_cfg, ImGui::GetIO().Fonts->GetGlyphRangesCyrillic());
			io.Fonts->Build();
		}

		{
			ImFontConfig fnt_cfg{};
			fnt_cfg.FontDataOwnedByAtlas = false;
			strcpy(fnt_cfg.Name, "Fnt28px");

			font_title = io.Fonts->AddFontFromMemoryTTF(const_cast<uint8_t*>(font_storopia), sizeof(font_storopia), 28.f, &fnt_cfg);
			fnt_cfg.MergeMode = true;
			io.Fonts->AddFontFromMemoryTTF(font_data.get(), font_data_size, 28.f, &fnt_cfg, ImGui::GetIO().Fonts->GetGlyphRangesChineseSimplifiedCommon());
			io.Fonts->AddFontFromMemoryTTF(font_data.get(), font_data_size, 28.f, &fnt_cfg, ImGui::GetIO().Fonts->GetGlyphRangesCyrillic());
			io.Fonts->Build();
		}

		{
			ImFontConfig fnt_cfg{};
			fnt_cfg.FontDataOwnedByAtlas = false;
			strcpy(fnt_cfg.Name, "Fnt24px");

			font_sub_title = io.Fonts->AddFontFromMemoryTTF(const_cast<uint8_t*>(font_storopia), sizeof(font_storopia), 24.f, &fnt_cfg);
			fnt_cfg.MergeMode = true;
			io.Fonts->AddFontFromMemoryTTF(font_data.get(), font_data_size, 24.f, &fnt_cfg, ImGui::GetIO().Fonts->GetGlyphRangesChineseSimplifiedCommon());
			io.Fonts->AddFontFromMemoryTTF(font_data.get(), font_data_size, 24.f, &fnt_cfg, ImGui::GetIO().Fonts->GetGlyphRangesCyrillic());
			io.Fonts->Build();
		}

		{
			ImFontConfig fnt_cfg{};
			fnt_cfg.FontDataOwnedByAtlas = false;
			strcpy(fnt_cfg.Name, "Fnt18px");

			font_small = io.Fonts->AddFontFromMemoryTTF(const_cast<uint8_t*>(font_storopia), sizeof(font_storopia), 18.f, &fnt_cfg);
			fnt_cfg.MergeMode = true;
			io.Fonts->AddFontFromMemoryTTF(font_data.get(), font_data_size, 18.f, &fnt_cfg, ImGui::GetIO().Fonts->GetGlyphRangesChineseSimplifiedCommon());
			io.Fonts->AddFontFromMemoryTTF(font_data.get(), font_data_size, 18.f, &fnt_cfg, ImGui::GetIO().Fonts->GetGlyphRangesCyrillic());
			io.Fonts->Build();
		}

		{
			ImFontConfig font_icons_cfg{};
			font_icons_cfg.FontDataOwnedByAtlas = false;
			std::strcpy(font_icons_cfg.Name, "Icons");
			font_icon = io.Fonts->AddFontFromMemoryTTF(const_cast<uint8_t*>(font_icons), sizeof(font_icons), 24.f, &font_icons_cfg);
		}
	}

	void renderer::init(HWND window_handle)
	{
		hook(window_handle);

		init_imgui_context(window_handle);

		auto file_path = g_file_manager.get_project_file("./imgui.ini").get_path();
		static std::string path = file_path.make_preferred().string();
		ImGui::GetCurrentContext()->IO.IniFilename = path.c_str();

		init_fonts();

		for (const auto& init_cb : m_init_callbacks)
		{
			if (init_cb)
			{
				init_cb();
			}
		}

		m_og_wndproc = WNDPROC(SetWindowLongPtrW(window_handle, GWLP_WNDPROC, LONG_PTR(&static_wndproc)));
	}

	renderer::renderer(HWND window_handle)
	{
		init(window_handle);

		g_renderer = this;
	}

	renderer::~renderer()
	{
		cleanup();

		g_renderer = nullptr;
	}

	bool renderer::add_init_callback(init_callback callback)
	{
		m_init_callbacks.push_back(callback);

		return true;
	}

	bool renderer::add_dx_callback(dx_callback callback, uint32_t priority)
	{
		if (!m_dx_callbacks.insert({priority, callback}).second)
		{
			LOG(WARNING) << "Duplicate priority given on DX Callback!";

			return false;
		}
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

	void renderer::rescale(float rel_size)
	{
		pre_reset();
		g_gui->restore_default_style();

		if (rel_size != 1.0f)
			ImGui::GetStyle().ScaleAllSizes(rel_size);

		ImGui::GetStyle().MouseCursorScale = 1.0f;
		ImGui::GetIO().FontGlobalScale     = rel_size;
		post_reset();
	}

	void renderer::pre_reset()
	{
		ImGui_ImplDX11_InvalidateDeviceObjects();
	}

	void renderer::post_reset()
	{
		ImGui_ImplDX11_CreateDeviceObjects();
	}
}
