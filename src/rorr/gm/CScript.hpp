#pragma once

struct CStream
{
	bool m_ReadOnly;
	int internal_buffer_size;
	int internal_current_position;
	void* internal_buffer;
};

struct CScript
{
	void** pVMT;
	CStream* s_text;
	CCode* s_code;
	YYGMLFuncs* s_pFunc;
	CInstance* s_pStaticObject;

	union {
		const char* m_script_name; // example: gml_Script_init_player
		int s_compiledIndex;
	};

	const char* m_name;
	int m_offset;
};