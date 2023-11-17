#pragma once
#include "gm/Code_Execute.hpp"
#include "gm/Code_Function_GET_the_function_t.hpp"
#include "gm/RVariableRoutine.hpp"
#include "gm/CRoom.hpp"
#include "gm/CInstance_hooks.hpp"

#include <memory/handle.hpp>

namespace big
{
	// needed for serialization of the pointers cache
#pragma pack(push, 1)
	struct rorr_pointers
	{
		int* m_gamemaker_version_major;

		gm::Code_Function_GET_the_function_t m_code_function_GET_the_function;
		int* m_code_function_GET_the_function_function_count;

		gm::Code_Execute m_code_execute;

		gm::RVariableRoutine* m_builtin_variables;
		int* m_builtin_variable_count;

		gm::CRoom** m_croom;

		gm::CInstance_ctor m_cinstance_ctor;
		gm::CInstance_dctor m_cinstance_dctor;

		gm::CObjectGM_AddInstance m_cobjectgm_add_instance;
		gm::CObjectGM_RemoveInstance m_cobjectgm_remove_instance;
	};
#pragma pack(pop)
	static_assert(sizeof(rorr_pointers) % 8 == 0, "Pointers are not properly aligned");
}
