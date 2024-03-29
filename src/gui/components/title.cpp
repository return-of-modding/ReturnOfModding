#include "fonts/fonts.hpp"
#include "gui/components/components.hpp"
#include "gui/renderer.hpp"

namespace big
{
	void components::title(const std::string_view text)
	{
		components::custom_text(text.data(), g_renderer->font_title);
	}
} // namespace big
