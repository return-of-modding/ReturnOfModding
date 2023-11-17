#pragma once

struct YYGMLFuncs
{
	const char* pName;
	union {
		PFUNC_YYGMLScript pScriptFunc;
		PFUNC_YYGML pFunc;
	};
	YYVAR* pFuncVar;
};
