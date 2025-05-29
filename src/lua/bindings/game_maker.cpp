#include "game_maker.hpp"

#include "lua/bindings/memory.hpp"
#include "lua/lua_manager_extension.hpp"
#include "lua/lua_module_ext.hpp"
#include "rorr/gm/Code_Function_GET_the_function.hpp"
#include "rorr/gm/CScript.hpp"
#include "rorr/gm/CScriptRef.hpp"
#include "rorr/gm/EVariableType.hpp"
#include "rorr/gm/pin_map.hpp"
#include "rorr/gm/Variable_BuiltIn.hpp"
#include "rorr/gm/YYGMLFuncs.hpp"

#include <ankerl/unordered_dense.h>

extern "C"
{
#undef WIN32_LEAN_AND_MEAN
#include "lj_err.h"

#include <lj_frame.h>
#include <lj_func.h>
#include <lj_state.h>
#include <lj_vm.h>

#if LJ_TARGET_X86
	typedef void* UndocumentedDispatcherContext; /* Unused on x86. */
#else
	/* Taken from: http://www.nynaeve.net/?p=99 */
	typedef struct UndocumentedDispatcherContext
	{
		ULONG64 ControlPc;
		ULONG64 ImageBase;
		PRUNTIME_FUNCTION FunctionEntry;
		ULONG64 EstablisherFrame;
		ULONG64 TargetIp;
		PCONTEXT ContextRecord;
		void (*LanguageHandler)(void);
		PVOID HandlerData;
		PUNWIND_HISTORY_TABLE HistoryTable;
		ULONG ScopeIndex;
		ULONG Fill0;
	} UndocumentedDispatcherContext;
#endif

	LJ_FUNCA int lj_err_unwind_win(EXCEPTION_RECORD* rec, void* f, CONTEXT* ctx, UndocumentedDispatcherContext* dispatch);

#define LJ_MSVC_EXCODE ((DWORD)0xe0'6d'73'63)
#define LJ_GCC_EXCODE  ((DWORD)0x20'47'43'43)

#define LJ_EXCODE             ((DWORD)0xe2'4c'4a'00)
#define LJ_EXCODE_CHECK(cl)   (((cl) ^ LJ_EXCODE) <= 0xff)
#define LJ_EXCODE_ERRCODE(cl) ((int)((cl) & 0xff))

	extern void __DestructExceptionObject(EXCEPTION_RECORD* rec, int nothrow);

	LJ_NOINLINE static void unwindstack(lua_State* L, TValue* top)
	{
		lj_func_closeuv(L, top);
		if (top < L->top - 1)
		{
			copyTV(L, top, L->top - 1);
			L->top = top + 1;
		}
		lj_state_relimitstack(L);
	}

	static void* err_unwind(lua_State* L, void* stopcf, int errcode)
	{
		TValue* frame = L->base - 1;
		void* cf      = L->cframe;
		while (cf)
		{
			int32_t nres = cframe_nres(cframe_raw(cf));
			if (nres < 0)
			{ /* C frame without Lua frame? */
				TValue* top = restorestack(L, -nres);
				if (frame < top)
				{ /* Frame reached? */
					if (errcode)
					{
						L->base   = frame + 1;
						L->cframe = cframe_prev(cf);
						unwindstack(L, top);
					}
					return cf;
				}
			}
			if (frame <= tvref(L->stack) + LJ_FR2)
			{
				break;
			}
			switch (frame_typep(frame))
			{
			case FRAME_LUA: /* Lua frame. */
			case FRAME_LUAP: frame = frame_prevl(frame); break;
			case FRAME_C: /* C frame. */
			unwind_c:
#if LJ_UNWIND_EXT
				if (errcode)
				{
					L->base   = frame_prevd(frame) + 1;
					L->cframe = cframe_prev(cf);
					unwindstack(L, frame - LJ_FR2);
				}
				else if (cf != stopcf)
				{
					cf    = cframe_prev(cf);
					frame = frame_prevd(frame);
					break;
				}
				return NULL; /* Continue unwinding. */
#else
				UNUSED(stopcf);
				cf    = cframe_prev(cf);
				frame = frame_prevd(frame);
				break;
#endif
			case FRAME_CP: /* Protected C frame. */
				if (cframe_canyield(cf))
				{ /* Resume? */
					if (errcode)
					{
						hook_leave(G(L)); /* Assumes nobody uses coroutines inside hooks. */
						L->cframe = NULL;
						L->status = (uint8_t)errcode;
					}
					return cf;
				}
				if (errcode)
				{
					L->base   = frame_prevd(frame) + 1;
					L->cframe = cframe_prev(cf);
					unwindstack(L, frame - LJ_FR2);
				}
				return cf;
			case FRAME_CONT: /* Continuation frame. */
				if (frame_iscont_fficb(frame))
				{
					goto unwind_c;
				}
				/* fallthrough */
			case FRAME_VARG: /* Vararg frame. */ frame = frame_prevd(frame); break;
			case FRAME_PCALL:  /* FF pcall() frame. */
			case FRAME_PCALLH: /* FF pcall() frame inside hook. */
				if (errcode)
				{
					global_State* g;
					if (errcode == LUA_YIELD)
					{
						frame = frame_prevd(frame);
						break;
					}
					g = G(L);
					setgcref(g->cur_L, obj2gco(L));
					if (frame_typep(frame) == FRAME_PCALL)
					{
						hook_leave(g);
					}
					L->base   = frame_prevd(frame) + 1;
					L->cframe = cf;
					unwindstack(L, L->base);
				}
				return (void*)((intptr_t)cf | CFRAME_UNWIND_FF);
			}
		}
		/* No C frame. */
		if (errcode)
		{
			L->base   = tvref(L->stack) + 1 + LJ_FR2;
			L->cframe = NULL;
			unwindstack(L, L->base);
			if (G(L)->panic)
			{
				G(L)->panic(L);
			}
			exit(EXIT_FAILURE);
		}
		return L; /* Anything non-NULL will do. */
	}

	LJ_FUNCA int lj_err_unwind_win_VERBOSE(EXCEPTION_RECORD* rec, void* f, CONTEXT* ctx, UndocumentedDispatcherContext* dispatch)
	{
#if LJ_TARGET_X86
		void* cf = (char*)f - CFRAME_OFS_SEH;
#elif LJ_TARGET_ARM64
		void* cf = (char*)f - CFRAME_SIZE;
#else
		void* cf = f;
#endif
		lua_State* L = cframe_L(cf);
		int errcode  = LJ_EXCODE_CHECK(rec->ExceptionCode) ? LJ_EXCODE_ERRCODE(rec->ExceptionCode) : LUA_ERRRUN;
		if ((rec->ExceptionFlags & 6))
		{ /* EH_UNWINDING|EH_EXIT_UNWIND */
			if (rec->ExceptionCode == STATUS_LONGJUMP && rec->ExceptionRecord && LJ_EXCODE_CHECK(rec->ExceptionRecord->ExceptionCode))
			{
				errcode = LJ_EXCODE_ERRCODE(rec->ExceptionRecord->ExceptionCode);
				if ((rec->ExceptionFlags & 0x20))
				{ /* EH_TARGET_UNWIND */
					/* Unwinding is about to finish; revert the ExceptionCode so that
	** RtlRestoreContext does not try to restore from a _JUMP_BUFFER.
	*/
					rec->ExceptionCode = 0;
				}
			}
			/* Unwind internal frames. */
			err_unwind(L, cf, errcode);
		}
		else
		{
			void* cf2 = err_unwind(L, cf, 0);
			if (cf2)
			{ /* We catch it, so start unwinding the upper frames. */
#if !LJ_TARGET_X86
				EXCEPTION_RECORD rec2;
#endif
				if (rec->ExceptionCode == LJ_MSVC_EXCODE || rec->ExceptionCode == LJ_GCC_EXCODE)
				{
#if !LJ_TARGET_CYGWIN
					__DestructExceptionObject(rec, 1);
#endif
					constexpr auto msvc_exception_code = 0xE0'6D'73'63;
					if (rec->ExceptionCode == msvc_exception_code && rec->NumberParameters > 2)
					{
						struct _ThrowInfo
						{
							int attributes;
							int pmfnUnwind;
							int pForwardCompat;
							int pCatchableTypeArray;
						};

						constexpr auto yygml_exception_code = 0x1'E1'80'28;
						const auto yygmlexception_id        = (_ThrowInfo*)rec->ExceptionInformation[2];
						if (yygmlexception_id && yygmlexception_id->pCatchableTypeArray == yygml_exception_code)
						{
							gm::gml_exception_handler(((YYGMLException*)rec->ExceptionInformation[1])->GetExceptionObject());
						}
					}

					setstrV(L, L->top++, lj_err_str(L, LJ_ERR_ERRCPP));
				}
				else if (!LJ_EXCODE_CHECK(rec->ExceptionCode))
				{
					/* Don't catch access violations etc. */
					return 1; /* ExceptionContinueSearch */
				}
#if LJ_TARGET_X86
				UNUSED(ctx);
				UNUSED(dispatch);
				/* Call all handlers for all lower C frames (including ourselves) again
      ** with EH_UNWINDING set. Then call the specified function, passing cf
      ** and errcode.
      */
				lj_vm_rtlunwind(cf, (void*)rec, (cframe_unwind_ff(cf2) && errcode != LUA_YIELD) ? (void*)lj_vm_unwind_ff : (void*)lj_vm_unwind_c, errcode);
				/* lj_vm_rtlunwind does not return. */
#else
				if (LJ_EXCODE_CHECK(rec->ExceptionCode))
				{
					/* For unwind purposes, wrap the EXCEPTION_RECORD in something that
	** looks like a longjmp, so that MSVC will execute C++ destructors in
	** the frames we unwind over. ExceptionInformation[0] should really
	** contain a _JUMP_BUFFER*, but hopefully nobody is looking too closely
	** at this point.
	*/
					rec2.ExceptionCode           = STATUS_LONGJUMP;
					rec2.ExceptionRecord         = rec;
					rec2.ExceptionAddress        = 0;
					rec2.NumberParameters        = 1;
					rec2.ExceptionInformation[0] = (ULONG_PTR)ctx;
					rec                          = &rec2;
				}
				/* Unwind the stack and call all handlers for all lower C frames
      ** (including ourselves) again with EH_UNWINDING set. Then set
      ** stack pointer = f, result = errcode and jump to the specified target.
      */
				RtlUnwindEx(f,
				            (void*)((cframe_unwind_ff(cf2) && errcode != LUA_YIELD) ? lj_vm_unwind_ff_eh : lj_vm_unwind_c_eh),
				            rec,
				            (void*)(uintptr_t)errcode,
				            dispatch->ContextRecord,
				            dispatch->HistoryTable);
				/* RtlUnwindEx should never return. */
#endif
			}
		}
		return 1; /* ExceptionContinueSearch */
	}
}

#pragma warning(push, 0)
#include <asmjit/asmjit.h>
#pragma warning(pop)

