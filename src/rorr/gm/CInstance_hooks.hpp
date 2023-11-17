#pragma once

#include "hooks/hooking.hpp"

namespace gm
{
	inline std::vector<CInstance*> CInstances_all;
	inline std::vector<CInstance*> CInstances_active;

	using CInstance_ctor = CInstance* (*)(CInstance* this_, float a2, float a3, int a4, int a5, bool a6);
	inline CInstance* hook_CInstance_ctor(CInstance* this_, float a2, float a3, int a4, int a5, bool a6)
	{
		auto* res = big::g_hooking->get_original<hook_CInstance_ctor>()(this_, a2, a3, a4, a5, a6);

		CInstances_all.push_back(res);

		return res;
	}

	using CInstance_dctor = void* (*)(CInstance* this_);
	inline void* hook_CInstance_dctor(CInstance* this_)
	{
		std::erase_if(CInstances_all, [=](CInstance* other) {
			return this_ == other;
		});

		auto* res = big::g_hooking->get_original<hook_CInstance_dctor>()(this_);

		return res;
	}

	using CObjectGM_AddInstance = void (*)(void* CObjectGM_this, CInstance* real_this);
	inline void hook_CObjectGM_AddInstance(void* CObjectGM_this, CInstance* real_this)
	{
		big::g_hooking->get_original<hook_CObjectGM_AddInstance>()(CObjectGM_this, real_this);

		CInstances_active.push_back(real_this);
	}

	using CObjectGM_RemoveInstance = void (*)(void* CObjectGM_this, CInstance* real_this);
	inline void hook_CObjectGM_RemoveInstance(void* CObjectGM_this, CInstance* real_this)
	{
		std::erase_if(CInstances_active, [=](CInstance* other) {
			return real_this == other;
		});

		big::g_hooking->get_original<hook_CObjectGM_RemoveInstance>()(CObjectGM_this, real_this);
	}
}