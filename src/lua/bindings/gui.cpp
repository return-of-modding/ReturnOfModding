#include "gui.hpp"

#include "gui/gui.hpp"
#include "gui_element.hpp"
#include "raw_imgui_callback.hpp"

namespace lua::gui
{
	static void add_independent_element(sol::this_environment& env, std::unique_ptr<lua::gui::gui_element> element)
	{
		big::lua_module* module = big::lua_module::this_from(env);
		if (module)
			module->m_independent_gui.push_back(std::move(element));
	}

	// Lua API: Function
	// Table: gui
	// Name: is_open
	// Returns: bool: Returns true if the GUI is open.
	static bool is_open()
	{
		return big::g_gui->is_open();
	}

	// Lua API: Function
	// Table: gui
	// Name: add_imgui
	// Param: imgui_rendering: function: Function that will be called every rendering frame, you can call ImGui functions in it, please check the ImGui.md documentation file for more info.
	// Registers a function that will be called every rendering frame, you can call ImGui functions in it, please check the ImGui.md documentation file for more info.
	// **Example Usage:**
	// ```lua
	// gui.add_imgui(function()
	//   if ImGui.Begin("My Custom Window") then
	//       if ImGui.Button("Label") then
	//         script.run_in_fiber(function(script)
	//           -- call natives in there
	//         end)
	//       end
	//
	//       ImGui.End()
	//   end
	// end)
	// ```
	static lua::gui::raw_imgui_callback* add_imgui(sol::protected_function imgui_rendering, sol::this_environment state)
	{
		auto element = std::make_unique<lua::gui::raw_imgui_callback>(imgui_rendering);
		auto el_ptr  = element.get();
		add_independent_element(state, std::move(element));
		return el_ptr;
	}

	void bind(sol::state& state)
	{
		auto ns            = state["gui"].get_or_create<sol::table>();
		ns["is_open"]      = is_open;
		ns["add_imgui"]    = add_imgui;
	}
}