#pragma warning(disable : 4200)
#include "polyhook2/Enums.hpp"
#include "polyhook2/ErrorLog.hpp"
#include "polyhook2/MemAccessor.hpp"
#include "polyhook2/PolyHookOs.hpp"

#pragma comment(lib, "d3dcompiler.lib")
#pragma comment(lib, "dxguid.lib")

namespace qstd
{
	class runtime_func : public PLH::MemAccessor
	{
		std::vector<uint8_t> m_jit_function_buffer;
		asmjit::x86::Mem argsStack;

	public:
		std::unique_ptr<big::detour_hook> m_detour;

		struct parameters_t
		{
			template<typename T>
			void set(const uint8_t idx, const T val) const
			{
				*(T*)get_arg_ptr(idx) = val;
			}

			template<typename T>
			T get(const uint8_t idx) const
			{
				return *(T*)get_arg_ptr(idx);
			}

			// asm depends on this specific type
			// we the runtime_func allocates stack space that is set to point here (check asmjit::compiler.newStack calls)
			volatile uintptr_t m_arguments;

			// must be char* for aliasing rules to work when reading back out
			char* get_arg_ptr(const uint8_t idx) const
			{
				return ((char*)&m_arguments) + sizeof(uintptr_t) * idx;
			}
		};

		struct return_value_t
		{
			uintptr_t m_return_value;
		};

		typedef void (*user_callback_t)(const parameters_t* params, const uint8_t count, return_value_t* return_value, const uintptr_t original_func_ptr);

		runtime_func()
		{
			m_detour = std::make_unique<big::detour_hook>();
			m_jit_function_buffer.clear();
		}

		~runtime_func()
		{
			m_detour->disable();
		}

		/* Construct a callback given the raw signature at runtime. 'Callback' param is the C stub to transfer to,
		where parameters can be modified through a structure which is written back to the parameter slots depending
		on calling convention.*/
		uintptr_t make_jit_func(const asmjit::FuncSignature& sig, const asmjit::Arch arch, const user_callback_t callback, const uintptr_t original_func_ptr)
		{
			asmjit::CodeHolder code;
			auto env = asmjit::Environment::host();
			env.setArch(arch);
			code.init(env);

			// initialize function
			asmjit::x86::Compiler cc(&code);
			asmjit::FuncNode* func = cc.addFunc(sig);

			asmjit::StringLogger log;
			auto kFormatFlags = asmjit::FormatFlags::kMachineCode | asmjit::FormatFlags::kExplainImms | asmjit::FormatFlags::kRegCasts | asmjit::FormatFlags::kHexImms | asmjit::FormatFlags::kHexOffsets | asmjit::FormatFlags::kPositions;

			log.addFlags(kFormatFlags);
#ifndef FINAL
			code.setLogger(&log);
#endif // ! FINAL


			// too small to really need it
			func->frame().resetPreservedFP();

			// map argument slots to registers, following abi.
			std::vector<asmjit::x86::Reg> argRegisters;
			for (uint8_t argIdx = 0; argIdx < sig.argCount(); argIdx++)
			{
				const auto argType = sig.args()[argIdx];

				asmjit::x86::Reg arg;
				if (lua::memory::is_general_register(argType))
				{
					arg = cc.newUIntPtr();
				}
				else if (lua::memory::is_XMM_register(argType))
				{
					arg = cc.newXmm();
				}
				else
				{
					LOG(ERROR) << "Parameters wider than 64bits not supported";
					return 0;
				}

				func->setArg(argIdx, arg);
				argRegisters.push_back(arg);
			}

			// setup the stack structure to hold arguments for user callback
			uint32_t stackSize = (uint32_t)(sizeof(uintptr_t) * sig.argCount());
			argsStack          = cc.newStack(stackSize, 16);
			asmjit::x86::Mem argsStackIdx(argsStack);

			// assigns some register as index reg
			asmjit::x86::Gp i = cc.newUIntPtr();

			// stackIdx <- stack[i].
			argsStackIdx.setIndex(i);

			// r/w are sizeof(uintptr_t) width now
			argsStackIdx.setSize(sizeof(uintptr_t));

			// set i = 0
			cc.mov(i, 0);
			//// mov from arguments registers into the stack structure
			for (uint8_t argIdx = 0; argIdx < sig.argCount(); argIdx++)
			{
				const auto argType = sig.args()[argIdx];

				// have to cast back to explicit register types to gen right mov type
				if (lua::memory::is_general_register(argType))
				{
					cc.mov(argsStackIdx, argRegisters.at(argIdx).as<asmjit::x86::Gp>());
				}
				else if (lua::memory::is_XMM_register(argType))
				{
					cc.movq(argsStackIdx, argRegisters.at(argIdx).as<asmjit::x86::Xmm>());
				}
				else
				{
					LOG(ERROR) << "Parameters wider than 64bits not supported";
					return 0;
				}

				// next structure slot (+= sizeof(uintptr_t))
				cc.add(i, sizeof(uintptr_t));
			}

			// get pointer to stack structure and pass it to the user callback
			asmjit::x86::Gp argStruct = cc.newUIntPtr("argStruct");
			cc.lea(argStruct, argsStack);

			// fill reg to pass struct arg count to callback
			asmjit::x86::Gp argCountParam = cc.newUInt8();
			cc.mov(argCountParam, (uint8_t)sig.argCount());

			// create buffer for ret val
			asmjit::x86::Mem retStack = cc.newStack(sizeof(uintptr_t), 16);
			asmjit::x86::Gp retStruct = cc.newUIntPtr("retStruct");
			cc.lea(retStruct, retStack);

			// fill reg to pass original function pointer to callback
			asmjit::x86::Gp original_func_ptr_reg = cc.newUIntPtr();
			cc.mov(original_func_ptr_reg, original_func_ptr);

			asmjit::InvokeNode* invokeNode;
			cc.invoke(&invokeNode, (uintptr_t)callback, asmjit::FuncSignatureT<void, parameters_t*, uint8_t, return_value_t*, uintptr_t>());

			// call to user provided function (use ABI of host compiler)
			invokeNode->setArg(0, argStruct);
			invokeNode->setArg(1, argCountParam);
			invokeNode->setArg(2, retStruct);
			invokeNode->setArg(3, original_func_ptr_reg);

			if (sig.hasRet())
			{
				asmjit::x86::Mem retStackIdx(retStack);
				retStackIdx.setSize(sizeof(uintptr_t));
				if (lua::memory::is_general_register(sig.ret()))
				{
					asmjit::x86::Gp tmp2 = cc.newUIntPtr();
					cc.mov(tmp2, retStackIdx);
					cc.ret(tmp2);
				}
				else
				{
					asmjit::x86::Xmm tmp2 = cc.newXmm();
					cc.movq(tmp2, retStackIdx);
					cc.ret(tmp2);
				}
			}

			cc.endFunc();

			// write to buffer
			cc.finalize();

			// worst case, overestimates for case trampolines needed
			code.flatten();
			size_t size = code.codeSize();

			// Allocate a virtual memory (executable).
			m_jit_function_buffer.reserve(size);

			PLH::MemoryProtector protector((uintptr_t)m_jit_function_buffer.data(), size, PLH::ProtFlag::R | PLH::ProtFlag::W | PLH::ProtFlag::X, *this, false);

			// if multiple sections, resolve linkage (1 atm)
			if (code.hasUnresolvedLinks())
			{
				code.resolveUnresolvedLinks();
			}

			// Relocate to the base-address of the allocated memory.
			code.relocateToBase((uintptr_t)m_jit_function_buffer.data());
			code.copyFlattenedData(m_jit_function_buffer.data(), size);

#ifndef FINAL
			LOG(INFO) << "JIT Stub: " << log.data();
#endif

			return (uintptr_t)m_jit_function_buffer.data();
		}

		/* Construct a callback given the typedef as a string. Types are any valid C/C++ data type (basic types), and pointers to
		anything are just a uintptr_t. Calling convention is defaulted to whatever is typical for the compiler you use, you can override with
		stdcall, fastcall, or cdecl (cdecl is default on x86). On x64 those map to the same thing.*/
		uintptr_t make_jit_func(const std::string& return_type, const std::vector<std::string>& param_types, const asmjit::Arch arch, const user_callback_t callback, const uintptr_t original_func_ptr, std::string call_convention = "")
		{
			asmjit::FuncSignature sig(lua::memory::get_call_convention(call_convention), asmjit::FuncSignature::kNoVarArgs, lua::memory::get_type_id(return_type));

			for (const std::string& s : param_types)
			{
				sig.addArg(lua::memory::get_type_id(s));
			}

			return make_jit_func(sig, arch, callback, original_func_ptr);
		}

		void create_and_enable_hook(const std::string& hook_name, uintptr_t target_func_ptr, uintptr_t jitted_func_ptr)
		{
			m_detour->set_instance(hook_name, (void*)target_func_ptr, (void*)jitted_func_ptr);

			m_detour->enable();
		}
	};
} // namespace qstd

#define BIND_USERTYPE(lua_variable, type_name, field_name) lua_variable[#field_name] = &type_name::field_name;

static sol::object RValue_to_lua(const RValue& res, sol::this_state this_state_)
{
	switch (res.type & MASK_TYPE_RVALUE)
	{
	case STRING: return sol::make_object<const char*>(this_state_, res.ref_string->get());
	case _BOOL:  return sol::make_object<bool>(this_state_, res.asBoolean());
	case REAL:
	case _INT32:
	case _INT64: return sol::make_object<double>(this_state_, res.asReal());
	case ARRAY:
		YYObjectPinMap::pin(res.ref_array);
		return sol::make_object<RefDynamicArrayOfRValue*>(this_state_, res.ref_array);
	case REF: return sol::make_object<CInstance*>(this_state_, gm::CInstance_id_to_CInstance[res.i32]);
	case PTR: return sol::make_object<uintptr_t>(this_state_, (uintptr_t)res.ptr);
	case OBJECT:
		if (res.yy_object_base->type == YYObjectBaseType::CINSTANCE)
		{
			return sol::make_object<CInstance*>(this_state_, (CInstance*)res.ptr);
		}
		if (res.yy_object_base->type == YYObjectBaseType::SCRIPTREF)
		{
			return sol::make_object<CScriptRef*>(this_state_, (CScriptRef*)res.ptr);
		}
		return sol::make_object<YYObjectBase*>(this_state_, res.yy_object_base);
	case UNDEFINED:
	case UNSET:     return sol::lua_nil;
	default:        return sol::make_object<RValue>(this_state_, res);
	}
}

static RValue parse_sol_object(sol::object arg)
{
	switch (arg.get_type())
	{
	case sol::type::number:  return RValue(arg.as<double>());
	case sol::type::string:  return RValue(arg.as<std::string>());
	case sol::type::boolean: return RValue(arg.as<bool>());
	case sol::type::userdata:
		if (arg.is<RefDynamicArrayOfRValue*>())
		{
			return RValue(arg.as<RefDynamicArrayOfRValue*>());
		}
		else if (arg.is<CScriptRef*>())
		{
			return RValue(arg.as<YYObjectBase*>());
		}
		else if (arg.is<CInstance*>())
		{
			return RValue(arg.as<CInstance*>());
		}
		else if (arg.is<YYObjectBase*>())
		{
			return RValue(arg.as<YYObjectBase*>());
		}
		break;
	//case sol::type::table: break;
	default: break;
	}

	if (arg.is<RValue>())
	{
		return arg.as<RValue>();
	}

	return {};
}

