#pragma once
#include <cstddef>
#include <cstdint>

namespace gm
{
	namespace MemoryManager
	{
		using ReAlloc = uintptr_t (*)(uintptr_t Block, std::size_t Size);
	}
} // namespace gm
