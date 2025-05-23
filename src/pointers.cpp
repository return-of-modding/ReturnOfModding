#include "pointers.hpp"

#include "hooks/hooking.hpp"
#include "memory/all.hpp"
#include "rorr/rorr_pointers_layout_info.hpp"

namespace big
{
	constexpr auto pointers::get_rorr_batch()
	{
		// clang-format off

        constexpr auto batch_and_hash = memory::make_batch<
        // Game Maker Version
        {
            "GMV",
            "E8 ? ? ? ? 48 39 35",
            [](memory::handle ptr)
            {
                g_pointers->m_rorr.m_gamemaker_version_major = ptr.sub(15).as<int*>();
            }
        },
		// Code_Function_GET_the_function
        {
            "CFGTF",
            "3B 0D ? ? ? ? 7F 3F",
            [](memory::handle ptr)
            {
                g_pointers->m_rorr.m_code_function_GET_the_function = ptr.as<gm::Code_Function_GET_the_function_t>();
                g_pointers->m_rorr.m_code_function_GET_the_function_function_count = ptr.add(2).rip().as<int*>();
            }
        },
		// Code_Execute
        {
            "CE",
            "E8 ? ? ? ? FF C6 48 83 C3 04 ?",
            [](memory::handle ptr)
            {
                g_pointers->m_rorr.m_code_execute = ptr.add(1).rip().as<gm::Code_Execute>();
            }
        },
		// Builtin Variables
        {
            "BV",
            "48 89 6C 24 18 48 89 74 24 20 57 48 83 EC 20 48 63 05",
            [](memory::handle ptr)
            {
				g_pointers->m_rorr.m_builtin_variables = ptr.add(85).rip().as<gm::RVariableRoutine*>();
                g_pointers->m_rorr.m_builtin_variable_count = ptr.add(18).rip().as<int*>();
            }
        },
		// CRoom
        {
            "CR",
            "7D 3C 48 8B 80",
            [](memory::handle ptr)
            {
                g_pointers->m_rorr.m_croom = ptr.sub(19).rip().as<gm::CRoom**>();
            }
        },
		// CInstance constructor
        {
            "CIC",
            "33 F6 48 89 70",
            [](memory::handle ptr)
            {
				g_pointers->m_rorr.m_cinstance_ctor = ptr.sub(94).as<gm::CInstance_ctor>();
            }
        },
		// CInstance deconstructor
        {
            "CID",
            "33 ED 48 85 FF 74 1A",
            [](memory::handle ptr)
            {
				g_pointers->m_rorr.m_cinstance_dctor = ptr.sub(0x2F).as<gm::CInstance_dctor>();
            }
        },
		// CObjectGM Add Instance
        {
            "COGMAI",
            "75 0E 48 89 4B",
            [](memory::handle ptr)
            {
				g_pointers->m_rorr.m_cobjectgm_add_instance = ptr.sub(0x5A).as<gm::CObjectGM_AddInstance>();
            }
        },
		// CObjectGM Remove Instance
        {
            "COGMRI",
            "48 85 DB 74 5E",
            [](memory::handle ptr)
            {
				g_pointers->m_rorr.m_cobjectgm_remove_instance = ptr.sub(0x19).as<gm::CObjectGM_RemoveInstance>();
            }
        },
        // YYSetString
        {
            "YYSS",
            "48 8B FA 48 8B D9 B9 10 00 00 00",
            [](memory::handle ptr)
            {
				g_pointers->m_rorr.m_yysetstring = ptr.sub(0xA).as<YYSetStr>();
            }
        },
        // FREE_RValue_Pre
        {
            "FRP",
            "74 34 83 F8 01",
            [](memory::handle ptr)
            {
				g_pointers->m_rorr.m_free_rvalue_pre = ptr.sub(0x1D).as<FREE_RVal_Pre>();
            }
        },
        // COPY_RValue_do__Post
        {
            "CRDP",
            "83 F8 04 75 66",
            [](memory::handle ptr)
            {
				g_pointers->m_rorr.m_copy_rvalue_do_post = ptr.sub(0x22).as<COPY_RValue_do__Post_t>();
            }
        },
        // Debug Console Output
        {
            "DCO",
            "48 8B 0D ? ? ? ? 48 8D 15 ? ? ? ? 48 8B 01 FF 50 ? 48 8B 74 24 ? 48 8B 5C 24 ? 48 8B 7C 24",
            [](memory::handle ptr)
            {
                auto instance = ptr.add(3).rip().as<__int64**>();
				g_pointers->m_rorr.m_debug_console_output = (*((void(__fastcall**)(void*, const char*, ...)) * instance[0] + 2));
            }
        },
        // IO_UpdateM
        {
            "IOUM",
            "48 8B CF 89 05",
            [](memory::handle ptr)
            {
				g_pointers->m_rorr.m_io_update_m = ptr.sub(0x8A).as<gm::IO_UpdateM_t>();
            }
        },
        // Script_Data
        {
            "SD",
            "E8 ? ? ? ? 33 C9 0F B7 D3",
            [](memory::handle ptr)
            {
				g_pointers->m_rorr.m_script_data = ptr.add(1).rip().as<gm::Script_Data_t>();
            }
        },
        // StructCreate
        {
            "SC",
            "48 8B D9 45 33 C9 33 C9",
            [](memory::handle ptr)
            {
				g_pointers->m_rorr.m_struct_create = ptr.sub(0x6).as<gm::StructCreate_t>();
            }
        },
        // ShaderCreate
        {
            "ShC",
            "E8 ? ? ? ? 85 C0 79 ? 83 F8 FF",
            [](memory::handle ptr)
            {
				g_pointers->m_rorr.m_shader_create = ptr.sub(0x37).as<gm::ShaderCreate_t>();
            }
        },
        // in FindShaderByName
        {
            "FSBN",
            "44 8B 1D ? ? ? ? 45 33 C9 48 8B D9",
            [](memory::handle ptr)
            {
				g_pointers->m_rorr.m_shader_amount = ptr.add(3).rip().as<int*>();
                g_pointers->m_rorr.m_shader_pool = ptr.add(18).add(3).rip().as<YYShader***>();
            }
        },
        // MemoryManager::ReAlloc
        {
            "MMRA",
            "48 89 5C 24 ? 48 89 6C 24 ? 48 89 74 24 ? 57 41 56 41 57 48 83 EC 40 41 8B E9",
            [](memory::handle ptr)
            {
				g_pointers->m_rorr.m_memorymanager_realloc = ptr.as<gm::MemoryManager::ReAlloc>();
            }
        },
        // MemoryManager::Free
        {
            "MMF",
            "48 85 C9 0F 84 ? ? ? ? 53 48 83 EC 30 48 8B D9",
            [](memory::handle ptr)
            {
                g_pointers->m_rorr.m_memorymanager_free = ptr.as<gm::MemoryManager::Free>();
            }
        },
        // MemoryManager::Alloc
        {
            "MMA",
            "40 53 56 57 48 81 EC 70 04 00 00",
            [](memory::handle ptr)
            {
                g_pointers->m_rorr.m_memorymanager_alloc = ptr.as<gm::MemoryManager::Alloc>();
            }
        },
        //NativeShaderCreateFromHeader
        {
            "NSCFH",
            "E8 ? ? ? ? 48 89 43 ? 48 8B CB E8 ? ? ? ? 48 8B CB",
            [](memory::handle ptr)
            {
				g_pointers->m_rorr.m_gen_shader_data_header = ptr.add(1).rip().as<gm::GenShaderDataHeader_t>();
				g_pointers->m_rorr.m_native_shader_gen_cbuf = ptr.add(12).add(1).rip().as<gm::NativeShaderGenCBuf_t>();
				g_pointers->m_rorr.m_native_shader_create = ptr.add(20).add(1).rip().as<gm::NativeShaderCreate_t>();
				g_pointers->m_rorr.m_free_shader_data_header = ptr.add(0x1A5).add(1).rip().as<gm::FreeShaderDataHeader_t>();
                g_pointers->m_rorr.m_native_shader_amount = ptr.add(0x2D2).add(2).rip().as<int*>();
				g_pointers->m_rorr.m_native_shader_pool = ptr.add(0x2F4).add(3).rip().as<YYNativeShader***>();
            }
        },
        // GetSaveFileName
        {
            "GSFN",
            "44 8B E8 8D 50",
            [](memory::handle ptr)
            {
				g_pointers->m_rorr.m_get_save_file_name = ptr.sub(0x18A).as<gm::GetSaveFileName_t>();
            }
        },
        // save_file_serialize
        {
            "SFS",
            "4C 89 44 24 18 48 89 54 24 10 55 53 56 57 41 54 41 55 41 56 41 57 48 8D AC 24 48 FD",
            [](memory::handle ptr)
            {
				g_pointers->m_rorr.m_save_file_serialize = ptr.as<gm::save_file_serialize_t>();
            }
        },
        // save_file_deserialize
        {
            "SFD",
            "4C 8B DC 4D 89 43 18 49 89 53 10 49 89 4B 08 53 56 57 41 54 41 55 41 56 41 57 48 81 EC 10",
            [](memory::handle ptr)
            {
				g_pointers->m_rorr.m_save_file_deserialize = ptr.as<gm::save_file_deserialize_t>();
            }
        },
        // json_parse
        {
            "JP",
            "40 57 48 83 EC 20 48 8B F9 48 8B 4C 24",
            [](memory::handle ptr)
            {
				g_pointers->m_rorr.m_json_parse = ptr.as<gm::json_parse_t>();
            }
        },
        // struct YYGMLFuncs near * g_GMLFuncs
        {
            "GMLF",
            "E8 ? ? ? ? 48 8B 0D ? ? ? ? 8B 41 14",
            [](memory::handle ptr)
            {
				g_pointers->m_rorr.m_GMLFuncs = ptr.add(1).rip().add(0x31).rip().as<YYGMLFuncs*>();
            }
        },
        // YYSetScriptRef
        {
            "YYSSR",
            "E8 ? ? ? ? 90 48 8D 55 17",
            [](memory::handle ptr)
            {
				g_pointers->m_rorr.m_YYSetScriptRef = ptr.add(1).rip().as<YYSetScriptRef_t>();
            }
        },
        // CreateSwapChain
        {
            "CSC",
            "E8 ? ? ? ? 80 3D ? ? ? ? ? 74 70",
            [](memory::handle ptr)
            {
				g_pointers->m_rorr.m_CreateSwapChain = ptr.add(1).rip().as<void*>();
            }
        }
        >(); // don't leave a trailing comma at the end
		// clang-format on
		return batch_and_hash;
	}