static std::vector<RValue> parse_variadic_args(sol::variadic_args args)
{
	std::vector<RValue> vec_args;
	vec_args.reserve(args.size());
	for (const auto& arg : args)
	{
		vec_args.push_back(parse_sol_object(arg));
	}
	return vec_args;
}

// Lua API: Table
// Name: gm
// Table containing helpers for interacting with the game maker engine.

namespace lua::game_maker
{
	static ankerl::unordered_dense::map<uintptr_t, std::unique_ptr<qstd::runtime_func>> hooks_original_func_ptr_to_info;

	static void builtin_script_callback(const qstd::runtime_func::parameters_t* p, const uint8_t count, qstd::runtime_func::return_value_t* ret_val, const uintptr_t original_func_ptr)
	{
		const auto result    = p->get<RValue*>(0);
		const auto self      = p->get<CInstance*>(1);
		const auto other     = p->get<CInstance*>(2);
		const auto arg_count = p->get<int>(3);
		const auto args      = p->get<RValue*>(4);

		const auto call_orig_if_true = big::lua_manager_extension::pre_builtin_execute((void*)original_func_ptr, self, other, result, arg_count, args);

		if (call_orig_if_true)
		{
			hooks_original_func_ptr_to_info[original_func_ptr]->m_detour->get_original<gm::TRoutine>()(result, self, other, arg_count, args);
		}

		big::lua_manager_extension::post_builtin_execute((void*)original_func_ptr, self, other, result, arg_count, args);
	}

	static void script_callback(const qstd::runtime_func::parameters_t* p, const uint8_t count, qstd::runtime_func::return_value_t* ret_val, const uintptr_t original_func_ptr)
	{
		const auto self      = p->get<CInstance*>(0);
		const auto other     = p->get<CInstance*>(1);
		const auto result    = p->get<RValue*>(2);
		const auto arg_count = p->get<int>(3);
		const auto args      = p->get<RValue**>(4);

		ret_val->m_return_value = (uintptr_t)result;

		const auto call_orig_if_true = big::lua_manager_extension::pre_script_execute((void*)original_func_ptr, self, other, result, arg_count, args);

		ret_val->m_return_value = (uintptr_t)result;

		if (call_orig_if_true)
		{
			hooks_original_func_ptr_to_info[original_func_ptr]->m_detour->get_original<PFUNC_YYGMLScript>()(self, other, result, arg_count, args);
		}

		ret_val->m_return_value = (uintptr_t)result;

		big::lua_manager_extension::post_script_execute((void*)original_func_ptr, self, other, result, arg_count, args);

		ret_val->m_return_value = (uintptr_t)result;
	}

	static void object_function_callback(const qstd::runtime_func::parameters_t* p, const uint8_t count, qstd::runtime_func::return_value_t* ret_val, const uintptr_t original_func_ptr)
	{
		const auto self  = p->get<CInstance*>(0);
		const auto other = p->get<CInstance*>(1);

		const auto call_orig_if_true = big::lua_manager_extension::pre_code_execute_fast((void*)original_func_ptr, self, other);

		if (call_orig_if_true)
		{
			hooks_original_func_ptr_to_info[original_func_ptr]->m_detour->get_original<PFUNC_YYGML>()(self, other);
		}

		big::lua_manager_extension::post_code_execute_fast((void*)original_func_ptr, self, other);
	}

	struct make_central_script_result
	{
		big::lua_module_ext* m_this_lua_module = nullptr;
		void* m_original_func_ptr              = nullptr;
		bool m_is_game_script_func             = false;
	};

	static ankerl::unordered_dense::map<int, std::string> script_index_to_name;

	struct builtin_or_script_function_info
	{
		uintptr_t function_ptr;
		bool is_builtin;
	};

