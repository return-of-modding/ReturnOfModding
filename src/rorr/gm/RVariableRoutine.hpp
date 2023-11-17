#pragma once

namespace gm
{
	using RVariableRoutineGetter = bool(*)(CInstance* self, void* a2, RValue* out);
	using RVariableRoutineSetter = bool(*)(CInstance* self, void* a2, RValue* new_value);

	struct RVariableRoutine
	{
		const char* name;
		RVariableRoutineGetter getter;
		RVariableRoutineSetter setter;
		void* has_setter;
	};

	static_assert(sizeof(RVariableRoutine) == 32);
}