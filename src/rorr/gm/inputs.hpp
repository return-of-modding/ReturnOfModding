#pragma once

#include "gui/gui.hpp"

namespace gm
{
    using IO_UpdateM_t = void (*)();

    inline void hook_IO_UpdateM()
    {
        if (!big::g_gui->is_open())
        {
			big::g_hooking->get_original<hook_IO_UpdateM>()();
        }
    }
}