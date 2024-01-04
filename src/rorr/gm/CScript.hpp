#pragma once

struct CStream
{
	bool m_ReadOnly;
	int internal_buffer_size;
	int internal_current_position;
	void* internal_buffer;
};

struct CCode;
struct YYGMLFuncs;
struct CInstance;

struct CScript
{
	int (**_vptr$CScript)(void);
	CCode* m_code;
	YYGMLFuncs* m_funcs;
	CInstance* m_static_object;

	union {
		const char* m_script;
		int m_compiled_index;
	};

	const char* m_script_name; // example: gml_Script_init_player
	int m_offset;
};