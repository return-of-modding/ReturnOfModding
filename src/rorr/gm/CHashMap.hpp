#pragma once

#include <cstddef>
#include <iterator>
#include "MurMurHash.hpp"
#include "xutility"

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

	using key_type = Key;
	using mapped_type = Value;
	using value_type = CElement;
	using size_type = int;

	template<bool is_const>
	struct TIterator {
		using iterator_concept = std::forward_iterator_tag;
		using iterator_category = std::forward_iterator_tag;
		using value_type = CElement;
		using difference_type = std::ptrdiff_t;
		using pointer = std::conditional_t<is_const, const value_type*, value_type*>;
		using reference = std::conditional_t<is_const, const value_type&, value_type&>;

		TIterator() : m_current(nullptr), m_end(nullptr){};
		template<bool other_const>
		TIterator(const TIterator<other_const>& rhs) requires (is_const && !other_const) : m_current(rhs.m_current), m_end(rhs.m_end) {}
		TIterator(pointer curr, pointer end) : m_current(curr), m_end(end){
			move_to_valid();
		};
		reference operator*() const {
			return *m_current;
		}
		pointer operator->() const {
			return m_current;
		}
		TIterator& operator++(){
			m_current++;
			move_to_valid();
			return *this;
		}
		TIterator operator++(int){
			TIterator tmp = *this;
			++(*this);
			return tmp;
		}
		friend bool operator==(const TIterator& lhs, const TIterator& rhs)
		{
			return lhs.m_current == rhs.m_current;
		}
		private:
			void move_to_valid()
			{
				while (m_current < m_end && m_current->Hash == 0)
				{
					m_current++;
				}
			}
			pointer m_current, m_end;
	};

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

	using iterator = TIterator<false>;
	using const_iterator = TIterator<true>;

	size_type size() const { return m_numUsed;}
	iterator begin(){
		return iterator(m_pBuckets, m_pBuckets + m_curSize);
	}
	const_iterator begin() const {
		return const_iterator(m_pBuckets, m_pBuckets + m_curSize);
	}
	const_iterator cbegin() const {
		return begin();
	}
	iterator end(){
		return iterator(m_pBuckets + m_curSize, m_pBuckets + m_curSize);
	}
	const_iterator end() const {
		return const_iterator(m_pBuckets + m_curSize, m_pBuckets + m_curSize);
	}
	const_iterator cend() const {
		return end();
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
