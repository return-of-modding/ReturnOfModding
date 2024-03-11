#pragma once
#include "RToken.hpp"
#include "RValue.hpp"
#include "VMBuffer.hpp"

struct YYGMLFuncs;

struct CCode
{
	int (**_vptr$CCode)(void);
	CCode* m_pNext;
	int i_kind;
	int i_compiled;
	const char* i_str;
	RToken i_token;
	RValue i_value;
	VMBuffer* i_pVM;
	VMBuffer* i_pVMDebugInfo;
	char* i_pCode;
	const char* name;
	int index;
	YYGMLFuncs* i_pFunc;
	bool i_watch;
	int i_offset;
	int i_locals;
	int i_args;
	int i_flags;
	YYObjectBase* i_pPrototype;

	inline const char* GetText()
	{
		return this->i_str;
	}

	inline YYObjectBase* GetStatic()
	{
		return this->i_pPrototype;
	}
};
