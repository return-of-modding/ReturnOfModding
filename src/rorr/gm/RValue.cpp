#include "RValue.hpp"

#include "pointers.hpp"

#include <sstream>

void RValue::__localFree()
{
	if (((kind - 1) & (MASK_KIND_RVALUE & (~PTR))) == 0)
	{
		//big::g_pointers->m_rorr.m_free_rvalue_pre(this);
	}
}

void RValue::__localCopy(const RValue& v)
{
	this->kind  = v.kind;
	this->flags = v.flags;

	switch (v.kind & MASK_KIND_RVALUE)
	{
	case _BOOL:
	case REAL: this->real = v.real; break;
	case _INT32: this->v32 = v.v32; break;
	case _INT64: this->v64 = v.v64; break;
	case PTR:
	case ITERATOR: this->ptr = v.ptr; break;
	case ARRAY:
		this->pRefArray = v.pRefArray;
		if (this->pRefArray != nullptr)
		{
			//++this->pRefArray->m_refCount;
			//this->pRefArray->m_Owner = this;
		}
		break;
	case STRING: this->pRefString = RefString::assign(v.pRefString); break;
	case OBJECT:
		this->pObj = v.pObj;

		if (this->pObj != nullptr)
		{
			LOG(FATAL) << "unhandled;";
			//YYObjectBase* pContainer = GetContextStackTop();
			//DeterminePotentialRoot(pContainer, v.pObj);
		}
		break;
	case REF: this->v64 = v.v64; break;
	}
}

RValue::~RValue()
{
	__localFree();
	flags = 0;
	kind  = UNSET;
	v64   = 0L;
}

RValue::RValue()
{
	flags = 0;
	kind  = UNSET;
	v64   = 0L;
}

RValue::RValue(std::nullptr_t, bool undefined)
{
	flags = 0;
	kind  = UNDEFINED;
	v64   = 0L;
}

RValue::RValue(const RValue& v)
{
	__localCopy(v);
}

RValue::RValue(double v)
{
	flags = 0;
	kind  = REAL;
	real  = v;
}

RValue::RValue(float v)
{
	flags = 0;
	kind  = REAL;
	real  = v;
}

RValue::RValue(int v)
{
	flags = 0;
	kind  = _INT32;
	v32  = v;
}

RValue::RValue(long long v)
{
	flags = 0;
	kind  = _INT64;
	v64   = v;
}

RValue::RValue(bool v)
{
	flags = 0;
	kind  = REAL;
	real  = v ? 1.0 : 0.0;
}

RValue::RValue(std::nullptr_t)
{
	flags = 0;
	kind  = PTR;
	ptr   = nullptr;
}

RValue::RValue(void* v)
{
	flags = 0;
	kind  = PTR;
	ptr   = v;
}

RValue::RValue(const char* v)
{
	flags = 0;
	big::g_pointers->m_rorr.m_yysetstring(this, v);
}

RValue::RValue(std::string v)
{
	flags = 0;
	big::g_pointers->m_rorr.m_yysetstring(this, v.c_str());
}

RValue::RValue(std::wstring v)
{
	flags      = 0;
	int __size = WideCharToMultiByte(CP_UTF8, 0, v.c_str(), -1, nullptr, 0, nullptr, nullptr);
	char* s    = new char[__size];

	WideCharToMultiByte(CP_UTF8, 0, v.c_str(), -1, s, __size, nullptr, nullptr);

	big::g_pointers->m_rorr.m_yysetstring(this, s);
	delete[] s;
	s = nullptr;
}

RValue RValue::operator-()
{
	RValue ret;
	ret.kind  = kind;
	ret.flags = flags;
	switch ((kind & MASK_KIND_RVALUE))
	{
	case _BOOL:
	case REAL: ret.real = -real; break;
	case _INT32: ret.v32 = -v32; break;
	case _INT64: ret.v64 = -v64; break;
	default: LOG(FATAL) << "unhandled";
	}

	return ret;
}

RValue RValue::operator+()
{
	RValue copy(*this);
	return copy;
}

RValue& RValue::operator=(const RValue& v)
{
	if (&v != this)
	{
		RValue temp;
		memcpy(&temp, &v, sizeof(RValue));

		bool is_array = (temp.kind & MASK_KIND_RVALUE) == ARRAY;
		if (is_array)
			++(temp.pRefArray->m_refCount);

		__localFree();

		if (is_array)
			--(temp.pRefArray->m_refCount);

		__localCopy(temp);
	}

	return *this;
}

RValue& RValue::operator=(double v)
{
	__localFree();
	kind = REAL;
	real = v;
	return *this;
}

RValue& RValue::operator=(float v)
{
	__localFree();
	kind = REAL;
	real = v;
	return *this;
}

