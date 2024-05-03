#pragma once
#include "rorr/gm/CInstance_hooks.hpp"
#include "rorr/gm/Code_Execute_hook.hpp"
#include "rorr/gm/debug_console.hpp"
#include "rorr/gm/GetSaveFileName_hook.hpp"
#include "rorr/gm/inputs.hpp"

namespace big::rorr
{
	inline void init_hooks()
	{
		hooking::detour_hook_helper::add<gm::hook_debug_console_output>("DCO", g_pointers->m_rorr.m_debug_console_output);

		hooking::detour_hook_helper::add<gm::hook_Code_Execute>("CE", g_pointers->m_rorr.m_code_execute);

		hooking::detour_hook_helper::add<gm::hook_CInstance_ctor>("CIC", g_pointers->m_rorr.m_cinstance_ctor);
		hooking::detour_hook_helper::add<gm::hook_CInstance_dctor>("CID", g_pointers->m_rorr.m_cinstance_dctor);

		hooking::detour_hook_helper::add<gm::hook_CObjectGM_AddInstance>("COGMAI", g_pointers->m_rorr.m_cobjectgm_add_instance);
		hooking::detour_hook_helper::add<gm::hook_CObjectGM_RemoveInstance>("COGMRI", g_pointers->m_rorr.m_cobjectgm_remove_instance);

		hooking::detour_hook_helper::add<gm::hook_IO_UpdateM>("IOUM", g_pointers->m_rorr.m_io_update_m);

		hooking::detour_hook_helper::add<gm::hook_GetSaveFileName>("GSFN", g_pointers->m_rorr.m_get_save_file_name);
	}
} // namespace big::rorr
