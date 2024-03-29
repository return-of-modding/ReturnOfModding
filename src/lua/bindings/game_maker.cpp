#include "game_maker.hpp"

#include "lua/lua_manager.hpp"
#include "rorr/gm/Code_Function_GET_the_function.hpp"
#include "rorr/gm/CScript.hpp"
#include "rorr/gm/CScriptRef.hpp"
#include "rorr/gm/EVariableType.hpp"
#include "rorr/gm/pin_map.hpp"
#include "rorr/gm/Variable_BuiltIn.hpp"
#include "rorr/gm/YYGMLFuncs.hpp"

#pragma warning(push, 0)
#include <asmjit/asmjit.h>
#pragma warning(pop)

#pragma warning(disable : 4200)
#include "polyhook2/Enums.hpp"
#include "polyhook2/ErrorLog.hpp"
#include "polyhook2/MemAccessor.hpp"
#include "polyhook2/PolyHookOs.hpp"

namespace qstd
{
#define TYPEID_MATCH_STR_IF(var, T)                                      \
	if (var == #T)                                                       \
	{                                                                    \
		return asmjit::TypeId(asmjit::TypeUtils::TypeIdOfT<T>::kTypeId); \
	}
#define TYPEID_MATCH_STR_ELSEIF(var, T)                                  \
	else if (var == #T)                                                  \
	{                                                                    \
		return asmjit::TypeId(asmjit::TypeUtils::TypeIdOfT<T>::kTypeId); \
	}

	class runtime_func : public PLH::MemAccessor
	{
	public:
		struct Parameters
		{
			template<typename T>
			void setArg(const uint8_t idx, const T val) const
			{
				*(T*)getArgPtr(idx) = val;
			}

			template<typename T>
			T getArg(const uint8_t idx) const
			{
				return *(T*)getArgPtr(idx);
			}

			// asm depends on this specific type
			// we the ILCallback allocates stack space that is set to point here (check asmjit::compiler.newStack calls)
			volatile uint64_t m_arguments;

		private:
			// must be char* for aliasing rules to work when reading back out
			char* getArgPtr(const uint8_t idx) const
			{
				return ((char*)&m_arguments) + sizeof(uint64_t) * idx;
			}
		};

		struct ReturnValue
		{
			unsigned char* getRetPtr() const
			{
				return (unsigned char*)&m_retVal;
			}

			uint64_t m_retVal;
		};

		typedef void (*tUserCallback)(const Parameters* params, const uint8_t count, ReturnValue* ret, const uint64_t original_func_ptr);

		runtime_func()
		{
			m_callbackBuf   = 0;
			m_trampolinePtr = 0;
		}

		~runtime_func()
		{
		}

		/* Construct a callback given the raw signature at runtime. 'Callback' param is the C stub to transfer to,
		where parameters can be modified through a structure which is written back to the parameter slots depending
		on calling convention.*/
		uint64_t getJitFunc(const asmjit::FuncSignature& sig, const asmjit::Arch arch, const tUserCallback callback, const uint64_t original_func_ptr)
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
			code.setLogger(&log);

			// too small to really need it
			func->frame().resetPreservedFP();

			// map argument slots to registers, following abi.
			std::vector<asmjit::x86::Reg> argRegisters;
			for (uint8_t argIdx = 0; argIdx < sig.argCount(); argIdx++)
			{
				const auto argType = sig.args()[argIdx];

				asmjit::x86::Reg arg;
				if (isGeneralReg(argType))
				{
					arg = cc.newUIntPtr();
				}
				else if (isXmmReg(argType))
				{
					arg = cc.newXmm();
				}
				else
				{
					LOG(FATAL) << "Parameters wider than 64bits not supported";
					return 0;
				}

				func->setArg(argIdx, arg);
				argRegisters.push_back(arg);
			}

			// setup the stack structure to hold arguments for user callback
			uint32_t stackSize = (uint32_t)(sizeof(uint64_t) * sig.argCount());
			argsStack          = cc.newStack(stackSize, 16);
			asmjit::x86::Mem argsStackIdx(argsStack);

			// assigns some register as index reg
			asmjit::x86::Gp i = cc.newUIntPtr();

			// stackIdx <- stack[i].
			argsStackIdx.setIndex(i);

			// r/w are sizeof(uint64_t) width now
			argsStackIdx.setSize(sizeof(uint64_t));

			// set i = 0
			cc.mov(i, 0);
			//// mov from arguments registers into the stack structure
			for (uint8_t argIdx = 0; argIdx < sig.argCount(); argIdx++)
			{
				const auto argType = sig.args()[argIdx];

				// have to cast back to explicit register types to gen right mov type
				if (isGeneralReg(argType))
				{
					cc.mov(argsStackIdx, argRegisters.at(argIdx).as<asmjit::x86::Gp>());
				}
				else if (isXmmReg(argType))
				{
					cc.movq(argsStackIdx, argRegisters.at(argIdx).as<asmjit::x86::Xmm>());
				}
				else
				{
					LOG(FATAL) << "Parameters wider than 64bits not supported";
					return 0;
				}

				// next structure slot (+= sizeof(uint64_t))
				cc.add(i, sizeof(uint64_t));
			}

			// get pointer to stack structure and pass it to the user callback
			asmjit::x86::Gp argStruct = cc.newUIntPtr("argStruct");
			cc.lea(argStruct, argsStack);

			// fill reg to pass struct arg count to callback
			asmjit::x86::Gp argCountParam = cc.newUInt8();
			cc.mov(argCountParam, (uint8_t)sig.argCount());

			// create buffer for ret val
			asmjit::x86::Mem retStack = cc.newStack(sizeof(uint64_t), 16);
			asmjit::x86::Gp retStruct = cc.newUIntPtr("retStruct");
			cc.lea(retStruct, retStack);

			// fill reg to pass original function pointer to callback
			asmjit::x86::Gp original_func_ptr_reg = cc.newUIntPtr();
			cc.mov(original_func_ptr_reg, original_func_ptr);

			asmjit::InvokeNode* invokeNode;
			cc.invoke(&invokeNode, (uint64_t)callback, asmjit::FuncSignatureT<void, Parameters*, uint8_t, ReturnValue*, uint64_t>());

			// call to user provided function (use ABI of host compiler)
			invokeNode->setArg(0, argStruct);
			invokeNode->setArg(1, argCountParam);
			invokeNode->setArg(2, retStruct);
			invokeNode->setArg(3, original_func_ptr_reg);

			if (sig.hasRet())
			{
				asmjit::x86::Mem retStackIdx(retStack);
				retStackIdx.setSize(sizeof(uint64_t));
				if (isGeneralReg(sig.ret()))
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
			m_callbackBuf = (uint64_t) new char[size];
			if (!m_callbackBuf)
			{
				PolyHook2DebugBreak();
				return 0;
			}

			PLH::MemoryProtector protector(m_callbackBuf, size, PLH::ProtFlag::R | PLH::ProtFlag::W | PLH::ProtFlag::X, *this, false);

			// if multiple sections, resolve linkage (1 atm)
			if (code.hasUnresolvedLinks())
			{
				code.resolveUnresolvedLinks();
			}

			// Relocate to the base-address of the allocated memory.
			code.relocateToBase(m_callbackBuf);
			code.copyFlattenedData((unsigned char*)m_callbackBuf, size);

			LOG(INFO) << "JIT Stub: " << std::string(log.data());
			return m_callbackBuf;
		}

		/* Construct a callback given the typedef as a string. Types are any valid C/C++ data type (basic types), and pointers to
		anything are just a uintptr_t. Calling convention is defaulted to whatever is typical for the compiler you use, you can override with
		stdcall, fastcall, or cdecl (cdecl is default on x86). On x64 those map to the same thing.*/
		uint64_t getJitFunc(const std::string& retType, const std::vector<std::string>& paramTypes, const asmjit::Arch arch, const tUserCallback callback, const uint64_t original_func_ptr, std::string callConv = "")
		{
			asmjit::FuncSignature sig = {};

			std::vector<asmjit::TypeId> args;
			for (const std::string& s : paramTypes)
			{
				args.push_back(getTypeId(s));
			}

			sig.init(getCallConv(callConv),
			         asmjit::FuncSignature::kNoVarArgs,
			         getTypeId(retType),
			         args.data(),
			         (uint32_t)args.size());

			return getJitFunc(sig, arch, callback, original_func_ptr);
		}

		uint64_t* getTrampolineHolder()
		{
			return &m_trampolinePtr;
		}

	private:
		// does a given type fit in a general purpose register (i.e. is it integer type)
		bool isGeneralReg(const asmjit::TypeId typeId) const
		{
			switch (typeId)
			{
			case asmjit::TypeId::kInt8:
			case asmjit::TypeId::kUInt8:
			case asmjit::TypeId::kInt16:
			case asmjit::TypeId::kUInt16:
			case asmjit::TypeId::kInt32:
			case asmjit::TypeId::kUInt32:
			case asmjit::TypeId::kInt64:
			case asmjit::TypeId::kUInt64:
			case asmjit::TypeId::kIntPtr:
			case asmjit::TypeId::kUIntPtr: return true;
			default:                       return false;
			}
		}

		// float, double, simd128
		bool isXmmReg(const asmjit::TypeId typeId) const
		{
			switch (typeId)
			{
			case asmjit::TypeId::kFloat32:
			case asmjit::TypeId::kFloat64: return true;
			default:                       return false;
			}
		}

		asmjit::CallConvId getCallConv(const std::string& conv)
		{
			if (conv == "cdecl")
			{
				return asmjit::CallConvId::kCDecl;
			}
			else if (conv == "stdcall")
			{
				return asmjit::CallConvId::kStdCall;
			}
			else if (conv == "fastcall")
			{
				return asmjit::CallConvId::kFastCall;
			}

			return asmjit::CallConvId::kHost;
		}

		asmjit::TypeId getTypeId(const std::string& type)
		{
			if (type.find('*') != std::string::npos)
			{
				return asmjit::TypeId::kUIntPtr;
			}

			TYPEID_MATCH_STR_IF(type, signed char)
			TYPEID_MATCH_STR_ELSEIF(type, unsigned char)
			TYPEID_MATCH_STR_ELSEIF(type, short)
			TYPEID_MATCH_STR_ELSEIF(type, unsigned short)
			TYPEID_MATCH_STR_ELSEIF(type, int)
			TYPEID_MATCH_STR_ELSEIF(type, unsigned int)
			TYPEID_MATCH_STR_ELSEIF(type, long)
			TYPEID_MATCH_STR_ELSEIF(type, unsigned long)
#ifdef POLYHOOK2_OS_WINDOWS
			TYPEID_MATCH_STR_ELSEIF(type, __int64)
			TYPEID_MATCH_STR_ELSEIF(type, unsigned __int64)
#endif
			TYPEID_MATCH_STR_ELSEIF(type, long long)
			TYPEID_MATCH_STR_ELSEIF(type, unsigned long long)
			TYPEID_MATCH_STR_ELSEIF(type, char)
			TYPEID_MATCH_STR_ELSEIF(type, char16_t)
			TYPEID_MATCH_STR_ELSEIF(type, char32_t)
			TYPEID_MATCH_STR_ELSEIF(type, wchar_t)
			TYPEID_MATCH_STR_ELSEIF(type, uint8_t)
			TYPEID_MATCH_STR_ELSEIF(type, int8_t)
			TYPEID_MATCH_STR_ELSEIF(type, uint16_t)
			TYPEID_MATCH_STR_ELSEIF(type, int16_t)
			TYPEID_MATCH_STR_ELSEIF(type, int32_t)
			TYPEID_MATCH_STR_ELSEIF(type, uint32_t)
			TYPEID_MATCH_STR_ELSEIF(type, uint64_t)
			TYPEID_MATCH_STR_ELSEIF(type, int64_t)
			TYPEID_MATCH_STR_ELSEIF(type, float)
			TYPEID_MATCH_STR_ELSEIF(type, double)
			TYPEID_MATCH_STR_ELSEIF(type, bool)
			TYPEID_MATCH_STR_ELSEIF(type, void)
			else if (type == "intptr_t")
			{
				return asmjit::TypeId::kIntPtr;
			}
			else if (type == "uintptr_t")
			{
				return asmjit::TypeId::kUIntPtr;
			}

			return asmjit::TypeId::kVoid;
		}

		uint64_t m_callbackBuf;
		asmjit::x86::Mem argsStack;

		// ptr to trampoline allocated by hook, we hold this so user doesn't need to.
		uint64_t m_trampolinePtr;
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
		return res.yy_object_base->type == YYObjectBaseType::CINSTANCE ?
		           sol::make_object<CInstance*>(this_state_, (CInstance*)res.ptr) :
		           sol::make_object<YYObjectBase*>(this_state_, res.yy_object_base);
	case UNDEFINED:
	case UNSET:     return sol::lua_nil;
	default:        return sol::make_object<RValue>(this_state_, res);
	}
}

static RValue parse_sol_object(sol::object arg)
{
	if (arg.get_type() == sol::type::number)
	{
		return RValue(arg.as<double>());
	}
	else if (arg.get_type() == sol::type::string)
	{
		return RValue(arg.as<std::string>());
	}
	else if (arg.get_type() == sol::type::boolean)
	{
		return RValue(arg.as<bool>());
	}
	else if (arg.is<RefDynamicArrayOfRValue*>())
	{
		return RValue(arg.as<RefDynamicArrayOfRValue*>());
	}
	else if (arg.is<CInstance*>())
	{
		return RValue(arg.as<CInstance*>());
	}
	else if (arg.is<YYObjectBase*>())
	{
		return RValue(arg.as<YYObjectBase*>());
	}
	else if (arg.is<RValue>())
	{
		return arg.as<RValue>();
	}

	return {};
}

static std::vector<RValue> parse_variadic_args(sol::variadic_args args)
{
	std::vector<RValue> vec_args;
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
	// Lua API: Function
	// Table: gm
	// Name: pre_code_execute
	// Param: callback: function: callback that match signature function, return value can be True if the original method we are hooking should be called, false if it should be skipped ( self (CInstance), other (CInstance), code (CCode), result (RValue), flags (number) )
	// Registers a callback that will be called right before any object function is called.
	static void pre_code_execute(sol::protected_function cb, sol::this_environment env)
	{
		big::lua_module* mdl = big::lua_module::this_from(env);
		if (mdl)
		{
			mdl->m_data.m_pre_code_execute_callbacks.push_back(cb);
		}
	}

	// Lua API: Function
	// Table: gm
	// Name: post_code_execute
	// Param: callback: function: callback that match signature function ( self (CInstance), other (CInstance), code (CCode), result (RValue), flags (number) )
	// Registers a callback that will be called right after any object function is called.
	static void post_code_execute(sol::protected_function cb, sol::this_environment env)
	{
		big::lua_module* mdl = big::lua_module::this_from(env);
		if (mdl)
		{
			mdl->m_data.m_post_code_execute_callbacks.push_back(cb);
		}
	}

	struct runtime_hook_info
	{
		std::unique_ptr<qstd::runtime_func> m_runtime_func;
		std::unique_ptr<PLH::x64Detour> m_detour;

		runtime_hook_info() = default;

		runtime_hook_info(std::unique_ptr<qstd::runtime_func>&& runtime_func, std::unique_ptr<PLH::x64Detour>&& detour) :
		    m_runtime_func(std::move(runtime_func)),
		    m_detour(std::move(detour))
		{
		}

		runtime_hook_info(runtime_hook_info&& other) noexcept :
		    m_runtime_func(std::move(other.m_runtime_func)),
		    m_detour(std::move(other.m_detour))
		{
		}
	};

	static std::unordered_map<uint64_t, runtime_hook_info> original_func_ptr_to_info;

	static void builtin_script_callback(const qstd::runtime_func::Parameters* p, const uint8_t count, qstd::runtime_func::ReturnValue* ret_val, const uint64_t original_func_ptr)
	{
		const auto result    = p->getArg<RValue*>(0);
		const auto self      = p->getArg<CInstance*>(1);
		const auto other     = p->getArg<CInstance*>(2);
		const auto arg_count = p->getArg<int>(3);
		const auto args      = p->getArg<RValue*>(4);

		ret_val->m_retVal = (uint64_t)result;

		const auto call_orig_if_true = big::g_lua_manager->pre_builtin_execute((void*)original_func_ptr, self, other, result, arg_count, args);

		ret_val->m_retVal = (uint64_t)result;

		if (call_orig_if_true)
		{
			reinterpret_cast<gm::TRoutine>(*original_func_ptr_to_info[original_func_ptr].m_runtime_func->getTrampolineHolder())(result, self, other, arg_count, args);
		}

		ret_val->m_retVal = (uint64_t)result;

		big::g_lua_manager->post_builtin_execute((void*)original_func_ptr, self, other, result, arg_count, args);

		ret_val->m_retVal = (uint64_t)result;
	}

	static void script_callback(const qstd::runtime_func::Parameters* p, const uint8_t count, qstd::runtime_func::ReturnValue* ret_val, const uint64_t original_func_ptr)
	{
		const auto self      = p->getArg<CInstance*>(0);
		const auto other     = p->getArg<CInstance*>(1);
		const auto result    = p->getArg<RValue*>(2);
		const auto arg_count = p->getArg<int>(3);
		const auto args      = p->getArg<RValue**>(4);

		ret_val->m_retVal = (uint64_t)result;

		const auto call_orig_if_true = big::g_lua_manager->pre_script_execute((void*)original_func_ptr, self, other, result, arg_count, args);

		ret_val->m_retVal = (uint64_t)result;

		if (call_orig_if_true)
		{
			reinterpret_cast<PFUNC_YYGMLScript>(*original_func_ptr_to_info[original_func_ptr].m_runtime_func->getTrampolineHolder())(self, other, result, arg_count, args);
		}

		ret_val->m_retVal = (uint64_t)result;

		big::g_lua_manager->post_script_execute((void*)original_func_ptr, self, other, result, arg_count, args);

		ret_val->m_retVal = (uint64_t)result;
	}

	struct make_central_script_result
	{
		big::lua_module* m_this_lua_module = nullptr;
		void* m_original_func_ptr          = nullptr;
		bool m_is_game_script_func         = false;
	};

	static make_central_script_result make_central_script_hook(const double script_function_index_double, sol::this_environment& env, bool is_pre_hook)
	{
		big::lua_module* mdl = big::lua_module::this_from(env);
		if (mdl)
		{
			const int script_function_index = script_function_index_double;
			if (script_function_index >= 100'000)
			{
				const auto cscript = big::g_pointers->m_rorr.m_script_data(script_function_index - 100'000);
				if (cscript)
				{
					std::stringstream hook_name;
					hook_name << mdl->guid() << " | " << script_function_index << " | "
					          << (is_pre_hook ? mdl->m_data.m_pre_script_execute_callbacks.size() :
					                            mdl->m_data.m_post_script_execute_callbacks.size());

					LOG(INFO) << "hook_name: " << hook_name.str();

					const auto original_func_ptr = (void*)cscript->m_funcs->m_script_function;

					if (!original_func_ptr_to_info.contains((uint64_t)original_func_ptr))
					{
						std::unique_ptr<qstd::runtime_func> runtime_func = std::make_unique<qstd::runtime_func>();
						uint64_t JIT = runtime_func->getJitFunc("uintptr_t", {"uintptr_t", "uintptr_t", "uintptr_t", "int", "uintptr_t"}, asmjit::Arch::kHost, &script_callback, (uint64_t)original_func_ptr);

						original_func_ptr_to_info.emplace(
						    (uint64_t)original_func_ptr,
						    runtime_hook_info{std::move(runtime_func),
						                      std::make_unique<PLH::x64Detour>((uint64_t)original_func_ptr,
						                                                       (uint64_t)JIT,
						                                                       runtime_func->getTrampolineHolder())});

						original_func_ptr_to_info[(uint64_t)original_func_ptr].m_detour->hook();
					}

					//big::hooking::detour_hook_helper::add(hook_name.str(), original_func_ptr, (void*)&central_script_hook);

					return {mdl, original_func_ptr, true};
				}
				else
				{
					LOG(FATAL) << "Could not find a corresponding script function index (" << script_function_index << ")";
				}
			}
			else
			{
				gm::code_function_info result{};
				big::g_pointers->m_rorr.m_code_function_GET_the_function(script_function_index,
				                                                         &result.function_name,
				                                                         &result.function_ptr,
				                                                         &result.function_arg_count);

				if (result.function_ptr)
				{
					std::stringstream hook_name;
					hook_name << mdl->guid() << " | " << script_function_index << " | "
					          << (is_pre_hook ? mdl->m_data.m_pre_builtin_execute_callbacks.size() :
					                            mdl->m_data.m_post_builtin_execute_callbacks.size());

					LOG(INFO) << "hook_name: " << hook_name.str();

					const auto original_func_ptr = (void*)result.function_ptr;

					if (!original_func_ptr_to_info.contains((uint64_t)original_func_ptr))
					{
						std::unique_ptr<qstd::runtime_func> runtime_func = std::make_unique<qstd::runtime_func>();
						uint64_t JIT = runtime_func->getJitFunc("uintptr_t", {"uintptr_t", "uintptr_t", "uintptr_t", "int", "uintptr_t"}, asmjit::Arch::kHost, &builtin_script_callback, (uint64_t)original_func_ptr);

						original_func_ptr_to_info.emplace(
						    (uint64_t)original_func_ptr,
						    runtime_hook_info{std::move(runtime_func),
						                      std::make_unique<PLH::x64Detour>((uint64_t)original_func_ptr,
						                                                       (uint64_t)JIT,
						                                                       runtime_func->getTrampolineHolder())});

						original_func_ptr_to_info[(uint64_t)original_func_ptr].m_detour->hook();
					}

					//big::hooking::detour_hook_helper::add(hook_name.str(), result.function_ptr, (void*)&central_builtin_hook);

					return {mdl, result.function_ptr, false};
				}
				else
				{
					LOG(FATAL) << "Could not find a corresponding builtin function index (" << script_function_index << ")";
				}
			}
		}

		return {};
	}

	// Lua API: Function
	// Table: gm
	// Name: pre_script_hook
	// Param: function_index: number: index of the game script / builtin game maker function to hook, for example `gm.constants.callback_execute`
	// Param: callback: function: callback that match signature function ( self (CInstance), other (CInstance), result (RValue), args (RValue array) ) -> Return true or false depending on if you want the orig method to be called.
	// Registers a callback that will be called right before any game script function is called.
	static void pre_script_hook(const double script_function_index_double, sol::protected_function cb, sol::this_environment env)
	{
		const auto res = make_central_script_hook(script_function_index_double, env, true);
		if (res.m_this_lua_module && res.m_original_func_ptr)
		{
			if (res.m_is_game_script_func)
			{
				res.m_this_lua_module->m_data.m_pre_script_execute_callbacks[res.m_original_func_ptr].push_back(cb);
			}
			else
			{
				res.m_this_lua_module->m_data.m_pre_builtin_execute_callbacks[res.m_original_func_ptr].push_back(cb);
			}
		}
	}

	// Lua API: Function
	// Table: gm
	// Name: post_script_hook
	// Param: function_index: number: index of the game script / builtin game maker function to hook, for example `gm.constants.callback_execute`
	// Param: callback: function: callback that match signature function ( self (CInstance), other (CInstance), result (RValue), args (RValue array) )
	// Registers a callback that will be called right after any game script function is called.
	static void post_script_hook(const double script_function_index_double, sol::protected_function cb, sol::this_environment env)
	{
		const auto res = make_central_script_hook(script_function_index_double, env, false);
		if (res.m_this_lua_module && res.m_original_func_ptr)
		{
			if (res.m_is_game_script_func)
			{
				res.m_this_lua_module->m_data.m_post_script_execute_callbacks[res.m_original_func_ptr].push_back(cb);
			}
			else
			{
				res.m_this_lua_module->m_data.m_post_builtin_execute_callbacks[res.m_original_func_ptr].push_back(cb);
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

	void bind(sol::state& state)
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
			    [](sol::this_state this_state_, sol::object self, sol::stack_object key) -> sol::reference
			    {
				    auto v = self.as<sol::table&>().raw_get<sol::optional<sol::reference>>(key);
				    if (v)
				    {
					    return v.value();
				    }
				    else
				    {
					    const auto yyobject = self.as<YYObjectBase*>();
					    if (!key.is<const char*>() || yyobject->type != YYObjectBaseType::YYOBJECTBASE)
					    {
						    return sol::lua_nil;
					    }

					    const auto res = gm::call("struct_get", std::to_array<RValue, 2>({yyobject, key.as<const char*>()}));

					    return RValue_to_lua(res, this_state_);
				    }
			    },
			    sol::meta_function::new_index,
			    [](sol::object self, sol::stack_object key, sol::stack_object value)
			    {
				    auto v = self.as<sol::table&>().raw_get<sol::optional<sol::reference>>(key);
				    if (v)
				    {
					    self.as<sol::table&>().raw_set(key, value);
				    }
				    else
				    {
					    const auto yyobject = self.as<YYObjectBase*>();
					    if (!key.is<const char*>() || yyobject->type != YYObjectBaseType::YYOBJECTBASE)
					    {
						    return;
					    }

					    gm::call("struct_set", std::to_array<RValue, 3>({yyobject, key.as<const char*>(), parse_sol_object(value)}));
				    }
			    });

			// Lua API: Field
			// Class: YYObjectBase
			// Field: type: YYObjectBaseType
			BIND_USERTYPE(type, YYObjectBase, type);

			// Lua API: Field
			// Class: YYObjectBase
			// Field: cinstance: CInstance or nil if not a CInstance
			type["cinstance"] = sol::property(
			    [](YYObjectBase& inst, sol::this_state this_state_)
			    {
				    return inst.type == YYObjectBaseType::CINSTANCE ? sol::make_object(this_state_, (CInstance*)&inst) : sol::lua_nil;
			    });

			// Lua API: Field
			// Class: YYObjectBase
			// Field: script_name: string or nil if not a SCRIPTREF
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
			// Param: value: boolean: value
			// Returns an RValue instance

			// Lua API: Constructor
			// Class: RValue
			// Param: value: number: value
			// Returns an RValue instance

			// Lua API: Constructor
			// Class: RValue
			// Param: value: string: value
			// Returns an RValue instance
			sol::usertype<RValue> type = state.new_usertype<RValue>("RValue", sol::constructors<RValue(), RValue(bool), RValue(double), RValue(const char*)>(), sol::meta_function::garbage_collect, sol::destructor(&RValue::__localFree));

			// Lua API: Field
			// Class: RValue
			// Field: type: RValueType
			BIND_USERTYPE(type, RValue, type);

			// Lua API: Field
			// Class: RValue
			// Field: value: The actual value behind the RValue, or RValue if the type is not handled yet.
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
			// Field: tostring: string representation of the RValue
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
			    [&](sol::this_state this_state_, sol::object self, sol::stack_object key) -> sol::reference
			    {
				    auto v = self.as<sol::table&>().raw_get<sol::optional<sol::reference>>(key);
				    if (v)
				    {
					    return v.value();
				    }
				    else
				    {
					    if (!key.is<const char*>())
					    {
						    return sol::lua_nil;
					    }

					    const char* key_str = key.as<const char*>();

					    const auto var_get_args = std::to_array<RValue, 2>({self.as<CInstance&>().id, key_str});
					    const auto var_exists   = gm::call("variable_instance_exists", var_get_args);
					    if (var_exists.asBoolean())
					    {
						    const auto res = gm::call("variable_instance_get", var_get_args);
						    return RValue_to_lua(res, this_state_);
					    }
					    else
					    {
						    const std::string key_str_copy = key_str;
						    type[key_str] = [key_str_copy](sol::this_state this_state_, sol::stack_object key, sol::variadic_args args)
						    {
							    const auto res = gm::call(key_str_copy, key.as<CInstance*>(), nullptr, parse_variadic_args(args));
							    return RValue_to_lua(res, this_state_);
						    };
						    return type[key_str];
					    }
				    }
			    },
			    sol::meta_function::new_index,
			    [](sol::object self, sol::stack_object key, sol::stack_object value)
			    {
				    auto v = self.as<sol::table&>().raw_get<sol::optional<sol::reference>>(key);
				    if (v)
				    {
					    self.as<sol::table&>().raw_set(key, value);
				    }
				    else
				    {
					    if (!key.is<const char*>())
					    {
						    return;
					    }

					    gm::call("variable_instance_set", std::to_array<RValue, 3>({self.as<CInstance&>().id, key.as<const char*>(), parse_sol_object(value)}));
				    }
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
			// Field: instances_all: CInstance table of all (active or unactive) game maker object instances
			CInstance_table["instances_all"] = std::ref(gm::CInstances_all);

			// Lua API: Field
			// Table: gm.CInstance
			// Field: instances_active: CInstance table of all active game maker object instances
			CInstance_table["instances_active"] = std::ref(gm::CInstances_active);

			// Lua API: Field
			// Table: gm.CInstance
			// Field: instance_id_to_CInstance: table of all game maker object instances ids to their corresponding CInstance
			CInstance_table["instance_id_to_CInstance"] = std::ref(gm::CInstance_id_to_CInstance);
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

		ns["pre_code_execute"]  = pre_code_execute;
		ns["post_code_execute"] = post_code_execute;

		ns["pre_script_hook"]  = pre_script_hook;
		ns["post_script_hook"] = post_script_hook;

		ns["call"] = sol::overload(lua_gm_call, lua_gm_call_global);

		ns["variable_global_get"] = lua_gm_variable_global_get;
		ns["variable_global_set"] = lua_gm_variable_global_set;

		ns["struct_create"] = lua_struct_create;

		auto meta_gm = state.create_table();
		// Wrapper so that users can do gm.room_goto(new_room) for example instead of gm.call("room_goto", new_room)
		meta_gm.set_function(sol::meta_function::index,
		                     [](sol::this_state this_state_, sol::table self, std::string key) -> sol::reference
		                     {
			                     auto v = self.raw_get<sol::optional<sol::reference>>(key);
			                     if (v)
			                     {
				                     return v.value();
			                     }
			                     else
			                     {
				                     if (!key.size())
				                     {
					                     return sol::lua_nil;
				                     }

				                     self.raw_set(key,
				                                  sol::overload(
				                                      [key, this_state_](sol::variadic_args args)
				                                      {
					                                      return RValue_to_lua(gm::call(key, parse_variadic_args(args)), this_state_);
				                                      },
				                                      [key, this_state_](CInstance* self, CInstance* other, sol::variadic_args args)
				                                      {
					                                      return RValue_to_lua(gm::call(key, self, other, parse_variadic_args(args)), this_state_);
				                                      }));

				                     return self.raw_get<sol::reference>(key);
			                     }
		                     });
		meta_gm.set_function(sol::meta_function::new_index,
		                     [](lua_State* L) -> int
		                     {
			                     return luaL_error(L, "Can't define new game maker functions this way");
		                     });
		state["gm"][sol::metatable_key] = meta_gm;
	}
} // namespace lua::game_maker
