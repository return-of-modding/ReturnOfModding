#include "gui_ext.hpp"

#include "gui/gui.hpp"

#include <lua/bindings/gui.hpp>

namespace lua::gui_ext
{
	static bool is_open()
	{
		return big::g_gui && big::g_gui->is_open();
	}

	static void toggle()
	{
		if (big::g_gui)
		{
			big::g_gui->toggle(!big::g_gui->is_open());
		}
	}

	static void reshow_onboarding()
	{
		big::g_gui->m_onboarding_open        = false;
		big::g_gui->m_onboarded->ref<bool>() = false;
	}

	void bind(sol::table& state)
	{
		lua::gui::g_on_is_open = is_open;
		lua::gui::g_on_toggle  = toggle;

		auto ns = state["gui"].get_or_create<sol::table>();
		ns["reshow_onboarding"] = reshow_onboarding;
	}
} // namespace lua::gui_ext
