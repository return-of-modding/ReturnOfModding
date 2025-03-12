#pragma once
#include "Code_Execute_trace.hpp"
#include "CScript.hpp"
#include "lua/lua_manager.hpp"
#include "YYGMLException.hpp"
#include "YYGMLFuncs.hpp"

#include <pointers.hpp>
#include <string/hash.hpp>

namespace gm
{
	inline void gml_exception_handler(const RValue& e)
	{
		std::stringstream exception_log;

		RValue e_message{}, e_longMessage{}, e_script{}, e_line{}, e_stacktrace{};
		e.yy_object_base->m_getOwnProperty(e.yy_object_base, &e_message, "message");
		e.yy_object_base->m_getOwnProperty(e.yy_object_base, &e_longMessage, "longMessage");
		e.yy_object_base->m_getOwnProperty(e.yy_object_base, &e_script, "script");
		e.yy_object_base->m_getOwnProperty(e.yy_object_base, &e_line, "line");
		e.yy_object_base->m_getOwnProperty(e.yy_object_base, &e_stacktrace, "stacktrace");

		exception_log << "class: " << e.yy_object_base->m_class << "\n";
		exception_log << "message:" << (e_message.type == RValueType::STRING ? e_message.ref_string->get() : "") << "\n";
		exception_log << "longMessage:" << (e_longMessage.type == RValueType::STRING ? e_longMessage.ref_string->get() : "") << "\n";
		exception_log << "script:" << (e_script.type == RValueType::STRING ? e_script.ref_string->get() : "") << "\n";
		exception_log << "line:" << (e_line.type == RValueType::REAL ? e_line.value : 0) << "\n";

		exception_log << "stacktrace:\n";

		if (((e_stacktrace.type & MASK_TYPE_RVALUE) == ARRAY) && e_stacktrace.ref_array && e_stacktrace.ref_array->m_Array
		    && e_stacktrace.ref_array->length > 0)
		{
			const auto thelen{e_stacktrace.ref_array->length};
			for (auto i{0}; i < thelen; ++i)
			{
				const auto& item{e_stacktrace.ref_array->m_Array[i]};
				if ((item.type & MASK_TYPE_RVALUE) == STRING)
				{
					exception_log << item.ref_string->get() << "\n";
				}
				else
				{
					exception_log << static_cast<double>(item) << "\n";
				}
			}
		}

		LOG(ERROR) << exception_log.str();
		Logger::FlushQueue();
	}

	struct code_function_info
	{
		const char* function_name = nullptr;
		TRoutine function_ptr     = nullptr;
		int function_arg_count    = 0;
	};

	inline code_function_info dummy{};
	inline std::unordered_map<std::string, code_function_info, big::string::transparent_string_hash, std::equal_to<>> code_function_cache;

	inline code_function_info& get_code_function(std::string_view name)
	{
		if (const auto it = code_function_cache.find(name.data()); it != code_function_cache.end())
		{
			return it->second;
		}

		// Builtin GML Functions
		const auto size = *big::g_pointers->m_rorr.m_code_function_GET_the_function_function_count;
		for (int i = 0; i < size; i++)
		{
			code_function_info result{};

			big::g_pointers->m_rorr.m_code_function_GET_the_function(i,
			                                                         &result.function_name,
			                                                         &result.function_ptr,
			                                                         &result.function_arg_count);

			const auto same_name = !strcmp(result.function_name, name.data());
			if (same_name)
			{
				code_function_cache[name.data()] = result;
				return code_function_cache[name.data()];
			}
		}

		return dummy;
	}

