#include "RValue.hpp"

#include "Code_Function_GET_the_function.hpp"
#include "pin_map.hpp"
#include "pointers.hpp"

#include <sstream>

static bool YYFree_valid_vkind(const unsigned int rvkind)
{
	return (((1 << STRING) | (1 << OBJECT) | (1 << ARRAY)) & (1 << (rvkind & 0x1f))) != 0;
}

void RValue::__localFree()
{
	if (YYFree_valid_vkind(type))
	{
		big::g_pointers->m_rorr.m_free_rvalue_pre(this);

		if ((type & MASK_TYPE_RVALUE) == ARRAY)
		{
			YYObjectPinMap::unpin(this->yy_object_base);
		}
	}
}

static void COPY_RValue__Post(RValue* dest, const RValue* source)
{
	dest->type  = source->type;
	dest->flags = source->flags;

	if (YYFree_valid_vkind(source->type))
	{
		big::g_pointers->m_rorr.m_copy_rvalue_do_post(dest, (RValue*)source);
	}
	else
	{
		dest->i64 = source->i64;
	}
}

void RValue::__localCopy(const RValue& other)
{
	if (&other != this)
	{
		DValue tmp{};
		memcpy(&tmp, &other, sizeof(RValue));

		bool is_array{(tmp.type & MASK_TYPE_RVALUE) == ARRAY};
		if (is_array)
		{
			++(reinterpret_cast<RValue*>(&tmp)->ref_array->m_refCount);
		}

		__localFree();

		if (is_array)
		{
			--(reinterpret_cast<RValue*>(&tmp)->ref_array->m_refCount);
		}

		COPY_RValue__Post(this, &other);

		if (is_array)
		{
			YYObjectPinMap::pin(this->yy_object_base);
		}
	}
}

RValue::~RValue()
{
	__localFree();
}

RValue::RValue()
{
	flags = 0;
	type  = UNDEFINED;
	i64   = 0L;
}

RValue::RValue(std::nullptr_t, bool undefined)
{
	flags = 0;
	type  = UNDEFINED;
	i64   = 0L;
}

RValue::RValue(const RValue& v)
{
	flags = 0;
	type  = UNDEFINED;
	i64   = 0L;

	__localCopy(v);
}

RValue::RValue(double v)
{
	flags = 0;
	type  = REAL;
	value = v;
}

RValue::RValue(float v)
{
	flags = 0;
	type  = REAL;
	value = v;
}

RValue::RValue(int v)
{
	flags = 0;
	type  = _INT32;
	i32   = v;
}

RValue::RValue(long long v)
{
	flags = 0;
	type  = _INT64;
	i64   = v;
}

RValue::RValue(bool v)
{
	flags = 0;
	type  = REAL;
	value = v ? 1.0 : 0.0;
}

RValue::RValue(std::nullptr_t)
{
	flags = 0;
	type  = PTR;
	ptr   = nullptr;
}

RValue::RValue(void* v)
{
	flags = 0;
	type  = PTR;
	ptr   = v;
}

RValue::RValue(YYObjectBase* obj)
{
	flags                = 0;
	type                 = OBJECT;
	this->yy_object_base = obj;
}

RValue::RValue(RefDynamicArrayOfRValue* arr)
{
	flags           = 0;
	type            = ARRAY;
	this->ref_array = arr;
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
	ret.type  = type;
	ret.flags = flags;
	switch ((type & MASK_TYPE_RVALUE))
	{
	case _BOOL:
	case REAL:   ret.value = -value; break;
	case _INT32: ret.i32 = -i32; break;
	case _INT64: ret.i64 = -i64; break;
	default:     LOG(ERROR) << "unhandled";
	}

	return ret;
}

RValue RValue::operator+()
{
	RValue copy(*this);
	return copy;
}

RValue& RValue::operator=(const RValue& other)
{
	__localCopy(other);
	return *this;
}

RValue& RValue::operator=(double v)
{
	__localFree();
	type  = REAL;
	value = v;
	return *this;
}

RValue& RValue::operator=(float v)
{
	__localFree();
	type  = REAL;
	value = v;
	return *this;
}

RValue& RValue::operator=(int v)
{
	__localFree();
	type = _INT32;
	i32  = v;
	return *this;
}

RValue& RValue::operator=(long long v)
{
	__localFree();
	type = _INT64;
	i64  = v;
	return *this;
}

