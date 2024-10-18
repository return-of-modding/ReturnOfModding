#pragma once
#include "lua_module_ext.hpp"

#include <rorr/gm/CCode.hpp>
#include <rorr/gm/CInstance.hpp>
#include <rorr/gm/RValue.hpp>

namespace big::lua_manager_extension
{
	void init_lua_base(sol::state_view& state);
	void init_lua_api(sol::state_view& state, sol::table& lua_ext);

	bool pre_code_execute(CInstance* self, CInstance* other, CCode* code, RValue* result, int flags);
	void post_code_execute(CInstance* self, CInstance* other, CCode* code, RValue* result, int flags);

	bool pre_code_execute_fast(void* original_func_ptr, CInstance* self, CInstance* other);
	void post_code_execute_fast(void* original_func_ptr, CInstance* self, CInstance* other);

	bool pre_builtin_execute(void* original_func_ptr, CInstance* self, CInstance* other, RValue* result, int arg_count, RValue* args);
	void post_builtin_execute(void* original_func_ptr, CInstance* self, CInstance* other, RValue* result, int arg_count, RValue* args);

	bool pre_script_execute(void* original_func_ptr, CInstance* self, CInstance* other, RValue* result, int arg_count, RValue** args);
	void post_script_execute(void* original_func_ptr, CInstance* self, CInstance* other, RValue* result, int arg_count, RValue** args);
} // namespace big::lua_manager_extension