RValue& RValue::operator=(int v)
{
	__localFree();
	kind = _INT32;
	v32 = v;
	return *this;
}

RValue& RValue::operator=(long long v)
{
	__localFree();
	kind = _INT64;
	v64  = v;
	return *this;
}

RValue& RValue::operator=(void* v)
{
	__localFree();
	kind = PTR;
	ptr  = v;
	return *this;
}

RValue& RValue::operator=(bool v)
{
	__localFree();
	kind = REAL;
	real = v ? 1.0 : 0.0;
	return *this;
}

RValue& RValue::operator=(const char* v)
{
	__localFree();
	return *this;
}

RValue& RValue::operator=(std::string v)
{
	return operator=(v.c_str());
}

RValue& RValue::operator=(std::wstring v)
{
	flags      = 0;
	int __size = WideCharToMultiByte(CP_UTF8, 0, v.c_str(), -1, nullptr, 0, nullptr, nullptr);
	LPSTR s    = new CHAR[__size];

	WideCharToMultiByte(CP_UTF8, 0, v.c_str(), -1, s, __size, nullptr, nullptr);
	RValue& ret(operator=(s));
	delete[] s;
	s = nullptr;

	return ret;
}

RValue& RValue::operator++()
{
	switch (kind & MASK_KIND_RVALUE)
	{
	case _BOOL:
	case REAL: ++real; break;
	case _INT32: ++v32; break;
	case _INT64: ++v64; break;
	case PTR: ptr = reinterpret_cast<void*>(reinterpret_cast<char*>(ptr) + 1); break;
	default: LOG(FATAL) << "unhandled";
	}
	return *this;
}

RValue RValue::operator++(int)
{
	RValue tmp(*this);
	operator++();
	return tmp;
}

RValue& RValue::operator--()
{
	switch (kind & MASK_KIND_RVALUE)
	{
	case _BOOL:
	case REAL: --real; break;
	case _INT32: --v32; break;
	case _INT64: --v64; break;
	case PTR: ptr = reinterpret_cast<void*>(reinterpret_cast<char*>(ptr) - 1); break;
	default: LOG(FATAL) << "unhandled";
	}
	return *this;
}

RValue RValue::operator--(int)
{
	RValue tmp(*this);
	operator--();
	return tmp;
}

bool RValue::operator==(const RValue& rhs) const
{
	int lhsType = kind & MASK_KIND_RVALUE;
	int rhsType = rhs.kind & MASK_KIND_RVALUE;

	if (lhsType == STRING && rhsType == STRING)
		return strcmp(pRefString->get(), rhs.pRefString->get()) == 0;

	double lhsD = this->asReal();
	double rhsD = 0.0;
	switch (rhsType)
	{
	case REAL:
	case _BOOL: rhsD = rhs.real; break;
	case _INT32: rhsD = static_cast<double>(rhs.v32); break;
	case _INT64: rhsD = static_cast<double>(rhs.v64); break;
	case PTR: rhsD = static_cast<double>(reinterpret_cast<uintptr_t>(ptr)); break;
	case UNSET:
	case UNDEFINED: rhsD = std::nan(""); break;
	default: LOG(FATAL) << "unhandled";
	}

	return lhsD == rhsD;
}

bool RValue::operator!=(const RValue& rhs) const
{
	return (!(operator==(rhs)));
}

RValue* RValue::DoArrayIndex(const int _index)
{
	if ((kind & MASK_KIND_RVALUE) == ARRAY && (pRefArray != nullptr) && _index < pRefArray->length)
	{
		if (pRefArray->m_Owner == nullptr)
		{
			pRefArray->m_Owner = this;

			return &pRefArray->m_Array[_index];
		}
		else
		{
			LOG(FATAL) << "unhandled";
		}
	}
	else
	{
		LOG(FATAL) << "unhandled";
	}

	return nullptr;
}

RValue* RValue::operator[](const int _index)
{
	return DoArrayIndex(_index);
}

std::string RValue::asString()
{
	switch (kind & MASK_KIND_RVALUE)
	{
	case REAL: return std::to_string(real);
	case _INT32: return std::to_string(v32);
	case _INT64: return std::to_string(v64);
	case PTR:
	{
		char buf[32] = {'\0'};
		memset(buf, 0, sizeof(buf));
		std::snprintf(buf, sizeof(buf), "%p", ptr);
		return std::string(buf);
	}
	case ARRAY:
	{
		// WARNING: A VERY VERY VERY HORRIBLE IMPLEMENTATION!!

		if (this->pRefArray->m_Array == nullptr)
			return "{ <empty array pointer> }";
		int arrlen = this->pRefArray->length;
		if (arrlen <= 0)
			return "{ <empty array> }";

		std::stringstream ss;

		ss << "{ ";
		for (int i = 0; i < arrlen; i++)
		{
			auto* elem = DoArrayIndex(i);
			ss << '"' << i << "\": ";
			if ((elem->kind & MASK_KIND_RVALUE) == STRING)
				ss << '"';
			ss << elem->asString();
			if ((elem->kind & MASK_KIND_RVALUE) == STRING)
				ss << '"';
			if (i < arrlen - 1)
				ss << ", ";
		}
		ss << " }";

		return ss.str();
	}
	case _BOOL: return (real > 0.5) ? "true" : "false";
	case UNSET: return "<unset>"; // ??????????
	case UNDEFINED: return "<undefined>";
	case STRING: return pRefString->get();
	default: LOG(FATAL) << "unhandled";
	}

	return "";
}

