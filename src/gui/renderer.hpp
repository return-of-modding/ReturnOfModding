#pragma once
#include "common.hpp"

namespace big
{
	using init_callback      = std::function<void()>;
	using dx_callback      = std::function<void()>;
	using wndproc_callback = std::function<void(HWND, UINT, WPARAM, LPARAM)>;

	class renderer final
	{
	private:
		HWND m_hwnd;
		ID3D11Device* m_d3d_device{};
		ID3D11DeviceContext* m_d3d_device_context{};
		ID3D11RenderTargetView* m_d3d_render_target{};
		IDXGISwapChain* m_dxgi_swapchain{};

		std::vector<init_callback> m_init_callbacks;
		std::map<uint32_t, dx_callback> m_dx_callbacks;
		std::vector<wndproc_callback> m_wndproc_callbacks;

	public:
		WNDPROC m_og_wndproc = nullptr;

		ImFont* font_title     = nullptr;
		ImFont* font_sub_title = nullptr;
		ImFont* font_small     = nullptr;
		ImFont* font_icon      = nullptr;

	public:
		void init(HWND window_handle);

		explicit renderer(HWND window_handle);
		~renderer();

		bool add_init_callback(init_callback callback);

		/**
		 * @brief Add a callback function to draw your ImGui content in
		 *
		 * @param callback Function
		 * @param priority The higher the priority the value the later it gets drawn on top
		 * @return true
		 * @return false
		 */
		bool add_dx_callback(dx_callback callback, uint32_t priority);

		void remove_wndproc_callback(size_t callback_index);

		/**
		 * @brief Add a callback function on wndproc
		 *
		 * @param callback Function
		 */
		size_t add_wndproc_callback(wndproc_callback callback);

		void rescale(float rel_size);

		void pre_reset();
		void post_reset();

		void wndproc(HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam);

		void cleanup_render_target();

		void render_imgui_d3d11(IDXGISwapChain* swapchain);

	private:
		void init_fonts();
		void cleanup();
		void cleanup_d3d11_device();
		void hook(HWND window_handle);
		bool create_device_d3d11();
		void create_render_target(IDXGISwapChain* swapchain);
		void init_imgui_context(HWND window_handle);
	};

	inline renderer* g_renderer{};
}
