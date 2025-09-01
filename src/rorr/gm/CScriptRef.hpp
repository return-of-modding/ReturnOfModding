#pragma once

#include "YYObjectBase.hpp"

struct CScript;

class CScriptRef : public YYObjectBase
{
public:
	void* m_unk;
	void* m_unk2;
	void* m_unk3;
	void* m_unk4;
	void* m_unk5;
	void* m_self;
	void* m_unk7;

public:
	CScript* m_call_script;
};
