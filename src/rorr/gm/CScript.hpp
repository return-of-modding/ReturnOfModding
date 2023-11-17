#pragma once

struct CStream
{
	bool m_ReadOnly;
	int internal_buffer_size;
	int internal_current_position;
	void* internal_buffer;
};

struct __declspec(align(4)) CScript
{
	void** pVMT;
	CStream* s_text;
	CCode* s_code;
	YYGMLFuncs* s_pFunc;
	CInstance* s_pStaticObject;

	union {
		const char* s_script;
		int s_compiledIndex;
	};

	const char* s_name;
	int s_offset;
};