	static builtin_or_script_function_info get_builtin_or_script_function_from_index(const int function_index)
	{
		if (function_index >= 100'000)
		{
			const auto cscript = big::g_pointers->m_rorr.m_script_data(function_index - 100'000);
			if (cscript)
			{
				return {.function_ptr = (uintptr_t)cscript->m_funcs->m_script_function, .is_builtin = false};
			}
			else
			{
				LOG(ERROR) << "Could not find a corresponding script function index (" << function_index << ")";
			}
		}
		else
		{
			gm::code_function_info result{};
			big::g_pointers->m_rorr.m_code_function_GET_the_function(function_index,
			                                                         &result.function_name,
			                                                         &result.function_ptr,
			                                                         &result.function_arg_count);

			if (result.function_ptr)
			{
				return {.function_ptr = (uintptr_t)result.function_ptr, .is_builtin = true};
			}
			else
			{
				LOG(ERROR) << "Could not find a corresponding builtin function index (" << function_index << ")";
			}
		}

		return {.function_ptr = 0};
	}

	static make_central_script_result make_central_script_hook(const double script_function_index_double, sol::this_environment& env, bool is_pre_hook)
	{
		auto mdl = (big::lua_module_ext*)big::lua_module::this_from(env);
		if (!mdl)
		{
			return {};
		}

		const int function_index = script_function_index_double;
		const auto func_info     = get_builtin_or_script_function_from_index(function_index);
		if (!func_info.function_ptr)
		{
			return {};
		}

		if (!func_info.is_builtin)
		{
			std::stringstream hook_name;
			hook_name << mdl->guid() << " | " << script_index_to_name[function_index] << " | "
			          << (is_pre_hook ? mdl->m_data_ext.m_pre_script_execute_callbacks.size() :
			                            mdl->m_data_ext.m_post_script_execute_callbacks.size());

			LOG(INFO) << "hook_name: " << hook_name.str();

			const auto original_func_ptr = func_info.function_ptr;

			if (!hooks_original_func_ptr_to_info.contains(original_func_ptr))
			{
				std::unique_ptr<qstd::runtime_func> runtime_func = std::make_unique<qstd::runtime_func>();

				// clang-format off
				const auto JIT = runtime_func->make_jit_func(
					"RValue*",
					{"CInstance*", "CInstance*", "RValue*", "int", "RValue**"},
					asmjit::Arch::kHost,
					&script_callback,
					original_func_ptr);
				// clang-format on

				//LOG(INFO) << "hook func address: " << HEX_TO_UPPER(JIT);

				hooks_original_func_ptr_to_info.emplace(original_func_ptr, std::move(runtime_func));

				hooks_original_func_ptr_to_info[original_func_ptr]->create_and_enable_hook(hook_name.str(), original_func_ptr, JIT);
			}

			return {mdl, (void*)original_func_ptr, true};
		}
		else
		{
			std::stringstream hook_name;
			hook_name << mdl->guid() << " | " << script_index_to_name[function_index] << " | "
			          << (is_pre_hook ? mdl->m_data_ext.m_pre_builtin_execute_callbacks.size() :
			                            mdl->m_data_ext.m_post_builtin_execute_callbacks.size());

			LOG(INFO) << "hook_name: " << hook_name.str();

			const auto original_func_ptr = func_info.function_ptr;

			if (!hooks_original_func_ptr_to_info.contains(original_func_ptr))
			{
				std::unique_ptr<qstd::runtime_func> runtime_func = std::make_unique<qstd::runtime_func>();

				// clang-format off
				const auto JIT = runtime_func->make_jit_func(
					"void",
					{"RValue*", "CInstance*", "CInstance*", "int", "RValue*"},
					asmjit::Arch::kHost,
					&builtin_script_callback,
					original_func_ptr);
				// clang-format on

				//LOG(INFO) << "hook func address: " << HEX_TO_UPPER(JIT);

				hooks_original_func_ptr_to_info.emplace(original_func_ptr, std::move(runtime_func));

				hooks_original_func_ptr_to_info[original_func_ptr]->create_and_enable_hook(hook_name.str(), original_func_ptr, JIT);
			}

			return {mdl, (void*)original_func_ptr, false};
		}

		return {};
	}

	static uintptr_t get_object_function_ptr(const std::string& function_name)
	{
		static auto lazy_init_gml_func_cache = []()
		{
			ankerl::unordered_dense::map<std::string, uintptr_t> gml_func_cache;

			auto gml_funcs = big::g_pointers->m_rorr.m_GMLFuncs;

			const auto game_base_address = (uintptr_t)GetModuleHandleA(0);

			while (true)
			{
				if (gml_funcs->m_name &&
				    //stupid bound check, better check would be to check if function ptr is inside module .text range begin / end
				    ((uintptr_t)gml_funcs->m_script_function - game_base_address) < 0xF'F0'00'00'00)
				{
					gml_func_cache[gml_funcs->m_name] = (uintptr_t)gml_funcs->m_script_function;

					gml_funcs++;
				}
				else
				{
					break;
				}
			}

			return gml_func_cache;
		}();
		const auto ptr_it = lazy_init_gml_func_cache.find(function_name);
		if (ptr_it == lazy_init_gml_func_cache.end())
		{
			LOG(ERROR) << "Could not find a corresponding object function pointer (" << function_name << ")";
			return 0;
		}
		return ptr_it->second;
	}

	static make_central_script_result make_central_object_function_hook(const std::string& function_name, sol::this_environment& env, bool is_pre_hook)
	{
		auto mdl = (big::lua_module_ext*)big::lua_module::this_from(env);
		if (!mdl)
		{
			return {};
		}

		const auto original_func_ptr = get_object_function_ptr(function_name);
		if (original_func_ptr == 0)
		{
			LOG(ERROR) << "Could not find a corresponding object function pointer (" << function_name << ")";
			return {};
		}

		std::stringstream hook_name;
		hook_name << mdl->guid() << " | " << function_name << " | "
		          << (is_pre_hook ? mdl->m_data_ext.m_pre_code_execute_fast_callbacks.size() :
		                            mdl->m_data_ext.m_post_code_execute_fast_callbacks.size());

		LOG(INFO) << "hook_name: " << hook_name.str();

		if (!hooks_original_func_ptr_to_info.contains(original_func_ptr))
		{
			std::unique_ptr<qstd::runtime_func> runtime_func = std::make_unique<qstd::runtime_func>();
			uintptr_t JIT;
			if (function_name.starts_with("gml_Object"))
			{
				// clang-format off
				JIT = runtime_func->make_jit_func(
					"void",
					{"CInstance*", "CInstance*"},
					asmjit::Arch::kHost,
					&object_function_callback,
					original_func_ptr);
				// clang-format on
			}
			else
			{
				// clang-format off
				JIT = runtime_func->make_jit_func(
					"RValue*",
					{"CInstance*", "CInstance*", "RValue*", "int", "RValue**"},
					asmjit::Arch::kHost,
					&script_callback,
					original_func_ptr);
				// clang-format on
			}

			//LOG(INFO) << "hook func address: " << HEX_TO_UPPER(JIT);

			hooks_original_func_ptr_to_info.emplace(original_func_ptr, std::move(runtime_func));

			hooks_original_func_ptr_to_info[original_func_ptr]->create_and_enable_hook(hook_name.str(), original_func_ptr, JIT);
		}

		return {mdl, (void*)original_func_ptr, true};
	}

	// Lua API: Function
	// Table: gm
	// Name: pre_code_execute
	// Param: function_name: string (optional): Function name to hook. If you pass a valid name, the hook will be a lot faster to execute. Example valid function name: `gml_Object_oStartMenu_Step_2`
	// Param: callback: function: callback that match signature function ( self (CInstance), other (CInstance) ) for **fast** overload and ( self (CInstance), other (CInstance), code (CCode), result (RValue), flags (number) ) for **non fast** overload.
	// Registers a callback that will be called right before any object function is called. Note: for script functions, use pre_script_hook / post_script_hook
	static void pre_code_execute_fast(const std::string& function_name, sol::protected_function cb, sol::this_environment env)
	{
		const auto res = make_central_object_function_hook(function_name, env, true);
		if (res.m_this_lua_module && res.m_original_func_ptr)
		{
			res.m_this_lua_module->m_data_ext.m_pre_code_execute_fast_callbacks[res.m_original_func_ptr].push_back(cb);
		}
	}

	static constexpr auto slow_code_execute_warning =
	    "without passing a function name is deprecated and not recommended for use "
	    "because of its slowness. You can still use it for debugging / development as it can be "
	    "still useful for observing what the game code is doing.";

	static void pre_code_execute(sol::protected_function cb, sol::this_environment env)
	{
		auto mdl = (big::lua_module_ext*)big::lua_module::this_from(env);
		if (mdl)
		{
			LOG(WARNING) << "pre_code_execute " << slow_code_execute_warning;

			mdl->m_data_ext.m_pre_code_execute_callbacks.push_back(cb);
		}
	}

	// Lua API: Function
	// Table: gm
	// Name: post_code_execute
	// Param: function_name: string (optional): Function name to hook. If you pass a valid name, the hook will be a lot faster to execute. Example valid function name: `gml_Object_oStartMenu_Step_2`
	// Param: callback: function: callback that match signature function ( self (CInstance), other (CInstance) ) for **fast** overload and ( self (CInstance), other (CInstance), code (CCode), result (RValue), flags (number) ) for **non fast** overload.
	// Registers a callback that will be called right after any object function is called. Note: for script functions, use pre_script_hook / post_script_hook
	static void post_code_execute_fast(const std::string& function_name, sol::protected_function cb, sol::this_environment env)
	{
		const auto res = make_central_object_function_hook(function_name, env, true);
		if (res.m_this_lua_module && res.m_original_func_ptr)
		{
			res.m_this_lua_module->m_data_ext.m_post_code_execute_fast_callbacks[res.m_original_func_ptr].push_back(cb);
		}
	}

	static void post_code_execute(sol::protected_function cb, sol::this_environment env)
	{
		auto mdl = (big::lua_module_ext*)big::lua_module::this_from(env);
		if (mdl)
		{
			LOG(WARNING) << "post_code_execute " << slow_code_execute_warning;

			mdl->m_data_ext.m_post_code_execute_callbacks.push_back(cb);
		}
	}

	// Lua API: Function
	// Table: gm
	// Name: pre_script_hook
	// Param: function_index: number: index of the game script / builtin game maker function to hook, for example `gm.constants.callback_execute`
	// Param: callback: function: callback that match signature function ( self (CInstance), other (CInstance), result (RValue), args (RValue array) ) -> Return true or false depending on if you want the orig method to be called.
	// Registers a callback that will be called right before any script function is called. Note: for object functions, use pre_code_execute / post_code_execute
	static void pre_script_hook(const double script_function_index_double, sol::protected_function cb, sol::this_environment env)
	{
		const auto res = make_central_script_hook(script_function_index_double, env, true);
		if (res.m_this_lua_module && res.m_original_func_ptr)
		{
			if (res.m_is_game_script_func)
			{
				res.m_this_lua_module->m_data_ext.m_pre_script_execute_callbacks[res.m_original_func_ptr].push_back(cb);
			}
			else
			{
				res.m_this_lua_module->m_data_ext.m_pre_builtin_execute_callbacks[res.m_original_func_ptr].push_back(cb);
			}
		}
	}

	// Lua API: Function
	// Table: gm
	// Name: post_script_hook
	// Param: function_index: number: index of the game script / builtin game maker function to hook, for example `gm.constants.callback_execute`
	// Param: callback: function: callback that match signature function ( self (CInstance), other (CInstance), result (RValue), args (RValue array) )
	// Registers a callback that will be called right after any script function is called. Note: for object functions, use pre_code_execute / post_code_execute
	static void post_script_hook(const double script_function_index_double, sol::protected_function cb, sol::this_environment env)
	{
		const auto res = make_central_script_hook(script_function_index_double, env, false);
		if (res.m_this_lua_module && res.m_original_func_ptr)
		{
			if (res.m_is_game_script_func)
			{
				res.m_this_lua_module->m_data_ext.m_post_script_execute_callbacks[res.m_original_func_ptr].push_back(cb);
			}
			else
			{
				res.m_this_lua_module->m_data_ext.m_post_builtin_execute_callbacks[res.m_original_func_ptr].push_back(cb);
			}
		}
	}

	// Lua API: Function
	// Table: gm
	// Name: variable_global_get
	// Param: name: string: name of the variable
	// Returns: value: The actual value behind the RValue, or RValue if the type is not handled yet.
	static sol::object lua_gm_variable_global_get(sol::this_state this_state_, std::string_view name)
	{
		return RValue_to_lua(gm::variable_global_get(name), this_state_);
	}

	// Lua API: Function
	// Table: gm
	// Name: variable_global_set
	// Param: name: string: name of the variable
	// Param: new_value: any: new value
	static void lua_gm_variable_global_set(std::string_view name, sol::reference new_value)
	{
		auto val = parse_sol_object(new_value);
		gm::variable_global_set(name, val);
	}

	// Lua API: Function
	// Table: gm
	// Name: call
	// Param: name: string: name of the function to call
	// Param: self: CInstance: (optional)
	// Param: other: CInstance: (optional)
	// Param: args: any: (optional)
	// Returns: value: The actual value behind the RValue, or RValue if the type is not handled yet.
	static sol::object lua_gm_call(sol::this_state this_state_, std::string_view name, CInstance* self, CInstance* other, sol::variadic_args args)
	{
		return RValue_to_lua(gm::call(name, self, other, parse_variadic_args(args)), this_state_);
	}

	static sol::object lua_gm_call_global(sol::this_state this_state_, std::string_view name, sol::variadic_args args)
	{
		return RValue_to_lua(gm::call(name, parse_variadic_args(args)), this_state_);
	}

	// Lua API: Function
	// Table: gm
	// Name: struct_create
	// Returns: YYObjectBase*: The freshly made empty struct
	static YYObjectBase* lua_struct_create()
	{
		RValue out_res;
		big::g_pointers->m_rorr.m_struct_create(&out_res);
		return out_res.yy_object_base;
	}

	// Lua API: Function
	// Table: gm
	// Name: gmf_struct_create
	// Returns: number: The freshly made empty struct pointer
	static uintptr_t lua_gmf_struct_create()
	{
		RValue out_res;
		big::g_pointers->m_rorr.m_struct_create(&out_res);
		return (uintptr_t)out_res.yy_object_base;
	}

	// based on https://github.com/YAL-GameMaker/shader_replace_unsafe/blob/main/shader_replace_unsafe/shader_add.cpp
	// I think my solution is terrible.
	std::string shader_model = "4_0";

	static YYShader* shader_compiler(std::string file_path, std::string name, int id)
	{
		int size = MultiByteToWideChar(CP_UTF8, 0, file_path.c_str(), -1, nullptr, 0) - 1;
		std::wstring wide_file_path(size, 0);
		MultiByteToWideChar(CP_UTF8, 0, file_path.c_str(), -1, &wide_file_path[0], size);

		std::wstring vertex_path = wide_file_path + L".vsh";
		std::wstring pixel_path  = wide_file_path + L".fsh";


		auto vs_model = "vs_" + shader_model;
		auto ps_model = "ps_" + shader_model;

		// https://github.com/GameMakerDiscord/gists/blob/master/HLSL_default_shader
		D3D_SHADER_MACRO macros[] = {{"MATRIX_VIEW", "0"}, {"MATRIX_PROJECTION", "1"}, {"MATRIX_WORLD", "2"}, {"MATRIX_WORLD_VIEW", "3"}, {"MATRIX_WORLD_VIEW_PROJECTION", "4"}, {"MATRICES_MAX", "5"}, {"MAX_VS_LIGHTS", "8"}, {nullptr, nullptr}};

		Microsoft::WRL::ComPtr<ID3DBlob> vertex_blob;
		Microsoft::WRL::ComPtr<ID3DBlob> pixel_blob;
		Microsoft::WRL::ComPtr<ID3D11ShaderReflection> vertex_reflection;
		Microsoft::WRL::ComPtr<ID3D11ShaderReflection> pixel_reflection;

		Microsoft::WRL::ComPtr<ID3DBlob> error_blob;
		HRESULT hr;

		std::string shader_last_error;

#define m_try_break(_call, _text)                                                             \
	{                                                                                         \
		hr = _call;                                                                           \
		if (FAILED(hr))                                                                       \
		{                                                                                     \
			shader_last_error = std::string(_text) + " (hresult:" + std::to_string(hr) + ")"; \
			break;                                                                            \
		}                                                                                     \
	}
		do
		{
			m_try_break(D3DCompileFromFile(vertex_path.c_str(),
			                               macros,
			                               D3D_COMPILE_STANDARD_FILE_INCLUDE,
			                               "main",
			                               vs_model.c_str(),
			                               D3DCOMPILE_ENABLE_BACKWARDS_COMPATIBILITY,
			                               0,
			                               vertex_blob.GetAddressOf(),
			                               error_blob.GetAddressOf());
			            , "Vertex shader compile failed");
			m_try_break(D3DCompileFromFile(pixel_path.c_str(),
			                               macros,
			                               D3D_COMPILE_STANDARD_FILE_INCLUDE,
			                               "main",
			                               ps_model.c_str(),
			                               D3DCOMPILE_ENABLE_BACKWARDS_COMPATIBILITY,
			                               0,
			                               pixel_blob.GetAddressOf(),
			                               error_blob.GetAddressOf()),
			            "Pixel shader compile failed");

			m_try_break(D3DReflect(vertex_blob->GetBufferPointer(),
			                       vertex_blob->GetBufferSize(),
			                       IID_ID3D11ShaderReflection,
			                       (void**)vertex_reflection.GetAddressOf()),
			            "Vertex shader reflection failed");

			m_try_break(D3DReflect(pixel_blob->GetBufferPointer(),
			                       pixel_blob->GetBufferSize(),
			                       IID_ID3D11ShaderReflection,
			                       (void**)pixel_reflection.GetAddressOf()),
			            "Pixel shader reflection failed");

			std::vector<char> vertexShaderRaw = YYShaderDataHeader(vertex_blob, vertex_reflection).convertToRaw();
			std::vector<char> pixelShaderRaw  = YYShaderDataHeader(pixel_blob, pixel_reflection).convertToRaw();

			YYShader* shader = new YYShader(name, id, vertexShaderRaw, pixelShaderRaw);

			LOG(INFO) << "shader compile success " << name;
			return shader;
		} while (false);
#undef m_try_break
		if (error_blob)
		{
			shader_last_error += std::string(": ") + (const char*)error_blob->GetBufferPointer();
		}
		LOG(ERROR) << "shader compile failed " << name << shader_last_error;
		return nullptr;
	}

	// The find_shader_by_name function exists in GameMaker.


	// Lua API: Function
	// Table: gm
	// Name: find_shader_by_name
	// Param: shader_name: string: the name of shader.
	// Returns: value: The id of the shader.
	static int lua_find_shader_by_name(std::string name)
	{
		int shader_amount = *big::g_pointers->m_rorr.m_shader_amount;
		for (int i = 0; i < shader_amount; i++)
		{
			YYShader* shader = (*big::g_pointers->m_rorr.m_shader_pool)[i];
			if (name == shader->name)
			{
				return i;
			}
		}
		return -1;
	}

	// Lua API: Function
	// Table: gm
	// Name: shader_replace
	// Param: file_path: string: the path to the shader source code (must be HLSL).
	// Param: name: string: the shader name.
	// Param: id: int: the id of the shader to replace.
	static void lua_shader_replace(std::string file_path, std::string name, int id)
	{
		if (id < 0 || id >= *big::g_pointers->m_rorr.m_shader_amount)
		{
			LOG(ERROR) << "Failed to replace shader. InValid shader id.";
			return;
		}
		int existing_shader_id = lua_find_shader_by_name(name);
		if (existing_shader_id != -1 && existing_shader_id != id)
		{
			LOG(ERROR) << "Failed to replace shader. The shader name already exists.";
			return;
		}
		YYShader* shader = shader_compiler(file_path, name, id);
		if (shader == nullptr)
		{
			return;
		}
		int native_shader_handle = -1;
		YYNativeShader* native_shader = new YYNativeShader(shader->HLSL11.vertexShader, shader->HLSL11.pixelShader, native_shader_handle);


		if (native_shader_handle < 0)
		{
			if (native_shader_handle == -1)
			{
				LOG(ERROR) << "Failed to replace shader. Vertex shader not compatible with this device";
			}
			else if (native_shader_handle == -2)
			{
				LOG(ERROR) << "Failed to replace shader. Pixel shader not compatible with this device";
			}
			else
			{
				LOG(ERROR) << "Failed to replace shader. Unknow error.";
			}
			delete native_shader;
			delete shader;
			return;
		}

		shader->native_shader_handle = id;

		delete (*big::g_pointers->m_rorr.m_shader_pool)[id];
		delete (*big::g_pointers->m_rorr.m_native_shader_pool)[id];

		(*big::g_pointers->m_rorr.m_shader_pool)[id]        = shader;
		(*big::g_pointers->m_rorr.m_native_shader_pool)[id] = native_shader;

		shader->gm_BaseTexture = gm::call("shader_get_sampler_index", std::to_array<RValue, 2>({id, "gm_BaseTexture"}));
		shader->gm_Matrices    = gm::call("shader_get_uniform", std::to_array<RValue, 2>({id, "gm_Matrices"}));
		shader->gm_Lights_Direction = gm::call("shader_get_uniform", std::to_array<RValue, 2>({id, "gm_Lights_Direction"}));
		shader->gm_Lights_PosRange = gm::call("shader_get_uniform", std::to_array<RValue, 2>({id, "gm_Lights_PosRange"}));
		shader->gm_Lights_Colour = gm::call("shader_get_uniform", std::to_array<RValue, 2>({id, "gm_Lights_Colour"}));
		shader->gm_AmbientColour = gm::call("shader_get_uniform", std::to_array<RValue, 2>({id, "gm_AmbientColour"}));
		shader->gm_LightingEnabled = gm::call("shader_get_uniform", std::to_array<RValue, 2>({id, "gm_LightingEnabled"}));
	}

	// Lua API: Function
	// Table: gm
	// Name: shader_add
	// Param: file_path: string: the path to the shader source code (must be HLSL). Check https://github.com/GameMakerDiscord/gists/blob/master/HLSL_passthrough for example.
	// Param: name: string: the shader name.
	// Returns: value: The id of the shader.
	// **Example Usage**
	// ```lua
	// local shd_test = gm.shader_add(path.combine(PATH, "shd_test"), "shd_test")
	// ```
	static int lua_shader_add(std::string file_path, std::string name)
	{
		int existing_shader_id = lua_find_shader_by_name(name);
		if (existing_shader_id != -1)
		{
			LOG(WARNING) << "The shader name already exists. Try replacing instead of adding.";
			lua_shader_replace(file_path, name, existing_shader_id);
			return existing_shader_id;
		}
		YYShader* shader = shader_compiler(file_path, name, *big::g_pointers->m_rorr.m_shader_amount);

		if (shader == nullptr)
		{
			return -1;
		}
		(*big::g_pointers->m_rorr.m_shader_amount)++;
		*big::g_pointers->m_rorr.m_shader_pool =
		    (YYShader**)big::g_pointers->m_rorr.m_memorymanager_realloc(*big::g_pointers->m_rorr.m_shader_pool,
		                                                                8 * (*big::g_pointers->m_rorr.m_shader_amount));
		(*big::g_pointers->m_rorr.m_shader_pool)[shader->id] = shader;
		big::g_pointers->m_rorr.m_shader_create(shader);
		return shader->id;
	}

	// Lua API: Function
	// Table: gm
	// Name: shader_dump
	// Param: id: int: The id of the shader.
	// **Example Usage**
	// ```lua
	// gm.shader_dump(1)
	// ```
	static void lua_shader_dump(int id)
	{
		if (id < 0 || id >= *big::g_pointers->m_rorr.m_shader_amount)
		{
			LOG(ERROR) << "Failed to dump shader. InValid shader id.";
			return;
		}

		const auto& native_shader = (*big::g_pointers->m_rorr.m_native_shader_pool)[id];
		const auto& shader        = (*big::g_pointers->m_rorr.m_shader_pool)[id];

		for (int i = 0; i < native_shader->constBufVarCount; i++)
		{
			const auto& cvars = native_shader->constBufVars[i];
			LOG(INFO) << "handle: " << i << " unfirom: " << cvars.name << " type: " << (UINT)cvars.type;
		}

		LOG(INFO) << "gm_BaseTexture: " << shader->gm_BaseTexture << "\n gm_Matrices: " << shader->gm_Matrices
		          << "\n gm_Lights_Direction: " << shader->gm_Lights_Direction << "\n gm_Lights_PosRange: " << shader->gm_Lights_PosRange
		          << "\n gm_Lights_Colour: " << shader->gm_Lights_Colour << "\n gm_AmbientColour: " << shader->gm_AmbientColour
		          << "\n gm_LightingEnabled: " << shader->gm_LightingEnabled;

		Microsoft::WRL::ComPtr<ID3DBlob> disassembly;
		HRESULT hr = D3DDisassemble(native_shader->vertexHeader->shader_data,
		                            native_shader->vertexHeader->shader_size,
		                            D3D_DISASM_ENABLE_INSTRUCTION_OFFSET | D3D_DISASM_ENABLE_INSTRUCTION_CYCLE,
		                            nullptr,
		                            disassembly.GetAddressOf());
		if (FAILED(hr))
		{
			LOG(ERROR) << "Failed to disassemble shader.";
		}
		else
		{
			LOG(INFO) << "Vertex Disassembly: \n" << (char*)(disassembly->GetBufferPointer());
		}
		hr = D3DDisassemble(native_shader->pixelHeader->shader_data,
		                    native_shader->pixelHeader->shader_size,
		                    D3D_DISASM_ENABLE_INSTRUCTION_OFFSET | D3D_DISASM_ENABLE_INSTRUCTION_CYCLE,
		                    nullptr,
		                    disassembly.GetAddressOf());
		if (FAILED(hr))
		{
			LOG(ERROR) << "Failed to disassemble shader.";
		}
		else
		{
			LOG(INFO) << "Pixel Disassembly: \n" << (char*)(disassembly->GetBufferPointer());
		}
	}

	void bind(sol::table& state)
	{
		auto ns = state["gm"].get_or_create<sol::table>();

		// Lua API: Table
		// Name: YYObjectBaseType
		// Table containing all possible types of an YYObjectBaseType
		{
			state.new_enum<YYObjectBaseType>("YYObjectBaseType",
			                                 {
			                                     // Lua API: Field
			                                     // Table: YYObjectBaseType
			                                     // Field: YYOBJECTBASE: YYOBJECTBASE
			                                     {"YYOBJECTBASE", YYObjectBaseType::YYOBJECTBASE},

			                                     // Lua API: Field
			                                     // Table: YYObjectBaseType
			                                     // Field: CINSTANCE: CINSTANCE
			                                     {"CINSTANCE", YYObjectBaseType::CINSTANCE},

			                                     // Lua API: Field
			                                     // Table: YYObjectBaseType
			                                     // Field: ACCESSOR: ACCESSOR
			                                     {"ACCESSOR", YYObjectBaseType::ACCESSOR},

			                                     // Lua API: Field
			                                     // Table: YYObjectBaseType
			                                     // Field: SCRIPTREF: SCRIPTREF
			                                     {"SCRIPTREF", YYObjectBaseType::SCRIPTREF},

			                                     // Lua API: Field
			                                     // Table: YYObjectBaseType
			                                     // Field: PROPERTY: PROPERTY
			                                     {"PROPERTY", YYObjectBaseType::PROPERTY},

			                                     // Lua API: Field
			                                     // Table: YYObjectBaseType
			                                     // Field: ARRAY: ARRAY
			                                     {"ARRAY", YYObjectBaseType::ARRAY},

			                                     // Lua API: Field
			                                     // Table: YYObjectBaseType
			                                     // Field: WEAKREF: WEAKREF
			                                     {"WEAKREF", YYObjectBaseType::WEAKREF},

			                                     // Lua API: Field
			                                     // Table: YYObjectBaseType
			                                     // Field: CONTAINER: CONTAINER
			                                     {"CONTAINER", YYObjectBaseType::CONTAINER},

			                                     // Lua API: Field
			                                     // Table: YYObjectBaseType
			                                     // Field: SEQUENCE: SEQUENCE
			                                     {"SEQUENCE", YYObjectBaseType::SEQUENCE},

			                                     // Lua API: Field
			                                     // Table: YYObjectBaseType
			                                     // Field: SEQUENCEINSTANCE: SEQUENCEINSTANCE
			                                     {"SEQUENCEINSTANCE", YYObjectBaseType::SEQUENCEINSTANCE},

			                                     // Lua API: Field
			                                     // Table: YYObjectBaseType
			                                     // Field: SEQUENCETRACK: SEQUENCETRACK
			                                     {"SEQUENCETRACK", YYObjectBaseType::SEQUENCETRACK},

			                                     // Lua API: Field
			                                     // Table: YYObjectBaseType
			                                     // Field: SEQUENCECURVE: SEQUENCECURVE
			                                     {"SEQUENCECURVE", YYObjectBaseType::SEQUENCECURVE},

			                                     // Lua API: Field
			                                     // Table: YYObjectBaseType
			                                     // Field: SEQUENCECURVECHANNEL: SEQUENCECURVECHANNEL
			                                     {"SEQUENCECURVECHANNEL", YYObjectBaseType::SEQUENCECURVECHANNEL},

			                                     // Lua API: Field
			                                     // Table: YYObjectBaseType
			                                     // Field: SEQUENCEKEYFRAMESTORE: SEQUENCEKEYFRAMESTORE
			                                     {"SEQUENCEKEYFRAMESTORE", YYObjectBaseType::SEQUENCEKEYFRAMESTORE},

			                                     // Lua API: Field
			                                     // Table: YYObjectBaseType
			                                     // Field: SEQUENCEKEYFRAME: SEQUENCEKEYFRAME
			                                     {"SEQUENCEKEYFRAME", YYObjectBaseType::SEQUENCEKEYFRAME},

			                                     // Lua API: Field
			                                     // Table: YYObjectBaseType
			                                     // Field: SEQUENCEEVALTREE: SEQUENCEEVALTREE
			                                     {"SEQUENCEEVALTREE", YYObjectBaseType::SEQUENCEEVALTREE},

			                                     // Lua API: Field
			                                     // Table: YYObjectBaseType
			                                     // Field: SEQUENCEEVALNODE: SEQUENCEEVALNODE
			                                     {"SEQUENCEEVALNODE", YYObjectBaseType::SEQUENCEEVALNODE},

			                                     // Lua API: Field
			                                     // Table: YYObjectBaseType
			                                     // Field: SEQUENCEEVENT: SEQUENCEEVENT
			                                     {"SEQUENCEEVENT", YYObjectBaseType::SEQUENCEEVENT},

			                                     // Lua API: Field
			                                     // Table: YYObjectBaseType
			                                     // Field: NINESLICE: NINESLICE
			                                     {"NINESLICE", YYObjectBaseType::NINESLICE},
			                                 });
		}

		// Lua API: Class
		// Name: YYObjectBase
		// Class representing an object coming from the game maker engine
		{
			sol::usertype<YYObjectBase> type = state.new_usertype<YYObjectBase>(
			    "YYObjectBase",
			    sol::meta_function::index,
			    [](sol::this_state this_state_, YYObjectBase* self, const char* key)
			    {
				    const auto res = gm::call("struct_get", std::to_array<RValue, 2>({self, key}));

				    return RValue_to_lua(res, this_state_);
			    },
			    sol::meta_function::new_index,
			    [](YYObjectBase* self, const char* key, sol::stack_object value)
			    {
				    gm::call("struct_set", std::to_array<RValue, 3>({self, key, parse_sol_object(value)}));
			    });

			// Lua API: Field
			// Class: YYObjectBase
			// Field: type: YYObjectBaseType
			BIND_USERTYPE(type, YYObjectBase, type);

			// Lua API: Field
			// Class: YYObjectBase
			// Field: cinstance: CInstance|nil
			// nil if not a CInstance
			type["cinstance"] = sol::property(
			    [](YYObjectBase& inst, sol::this_state this_state_)
			    {
				    return inst.type == YYObjectBaseType::CINSTANCE ? sol::make_object(this_state_, (CInstance*)&inst) : sol::lua_nil;
			    });

			// Lua API: Field
			// Class: YYObjectBase
			// Field: script_name: string|nil
			// nil if not a SCRIPTREF. Can be used to then hook the function with a pre / post script hook. The `gml_Script_` prefix may need to be removed for the hook to work.
			type["script_name"] = sol::property(
			    [](YYObjectBase& inst, sol::this_state this_state_)
			    {
				    return inst.type == YYObjectBaseType::SCRIPTREF ?
				               sol::make_object(this_state_, ((CScriptRef*)&inst)->m_call_script->m_script_name) :
				               sol::lua_nil;
			    });
		}

		// Lua API: Class
		// Name: RValue
		// Class representing a value coming from the game maker engine
		{
			// Lua API: Constructor
			// Class: RValue
			// Param: value: boolean|number|string: value
			// Returns an RValue instance
			sol::usertype<RValue> type = state.new_usertype<RValue>("RValue", sol::constructors<RValue(), RValue(bool), RValue(double), RValue(const char*)>(), sol::meta_function::garbage_collect, sol::destructor(&RValue::__localFree));

			// Lua API: Field
			// Class: RValue
			// Field: type: RValueType: The actual type behind the RValue
			BIND_USERTYPE(type, RValue, type);

			// Lua API: Field
			// Class: RValue
			// Field: value: any: The actual value behind the RValue, or RValue if the type is not handled yet.
			type["value"] = sol::property(
			    [](RValue& inst, sol::this_state this_state_)
			    {
				    return RValue_to_lua(inst, this_state_);
			    },
			    [](RValue& inst, sol::object arg, sol::this_state this_state_)
			    {
				    inst = parse_sol_object(arg);
			    });

			// Lua API: Field
			// Class: RValue
			// Field: tostring: string: string representation of the RValue
			type["tostring"] = sol::property(
			    [](RValue& inst)
			    {
				    return inst.asString();
			    });
		}

		// Lua API: Table
		// Name: RValueType
		// Table containing all possible types of an RValue
		{
			state.new_enum<RValueType>("RValueType",
			                           {
			                               // Lua API: Field
			                               // Table: RValueType
			                               // Field: REAL: REAL
			                               {"REAL", RValueType::REAL},

			                               // Lua API: Field
			                               // Table: RValueType
			                               // Field: STRING: STRING
			                               {"STRING", RValueType::STRING},

			                               // Lua API: Field
			                               // Table: RValueType
			                               // Field: ARRAY: ARRAY
			                               {"ARRAY", RValueType::ARRAY},

			                               // Lua API: Field
			                               // Table: RValueType
			                               // Field: PTR: PTR
			                               {"PTR", RValueType::PTR},

			                               // Lua API: Field
			                               // Table: RValueType
			                               // Field: VEC3: VEC3
			                               {"VEC3", RValueType::VEC3},

			                               // Lua API: Field
			                               // Table: RValueType
			                               // Field: UNDEFINED: UNDEFINED
			                               {"UNDEFINED", RValueType::UNDEFINED},

			                               // Lua API: Field
			                               // Table: RValueType
			                               // Field: OBJECT: OBJECT
			                               {"OBJECT", RValueType::OBJECT},

			                               // Lua API: Field
			                               // Table: RValueType
			                               // Field: INT32: INT32
			                               {"INT32", RValueType::_INT32},

			                               // Lua API: Field
			                               // Table: RValueType
			                               // Field: VEC4: VEC4
			                               {"VEC4", RValueType::VEC4},

			                               // Lua API: Field
			                               // Table: RValueType
			                               // Field: MATRIX: MATRIX
			                               {"MATRIX", RValueType::MATRIX},

			                               // Lua API: Field
			                               // Table: RValueType
			                               // Field: INT64: INT64
			                               {"INT64", RValueType::_INT64},

			                               // Lua API: Field
			                               // Table: RValueType
			                               // Field: ACCESSOR: ACCESSOR
			                               {"ACCESSOR", RValueType::ACCESSOR},

			                               // Lua API: Field
			                               // Table: RValueType
			                               // Field: JSNULL: JSNULL
			                               {"JSNULL", RValueType::JSNULL},

			                               // Lua API: Field
			                               // Table: RValueType
			                               // Field: BOOL: BOOL
			                               {"BOOL", RValueType::_BOOL},

			                               // Lua API: Field
			                               // Table: RValueType
			                               // Field: ITERATOR: ITERATOR
			                               {"ITERATOR", RValueType::ITERATOR},

			                               // Lua API: Field
			                               // Table: RValueType
			                               // Field: REF: REF
			                               {"REF", RValueType::REF},

			                               // Lua API: Field
			                               // Table: RValueType
			                               // Field: UNSET: UNSET
			                               {"UNSET", RValueType::UNSET},
			                           });
		}

		// Lua API: Table
		// Name: EVariableType
		// Table containing all possible kind / type of variable within the GM engine.
		{
			state.new_enum<EVariableType>("EVariableType",
			                              {
			                                  // Lua API: Field
			                                  // Table: EVariableType
			                                  // Field: SELF: SELF
			                                  {"SELF", EVariableType::SELF},

			                                  // Lua API: Field
			                                  // Table: EVariableType
			                                  // Field: OTHER: OTHER
			                                  {"OTHER", EVariableType::OTHER},

			                                  // Lua API: Field
			                                  // Table: EVariableType
			                                  // Field: ALL: ALL
			                                  {"ALL", EVariableType::ALL},

			                                  // Lua API: Field
			                                  // Table: EVariableType
			                                  // Field: NOONE: NOONE
			                                  {"NOONE", EVariableType::NOONE},

			                                  // Lua API: Field
			                                  // Table: EVariableType
			                                  // Field: GLOBAL: GLOBAL
			                                  {"GLOBAL", EVariableType::GLOBAL},

			                                  // Lua API: Field
			                                  // Table: EVariableType
			                                  // Field: BUILTIN: BUILTIN
			                                  {"BUILTIN", EVariableType::BUILTIN},

			                                  // Lua API: Field
			                                  // Table: EVariableType
			                                  // Field: LOCAL: LOCAL
			                                  {"LOCAL", EVariableType::LOCAL},

			                                  // Lua API: Field
			                                  // Table: EVariableType
			                                  // Field: STACKTOP: STACKTOP
			                                  {"STACKTOP", EVariableType::STACKTOP},

			                                  // Lua API: Field
			                                  // Table: EVariableType
			                                  // Field: ARGUMENT: ARGUMENT
			                                  {"ARGUMENT", EVariableType::ARGUMENT},
			                              });
		}

		// Lua API: Class
		// Name: CInstance
		// Class representing a game maker object instance.
		//
		// You can use most if not all of the builtin game maker variables (For example `myCInstance.x`) [listed here](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Asset_Management/Instances/Instance_Variables/Instance_Variables.htm).
		//
		// To know the specific instance variables of a given object defined by the game call dump_vars() on the instance
		{
			static sol::usertype<CInstance> type = state.new_usertype<CInstance>(
			    "CInstance",
			    sol::meta_function::index,
			    [&](sol::this_state this_state_, CInstance* self, const char* key) -> sol::object
			    {
				    const auto var_get_args = std::to_array<RValue, 2>({self->id, key});
				    const auto var_exists   = gm::call("variable_instance_exists", var_get_args);
				    if (var_exists.asBoolean())
				    {
					    const auto res = gm::call("variable_instance_get", var_get_args);
					    return RValue_to_lua(res, this_state_);
				    }
				    else
				    {
					    if (!gm::is_valid_call(key))
					    {
						    return sol::lua_nil;
					    }

					    const std::string key_str_copy = key;
					    type[key] = [key_str_copy](sol::this_state this_state_, sol::object key, sol::variadic_args args)
					    {
						    const auto res = gm::call(key_str_copy, key.as<CInstance*>(), nullptr, parse_variadic_args(args));
						    return RValue_to_lua(res, this_state_);
					    };
					    return type[key];
				    }
			    },
			    sol::meta_function::new_index,
			    [](CInstance* self, const char* key, sol::object value)
			    {
				    gm::call("variable_instance_set", std::to_array<RValue, 3>({self->id, key, parse_sol_object(value)}));
			    });

			BIND_USERTYPE(type, CInstance, m_CreateCounter);

			BIND_USERTYPE(type, CInstance, m_Instflags);

			// Lua API: Field
			// Class: CInstance
			// Field: id: number
			BIND_USERTYPE(type, CInstance, id);

			// Lua API: Field
			// Class: CInstance
			// Field: object_index: number
			BIND_USERTYPE(type, CInstance, object_index);

			// Lua API: Field
			// Class: CInstance
			// Field: sprite_index: number
			BIND_USERTYPE(type, CInstance, sprite_index);

			BIND_USERTYPE(type, CInstance, i_sequencePos);
			BIND_USERTYPE(type, CInstance, i_lastSequencePos);
			BIND_USERTYPE(type, CInstance, i_sequenceDir);

			// Lua API: Field
			// Class: CInstance
			// Field: image_index: number
			BIND_USERTYPE(type, CInstance, image_index);

			// Lua API: Field
			// Class: CInstance
			// Field: image_speed: number
			BIND_USERTYPE(type, CInstance, image_speed);

			// Lua API: Field
			// Class: CInstance
			// Field: image_xscale: number
			BIND_USERTYPE(type, CInstance, image_xscale);

			// Lua API: Field
			// Class: CInstance
			// Field: image_yscale: number
			BIND_USERTYPE(type, CInstance, image_yscale);

			// Lua API: Field
			// Class: CInstance
			// Field: image_angle: number
			BIND_USERTYPE(type, CInstance, image_angle);

			// Lua API: Field
			// Class: CInstance
			// Field: image_alpha: number
			BIND_USERTYPE(type, CInstance, image_alpha);

			// Lua API: Field
			// Class: CInstance
			// Field: image_blend: number
			BIND_USERTYPE(type, CInstance, image_blend);

			// Lua API: Field
			// Class: CInstance
			// Field: x: number
			BIND_USERTYPE(type, CInstance, x);

			// Lua API: Field
			// Class: CInstance
			// Field: y: number
			BIND_USERTYPE(type, CInstance, y);

			// Lua API: Field
			// Class: CInstance
			// Field: xstart: number
			BIND_USERTYPE(type, CInstance, xstart);

			// Lua API: Field
			// Class: CInstance
			// Field: ystart: number
			BIND_USERTYPE(type, CInstance, ystart);

			// Lua API: Field
			// Class: CInstance
			// Field: xprevious: number
			BIND_USERTYPE(type, CInstance, xprevious);

			// Lua API: Field
			// Class: CInstance
			// Field: yprevious: number
			BIND_USERTYPE(type, CInstance, yprevious);

			// Lua API: Field
			// Class: CInstance
			// Field: direction: number
			BIND_USERTYPE(type, CInstance, direction);

			// Lua API: Field
			// Class: CInstance
			// Field: speed: number
			BIND_USERTYPE(type, CInstance, speed);

			// Lua API: Field
			// Class: CInstance
			// Field: friction: number
			BIND_USERTYPE(type, CInstance, friction);

			// Lua API: Field
			// Class: CInstance
			// Field: gravity_direction: number
			BIND_USERTYPE(type, CInstance, gravity_direction);

			// Lua API: Field
			// Class: CInstance
			// Field: gravity: number
			BIND_USERTYPE(type, CInstance, gravity);

			// Lua API: Field
			// Class: CInstance
			// Field: hspeed: number
			BIND_USERTYPE(type, CInstance, hspeed);

			// Lua API: Field
			// Class: CInstance
			// Field: vspeed: number
			BIND_USERTYPE(type, CInstance, vspeed);

			// Lua API: Field
			// Class: CInstance
			// Field: bbox: number[4] array
			type["bbox"] = sol::property(
			    [](CInstance& inst)
			    {
				    return std::span(inst.bbox);
			    });

			// Lua API: Field
			// Class: CInstance
			// Field: timer: number[12] array
			type["timer"] = sol::property(
			    [](CInstance& inst)
			    {
				    return std::span(inst.timer);
			    });

			// Lua API: Field
			// Class: CInstance
			// Field: layer: number
			BIND_USERTYPE(type, CInstance, layer);

			// Lua API: Field
			// Class: CInstance
			// Field: mask_index: number
			BIND_USERTYPE(type, CInstance, mask_index);

			// Lua API: Field
			// Class: CInstance
			// Field: m_nMouseOver: number
			BIND_USERTYPE(type, CInstance, m_nMouseOver);

			// Lua API: Field
			// Class: CInstance
			// Field: depth: number
			BIND_USERTYPE(type, CInstance, depth);

			// Lua API: Field
			// Class: CInstance
			// Field: i_currentdepth: number
			BIND_USERTYPE(type, CInstance, i_currentdepth);

			BIND_USERTYPE(type, CInstance, i_lastImageNumber);
			BIND_USERTYPE(type, CInstance, m_collisionTestNumber);

			// Lua API: Field
			// Class: CInstance
			// Field: object_name: string
			type["object_name"] = sol::property(&CInstance::object_name);

			auto CInstance_table = ns["CInstance"].get_or_create<sol::table>();

			// Lua API: Field
			// Table: gm.CInstance
			// Field: instances_all: table<CInstance>
			// table of all (active or unactive) game maker object instances
			CInstance_table["instances_all"] = std::ref(gm::CInstances_all);

			// Lua API: Field
			// Table: gm.CInstance
			// Field: instances_active: table<CInstance>
			// table of all active game maker object instances
			CInstance_table["instances_active"] = std::ref(gm::CInstances_active);

			// Lua API: Field
			// Table: gm.CInstance
			// Field: instance_id_to_CInstance: table<number, CInstance>
			// table of all game maker object instances ids to their corresponding CInstance
			CInstance_table["instance_id_to_CInstance"]     = std::ref(gm::CInstance_id_to_CInstance);
			CInstance_table["instance_id_to_CInstance_ffi"] = std::ref(gm::CInstance_id_to_CInstance_ffi);
		}

		// Lua API: Class
		// Name: CScriptRef
		// Class representing a game maker script reference.
		//
		// Can be called by having an instance and doing `someScriptRefInstance(self, other, someExtraArg)`.
		//
		// Atleast 2 args 'self' and 'other' game maker instances / structs need to be passed when calling the script.
		//
		// lua nil can also be passed if needed for those two args.
		//
		// Can also be hooked with a pre / post script hook. The `gml_Script_` prefix may need to be removed for the hook to work. Use the `script_name` field to retrieve the name.
		{
			sol::usertype<CScriptRef> type = state.new_usertype<CScriptRef>(
			    "CScriptRef",
			    sol::base_classes,
			    sol::bases<YYObjectBase>(),
			    sol::meta_function::call,
			    [](sol::this_state this_state_, CScriptRef* self, sol::variadic_args args_) -> sol::reference
			    {
				    if (self->type != YYObjectBaseType::SCRIPTREF)
				    {
					    LOG(WARNING) << "Attempted to call a YYObjectBase which was not a script reference.";
					    return sol::nil;
				    }

				    if (args_.size() < 2)
				    {
					    LOG(WARNING) << "Attempted to call a script reference without atleast 2 args 'self' "
					                    "and 'other' game "
					                    "maker instances / structs. lua nil can also be passed if needed.";
					    return sol::nil;
				    }

				    auto args = parse_variadic_args(args_);

				    const auto scriptref_index = self->m_call_script->m_script_name;

				    const auto res = gm::call(scriptref_index, (CInstance*)args[0].yy_object_base, (CInstance*)args[1].yy_object_base, &args[2], args.size() - 2);

				    return RValue_to_lua(res, this_state_);
			    });
		}

		// Lua API: Class
		// Name: RefDynamicArrayOfRValue
		// Class representing a game maker RValue array
		{
			sol::usertype<RefDynamicArrayOfRValue> type = state.new_usertype<RefDynamicArrayOfRValue>(
			    "RefDynamicArrayOfRValue",
			    sol::base_classes,
			    sol::bases<YYObjectBase>(),
			    sol::meta_function::index,
			    [](sol::this_state this_state_, RefDynamicArrayOfRValue& self, sol::stack_object position_) -> sol::reference
			    {
				    if (position_.get_type() != sol::type::number)
				    {
					    return sol::lua_nil;
				    }

				    int pos = (int)position_.as<double>();
				    // lua index adjustment
				    pos -= 1;
				    if (pos < 0 || pos >= self.length)
				    {
					    return sol::lua_nil;
				    }

				    RValue& val = self.m_Array[pos];

				    return RValue_to_lua(val, this_state_);
			    },
			    sol::meta_function::garbage_collect,
			    sol::destructor(
			        [](RefDynamicArrayOfRValue& inst)
			        {
				        YYObjectPinMap::unpin(&inst);
			        }));

			sol::protected_function ipairs_func = type[sol::meta_function::ipairs];
			type[sol::meta_function::pairs]     = ipairs_func;
		}

		// Lua API: Class
		// Name: CCode
		// Class representing a game function
		{
			sol::usertype<CCode> type = state.new_usertype<CCode>("CCode");

			// Lua API: Field
			// Class: CCode
			// Field: index: number
			// Index within the internal GM game functions table
			BIND_USERTYPE(type, CCode, index);

			// Lua API: Field
			// Class: CCode
			// Field: name: string
			// Name of the game function
			BIND_USERTYPE(type, CCode, name);
		}

		// Constants
		{
			// Lua API: Field
			// Table: gm
			// Field: constants: table of gml/game constants name to their asset index.
			auto constants = ns["constants"].get_or_create<sol::table>();

			// Lua API: Field
			// Table: gm
			// Field: constant_types: table of gml/game constants name to their type name
			auto constant_types = ns["constant_types"].get_or_create<sol::table>();

			// Lua API: Field
			// Table: gm
			// Field: constants_type_sorted: constants_type_sorted[type_name][i] = constant_name
			auto constants_type_sorted = ns["constants_type_sorted"].get_or_create<sol::table>();

			auto asset_loop_over = [&](std::string type, const std::string& custom_type_name = "", double start = 0.0)
			{
				const char* asset_name{"<undefined>"};

				std::string routine_name = type + "_get_name";

				if (custom_type_name.size())
				{
					type = custom_type_name;
				}

				double i;

				try
				{
					for (i = start; true; ++i)
					{
#ifdef FINAL
						// Bandaid fix for shader potential hard crash when going outside the maximum shader asset count limit.
						// Will need manual update if the game ever receive more / less shaders.
						// The game maker engine message is Illegal shader index 27
						if (type == "shader" && i == 27)
						{
							LOG(INFO) << "Stopping at shader " << i;
							break;
						}
#endif

						RValue asset = gm::call(routine_name, i);
						if (asset.type == RValueType::STRING)
						{
							asset_name = asset.ref_string->m_thing;
							// if the asset does not exist, its name will be "<undefined>"
							// but since in GM an asset can't start with '<', it's faster to just check for the first character.
							// (It seems GM internally does the exact same check)
							if (asset_name && asset_name[0] != '<')
							{
								constants[asset_name]                                      = i;
								constant_types[asset_name]                                 = type;
								constants_type_sorted[type].get_or_create<sol::table>()[i] = asset_name;
							}
							else
							{
								break;
							}
						}
						else
						{
							break;
						}
					}
				}
				catch (...)
				{
					// thrown by shader_get_name, just ignore it.
				}

				return i;
			};

			auto room_loop_over = [&]()
			{
				std::string room = "room";

				const char* asset_name{"<undefined>"};
				// arbitrary random limit,
				// can't use room_last because room added through room_add which happens a lot here are not counted by it
				constexpr double arbitrary_limit = 1000.0;
				for (double i = 0; i < arbitrary_limit; ++i)
				{
					RValue asset = gm::call(room + "_get_name", i);
					if (asset.type == RValueType::STRING)
					{
						asset_name = asset.ref_string->m_thing;
						// if the asset does not exist, its name will be "<undefined>"
						// but since in GM an asset can't start with '<', it's faster to just check for the first character.
						// (It seems GM internally does the exact same check)
						if (asset_name && asset_name[0] != '<')
						{
							state["gm"]["constants"][asset_name]                                      = i;
							state["gm"]["constant_types"][asset_name]                                 = room;
							state["gm"]["constants_type_sorted"][room].get_or_create<sol::table>()[i] = asset_name;
						}
					}
				}
			};

			auto script_loop_over = [&](std::string type, const std::string& custom_type_name = "", double start = 0.0)
			{
				const char* asset_name{"<undefined>"};

				std::string routine_name = type + "_get_name";

				if (custom_type_name.size())
				{
					type = custom_type_name;
				}

				double i;

				for (i = start; true; ++i)
				{
					RValue asset = gm::call(routine_name, i);
					if (asset.type == RValueType::STRING)
					{
						asset_name = asset.ref_string->m_thing;
						// if the asset does not exist, its name will be "<undefined>"
						// but since in GM an asset can't start with '<', it's faster to just check for the first character.
						// (It seems GM internally does the exact same check)
						if (asset_name && asset_name[0] != '<')
						{
							constants[asset_name]                                      = i;
							constant_types[asset_name]                                 = type;
							constants_type_sorted[type].get_or_create<sol::table>()[i] = asset_name;
							script_index_to_name[i]                                    = asset_name;
							gm::script_asset_cache[asset_name]                         = i;
						}
						else
						{
							break;
						}
					}
					else
					{
						break;
					}
				}

				return i;
			};

			asset_loop_over("object");
			asset_loop_over("sprite");
			room_loop_over();
			asset_loop_over("font");
			asset_loop_over("audio");
			asset_loop_over("path");
			asset_loop_over("timeline");
			asset_loop_over("tileset");
			asset_loop_over("shader");
			script_loop_over("script");                         // runtime funcs
			script_loop_over("script", "gml_script", 100001.0); // gml scripts

			ns["_returnofmodding_constants_internal_"].get_or_create<sol::table>()["update_room_cache"] = room_loop_over;
		}

		ns["pre_code_execute"]  = sol::overload(pre_code_execute, pre_code_execute_fast);
		ns["post_code_execute"] = sol::overload(post_code_execute, post_code_execute_fast);

		ns["pre_script_hook"]  = pre_script_hook;
		ns["post_script_hook"] = post_script_hook;

		ns["call"] = sol::overload(lua_gm_call, lua_gm_call_global);

		// Lua API: Function
		// Table: gm
		// Name: get_script_ref
		// Param: function_index: number: index of the game script / builtin game maker function to make a CScriptRef with.
		// Returns: CScriptRef*: The script reference from the passed function index.
		// **Example Usage**
		// ```lua
		// callable_ref = nil
		// gm.pre_script_hook(gm.constants.callable_call, function(self, other, result, args)
		//     if callable_ref then
		//         if args[1].value == callable_ref then
		//             print("GenericCallable ran")
		//         end
		//     end
		// end)
		//
		// gm.post_code_execute("gml_Object_pAttack_Create_0", function(self, other)
		//     gm.instance_callback_set(self.on_hit, gm.get_script_ref(gm.constants.function_dummy))
		//     callable_ref = self.on_hit.callables[#self.on_hit.callables]
		// end)
		// ```
		ns["get_script_ref"] = [](double function_index, sol::this_state this_state_) -> sol::object
		{
			const auto function_info = get_builtin_or_script_function_from_index(function_index);
			if (!function_info.function_ptr)
			{
				return sol::lua_nil;
			}

			RValue res;
			big::g_pointers->m_rorr.m_YYSetScriptRef(&res, (void*)function_info.function_ptr, nullptr);

			return RValue_to_lua(res, this_state_);
		};

		// Lua API: Function
		// Table: gm
		// Name: get_script_function_address
		// Param: function_index: number: index of the game script / builtin game maker function.
		// Returns: pointer: A pointer to the found address.
		// **Example Usage**
		// ```lua
		// pointer = gm.get_script_function_address(gm.constants.actor_death)
		// ```
		ns["get_script_function_address"] = [](double function_index, sol::this_state this_state_) -> sol::object
		{
			const auto function_info = get_builtin_or_script_function_from_index(function_index);
			if (!function_info.function_ptr)
			{
				return sol::lua_nil;
			}
			return sol::make_object(big::g_lua_manager->lua_state(), lua::memory::pointer(function_info.function_ptr));
		};

		// Lua API: Function
		// Table: gm
		// Name: get_object_function_address
		// Param: function_name: string: the name of target function.
		// Returns: pointer: A pointer to the found address.
		// **Example Usage**
		// ```lua
		// pointer = gm.get_object_function_address("gml_Object_oStartMenu_Step_2")
		// ```
		ns["get_object_function_address"] = [](const std::string& function_name, sol::this_state this_state_) -> sol::object
		{
			uintptr_t ptr = get_object_function_ptr(function_name);
			if (ptr == 0)
			{
				return sol::lua_nil;
			}
			return sol::make_object(big::g_lua_manager->lua_state(), lua::memory::pointer(ptr));
		};

		lua::memory::add_type_info_from_string("RValue*",
		                                       [](lua_State* state_, char* arg_ptr) -> sol::object
		                                       {
			                                       return sol::make_object(state_, *(RValue**)arg_ptr);
		                                       });
		lua::memory::add_type_info_from_string("CInstance*",
		                                       [](lua_State* state_, char* arg_ptr) -> sol::object
		                                       {
			                                       return sol::make_object(state_, *(CInstance**)arg_ptr);
		                                       });
		lua::memory::add_type_info_from_string("YYObjectBase*",
		                                       [](lua_State* state_, char* arg_ptr) -> sol::object
		                                       {
			                                       return sol::make_object(state_, *(YYObjectBase**)arg_ptr);
		                                       });
		lua::memory::add_type_info_from_string("RefDynamicArrayOfRValue*",
		                                       [](lua_State* state_, char* arg_ptr) -> sol::object
		                                       {
			                                       return sol::make_object(state_, *(RefDynamicArrayOfRValue**)arg_ptr);
		                                       });
		lua::memory::add_type_info_from_string("CScriptRef*",
		                                       [](lua_State* state_, char* arg_ptr) -> sol::object
		                                       {
			                                       return sol::make_object(state_, *(CScriptRef**)arg_ptr);
		                                       });

		ns["variable_global_get"] = lua_gm_variable_global_get;
		ns["variable_global_set"] = lua_gm_variable_global_set;

		ns["struct_create"]     = lua_struct_create;
		ns["gmf_struct_create"] = lua_gmf_struct_create;

		ns["gmf_builtin_variables_count"] = []()
		{
			const auto size = *big::g_pointers->m_rorr.m_builtin_variable_count;

			return size;
		};

		ns["gmf_builtin_variables"] = []()
		{
			return (uintptr_t)big::g_pointers->m_rorr.m_builtin_variables;
		};

		ns["shader_add"]          = lua_shader_add;
		ns["shader_replace"]      = lua_shader_replace;
		ns["find_shader_by_name"] = lua_find_shader_by_name;
		ns["shader_dump"]         = lua_shader_dump;

		auto meta_gm = state.create();
		// Wrapper so that users can do gm.room_goto(new_room) for example instead of gm.call("room_goto", new_room)
		meta_gm.set_function(sol::meta_function::index,
		                     [](sol::this_state this_state_, sol::table self, std::string key) -> sol::reference
		                     {
			                     if (!key.size())
			                     {
				                     return sol::lua_nil;
			                     }

			                     if (!gm::is_valid_call(key))
			                     {
				                     return sol::lua_nil;
			                     }

			                     self.raw_set(key,
			                                  sol::overload(
			                                      // TODO: Comment this out for now, the ordering of the two overloads below were wrong
			                                      // and it's unsure if some existing mods relied on this overload never triggering.
			                                      /*[key, this_state_](CInstance* self, CInstance* other, sol::variadic_args args)
				                                      {
					                                      return RValue_to_lua(gm::call(key, self, other, parse_variadic_args(args)), this_state_);
				                                      },*/
			                                      [key, this_state_](sol::variadic_args args)
			                                      {
				                                      return RValue_to_lua(gm::call(key, parse_variadic_args(args)), this_state_);
			                                      }));

			                     return self.raw_get<sol::reference>(key);
		                     });
		meta_gm.set_function(sol::meta_function::new_index,
		                     [](lua_State* L) -> int
		                     {
			                     return luaL_error(L, "Can't define new game maker functions this way");
		                     });
		state["gm"][sol::metatable_key] = meta_gm;

		// game maker fast

		auto ns_memory                 = state["memory"].get_or_create<sol::table>();
		ns_memory["game_base_address"] = (uintptr_t)GetModuleHandleA(0);

		gm::generate_gmf_ffi();

		// hook the luajit exception handler and log potential GM exceptions instead of silencing them
		big::hooking::detour_hook_helper::add<lj_err_unwind_win_VERBOSE>("lj_err_unwind_win_VERBOSE", lj_err_unwind_win);
	}
} // namespace lua::game_maker