RValue& RValue::operator=(void* v)
{
	__localFree();
	type = PTR;
	ptr  = v;
	return *this;
}

RValue& RValue::operator=(bool v)
{
	__localFree();
	type  = REAL;
	value = v ? 1.0 : 0.0;
	return *this;
}

RValue& RValue::operator=(const char* v)
{
	__localFree();

	flags = 0;
	big::g_pointers->m_rorr.m_yysetstring(this, v);

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
	switch (type & MASK_TYPE_RVALUE)
	{
	case _BOOL:
	case REAL:   ++value; break;
	case _INT32: ++i32; break;
	case _INT64: ++i64; break;
	case PTR:    ptr = reinterpret_cast<void*>(reinterpret_cast<char*>(ptr) + 1); break;
	default:     LOG(ERROR) << "unhandled";
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
	switch (type & MASK_TYPE_RVALUE)
	{
	case _BOOL:
	case REAL:   --value; break;
	case _INT32: --i32; break;
	case _INT64: --i64; break;
	case PTR:    ptr = reinterpret_cast<void*>(reinterpret_cast<char*>(ptr) - 1); break;
	default:     LOG(ERROR) << "unhandled";
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
	int lhsType = type & MASK_TYPE_RVALUE;
	int rhsType = rhs.type & MASK_TYPE_RVALUE;

	if (lhsType == STRING && rhsType == STRING)
	{
		return strcmp(ref_string->get(), rhs.ref_string->get()) == 0;
	}

	double lhsD = this->asReal();
	double rhsD = 0.0;
	switch (rhsType)
	{
	case REAL:
	case _BOOL:     rhsD = rhs.value; break;
	case _INT32:    rhsD = static_cast<double>(rhs.i32); break;
	case _INT64:    rhsD = static_cast<double>(rhs.i64); break;
	case ARRAY:
	case REF:
	case OBJECT:
	case PTR:       rhsD = static_cast<double>(reinterpret_cast<uintptr_t>(ptr)); break;
	case UNSET:
	case UNDEFINED: rhsD = std::nan(""); break;
	default:        LOG(ERROR) << "unhandled";
	}

	return lhsD == rhsD;
}

bool RValue::operator!=(const RValue& rhs) const
{
	return (!(operator==(rhs)));
}

RValue* RValue::DoArrayIndex(const int _index)
{
	if ((type & MASK_TYPE_RVALUE) == ARRAY && (ref_array != nullptr) && _index < ref_array->length)
	{
		return &ref_array->m_Array[_index];
	}
	else
	{
		LOG(ERROR) << "unhandled";
	}

	return nullptr;
}

RValue* RValue::operator[](const int _index)
{
	return DoArrayIndex(_index);
}

std::string RValue::asString()
{
	switch (type & MASK_TYPE_RVALUE)
	{
	case REAL:   return std::to_string(value);
	case _INT32: return std::to_string(i32);
	case _INT64: return std::to_string(i64);
	case REF:
	case PTR:
	{
		std::stringstream ss;
		ss << HEX_TO_UPPER(ptr);
		return ss.str();
	}
	case ARRAY:
	{
		if (this->ref_array->m_Array == nullptr)
		{
			return "{ <null array pointer> }";
		}
		int arrlen = this->ref_array->length;
		if (arrlen <= 0)
		{
			return "{ <empty array> }";
		}

		std::stringstream ss;

		ss << "{ ";
		for (int i = 0; i < arrlen; i++)
		{
			auto* elem = DoArrayIndex(i);
			if (elem)
			{
				if ((elem->type & MASK_TYPE_RVALUE) == STRING)
				{
					ss << '"';
				}
				ss << elem->asString();
				if ((elem->type & MASK_TYPE_RVALUE) == STRING)
				{
					ss << '"';
				}
				if (i < arrlen - 1)
				{
					ss << ", ";
				}
			}
		}
		ss << " }";

		return ss.str();
	}
	case _BOOL:     return (value > 0.5) ? "true" : "false";
	case UNSET:     return "<unset>";
	case UNDEFINED: return "<undefined>";
	case STRING:    return ref_string->get();
	default:        return "<UNHANDLED TYPE TO STRING!>";
	}

	return "";
}

double RValue::asReal() const
{
	switch (type & MASK_TYPE_RVALUE)
	{
	case REAL:
	case _BOOL:     return value;
	case UNDEFINED:
	case UNSET:     return std::nan("");
	case _INT32:    return static_cast<double>(i32);
	case _INT64:    return static_cast<double>(i64);
	case REF:       return (double)i32;
	case ARRAY:
	case OBJECT:
	case VEC4:
	case MATRIX:
	case VEC3:
	case PTR:       return static_cast<double>(reinterpret_cast<uintptr_t>(ptr));
	case STRING:
	{
		try
		{
			return std::stod(ref_string->get());
		}
		catch (...)
		{
		}
	}
	default: LOG(ERROR) << "unhandled " << (type & MASK_TYPE_RVALUE);
	}

	return std::nan("");
}

int RValue::asInt32() const
{
	switch (type & MASK_TYPE_RVALUE)
	{
	case REAL:
	case _BOOL:  return static_cast<int>(std::floor(value));
	case _INT32: return i32;
	case _INT64: return static_cast<int>(i64);
	case REF:    return i32;
	case ARRAY:
	case OBJECT:
	case VEC4:
	case MATRIX:
	case VEC3:
	case PTR:    return static_cast<int>(reinterpret_cast<intptr_t>(ptr));
	case STRING:
	{
		try
		{
			return std::stoi(ref_string->get());
		}
		catch (...)
		{
		}
	}
	default: LOG(ERROR) << "unhandled " << (type & MASK_TYPE_RVALUE);
	}

	return 0;
}

bool RValue::asBoolean() const
{
	switch (type & MASK_TYPE_RVALUE)
	{
	case REAL:
	case _BOOL:  return value > 0.5 ? true : false;
	case _INT32: return i32 > 0 ? true : false;
	case _INT64: return i64 > 0L ? true : false;
	case REF:    return i32 > 0 ? true : false;
	case ARRAY:
	case OBJECT:
	case VEC4:
	case MATRIX:
	case VEC3:
	case PTR:    return ptr != nullptr ? true : false;
	case STRING:
	{
		try
		{
			const std::string v = ref_string->get();
			if (v == "true" || v == "True")
			{
				return true;
			}
			else if (v == "false" || v == "False")
			{
				return false;
			}
			LOG(ERROR) << "unhandled";
		}
		catch (...)
		{
		}
	}
	default: LOG(ERROR) << "unhandled " << (type & MASK_TYPE_RVALUE);
	}

	return false;
}

long long RValue::asInt64() const
{
	switch (type & MASK_TYPE_RVALUE)
	{
	case REAL:
	case _BOOL:  return static_cast<long long>(std::floor(value));
	case _INT32: return static_cast<long long>(i32);
	case _INT64: return i64;
	case REF:    return static_cast<long long>(i32);
	case ARRAY:
	case PTR:    return static_cast<long long>(reinterpret_cast<uintptr_t>(ptr));
	case STRING:
	{
		try
		{
			return std::stoll(ref_string->get());
		}
		catch (...)
		{
		}
	}
	default: LOG(ERROR) << "unhandled " << (type & MASK_TYPE_RVALUE);
	}

	return 0;
}

bool RValue::isNumber() const
{
	int mtype = type & MASK_TYPE_RVALUE;
	return (mtype == REAL || mtype == _INT32 || mtype == _INT64 || mtype == _BOOL);
}

bool RValue::isUnset() const
{
	return type == UNSET;
}

bool RValue::isArray() const
{
	return (type & MASK_TYPE_RVALUE) == ARRAY;
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
	switch (type & MASK_TYPE_RVALUE)
	{
	case REAL:
	case _BOOL:  return reinterpret_cast<void*>(static_cast<uintptr_t>(std::floor(value)));
	case _INT32: return reinterpret_cast<void*>(static_cast<uintptr_t>(i32));
	case _INT64: return reinterpret_cast<void*>(static_cast<uintptr_t>(i64));
	case ARRAY:
	case REF:
	case OBJECT:
	case VEC3:
	case VEC4:
	case MATRIX:
	case PTR:    return ptr;
	default:     LOG(ERROR) << "unhandled";
	}

	return nullptr;
}

YYObjectBase* RValue::asObject() const
{
	return yy_object_base;
}

RValue::operator void*() const
{
	return asPointer();
}
