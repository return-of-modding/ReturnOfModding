#include "gui.hpp"

#include "gui/renderer.hpp"
#include "lua/bindings/imgui_window.hpp"

#include <gui/widgets/imgui_hotkey.hpp>
#include <input/hotkey.hpp>
#include <input/is_key_pressed.hpp>
#include <lua/lua_manager.hpp>
#include <pointers.hpp>
#include <rorr/gm/CInstance.hpp>
#include <rorr/gm/Code_Function_GET_the_function.hpp>
#include <rorr/gm/EVariableType.hpp>
#include <rorr/gm/RValue.hpp>
#include <rorr/gm/Variable_BuiltIn.hpp>
#include <rorr/gm/YYObjectBase.hpp>

namespace big
{
	gui::gui()
	{
		init_pref();

		g_renderer->add_dx_callback(
		    [this]
		    {
			    dx_on_tick();
		    },
		    -5);

		g_renderer->add_wndproc_callback(
		    [this](HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam)
		    {
			    wndproc(hwnd, msg, wparam, lparam);
		    });

		g_renderer->add_init_callback(
		    [this]()
		    {
			    dx_init();
			    g_renderer->rescale(g_gui->scale);
		    });

		g_gui = this;
	}

	gui::~gui()
	{
		g_gui = nullptr;
	}

	bool gui::is_open()
	{
		return m_is_open;
	}

	void gui::toggle(bool toggle)
	{
		m_is_open = toggle;

		toggle_mouse();
	}

