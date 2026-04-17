#pragma once
#include "CInstance.hpp"
#include "hooks/hooking.hpp"
#include "lua/lua_manager.hpp"
#include "lua/lua_manager_extension.hpp"

namespace gm
{
	using ObjectEventPerform = void (*)(CInstance* self, CInstance* other, int object_index, uint32_t event_type, uint32_t event_number, bool is_forced);

	inline void hook_ObjectEventPerform(CInstance* self, CInstance* other, int object_index, uint32_t event_type, uint32_t event_number, bool is_forced)
	{
		if (big::g_lua_manager)
		{
			const auto call_orig_if_true = big::lua_manager_extension::pre_event_execute(self, other, object_index, event_type, event_number);

			if (call_orig_if_true)
			{
				big::g_hooking->get_original<hook_ObjectEventPerform>()(self, other, object_index, event_type, event_number, is_forced);
			}

			big::lua_manager_extension::post_event_execute(self, other, object_index, event_type, event_number);
		}
		else
		{
			big::g_hooking->get_original<hook_ObjectEventPerform>()(self, other, object_index, event_type, event_number, is_forced);
		}
	}
} // namespace gm
