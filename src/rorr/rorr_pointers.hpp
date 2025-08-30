#pragma once
#include "gm/CInstance_hooks.hpp"
#include "gm/Code_Execute.hpp"
#include "gm/Code_Function_GET_the_function_t.hpp"
#include "gm/CRoom.hpp"
#include "gm/debug_console.hpp"
#include "gm/GetSaveFileName_t.hpp"
#include "gm/inputs.hpp"
#include "gm/RVariableRoutine.hpp"
#include "gm/save_file_serialize_t.hpp"
#include "gm/Script_Data.hpp"
#include "gm/StructCreate.hpp"
#include "gm/YYShader.hpp"
#include "gm/MemoryManager.hpp"
#include "gm/YYSetScriptRef.hpp"

#include <memory/handle.hpp>

namespace big
{
	// needed for serialization of the pointers cache
#pragma pack(push, 1)

	struct rorr_pointers
	{
		int* m_gamemaker_version_major;

		gm::Code_Function_GET_the_function_t m_code_function_GET_the_function;
		int* m_code_function_GET_the_function_function_count;

		gm::Code_Execute m_code_execute;

		gm::RVariableRoutine* m_builtin_variables;
		int* m_builtin_variable_count;

		gm::CRoom** m_croom;

		gm::CInstance_ctor m_cinstance_ctor;
		gm::CInstance_dctor m_cinstance_dctor;

		gm::CObjectGM_AddInstance m_cobjectgm_add_instance;
		gm::CObjectGM_RemoveInstance m_cobjectgm_remove_instance;

		YYSetStr m_yysetstring;

		FREE_RVal_Pre m_free_rvalue_pre;
		COPY_RValue_do__Post_t m_copy_rvalue_do_post;
		GCCollectHint_t m_GCCollectHint;

		gm::debug_console_output_t m_debug_console_output;

		gm::IO_UpdateM_t m_io_update_m;

		gm::Script_Data_t m_script_data;

		gm::StructCreate_t m_struct_create;

		YYShader*** m_shader_pool;
		int *m_shader_amount;
		YYNativeShader*** m_native_shader_pool;
		int *m_native_shader_amount;

		gm::ShaderCreate_t m_shader_create;
		gm::NativeShaderCreate_t m_native_shader_create;
		gm::GenShaderDataHeader_t m_gen_shader_data_header;
		gm::NativeShaderGenCBuf_t m_native_shader_gen_cbuf;
		gm::FreeShaderDataHeader_t m_free_shader_data_header;

		gm::MemoryManager::ReAlloc m_memorymanager_realloc;
		gm::MemoryManager::Free m_memorymanager_free;
		gm::MemoryManager::Alloc m_memorymanager_alloc;

		gm::GetSaveFileName_t m_get_save_file_name;

		gm::save_file_serialize_t m_save_file_serialize;
		gm::save_file_deserialize_t m_save_file_deserialize;
		gm::json_parse_t m_json_parse;

		YYGMLFuncs* m_GMLFuncs;

		YYSetScriptRef_t m_YYSetScriptRef;

		void* m_CreateSwapChain;
	};

#pragma pack(pop)
	static_assert(sizeof(rorr_pointers) % 8 == 0, "Pointers are not properly aligned");
} // namespace big
