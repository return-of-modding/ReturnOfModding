#pragma once
#include <cstddef>
#include <cstdint>

namespace gm
{
	namespace MemoryManager
	{
		using ReAlloc = uintptr_t (*)(void* Block, std::size_t Size);
		using Free    = void (*)(void* Block);
	} // namespace MemoryManager
} // namespace gm
