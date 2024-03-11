#pragma once

#include "YYObjectBase.hpp"

#include <string>

struct vec3
{
	float x, y, z;
};

struct vec4
{
	float x, y, z, w;
};

struct matrix44
{
	vec4 m[4];
};

constexpr int MASK_TYPE_RVALUE = 0x0'ff'ff'ff;

enum RValueType : int
{
	REAL      = 0,
	STRING    = 1,
	ARRAY     = 2,
	PTR       = 3,
	VEC3      = 4,
	UNDEFINED = 5,
	OBJECT    = 6,
	_INT32    = 7,
	VEC4      = 8,
	MATRIX    = 9,
	_INT64    = 10,
	ACCESSOR  = 11,
	JSNULL    = 12,
	_BOOL     = 13,
	ITERATOR  = 14,
	REF       = 15,
	UNSET     = MASK_TYPE_RVALUE
};

typedef YYObjectBase* (*GetCtxStackTop)(void);
typedef void (*DetPotRoot)(YYObjectBase* _pContainer, YYObjectBase* _yy_object_baseect);
//extern GetCtxStackTop GetContextStackTop;
//extern DetPotRoot DeterminePotentialRoot;

struct RValue;
typedef void (*FREE_RVal_Pre)(RValue* p);
typedef void (*COPY_RValue_do__Post_t)(RValue* dest, RValue* src);
typedef void (*YYSetStr)(RValue* _pVal, const char* _pS);
typedef void (*YYCreStr)(RValue* _pVal, const char* _pS);
typedef char* (*YYDupStr)(const char* _pStr);
typedef RValue* (*ARRAYLVal)(RValue* _pV, int _index);

#define YYC_DELETE(a) delete a

class YYObjectBase;

template<typename T>
struct _RefFactory
{
	static T Alloc(T _thing, int _size)
	{
		return _thing;
	}

	static T Create(T _thing, int& _size)
	{
		_size = 0;
		return _thing;
	}

	static T Destroy(T _thing)
	{
		return _thing;
	}
};

template<typename T>
struct _RefThing
{
	T m_thing;
	int m_refCount;
	int m_size;

	_RefThing(T _thing)
	{
		// this needs to have some sort of factory based on the type to do a duplicate
		m_thing    = _RefFactory<T>::Create(_thing, m_size);
		m_refCount = 0;
		inc();
	}

	_RefThing(int _maxSize)
	{
		// this needs to have some sort of factory based on the type to do a duplicate
		m_thing    = _RefFactory<T>::Alloc(m_thing, _maxSize);
		m_size     = _maxSize;
		m_refCount = 0;
		inc();
	}

	~_RefThing()
	{
		dec();
	}

	void inc()
	{
		++m_refCount;
	}

	void dec()
	{
		--m_refCount;
		if (m_refCount == 0)
		{
			// use the factory to clean it up and give us a default thing to use
			m_thing = _RefFactory<T>::Destroy(m_thing);
			m_size  = 0;

			YYC_DELETE(this);
		}
	}

	T get() const
	{
		return m_thing;
	}

	int size() const
	{
		return m_size;
	}

	static _RefThing<T>* assign(_RefThing<T>* _other)
	{
		if (_other != nullptr)
		{
			_other->inc();
		}

		return _other;
	}

	static _RefThing<T>* remove(_RefThing<T>* _other)
	{
		if (_other != nullptr)
		{
			_other->dec();
		}

		return nullptr;
	}
};

typedef _RefThing<const char*> RefString;

struct RefDynamicArrayOfRValue;

#pragma pack(push, 4)

struct DValue
{
	union
	{
		int64_t __64;
		void* __ptr;
		RefDynamicArrayOfRValue* __arr;
		YYObjectBase* __obj;
	};

	unsigned int flags;
	unsigned int type;
};

struct RValue
{
	union
	{
		// values.
		int i32;
		long long i64;
		double value;

		// pointers.
		void* ptr;
		RefString* ref_string;
		RefDynamicArrayOfRValue* ref_array;
		YYObjectBase* yy_object_base;
		vec4* vec4;
		matrix44* matrix44;
	};

	// use for flags (Hijack for Enumerable and Configurable bits in JavaScript)
	int flags;
	// kind of value
	RValueType type;

	void __localFree(void);
	void __localCopy(const RValue& v);

	~RValue();

	RValue();
	RValue(const RValue& v);

	RValue(double v);
	RValue(float v);
	RValue(int v);
	RValue(long long v);
	RValue(bool v);
	RValue(std::nullptr_t);
	RValue(std::nullptr_t, bool undefined);
	RValue(void* v);
	RValue(YYObjectBase* obj);
	RValue(RefDynamicArrayOfRValue* arr);
	RValue(const char* v);
	RValue(std::string v);
	RValue(std::wstring v);

	RValue operator-();
	RValue operator+();

	RValue& operator=(const RValue& v);
	RValue& operator=(double v);
	RValue& operator=(float v);
	RValue& operator=(int v);
	RValue& operator=(long long v);
	RValue& operator=(void* v);
	RValue& operator=(bool v);
	RValue& operator=(const char* v);
	RValue& operator=(std::string v);
	RValue& operator=(std::wstring v);

	RValue& operator++();
	RValue operator++(int);

	RValue& operator--();
	RValue operator--(int);

	bool operator==(const RValue& rhs) const;
	bool operator!=(const RValue& rhs) const;

	RValue* DoArrayIndex(const int _index);
	RValue* operator[](const int _index);

	std::string asString();
	double asReal() const;
	int asInt32() const;
	bool asBoolean() const;
	long long asInt64() const;
	void* asPointer() const;
	YYObjectBase* asObject() const;
	bool isNumber() const;
	bool isUnset() const;
	bool isArray() const;

	operator double() const;
	operator int() const;
	operator long long() const;
	operator bool() const;
	operator std::string();
	operator void*() const;
};

#pragma pack(pop)

struct RefDynamicArrayOfRValue : YYObjectBase
{
	int m_refCount;
	int m_flags; // flag set = is readonly for example
	RValue* m_Array;
	void* m_Owner;
	int visited;
	int length;

	using value_type = RValue;
	using iterator   = RValue*;
	using reference  = RValue&;
	using size_type  = int;

	iterator begin()
	{
		return iterator(m_Array);
	}

	iterator end()
	{
		return iterator(m_Array + length);
	}

	size_type size() const noexcept
	{
		return length;
	}

	size_type max_size() const noexcept
	{
		return length;
	}

	bool empty() const noexcept
	{
		return length == 0;
	}
};

// 136
static constexpr auto RefDynamicArrayOfRValue_offset_ref_count = offsetof(RefDynamicArrayOfRValue, m_refCount);
// 144
static constexpr auto RefDynamicArrayOfRValue_offset_array = offsetof(RefDynamicArrayOfRValue, m_Array);
// 152
static constexpr auto RefDynamicArrayOfRValue_offset_owner = offsetof(RefDynamicArrayOfRValue, m_Owner);
// 164
static constexpr auto RefDynamicArrayOfRValue_offset_length = offsetof(RefDynamicArrayOfRValue, length);