	inline bool is_valid_call(std::string_view name)
	{
		const auto& func_info = get_code_function(name);
		if (func_info.function_ptr)
		{
			return true;
		}

		if (const auto it = gm::script_asset_cache.find(name.data()); it != gm::script_asset_cache.end())
		{
			const auto cscript = big::g_pointers->m_rorr.m_script_data(it->second - 100'000);
			if (cscript && cscript->m_funcs && cscript->m_funcs->m_script_function)
			{
				return true;
			}
		}
		else
		{
			const auto& asset_get_index = gm::get_code_function("asset_get_index");
			RValue script_function_name{name.data()};
			RValue script_function_index;

			asset_get_index.function_ptr(&script_function_index, nullptr, nullptr, 1, &script_function_name);

			if (script_function_index.type == RValueType::REAL)
			{
				gm::script_asset_cache[name.data()] = script_function_index.asInt32();

				const auto cscript = big::g_pointers->m_rorr.m_script_data(script_function_index.asInt32() - 100'000);
				if (cscript && cscript->m_funcs && cscript->m_funcs->m_script_function)
				{
					return true;
				}
			}
		}

		return false;
	}

	inline void lua_print_traceback()
	{
		const auto lua_manager = big::g_lua_manager;
		if (lua_manager && lua_manager->get_module_count())
		{
			sol::state_view(lua_manager->lua_state()).script("log.warning(debug.traceback())");
		}
	}

	inline LONG double_exception_handler(EXCEPTION_POINTERS* exception_info)
	{
		big::big_exception_handler(exception_info);

		if (g_last_call)
		{
			LOG(ERROR) << "last gm.call: " << g_last_call;
		}
		if (g_last_code_execute)
		{
			LOG(ERROR) << "last code_execute: " << g_last_code_execute;
		}

		constexpr auto msvc_exception_code = 0xE0'6D'73'63;
		if (exception_info->ExceptionRecord->ExceptionCode == msvc_exception_code && exception_info->ExceptionRecord->NumberParameters > 2)
		{
			struct _ThrowInfo
			{
				int attributes;
				int pmfnUnwind;
				int pForwardCompat;
				int pCatchableTypeArray;
			};

			constexpr auto yygml_exception_code = 0x1'E1'80'28;
			const auto yygmlexception_id        = (_ThrowInfo*)exception_info->ExceptionRecord->ExceptionInformation[2];
			if (yygmlexception_id && yygmlexception_id->pCatchableTypeArray == yygml_exception_code)
			{
				gml_exception_handler(((YYGMLException*)exception_info->ExceptionRecord->ExceptionInformation[1])->GetExceptionObject());
			}
		}

		return EXCEPTION_CONTINUE_SEARCH;
	}

	inline LONG triple_exception_handler(EXCEPTION_POINTERS* exception_info)
	{
		double_exception_handler(exception_info);

		lua_print_traceback();

		return EXCEPTION_CONTINUE_SEARCH;
	}

	inline void safe_code_call(gm::TRoutine func, RValue* res, CInstance* self, CInstance* other, RValue* args, size_t arg_count)
	{
		__try
		{
			func(res, self, other, arg_count, args);
		}
		__except (triple_exception_handler(GetExceptionInformation()), EXCEPTION_EXECUTE_HANDLER)
		{
		}
	}

	inline void safe_script_call(PFUNC_YYGMLScript func, CInstance* self, CInstance* other, RValue* result, int arg_count, RValue** args)
	{
		__try
		{
			func(self, other, result, arg_count, args);
		}
		__except (triple_exception_handler(GetExceptionInformation()), EXCEPTION_EXECUTE_HANDLER)
		{
		}
	}

	inline RValue call(std::string_view name, CInstance* self, CInstance* other, RValue* args = nullptr, size_t arg_count = 0)
	{
		g_last_call = name.data();

		const auto& func_info = get_code_function(name);

		RValue res{};

		if (func_info.function_ptr)
		{
			safe_code_call(func_info.function_ptr, &res, self, other, args, arg_count);

			g_last_call = nullptr;
			return res;
		}
		// Script Execute
		else
		{
			if (const auto it = gm::script_asset_cache.find(name.data()); it != gm::script_asset_cache.end())
			{
				const auto cscript = big::g_pointers->m_rorr.m_script_data(it->second - 100'000);
				if (cscript)
				{
					auto arranged_args = (RValue**)alloca(sizeof(RValue*) * arg_count);
					for (size_t i = 0; i < arg_count; i++)
					{
						arranged_args[i] = &args[i];
					}

					safe_script_call(cscript->m_funcs->m_script_function, self, other, &res, arg_count, arranged_args);
				}

				g_last_call = nullptr;
				return res;
			}
			else
			{
				const auto& asset_get_index = gm::get_code_function("asset_get_index");
				RValue script_function_name{name.data()};
				RValue script_function_index;

				asset_get_index.function_ptr(&script_function_index, nullptr, nullptr, 1, &script_function_name);

				if (script_function_index.type == RValueType::REAL)
				{
					gm::script_asset_cache[name.data()] = script_function_index.asInt32();

					const auto cscript = big::g_pointers->m_rorr.m_script_data(script_function_index.asInt32() - 100'000);
					if (cscript)
					{
						auto arranged_args = (RValue**)alloca(sizeof(RValue*) * arg_count);
						for (size_t i = 0; i < arg_count; i++)
						{
							arranged_args[i] = &args[i];
						}

						safe_script_call(cscript->m_funcs->m_script_function, self, other, &res, arg_count, arranged_args);
					}

					g_last_call = nullptr;
					return res;
				}
			}
		}

		LOG(WARNING) << name << " function not found!";

		g_last_call = nullptr;
		return {};
	}

	inline RValue call(std::string_view name, RValue* args = nullptr, size_t arg_count = 0)
	{
		return call(name, nullptr, nullptr, args, arg_count);
	}

	template<typename T>
	concept SpanCompatibleType = requires(T a) { std::span{a}; };

	template<typename T>
	    requires SpanCompatibleType<T>
	inline RValue call(std::string_view name, CInstance* self, CInstance* other, T args)
	{
		return call(name, self, other, args.data(), args.size());
	}

	template<typename T>
	    requires SpanCompatibleType<T>
	inline RValue call(std::string_view name, T args)
	{
		return call(name, nullptr, nullptr, args.data(), args.size());
	}

	inline RValue call(std::string_view name, CInstance* self, CInstance* other, RValue& arg)
	{
		return call(name, self, other, &arg, 1);
	}

	inline RValue call(std::string_view name, CInstance* self, CInstance* other, RValue&& arg)
	{
		return call(name, self, other, arg);
	}

	inline RValue call(std::string_view name, RValue& arg)
	{
		return call(name, nullptr, nullptr, arg);
	}

	inline RValue call(std::string_view name, RValue&& arg)
	{
		return call(name, nullptr, nullptr, arg);
	}

	inline void print_all_code_functions()
	{
		auto gml_funcs = big::g_pointers->m_rorr.m_GMLFuncs;

		const auto game_base_address = (uintptr_t)GetModuleHandleA(0);

		while (true)
		{
			if (gml_funcs->m_name && ((uintptr_t)gml_funcs->m_script_function - game_base_address) < 0xF'F0'00'00'00 /* stupid bound check */)
			{
				LOG(INFO) << gml_funcs->m_name;
				LOG(INFO) << HEX_TO_UPPER_OFFSET(gml_funcs->m_script_function);

				gml_funcs++;
			}
			else
			{
				break;
			}
		}

		for (int i = 0; i < *big::g_pointers->m_rorr.m_code_function_GET_the_function_function_count; i++)
		{
			const char* function_name = nullptr;
			TRoutine function_ptr     = nullptr;
			int function_arg_count    = 0;

			big::g_pointers->m_rorr.m_code_function_GET_the_function(i, &function_name, &function_ptr, &function_arg_count);

			if (function_name)
			{
				LOG(INFO) << function_name << " | " << HEX_TO_UPPER_OFFSET(function_ptr) << " | " << function_arg_count;
			}
		}
	}

	inline void generate_gmf_ffi()
	{
		constexpr auto gmf_ffi_version_file_name = "gmf_version";
		constexpr auto gmf_ffi_version           = "1";

		const auto folder_path = big::g_file_manager.get_project_folder("plugins").get_path() / "ReturnOfModding-GLOBAL";

		try
		{
			std::filesystem::create_directories(folder_path);
		}
		catch (const std::exception& e)
		{
			LOG(ERROR) << e.what();
		}
		catch (...)
		{
			LOG(ERROR) << "unknown exception";
		}

		const auto file_path_gmf_ffi_version = folder_path / gmf_ffi_version_file_name;

		const auto functions_file_path = folder_path / "gmf_functions.lua";

		const auto main_file_path = folder_path / "gmf.lua";

		const auto write_version_to_version_file = [&]()
		{
			std::ofstream file_output_versioning(file_path_gmf_ffi_version, std::ios::out | std::ios::binary);
			file_output_versioning << gmf_ffi_version;
		};

		if (std::filesystem::exists(file_path_gmf_ffi_version) && std::filesystem::exists(functions_file_path))
		{
			std::ifstream file_input(file_path_gmf_ffi_version, std::ios::in);
			std::string version;
			file_input >> version;
			if (version == gmf_ffi_version)
			{
				return;
			}
			else
			{
				write_version_to_version_file();
			}
		}
		else
		{
			write_version_to_version_file();
		}

		std::ofstream functions_file_output(functions_file_path, std::ios::out | std::ios::binary);

		functions_file_output << R"(if gmf ~= nil then return gmf end

gmf = {}

ffi.cdef[[
typedef struct RefString
{
	const char* m_str;
	int m_refCount;
	int m_size;
} RefString;

typedef struct YYObjectBase YYObjectBase;
typedef struct CInstance CInstance;
typedef struct CScriptRef CScriptRef;

typedef struct RValue {
	union {
		int32_t i32;
		int64_t i64;
		double value;
		struct RefString* ref_string;
		struct YYObjectBase* yy_object_base;
		struct CInstance* cinstance;
		struct CScriptRef* cscriptref;
	};
	
    int32_t __flags;
    int32_t type;
} RValue;

typedef struct YYObjectBase {
	void* virtual_table_ptr;

	struct RValue* __yyvars;

	struct YYObjectBase* m_pNextObject;
	struct YYObjectBase* m_pPrevObject;
	struct YYObjectBase* m_prototype;
	const char* m_class;
	void* m_getOwnProperty;
	void* m_deleteProperty;
	void* m_defineOwnProperty;
	void* m_yyvarsMap;
	void* m_pWeakRefs;
	unsigned int m_numWeakRefs;
	unsigned int m_nvars;
	unsigned int m_flags;
	unsigned int m_capacity;
	unsigned int m_visited;
	unsigned int m_visitedGC;
	int m_GCgen;
	int m_GCcreationframe;
	int m_slot;            
	int32_t type; // YYObjectBaseType
	int m_rvalueInitType;
	int m_curSlot;
    
} YYObjectBase;

typedef struct YYGMLFuncs {
	const char* m_name;

	void* m_function_ptr;

	void* m_func_var;
} YYGMLFuncs;

typedef struct CScript {
	void* virtual_table_ptr;
	void* m_code;
	YYGMLFuncs* m_funcs;
	void* m_CInstance_static_object;

	union
	{
		const char* m_script;
		int m_compiled_index;
	};

	const char* m_script_name; // example: gml_Script_init_player
	int m_offset;
} CScript;

typedef struct CScriptRef {

	void* virtual_table_ptr;

	struct RValue* __yyvars;

	struct YYObjectBase* m_pNextObject;
	struct YYObjectBase* m_pPrevObject;
	struct YYObjectBase* m_prototype;
	const char* m_class;
	void* m_getOwnProperty;
	void* m_deleteProperty;
	void* m_defineOwnProperty;
	void* m_yyvarsMap;
	void* m_pWeakRefs;
	unsigned int m_numWeakRefs;
	unsigned int m_nvars;
	unsigned int m_flags;
	unsigned int m_capacity;
	unsigned int m_visited;
	unsigned int m_visitedGC;
	int m_GCgen;
	int m_GCcreationframe;
	int m_slot;            
	int32_t type; // YYObjectBaseType
	int m_rvalueInitType;
	int m_curSlot;

	void* m_unk;
	void* m_unk2;
	void* m_unk3;
	void* m_unk4;
	void* m_unk5;
	void* m_unk6;
	void* m_unk7;

	CScript* m_call_script;
} CScriptRef;

typedef struct CInstance {
	void* virtual_table_ptr;

	struct RValue* __yyvars;

	struct YYObjectBase* m_pNextObject;
	struct YYObjectBase* m_pPrevObject;
	struct YYObjectBase* m_prototype;
	const char* m_class;
	void* m_getOwnProperty;
	void* m_deleteProperty;
	void* m_defineOwnProperty;
	void* m_yyvarsMap;
	void* m_pWeakRefs;
	unsigned int m_numWeakRefs;
	unsigned int m_nvars;
	unsigned int m_flags;
	unsigned int m_capacity;
	unsigned int m_visited;
	unsigned int m_visitedGC;
	int m_GCgen;
	int m_GCcreationframe;
	int m_slot;            
	int32_t type; // YYObjectBaseType
	int m_rvalueInitType;
	int m_curSlot;

	__int64 m_CreateCounter;
	void* m_pObject;
	void* m_pPhysicsObject;
	void* m_pSkeletonAnimation;
	void* m_pControllingSeqInst;
	unsigned int m_Instflags;
	int id;
	int object_index;
	int sprite_index;
	float i_sequencePos;
	float i_lastSequencePos;
	float i_sequenceDir;
	float image_index;
	float image_speed;
	float image_xscale;
	float image_yscale;
	float image_angle;
	float image_alpha;
	unsigned int image_blend;
	float x;
	float y;
	float xstart;
	float ystart;
	float xprevious;
	float yprevious;
	float direction;
	float speed;
	float friction;
	float gravity_direction;
	float gravity;
	float hspeed;
	float vspeed;
	int bbox[4];
	int timer[12];
	void* m_pPathAndTimeline;
	void* i_initcode; // CCode
	void* i_precreatecode; // CCode
	void* m_pOldObject;
	int layer;
	int mask_index;
	int16_t m_nMouseOver;
	void* m_pNext; // CInstance
	void* m_pPrev; // CInstance
	void* m_collisionLink[3]; // SLink
	void* m_dirtyLink[3];     // SLink
	void* m_withLink[3];      // SLink
	float depth;
	float i_currentdepth;
	float i_lastImageNumber;
	unsigned int m_collisionTestNumber;
    
} CInstance;
]]
)";

		struct func_info_
		{
			const char* m_name;
			void* m_func_ptr;
		};

		std::vector<func_info_> func_info_builtins;
		std::vector<func_info_> func_info_objects;
		std::vector<func_info_> func_info_scripts;

		// Builtin GML Functions
		const auto size = *big::g_pointers->m_rorr.m_code_function_GET_the_function_function_count;
		for (int i = 0; i < size; i++)
		{
			code_function_info result{};

			big::g_pointers->m_rorr.m_code_function_GET_the_function(i,
			                                                         &result.function_name,
			                                                         &result.function_ptr,
			                                                         &result.function_arg_count);

			if (result.function_name && result.function_ptr)
			{
				func_info_builtins.push_back({result.function_name, result.function_ptr});
			}
		}

		// Script Execute
		/*for (size_t i = 0; true; i++)
		{
			const auto& asset_get_index = gm::get_code_function("asset_get_index");

			auto cscript = big::g_pointers->m_rorr.m_script_data(i);
			if (cscript)
			{
				func_info_scripts.push_back({cscript->m_script_name, (void*)cscript->m_funcs->m_script_function});
			}
			else
			{
				break;
			}
		}*/

		auto gml_funcs = big::g_pointers->m_rorr.m_GMLFuncs;

		const auto game_base_address = (uintptr_t)GetModuleHandleA(0);

		while (true)
		{
			if (gml_funcs->m_name && ((uintptr_t)gml_funcs->m_script_function - game_base_address) < 0xF'F0'00'00'00 /* stupid bound check */)
			{
				if (strstr(gml_funcs->m_name, "gml_Script_"))
				{
					func_info_scripts.push_back({gml_funcs->m_name + 11, (void*)gml_funcs->m_script_function});
				}
				else if (strstr(gml_funcs->m_name, "gml_Object_"))
				{
					func_info_objects.push_back({gml_funcs->m_name, (void*)gml_funcs->m_script_function});
				}

				gml_funcs++;
			}
			else
			{
				break;
			}
		}

		functions_file_output << "local game_base_address = memory.game_base_address\n\n";

		functions_file_output
		    << "local builtin_signature = \"void (*)(struct RValue* result, struct CInstance* self, struct "
		       "CInstance* other, int64_t arg_count, struct RValue* args)\"\n";
		functions_file_output
		    << "local object_signature = \"void (*)(struct CInstance* self, struct CInstance* other)\"\n";
		functions_file_output
		    << "local script_signature = \"void (*)(struct CInstance * self, struct "
		       "CInstance* other, struct RValue* result, int64_t arg_count, struct RValue** args)\"\n\n";

		for (const auto& func_info : func_info_builtins)
		{
			functions_file_output << "gmf[\"" << func_info.m_name << "\"] = ffi.cast(builtin_signature, game_base_address + "
			                      << HEX_TO_UPPER_OFFSET(func_info.m_func_ptr) << ")\n";
		}

		functions_file_output << "\n\n";

		for (const auto& func_info : func_info_objects)
		{
			functions_file_output << "gmf[\"" << func_info.m_name << "\"] = ffi.cast(object_signature, game_base_address + "
			                      << HEX_TO_UPPER_OFFSET(func_info.m_func_ptr) << ")\n";
		}

		functions_file_output << "\n\n";

		for (const auto& func_info : func_info_scripts)
		{
			functions_file_output << "gmf[\"" << func_info.m_name << "\"] = ffi.cast(script_signature, game_base_address + "
			                      << HEX_TO_UPPER_OFFSET(func_info.m_func_ptr) << ")\n";
		}

		functions_file_output << "\nreturn gmf\n";

		std::ofstream main_file_output(main_file_path, std::ios::out | std::ios::binary);

		main_file_output << R"(if gmf ~= nil then return gmf end

gmf = require("ReturnOfModding-GLOBAL/gmf_functions")

)";

		main_file_output
		    << "gmf.yysetstring = ffi.cast(\"void (*)(struct RValue*, const char*)\", memory.game_base_address + ";

		main_file_output << HEX_TO_UPPER_OFFSET(big::g_pointers->m_rorr.m_yysetstring) << ")\n\n";

		main_file_output << R"(local rvalue_type = ffi.typeof("struct RValue")

gmf.rvalue_type = rvalue_type

gmf.rvalue_new = function (val)
	local rvalue = ffi.new(rvalue_type)
	rvalue.value = val
	return rvalue
end

gmf.rvalue_new_string = function (str)
    local result = ffi.new("struct RValue[1]")
	gmf.yysetstring(result, str)
    return result[0]
end

return gmf

)";

		LOG(INFO) << "Done generating gmf ffi lua table.";
	}
} // namespace gm
