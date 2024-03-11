#pragma once

struct CInstance;
struct RValue;
struct YYVAR;

using PFUNC_YYGMLScript = RValue* (*)(CInstance* self, CInstance* other, RValue* result, int arg_count, RValue** args);
using PFUNC_YYGML       = void (*)(CInstance* self, CInstance* other);

struct YYGMLFuncs
{
	const char* m_name;

	union
	{
		PFUNC_YYGMLScript m_script_function;
		PFUNC_YYGML m_function;
	};

	YYVAR* m_func_var;
};