	void gui::dx_init()
	{
		static auto bgColor     = ImVec4(0.09f, 0.094f, 0.129f, .9f);
		static auto primary     = ImVec4(0.172f, 0.380f, 0.909f, 1.f);
		static auto secondary   = ImVec4(0.443f, 0.654f, 0.819f, 1.f);
		static auto whiteBroken = ImVec4(0.792f, 0.784f, 0.827f, 1.f);

		auto& style             = ImGui::GetStyle();
		style.WindowPadding     = ImVec2(15, 15);
		style.WindowRounding    = 10.f;
		style.WindowBorderSize  = 0.f;
		style.FramePadding      = ImVec2(5, 5);
		style.FrameRounding     = 4.0f;
		style.ItemSpacing       = ImVec2(12, 8);
		style.ItemInnerSpacing  = ImVec2(8, 6);
		style.IndentSpacing     = 25.0f;
		style.ScrollbarSize     = 15.0f;
		style.ScrollbarRounding = 9.0f;
		style.GrabMinSize       = 5.0f;
		style.GrabRounding      = 3.0f;
		style.ChildRounding     = 4.0f;

		auto& colors = style.Colors;
		//colors[ImGuiCol_Text]                 = ImGui::ColorConvertU32ToFloat4(g_gui->text_color);
		colors[ImGuiCol_TextDisabled] = ImVec4(0.24f, 0.23f, 0.29f, 1.00f);
		//colors[ImGuiCol_WindowBg]             = ImGui::ColorConvertU32ToFloat4(g_gui->background_color);
		//colors[ImGuiCol_ChildBg]              = ImGui::ColorConvertU32ToFloat4(g_gui->background_color);
		colors[ImGuiCol_PopupBg]              = ImVec4(0.07f, 0.07f, 0.09f, 1.00f);
		colors[ImGuiCol_Border]               = ImVec4(0.80f, 0.80f, 0.83f, 0.88f);
		colors[ImGuiCol_BorderShadow]         = ImVec4(0.92f, 0.91f, 0.88f, 0.00f);
		colors[ImGuiCol_FrameBg]              = ImVec4(0.10f, 0.09f, 0.12f, 1.00f);
		colors[ImGuiCol_FrameBgHovered]       = ImVec4(0.24f, 0.23f, 0.29f, 1.00f);
		colors[ImGuiCol_FrameBgActive]        = ImVec4(0.56f, 0.56f, 0.58f, 1.00f);
		colors[ImGuiCol_TitleBg]              = ImVec4(0.10f, 0.09f, 0.12f, 1.00f);
		colors[ImGuiCol_TitleBgCollapsed]     = ImVec4(1.00f, 0.98f, 0.95f, 0.75f);
		colors[ImGuiCol_TitleBgActive]        = ImVec4(0.07f, 0.07f, 0.09f, 1.00f);
		colors[ImGuiCol_MenuBarBg]            = ImVec4(0.10f, 0.09f, 0.12f, 1.00f);
		colors[ImGuiCol_ScrollbarBg]          = ImVec4(0.10f, 0.09f, 0.12f, 1.00f);
		colors[ImGuiCol_ScrollbarGrab]        = ImVec4(0.80f, 0.80f, 0.83f, 0.31f);
		colors[ImGuiCol_ScrollbarGrabHovered] = ImVec4(0.56f, 0.56f, 0.58f, 1.00f);
		colors[ImGuiCol_ScrollbarGrabActive]  = ImVec4(0.06f, 0.05f, 0.07f, 1.00f);
		colors[ImGuiCol_CheckMark]            = ImVec4(1.00f, 0.98f, 0.95f, 0.61f);
		colors[ImGuiCol_SliderGrab]           = ImVec4(0.80f, 0.80f, 0.83f, 0.31f);
		colors[ImGuiCol_SliderGrabActive]     = ImVec4(0.06f, 0.05f, 0.07f, 1.00f);
		colors[ImGuiCol_Button]               = ImVec4(0.24f, 0.23f, 0.29f, 1.00f);
		colors[ImGuiCol_ButtonHovered]        = ImVec4(0.24f, 0.23f, 0.29f, 1.00f);
		colors[ImGuiCol_ButtonActive]         = ImVec4(0.56f, 0.56f, 0.58f, 1.00f);
		colors[ImGuiCol_Header]               = ImVec4(0.30f, 0.29f, 0.32f, 1.00f);
		colors[ImGuiCol_HeaderHovered]        = ImVec4(0.56f, 0.56f, 0.58f, 1.00f);
		colors[ImGuiCol_HeaderActive]         = ImVec4(0.06f, 0.05f, 0.07f, 1.00f);
		colors[ImGuiCol_ResizeGrip]           = ImVec4(0.00f, 0.00f, 0.00f, 0.00f);
		colors[ImGuiCol_ResizeGripHovered]    = ImVec4(0.56f, 0.56f, 0.58f, 1.00f);
		colors[ImGuiCol_ResizeGripActive]     = ImVec4(0.06f, 0.05f, 0.07f, 1.00f);
		colors[ImGuiCol_PlotLines]            = ImVec4(0.40f, 0.39f, 0.38f, 0.63f);
		colors[ImGuiCol_PlotLinesHovered]     = ImVec4(0.25f, 1.00f, 0.00f, 1.00f);
		colors[ImGuiCol_PlotHistogram]        = ImVec4(0.40f, 0.39f, 0.38f, 0.63f);
		colors[ImGuiCol_PlotHistogramHovered] = ImVec4(0.25f, 1.00f, 0.00f, 1.00f);
		colors[ImGuiCol_TextSelectedBg]       = ImVec4(0.25f, 1.00f, 0.00f, 0.43f);

		save_default_style();
	}

	static bool editing_gui_keybind = false;

