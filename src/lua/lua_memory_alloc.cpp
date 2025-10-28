#include "lua/lua_memory_alloc.hpp"

tlsf_t g_lua_tlsf_pool;
size_t g_lua_tlsf_used_size = 0;
size_t g_tlsf_pool_size     = 1ULL * 1024 * 1024 * 1024; // 1 GB

void* lua_custom_alloc(void* ud, void* ptr, size_t osize, size_t nsize)
{
	(void)ud;
	if (nsize == 0)
	{
		if (ptr)
		{
			size_t block_size     = tlsf_block_size(ptr);
			g_lua_tlsf_used_size -= block_size;
		}

		tlsf_free(g_lua_tlsf_pool, ptr);
		return NULL;
	}
	else
	{
		void* new_ptr = tlsf_realloc(g_lua_tlsf_pool, ptr, nsize);

		if (new_ptr)
		{
			if (ptr)
			{
				size_t old_size       = tlsf_block_size(ptr);
				g_lua_tlsf_used_size -= old_size;
			}

			g_lua_tlsf_used_size += tlsf_block_size(new_ptr);
		}

		return new_ptr;
	}
}
