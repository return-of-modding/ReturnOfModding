#pragma once
#include <cstddef>
#include <cstdint>

namespace gm
{
	namespace MemoryManager
	{
		using ReAlloc = void* (*)(void* Block, std::size_t Size);
		using Free    = void (*)(void* Block);
		using Alloc = void*(*)(size_t Size, const char * a1, int64_t a2, bool zero_fill);// a1 and a2 seem useless
	} // namespace MemoryManager
} // namespace gm