	void gui::dx_on_tick()
	{
		push_theme_colors();

		g_lua_manager->always_draw_independent_gui();

		if (m_is_open)
		{
			if (ImGui::BeginMainMenuBar())
			{
				ImGui::SetNextWindowSize({400.0f, 0});
				if (ImGui::BeginMenu("GUI"))
				{
					if (ImGui::Checkbox("Open GUI At Startup", &m_is_open_at_startup->ref<bool>()))
					{
						save_pref();
					}

					if (ImGui::Hotkey("Open GUI Keybind", &g_gui_toggle.vk()))
					{
						editing_gui_keybind = true;
					}

					ImGui::EndMenu();
				}

				if (ImGui::BeginMenu("Mods"))
				{
					g_lua_manager->draw_menu_bar_callbacks();

					ImGui::EndMenu();
				}

				if (ImGui::BeginMenu("Windows"))
				{
					for (auto& [mod_guid, windows] : lua::window::is_open)
					{
						if (!g_lua_manager->module_exists(mod_guid))
						{
							continue;
						}

						if (ImGui::BeginMenu(mod_guid.c_str()))
						{
							if (ImGui::Button("Open All"))
							{
								for (auto& [window_name, is_window_open] : windows)
								{
									is_window_open = true;
								}
								lua::window::serialize();
							}
							ImGui::SameLine();
							if (ImGui::Button("Close All"))
							{
								for (auto& [window_name, is_window_open] : windows)
								{
									is_window_open = false;
								}
								lua::window::serialize();
							}

							for (auto& [window_name, is_window_open] : windows)
							{
								if (ImGui::Checkbox(window_name.c_str(), &is_window_open))
								{
									lua::window::serialize();
								}
							}

							ImGui::EndMenu();
						}
					}

					ImGui::EndMenu();
				}

				ImGui::EndMainMenuBar();
			}

			ImGui::SetMouseCursor(g_gui->m_mouse_cursor);

			g_lua_manager->draw_independent_gui();

			if (0)
			{
				if (ImGui::Begin("Return Of Modding"))
				{
					const auto mouse_x = gm::variable_global_get("mouse_x").value;
					const auto mouse_y = gm::variable_global_get("mouse_y").value;
					const auto nearest_instance = gm::call("instance_nearest", std::to_array<RValue, 3>({mouse_x, mouse_y, EVariableType::ALL}));
					ImGui::Text("Cursor (%.2f, %.2f)", mouse_x, mouse_y);
					ImGui::Separator();
					if (nearest_instance.type == RValueType::REF)
					{
						for (const auto& instance : gm::CInstances_active)
						{
							if (instance->id == nearest_instance.i32)
							{
								instance->imgui_dump();
								ImGui::Separator();

								break;
							}
						}
					}

					const auto current_room      = gm::variable_global_get("room").value;
					const auto current_room_name = gm::call("room_get_name", current_room);
					ImGui::Text("Current Room: %s (%f)", current_room_name.ref_string->m_thing, current_room);
					static int new_room{};
					ImGui::InputInt("New Room ID", &new_room);
					if (ImGui::Button("Goto Room"))
					{
						gm::call("room_goto", new_room);
					}

					if (GetAsyncKeyState(VK_F4) & 1)
					{
						gm::call("instance_create_depth", std::to_array<RValue, 4>({mouse_x, mouse_y, -200.0, 324 /*wisp*/}));
					}

					if (ImGui::Button("Create Survivor"))
					{
						const auto res = gm::call("survivor_create", std::to_array<RValue, 2>({"My", "Survivor"}));
					}

					for (size_t i = 0; i < gm::CInstances_active.size(); i++)
					{
						if (gm::CInstances_active[i]->object_name() == "oP")
						{
							gm::CInstances_active[i]->imgui_dump();
							gm::CInstances_active[i]->imgui_dump_instance_variables();
							ImGui::Separator();

							break;
						}
					}

					for (const auto& instance : gm::CInstances_active)
					{
						instance->imgui_dump();
						ImGui::Separator();
					}
				}
				ImGui::End();
			}
		}

		pop_theme_colors();
	}

	void gui::save_default_style()
	{
		memcpy(&m_default_config, &ImGui::GetStyle(), sizeof(ImGuiStyle));
	}

	void gui::restore_default_style()
	{
		memcpy(&ImGui::GetStyle(), &m_default_config, sizeof(ImGuiStyle));
	}

