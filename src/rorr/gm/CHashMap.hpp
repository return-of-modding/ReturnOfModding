#pragma once

#include "MurMurHash.hpp"

struct YYObjectBase;

template<typename Key, typename Value>
struct CHashMap
{
	int m_curSize;
	int m_numUsed;
	int m_curMask;
	int m_growThreshold;

	struct CElement
	{
		Value v;
		Key k;
		unsigned int Hash;
	}* m_pBuckets;

	bool FindElement(int hHash, Value& outValue)
	{
		int nIdealPos = m_curMask & hHash & 0x7f'ff'ff'ff;

		for (CElement node = m_pBuckets[nIdealPos]; node.Hash != 0; node = m_pBuckets[(++nIdealPos) & m_curMask & 0x7f'ff'ff'ff])
		{
			if (node.Hash == hHash)
			{
				outValue = node.v;
				return true;
			}
		}
		return false;
	}

	static unsigned int CalculateHash(int val)
	{
		return 0x9E'37'79'B1U * (unsigned int)val + 1;
	}

	static unsigned int CalculateHash(void* val)
	{
		return ((signed int)val >> 8) + 1;
	}

	static unsigned int CalculateHash(YYObjectBase* val)
	{
		return 7 * ((signed int)val >> 6) + 1;
	}

	static unsigned int CalculateHash(const char* val, size_t Len)
	{
		return Utils::Hash::MurMurHash((const unsigned char*)val, Len, 0);
	}
};
