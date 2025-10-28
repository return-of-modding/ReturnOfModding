#include <tlsf/tlsf.hpp>

extern tlsf_t g_lua_tlsf_pool;
extern size_t g_lua_tlsf_used_size;
extern size_t g_tlsf_pool_size;

void* lua_custom_alloc(void* ud, void* ptr, size_t osize, size_t nsize);