double RValue::asReal() const
{
	switch (kind & MASK_KIND_RVALUE)
	{
	case REAL:
	case _BOOL: return real;
	case UNDEFINED:
	case UNSET: return std::nan("");
	case _INT32: return static_cast<double>(v32);
	case _INT64: return static_cast<double>(v64);
	case PTR: return static_cast<double>(reinterpret_cast<uintptr_t>(ptr));
	case STRING:
	{
		try
		{
			return std::stod(pRefString->get());
		}
		catch (...)
		{
			return std::nan("");
		}
	}
	default: LOG(FATAL) << "unhandled";
	}

	return 0.0;
}

int RValue::asInt32() const
{
	switch (kind & MASK_KIND_RVALUE)
	{
	case REAL:
	case _BOOL: return static_cast<int>(std::floor(real));
	case _INT32: return v32;
	case _INT64: return static_cast<int>(v64);
	case PTR: return static_cast<int>(reinterpret_cast<intptr_t>(ptr));
	case STRING:
	{
		try
		{
			return std::stoi(pRefString->get());
		}
		catch (...)
		{
			LOG(FATAL) << "unhandled";
		}
	}
	default: LOG(FATAL) << "unhandled";
	}

	return 0;
}

bool RValue::asBoolean() const
{
	switch (kind & MASK_KIND_RVALUE)
	{
	case REAL:
	case _BOOL: return real > 0.5 ? true : false;
	case _INT32: return v32 > 0 ? true : false;
	case _INT64: return v64 > 0L ? true : false;
	case PTR: return ptr != nullptr ? true : false;
	case STRING:
	{
		try
		{
			const std::string v = pRefString->get();
			if (v == "true" || v == "True")
				return true;
			else if (v == "false" || v == "False")
				return false;
			LOG(FATAL) << "unhandled";
		}
		catch (...)
		{
			LOG(FATAL) << "unhandled";
		}
	}
	default: LOG(FATAL) << "unhandled";
	}

	return false;
}

long long RValue::asInt64() const
{
	switch (kind & MASK_KIND_RVALUE)
	{
	case REAL:
	case _BOOL: return static_cast<long long>(std::floor(real));
	case _INT32: return static_cast<long long>(v32);
	case _INT64: return v64;
	case PTR: return static_cast<long long>(reinterpret_cast<uintptr_t>(ptr));
	case STRING:
	{
		try
		{
			return std::stoll(pRefString->get());
		}
		catch (...)
		{
			LOG(FATAL) << "unhandled";
		}
	}
	default: LOG(FATAL) << "unhandled";
	}

	return 0;
}

bool RValue::isNumber() const
{
	int mKind = kind & MASK_KIND_RVALUE;
	return (mKind == REAL || mKind == _INT32 || mKind == _INT64 || mKind == _BOOL);
}

bool RValue::isUnset() const
{
	return kind == UNSET;
}

bool RValue::isArray() const
{
	return (kind & MASK_KIND_RVALUE) == ARRAY;
}

RValue::operator bool() const
{
	return asBoolean();
}

RValue::operator long long() const
{
	return asInt64();
}

RValue::operator int() const
{
	return asInt32();
}

RValue::operator double() const
{
	return asReal();
}

RValue::operator std::string()
{
	return asString();
}

void* RValue::asPointer() const
{
	switch (kind & MASK_KIND_RVALUE)
	{
	case REAL:
	case _BOOL: return reinterpret_cast<void*>(static_cast<uintptr_t>(std::floor(real)));
	case _INT32: return reinterpret_cast<void*>(static_cast<uintptr_t>(v32));
	case _INT64: return reinterpret_cast<void*>(static_cast<uintptr_t>(v64));
	case PTR: return ptr;
	default: abort();
	}
}

RValue::operator void*() const
{
	return asPointer();
}

const RefDynamicArrayOfRValue* RValue::asArray() const
{
	if ((kind & MASK_KIND_RVALUE) == ARRAY)
		return pRefArray;
	else
		LOG(FATAL) << "unhandled";

	return nullptr;
}