#pragma once

namespace gm
{
	using TRoutine = void(__cdecl*)(RValue* _result, CInstance* _self, CInstance* _other, int _argc, RValue* _args);

	using Code_Function_GET_the_function_t = void (*)(int index, const char** out_function_name, TRoutine* out_function_pointer, int* out_function_arg_count);
}
