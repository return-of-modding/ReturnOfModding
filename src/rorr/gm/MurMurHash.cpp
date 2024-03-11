#include "MurMurHash.hpp"

#include <memory.h>

using uint32_t = unsigned int;

uint32_t Utils::Hash::MurMurHash(const unsigned char* key, int len, uint32_t seed)
{
	uint32_t c1            = 0xcc'9e'2d'51;
	uint32_t c2            = 0x1b'87'35'93;
	uint32_t r1            = 15;
	uint32_t r2            = 13;
	uint32_t m             = 5;
	uint32_t n             = 0xe6'54'6b'64;
	uint32_t h             = 0;
	uint32_t k             = 0;
	uint8_t* d             = (uint8_t*)key;
	const uint32_t* chunks = NULL;
	const uint8_t* tail    = NULL;
	int i                  = 0;
	int l                  = len / 4;

	h = seed;

	chunks = (const uint32_t*)(d + l * 4);
	tail   = (const uint8_t*)(d + l * 4);

	for (i = -l; i != 0; ++i)
	{
		k = chunks[i];

		k *= c1;
		k  = (k << r1) | (k >> (32 - r1));
		k *= c2;

		h ^= k;
		h  = (h << r2) | (h >> (32 - r2));
		h  = h * m + n;
	}

	k = 0;

	switch (len & 3)
	{
	case 3: k ^= (tail[2] << 16);
	case 2: k ^= (tail[1] << 8);

	case 1:
		k ^= tail[0];
		k *= c1;
		k  = (k << r1) | (k >> (32 - r1));
		k *= c2;
		h ^= k;
	}

	h ^= len;

	h ^= (h >> 16);
	h *= 0x85'eb'ca'6b;
	h ^= (h >> 13);
	h *= 0xc2'b2'ae'35;
	h ^= (h >> 16);

	return h;
}