	void gui::push_theme_colors()
	{
		//auto button_color = ImGui::ColorConvertU32ToFloat4(g_gui->button_color);
		auto button_color = ImGui::ColorConvertU32ToFloat4(2'947'901'213);
		auto button_active_color =
		    ImVec4(button_color.x + 0.33f, button_color.y + 0.33f, button_color.z + 0.33f, button_color.w);
		auto button_hovered_color =
		    ImVec4(button_color.x + 0.15f, button_color.y + 0.15f, button_color.z + 0.15f, button_color.w);
		auto frame_color = ImGui::ColorConvertU32ToFloat4(2'942'518'340);
		auto frame_hovered_color =
		    ImVec4(frame_color.x + 0.14f, frame_color.y + 0.14f, frame_color.z + 0.14f, button_color.w);
		auto frame_active_color =
		    ImVec4(frame_color.x + 0.30f, frame_color.y + 0.30f, frame_color.z + 0.30f, button_color.w);

		//ImGui::PushStyleColor(ImGuiCol_WindowBg, ImGui::ColorConvertU32ToFloat4(g_gui->background_color));
		//ImGui::PushStyleColor(ImGuiCol_Text, ImGui::ColorConvertU32ToFloat4(g_gui->text_color));
		ImGui::PushStyleColor(ImGuiCol_Button, button_color);
		ImGui::PushStyleColor(ImGuiCol_ButtonHovered, button_hovered_color);
		ImGui::PushStyleColor(ImGuiCol_ButtonActive, button_active_color);
		ImGui::PushStyleColor(ImGuiCol_FrameBg, frame_color);
		ImGui::PushStyleColor(ImGuiCol_FrameBgHovered, frame_hovered_color);
		ImGui::PushStyleColor(ImGuiCol_FrameBgActive, frame_active_color);
	}

	void gui::pop_theme_colors()
	{
		//ImGui::PopStyleColor(8);
		ImGui::PopStyleColor(6);
	}

	void gui::wndproc(HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam)
	{
		if (msg == WM_KEYUP && wparam == g_gui_toggle.vk())
		{
			// Persist and restore the cursor position between menu instances.
			static POINT cursor_coords{};
			if (g_gui->m_is_open)
			{
				GetCursorPos(&cursor_coords);
			}
			else if (cursor_coords.x + cursor_coords.y != 0)
			{
				SetCursorPos(cursor_coords.x, cursor_coords.y);
			}

			toggle(editing_gui_keybind || !m_is_open);
			if (editing_gui_keybind)
			{
				editing_gui_keybind = false;
			}
		}
	}

	void gui::toggle_mouse()
	{
		auto& io = ImGui::GetIO();

		if (m_is_open)
		{
			io.MouseDrawCursor  = true;
			io.ConfigFlags     &= ~ImGuiConfigFlags_NoMouse;
		}
		else
		{
			io.MouseDrawCursor  = false;
			io.ConfigFlags     |= ImGuiConfigFlags_NoMouse;
		}
	}

	void gui::init_pref()
	{
		try
		{
			m_file_path = g_file_manager.get_project_folder("config").get_path() / m_file_name;
			if (std::filesystem::exists(m_file_path))
			{
				m_table = toml::parse_file(m_file_path.c_str());
			}

			constexpr auto is_open_at_startup_name = "is_open_at_startup";

			const auto entry_doesnt_exist = !m_table.contains(is_open_at_startup_name);
			if (entry_doesnt_exist)
			{
				m_table.insert_or_assign(is_open_at_startup_name, true);
			}

			m_is_open_at_startup = m_table.get(is_open_at_startup_name);
			if (m_is_open_at_startup == nullptr)
			{
				LOG(FATAL) << "what";
			}

			if (m_is_open_at_startup == nullptr || m_is_open_at_startup->type() != toml::node_type::boolean)
			{
				LOG(WARNING) << "Invalid serialized data. Clearing " << is_open_at_startup_name;

				m_table.insert_or_assign(is_open_at_startup_name, true);
				m_is_open_at_startup = m_table.get(is_open_at_startup_name);
				if (m_is_open_at_startup == nullptr)
				{
					LOG(FATAL) << "what2";
				}
			}

			save_pref();

			toggle(m_is_open_at_startup->ref<bool>());
		}
		catch (const std::exception& e)
		{
			LOG(INFO) << "Failed init hotkeys: " << e.what();

			m_is_open = true;
		}
	}

	void gui::save_pref()
	{
		std::ofstream file_stream(m_file_path, std::ios::out | std::ios::trunc);
		if (file_stream.is_open())
		{
			file_stream << m_table;
		}
		else
		{
			LOG(WARNING) << "Failed to save pref.";
		}
	}
} // namespace big
