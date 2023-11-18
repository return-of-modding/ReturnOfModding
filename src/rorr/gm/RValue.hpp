#pragma once
#include "RVKind.hpp"
#include "RefThing.hpp"

struct YYObjectBase;
struct CInstance;

template<typename T>
struct CDynamicArrayRef;
struct RefDynamicArrayOfRValue;

#pragma pack(push, 4)
// Base class with no overloading, just a pure RValue.
struct RValue
{
	union {
		double Real;
		int I32;
		long long I64;

		// Pointers
		union {
			YYObjectBase* Object;
			CInstance* Instance;
			RefString* String;
			CDynamicArrayRef<RValue>* EmbeddedArray;
			RefDynamicArrayOfRValue* RefArray;
			void* Pointer;
		};
	};

	int Flags;
	RVKind Kind;

	inline RValue() noexcept(true)
	{
		// Just set it to unset and zero out the whole 8-byte space.
		// Check it on https://godbolt.org/, it's true!
		this->Kind  = VALUE_UNSET;
		this->Flags = 0;
		this->Real  = 0.0;
	}

	inline RValue(const double& Value) noexcept(true)
	{
		this->Kind  = VALUE_REAL;
		this->Flags = 0;
		this->Real  = Value;
	}

	inline RValue(const char* Value) noexcept(true)
	{
		this->Kind   = VALUE_STRING;
		this->Flags  = 0;
		this->String = RefString::Alloc(Value, strlen(Value) + 1);
	}

	inline RValue(const std::string& Value) noexcept(true)
	{
		this->Kind   = VALUE_STRING;
		this->Flags  = 0;
		this->String = RefString::Alloc(Value.c_str(), Value.length() + 1);
	}

	inline const char* get_string() const
	{
		return String->m_Thing;
	}

	inline void set_string(const char* new_value)
	{
		this->String = RefString::Alloc(new_value, strlen(new_value) + 1);
	}
};
#pragma pack(pop)