	void pointers::load_pointers_from_cache(const cache_file& cache_file, const uintptr_t pointer_to_cacheable_data_start, const memory::module& mem_region)
	{
		// fill pointers instance fields by reading the file data into it

		LOG(INFO) << "Loading pointers instance from cache";

		// multiple things here:
		// - iterate each cacheable field of the pointers instance
		// - add the base module address to the current offset retrieved from the cache
		// - assign that ptr to the pointers field
		uintptr_t* cache_data = reinterpret_cast<uintptr_t*>(cache_file.data());

		const size_t field_count_from_cache = cache_file.data_size() / sizeof(uintptr_t);
		LOG(INFO) << "Pointers cache: Loading " << field_count_from_cache << " fields from the cache";

		uintptr_t* field_ptr = reinterpret_cast<uintptr_t*>(pointer_to_cacheable_data_start);
		for (size_t i = 0; i < field_count_from_cache; i++)
		{
			uintptr_t offset = cache_data[i];
			uintptr_t ptr    = offset + mem_region.begin().as<uintptr_t>();

			if (mem_region.contains(memory::handle(ptr)))
			{
				*field_ptr = ptr;
			}
			else
			{
				LOG(ERROR) << "Just tried to load from cache a pointer supposedly within the rorr module range but "
				              "isn't! Offset from start of pointers instance: "
				           << (reinterpret_cast<uintptr_t>(field_ptr) - reinterpret_cast<uintptr_t>(this));
			}

			field_ptr++;
		}
	}

	pointers::pointers() :
	    m_rorr_pointers_cache(g_file_manager.get_project_file("./cache/rorr_pointers.bin"))
	{
		g_pointers = this;

		const auto mem_region = memory::module("Risk of Rain Returns.exe");

		constexpr auto rorr_batch_and_hash = pointers::get_rorr_batch();
		constexpr cstxpr_str rorr_batch_name{"RORR"};
		write_to_cache_or_read_from_cache<rorr_batch_name,
		                                  rorr_batch_and_hash.m_hash,
		                                  rorr_pointers_layout_info::offset_of_cache_begin_field,
		                                  rorr_pointers_layout_info::offset_of_cache_end_field,
		                                  rorr_batch_and_hash.m_batch>(m_rorr_pointers_cache, mem_region);
	}

	pointers::~pointers()
	{
		g_pointers = nullptr;
	}
} // namespace big
