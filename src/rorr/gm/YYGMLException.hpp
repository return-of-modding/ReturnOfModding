#pragma once
#include "RValue.hpp"

struct CInstance;

class YYGMLException
{
public:
	char m_object[sizeof RValue];

	inline YYGMLException(CInstance* _pSelf, CInstance* _pOther, const char* _pMessage, const char* _pLongMessage, const char* _filename, int _line, const char** ppStackTrace, int numLines)
	{
	}

	inline YYGMLException(const RValue& _val)
	{
		RValue copy{_val};
		std::memcpy(&m_object, &copy, sizeof(m_object)); // raw copy...
		std::memset(&copy, 0, sizeof(copy));             // prevent copy from getting destructed...
		// initializing an RValue to all bits zero will make it a real number 0.0, which is fine.
	}

	inline const RValue& GetExceptionObject() const
	{
		return *reinterpret_cast<const RValue*>(&m_object);
	}
};
