#pragma once

#include "EJSRetValBool.hpp"

struct RValue;
struct CWeakRef;
struct CCode;

template<typename Key, typename Value>
struct CHashMap;

struct CInstanceBase
{
	RValue* yyvars;
	virtual ~CInstanceBase() = 0;

	virtual RValue& InternalGetYYVarRef(int index)  = 0;
	virtual RValue& InternalGetYYVarRefL(int index) = 0;
};

enum class YYObjectBaseType : int
{
	YYOBJECTBASE = 0,
	CINSTANCE,
	ACCESSOR,
	SCRIPTREF,
	PROPERTY,
	ARRAY,
	WEAKREF,

	CONTAINER,

	SEQUENCE,
	SEQUENCEINSTANCE,
	SEQUENCETRACK,
	SEQUENCECURVE,
	SEQUENCECURVECHANNEL,
	SEQUENCECURVEPOINT,
	SEQUENCEKEYFRAMESTORE,
	SEQUENCEKEYFRAME,
	SEQUENCEKEYFRAMEDATA,
	SEQUENCEEVALTREE,
	SEQUENCEEVALNODE,
	SEQUENCEEVENT,

	NINESLICE,

	MAX
};

struct YYObjectBase : CInstanceBase
{
	virtual bool Mark4GC(unsigned int* _pM, int _numObjects)             = 0;
	virtual bool MarkThisOnly4GC(unsigned int* _pM, int _numObjects)     = 0;
	virtual bool MarkOnlyChildren4GC(unsigned int* _pM, int _numObjects) = 0;
	virtual void Free(bool preserve_map)                                 = 0;
	virtual void ThreadFree(bool preserve_map, void* _pGCContext)        = 0;
	virtual void PreFree()                                               = 0;

	YYObjectBase* m_pNextObject;
	YYObjectBase* m_pPrevObject;
	YYObjectBase* m_prototype;
	//void* m_pcre;
	//void* m_pcreExtra;
	const char* m_class;
	void (*m_getOwnProperty)(YYObjectBase* obj, RValue* val, const char* name);
	void (*m_deleteProperty)(YYObjectBase* obj, RValue* val, const char* name, bool dothrow);
	EJSRetValBool (*m_defineOwnProperty)(YYObjectBase* obj, const char* name, RValue* val, bool dothrow);
	CHashMap<int, RValue*>* m_yyvarsMap;
	CWeakRef** m_pWeakRefs;
	unsigned int m_numWeakRefs;
	unsigned int m_nvars;
	unsigned int m_flags;
	unsigned int m_capacity;
	unsigned int m_visited;
	unsigned int m_visitedGC;
	int m_GCgen;
	int m_GCcreationframe;
	int m_slot;            // offset 30(int) | 120(byte)
	YYObjectBaseType type; // m_kind
	int m_rvalueInitType;
	int m_curSlot;
};

// 120
static constexpr auto YYObjectBase_offset_slot = offsetof(YYObjectBase, m_slot);
// 124
static constexpr auto YYObjectBase_offset_type = offsetof(YYObjectBase, type);

struct CWeakRef : YYObjectBase
{
	YYObjectBase* pWeakRef;
};
