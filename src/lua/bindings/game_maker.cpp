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
				if (is_general_register(argType))
				{
					arg = cc.newUIntPtr();
				}
				else if (is_XMM_register(argType))
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
				if (is_general_register(argType))
				{
					cc.mov(argsStackIdx, argRegisters.at(argIdx).as<asmjit::x86::Gp>());
				}
				else if (is_XMM_register(argType))
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
				if (is_general_register(sig.ret()))
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
			asmjit::FuncSignature sig(get_call_convention(call_convention), asmjit::FuncSignature::kNoVarArgs, get_type_id(return_type));

			for (const std::string& s : param_types)
			{
				sig.addArg(get_type_id(s));
			}

			return make_jit_func(sig, arch, callback, original_func_ptr);
		}

		uintptr_t make_jit_midfunc(const std::vector<std::string>& param_types, const std::vector<std::string>& param_captures, const int stack_restore_offset, const std::vector<std::string>& restore_targets, const std::vector<std::string>& restore_sources, const asmjit::Arch arch, bool (*mid_callback)(const parameters_t* params, const uint8_t param_count, const uintptr_t target_func_ptr), const uintptr_t target_func_ptr)
		{
			asmjit::CodeHolder code;
			auto env = asmjit::Environment::host();
			env.setArch(arch);
			code.init(env);
			// initialize function
			asmjit::x86::Compiler cc(&code);

			asmjit::StringLogger log;
			// clang-format off
			const auto format_flags =
				asmjit::FormatFlags::kMachineCode | asmjit::FormatFlags::kExplainImms | asmjit::FormatFlags::kRegCasts |
				asmjit::FormatFlags::kHexImms     | asmjit::FormatFlags::kHexOffsets  | asmjit::FormatFlags::kPositions;
			// clang-format on

			log.addFlags(format_flags);
			code.setLogger(&log);

			asmjit::Label skip_original_invoke_label = cc.newLabel();

			// save caller-saved registers
			cc.push(asmjit::x86::rbp);
			cc.push(asmjit::x86::rax);
			cc.push(asmjit::x86::rcx);
			cc.push(asmjit::x86::rdx);
			cc.push(asmjit::x86::r8);
			cc.push(asmjit::x86::r9);
			cc.push(asmjit::x86::r10);
			cc.push(asmjit::x86::r11);

			// setup the stack structure to hold arguments for user callback
			uint8_t stack_size = sizeof(uintptr_t) * param_types.size();

			// allocate space
			cc.sub(asmjit::x86::rsp, stack_size);

			// save capture registers to save change
			std::unordered_map<uint8_t, asmjit::x86::Gp> cap_Gps;
			std::unordered_map<uint8_t, asmjit::x86::Xmm> cap_Xmms;

			// capture registers to the stack
			for (uint8_t argIdx = 0; argIdx < param_types.size(); argIdx++)
			{
				auto argType    = get_type_id(param_types.at(argIdx));
				auto argCapture = param_captures.at(argIdx);
				if (argCapture.at(0) == '[')
				{
					auto target_address = get_addr_from_name(argCapture, stack_size);
					if (!target_address.has_value())
					{
						LOG(ERROR) << "Can't get address from the name";
						return 0;
					}
					if (is_general_register(argType))
					{
						cc.mov(asmjit::x86::rbp, *target_address);
						cc.mov(asmjit::x86::ptr(asmjit::x86::rsp, sizeof(uintptr_t) * argIdx), asmjit::x86::rbp);
					}
					else if (is_XMM_register(argType))
					{
						asmjit::x86::Xmm temp = cc.newXmm();
						cc.movq(temp, *target_address);
						cc.movq(asmjit::x86::ptr(asmjit::x86::rsp, sizeof(uintptr_t) * argIdx), temp);
					}
					else
					{
						LOG(ERROR) << "Parameters wider than 64bits not supported";
						return 0;
					}
				}
				else
				{
					if (is_general_register(argType))
					{
						auto target_reg = get_Gp_from_name(argCapture);
						if (!target_reg.has_value())
						{
							LOG(ERROR) << "Can't get register from the name";
							return 0;
						}
						cc.mov(asmjit::x86::ptr(asmjit::x86::rsp, sizeof(uintptr_t) * argIdx), *target_reg);
						cap_Gps[argIdx] = *target_reg;
					}
					else if (is_XMM_register(argType))
					{
						auto target_reg = get_Xmm_from_name(argCapture);
						if (!target_reg.has_value())
						{
							LOG(ERROR) << "Can't get register from the name";
							return 0;
						}
						cc.movq(asmjit::x86::ptr(asmjit::x86::rsp, sizeof(uintptr_t) * argIdx), *target_reg);
						cap_Xmms[argIdx] = *target_reg;
					}
					else
					{
						LOG(ERROR) << "Parameters wider than 64bits not supported";
						return 0;
					}
				}
			}
			// pass arguments to the function
			cc.mov(asmjit::x86::rcx, asmjit::x86::rsp);
			cc.mov(asmjit::x86::rdx, param_types.size());
			cc.mov(asmjit::x86::r8, (uintptr_t)target_func_ptr);

			// save the rsp
			cc.mov(asmjit::x86::rbp, asmjit::x86::rsp);
			
			// allocate prelogue space, may require a bigger space
			cc.sub(asmjit::x86::rsp, 48);

			// stack alignment
			cc.and_(asmjit::x86::rsp, 0xFF'FF'FF'F0);

			// invoke the mid callback
			cc.call((uintptr_t)mid_callback);
			
			// restore rsp
			cc.mov(asmjit::x86::rsp, asmjit::x86::rbp);

			// if the callback return value is zero, skip orig.
			cc.test(asmjit::x86::rax, asmjit::x86::rax);
			cc.jz(skip_original_invoke_label);

			// apply change
			for (const auto& pair : cap_Gps)
			{
				cc.mov(pair.second, asmjit::x86::ptr(asmjit::x86::rsp, sizeof(uintptr_t) * pair.first));
			}
			for (const auto& pair : cap_Xmms)
			{
				cc.movq(pair.second, asmjit::x86::ptr(asmjit::x86::rsp, sizeof(uintptr_t) * pair.first));
			}
			// stack cleanup
			cc.add(asmjit::x86::rsp, stack_size);

			// skip capture registers
			auto change_pop = [&](asmjit::x86::Gp reg)
			{
				for (const auto& pair : cap_Gps)
				{
					if (pair.second == reg)
					{
						cc.add(asmjit::x86::rsp, 8);
						return;
					}
				}
				cc.pop(reg);
			};
			// restore caller-saved registers
			change_pop(asmjit::x86::r11);
			change_pop(asmjit::x86::r10);
			change_pop(asmjit::x86::r9);
			change_pop(asmjit::x86::r8);
			change_pop(asmjit::x86::rdx);
			change_pop(asmjit::x86::rcx);
			change_pop(asmjit::x86::rax);
			cc.pop(asmjit::x86::rbp);

			// jump to the original function
			cc.jmp(asmjit::x86::ptr((uint64_t)m_detour->get_original_ptr()));

			cc.bind(skip_original_invoke_label);
			cc.add(asmjit::x86::rsp, stack_size + 8 * 8);
			// restore callee-saved registers
			for (int i = 0; i < restore_targets.size(); i++)
			{
				std::string target_name = restore_targets[i];
				std::string source_name = restore_sources[i];
				auto target             = get_Gp_from_name(target_name);
				if (target.has_value())
				{
					if (source_name.at(0) == '[')
					{
						auto source_addr = get_addr_from_name(source_name);
						if (source_addr.has_value())
						{
							cc.mov(*target, *source_addr);
						}
						else
						{
							LOG(ERROR) << "Failed to get source address";
							return 0;
						}
					}
					else
					{
						auto source = get_Gp_from_name(source_name);
						if (source.has_value())
						{
							cc.mov(*target, *source);
						}
						else
						{
							LOG(ERROR) << "Failed to get source register";
							return 0;
						}
					}
				}
				else
				{
					LOG(ERROR) << "Failed to get restore target";
					return 0;
				}
			}

			// stack cleanup
			if (stack_restore_offset != 0)
			{
				cc.sub(asmjit::x86::rsp, stack_restore_offset);
			}

			// write to buffer
			cc.finalize();

			// worst case, overestimates for case trampolines needed
			code.flatten();
			size_t size = code.codeSize();

			// Allocate a virtual memory (executable).
			m_jit_function_buffer.reserve(size);

			DWORD old_protect;
			VirtualProtect(m_jit_function_buffer.data(), size, PAGE_EXECUTE_READWRITE, &old_protect);

			// if multiple sections, resolve linkage (1 atm)
			if (code.hasUnresolvedLinks())
			{
				code.resolveUnresolvedLinks();
			}

			// Relocate to the base-address of the allocated memory.
			code.relocateToBase((uintptr_t)m_jit_function_buffer.data());
			code.copyFlattenedData(m_jit_function_buffer.data(), size);

			LOG(DEBUG) << "JIT Stub: " << log.data();

			return (uintptr_t)m_jit_function_buffer.data();
		}

		void create_and_enable_hook(const std::string& hook_name, uintptr_t target_func_ptr, uintptr_t jitted_func_ptr)
		{
			m_detour->set_instance(hook_name, (void*)target_func_ptr, (void*)jitted_func_ptr);

			m_detour->enable();
		}

	private:
		// does a given type fit in a general purpose register (i.e. is it integer type)
		bool is_general_register(const asmjit::TypeId type_id) const
		{
			switch (type_id)
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
		bool is_XMM_register(const asmjit::TypeId type_id) const
		{
			switch (type_id)
			{
			case asmjit::TypeId::kFloat32:
			case asmjit::TypeId::kFloat64: return true;
			default:                       return false;
			}
		}

		std::optional<asmjit::x86::Gp> get_Gp_from_name(const std::string& name)
		{
			// clang-format off
			static const std::unordered_map<std::string, asmjit::x86::Gp> reg_map = {
			    // 64-bit registers
			    {"rax", asmjit::x86::rax}, // RAX: 64-bit
			    {"rbx", asmjit::x86::rbx}, // RBX: 64-bit
			    {"rcx", asmjit::x86::rcx}, // RCX: 64-bit
			    {"rdx", asmjit::x86::rdx}, // RDX: 64-bit
			    {"rsi", asmjit::x86::rsi}, // RSI: 64-bit
			    {"rdi", asmjit::x86::rdi}, // RDI: 64-bit
			    {"rbp", asmjit::x86::rbp}, // RBP: 64-bit
			    {"rsp", asmjit::x86::rsp}, // RSP: 64-bit
			    {"r8", asmjit::x86::r8},   // R8: 64-bit
			    {"r9", asmjit::x86::r9},   // R9: 64-bit
			    {"r10", asmjit::x86::r10}, // R10: 64-bit
			    {"r11", asmjit::x86::r11}, // R11: 64-bit
			    {"r12", asmjit::x86::r12}, // R12: 64-bit
			    {"r13", asmjit::x86::r13}, // R13: 64-bit
			    {"r14", asmjit::x86::r14}, // R14: 64-bit
			    {"r15", asmjit::x86::r15}, // R15: 64-bit

			    // 32-bit registers (lower 32 bits of 64-bit registers)
			    {"eax", asmjit::x86::eax},   // EAX: low 32-bits of RAX
			    {"ebx", asmjit::x86::ebx},   // EBX: low 32-bits of RBX
			    {"ecx", asmjit::x86::ecx},   // ECX: low 32-bits of RCX
			    {"edx", asmjit::x86::edx},   // EDX: low 32-bits of RDX
			    {"esi", asmjit::x86::esi},   // ESI: low 32-bits of RSI
			    {"edi", asmjit::x86::edi},   // EDI: low 32-bits of RDI
			    {"ebp", asmjit::x86::ebp},   // EBP: low 32-bits of RBP
			    {"esp", asmjit::x86::esp},   // ESP: low 32-bits of RSP
				{"r8d", asmjit::x86::r8d},   // R8D: low 32-bits of R8
				{"r9d", asmjit::x86::r9d},   // R9D: low 32-bits of R9
				{"r10d", asmjit::x86::r10d}, // R10D: low 32-bits of R10
				{"r11d", asmjit::x86::r11d}, // R11D: low 32-bits of R11
				{"r12d", asmjit::x86::r12d}, // R12D: low 32-bits of R12
				{"r13d", asmjit::x86::r13d}, // R13D: low 32-bits of R13
				{"r14d", asmjit::x86::r14d}, // R14D: low 32-bits of R14
				{"r15d", asmjit::x86::r15d}, // R15D: low 32-bits of R15

			    // 16-bit registers (lower 16 bits of 64-bit registers)
			    {"ax", asmjit::x86::ax},     // AX: low 16-bits of RAX
			    {"bx", asmjit::x86::bx},     // BX: low 16-bits of RBX
			    {"cx", asmjit::x86::cx},     // CX: low 16-bits of RCX
			    {"dx", asmjit::x86::dx},     // DX: low 16-bits of RDX
			    {"si", asmjit::x86::si},     // SI: low 16-bits of RSI
			    {"di", asmjit::x86::di},     // DI: low 16-bits of RDI
			    {"bp", asmjit::x86::bp},     // BP: low 16-bits of RBP
			    {"sp", asmjit::x86::sp},     // SP: low 16-bits of RSP
				{"r8w", asmjit::x86::r8w},   // R8W: low 16-bits of R8
				{"r9w", asmjit::x86::r9w},   // R9W: low 16-bits of R9
				{"r10w", asmjit::x86::r10w}, // R10W: low 16-bits of R10
				{"r11w", asmjit::x86::r11w}, // R11W: low 16-bits of R11
				{"r12w", asmjit::x86::r12w}, // R12W: low 16-bits of R12
				{"r13w", asmjit::x86::r13w}, // R13W: low 16-bits of R13
				{"r14w", asmjit::x86::r14w}, // R14W: low 16-bits of R14
				{"r15w", asmjit::x86::r15w}, // R15W: low 16-bits of R15

			    // 8-bit registers (lower 8 bits of 64-bit registers)
			    {"al", asmjit::x86::al},     // AL: low 8-bits of RAX
			    {"ah", asmjit::x86::ah},     // AH: high 8-bits of RAX
			    {"bl", asmjit::x86::bl},     // BL: low 8-bits of RBX
			    {"bh", asmjit::x86::bh},     // BH: high 8-bits of RBX
			    {"cl", asmjit::x86::cl},     // CL: low 8-bits of RCX
			    {"ch", asmjit::x86::ch},     // CH: high 8-bits of RCX
			    {"dl", asmjit::x86::dl},     // DL: low 8-bits of RDX
			    {"dh", asmjit::x86::dh},     // DH: high 8-bits of RDX
			    {"sil", asmjit::x86::sil},   // SIL: low 8-bits of RSI
			    {"dil", asmjit::x86::dil},   // DIL: low 8-bits of RDI
			    {"bpl", asmjit::x86::bpl},   // BPL: low 8-bits of RBP
			    {"spl", asmjit::x86::spl},    // SPL: low 8-bits of RSP
				{"r8b", asmjit::x86::r8b},   // R8B: low 8-bits of R8
				{"r9b", asmjit::x86::r9b},   // R9B: low 8-bits of R9
				{"r10b", asmjit::x86::r10b}, // R10B: low 8-bits of R10
				{"r11b", asmjit::x86::r11b}, // R11B: low 8-bits of R11
				{"r12b", asmjit::x86::r12b}, // R12B: low 8-bits of R12
				{"r13b", asmjit::x86::r13b}, // R13B: low 8-bits of R13
				{"r14b", asmjit::x86::r14b}, // R14B: low 8-bits of R14
				{"r15b", asmjit::x86::r15b} // R15B: low 8-bits of R15
			};
			// clang-format on
			auto it = reg_map.find(name);
			if (it != reg_map.end())
			{
				return it->second;
			}
			else
			{
				return std::nullopt;
			}
		}

		std::optional<asmjit::x86::Xmm> get_Xmm_from_name(const std::string& name)
		{
			// clang-format off
			static const std::unordered_map<std::string, asmjit::x86::Xmm> reg_map = {
				{"xmm0", asmjit::x86::xmm0},   {"xmm1", asmjit::x86::xmm1},   {"xmm2", asmjit::x86::xmm2},
				{"xmm3", asmjit::x86::xmm3},   {"xmm4", asmjit::x86::xmm4},   {"xmm5", asmjit::x86::xmm5},
				{"xmm6", asmjit::x86::xmm6},   {"xmm7", asmjit::x86::xmm7},   {"xmm8", asmjit::x86::xmm8},
				{"xmm9", asmjit::x86::xmm9},   {"xmm10", asmjit::x86::xmm10}, {"xmm11", asmjit::x86::xmm11},
				{"xmm12", asmjit::x86::xmm12}, {"xmm13", asmjit::x86::xmm13}, {"xmm14", asmjit::x86::xmm14},
				{"xmm15", asmjit::x86::xmm15}
			};
			// clang-format on
			auto it = reg_map.find(name);
			if (it != reg_map.end())
			{
				return it->second;
			}
			else
			{
				return std::nullopt;
			}
		}

		std::optional<asmjit::x86::Mem> get_addr_from_name(const std::string& name, const int64_t rsp_offset = 0)
		{
			auto catch_substr = [&](auto& ch)
			{
				std::string sub_str;
				++ch;
				while (*ch != '+' && *ch != '-' && *ch != '*' && *ch != ']' && ch != name.end())
				{
					if (*ch != ' ')
					{
						sub_str += *ch;
					}
					++ch;
				}
				--ch;
				return sub_str;
			};
			auto to_number = [](std::string_view str) -> uint64_t
			{
				auto get_base = [](std::string_view& base) -> int
				{
					if (base.size() > 2 && base[0] == '0' && (base[1] == 'x' || base[1] == 'X'))
					{
						base.remove_prefix(2);
						return 16;
					}
					switch (base.back())
					{
					case 'b': base.remove_suffix(1); return 2;
					case 'o': base.remove_suffix(1); return 8;
					case 'd': base.remove_suffix(1); return 10;
					case 'h': base.remove_suffix(1); return 16;
					default:  return 10;
					}
				};
				uint64_t num;
				auto [ptr, ec] = std::from_chars(str.data(), str.data() + str.size(), num, get_base(str));
				if (ptr != (str.data() + str.size()))
				{
					return 0;
				}
				return num;
			};
			std::string base_str;
			std::string index_str;
			int32_t offset = 0;
			uint32_t shift = 0;
			for (auto ch = name.begin(); ch != name.end(); ++ch)
			{
				if (*ch == '[')
				{
					std::string sub_str = catch_substr(ch);
					auto num            = to_number(sub_str);
					if (num != 0)
					{
						return asmjit::x86::ptr(num);
					}
					else
					{
						base_str = sub_str;
					}
				}
				else if (*ch == '+')
				{
					std::string sub_str = catch_substr(ch);
					auto num            = to_number(sub_str);
					if (num != 0)
					{
						offset += num;
					}
					else
					{
						index_str = sub_str;
					}
				}
				else if (*ch == '-')
				{
					std::string sub_str = catch_substr(ch);
					auto num            = to_number(sub_str);
					if (num != 0)
					{
						offset -= num;
					}
					else
					{
						// I'm not sure this should happen.
						// I think this is not necessary in a normal situation, and may need a register to solve it.
						LOG(ERROR) << "Can't sub a register";
						return std::nullopt;
					}
				}
				else if (*ch == '*')
				{
					std::string sub_str = catch_substr(ch);
					auto num            = to_number(sub_str);
					if (num != 0)
					{
						while (num)
						{
							num >>= 1;
							shift++;
						}
						shift--;
					}
					else
					{
						LOG(ERROR) << "Can't parse the shift";
						return std::nullopt;
					}
				}
			}

			auto base = get_Gp_from_name(base_str);
			if (!base.has_value())
			{
				LOG(ERROR) << "Failed to get base reg from : " << base_str;
				return std::nullopt;
			}
			if (*base == asmjit::x86::rsp)
			{
				offset += rsp_offset;
			}
			auto index = get_Gp_from_name(index_str);
			if (index.has_value())
			{
				return asmjit::x86::ptr(*base, *index, shift, offset);
			}
			else
			{
				return asmjit::x86::ptr(*base, offset);
			}
			LOG(ERROR) << "Failed to parse address from : " << name;
			return std::nullopt;
		}

		asmjit::CallConvId get_call_convention(const std::string& conv)
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

		asmjit::TypeId get_type_id(const std::string& type)
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

		std::vector<uint8_t> m_jit_function_buffer;
		asmjit::x86::Mem argsStack;
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
	namespace type_info_utils
	{
		enum class type_info_ : uint8_t
		{
			RValue_ptr_,
			CInstance_ptr_,
			YYObjectBase_ptr_,
			RefDynamicArrayOfRValue_ptr_,
			CScriptRef_ptr_
		};
		using type_info_ext = std::variant<type_info_, lua::memory::type_info_t>;

		static type_info_ext get_type_info_ext_from_string(const std::string& s)
		{
			// clang-format off
			static std::unordered_map<std::string, type_info_> type_map = {
				{"RValue*", type_info_::RValue_ptr_},
				{"CInstance*", type_info_::CInstance_ptr_},
				{"YYObjectBase*", type_info_::YYObjectBase_ptr_},
				{"RefDynamicArrayOfRValue*", type_info_::RefDynamicArrayOfRValue_ptr_},
				{"CScriptRef*", type_info_::CScriptRef_ptr_}
			};
			// clang-format on
			for (const auto& [key, value] : type_map)
			{
				if (s.contains(key))
				{
					return value;
				}
			}
			auto get_type_info_t_from_string = [](const std::string& s)
			{
				if ((s.contains("const") && s.contains("char") && s.contains("*")) || s.contains("string"))
				{
					return lua::memory::type_info_t::string_;
				}
				else if (s.contains("bool"))
				{
					return lua::memory::type_info_t::boolean_;
				}
				else if (s.contains("ptr") || s.contains("pointer") || s.contains("*"))
				{
					// passing lua::memory::pointer
					return lua::memory::type_info_t::ptr_;
				}
				else if (s.contains("float"))
				{
					return lua::memory::type_info_t::float_;
				}
				else if (s.contains("double"))
				{
					return lua::memory::type_info_t::double_;
				}
				else
				{
					return lua::memory::type_info_t::integer_;
				}
			};
			return get_type_info_t_from_string(s);
		}
	} // namespace type_info_utils

	static std::unordered_map<uintptr_t, std::unique_ptr<qstd::runtime_func>> hooks_original_func_ptr_to_info;
	static std::unordered_map<uintptr_t, std::vector<type_info_utils::type_info_ext>> dynamic_hook_mid_ptr_to_param_types;
	static std::unordered_map<uintptr_t, sol::protected_function> m_dynamic_hook_mid_callbacks;

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

	static bool mid_callback(const qstd::runtime_func::parameters_t* params, const uint8_t param_count, const uintptr_t target_func_ptr)
	{
		sol::table args(big::g_lua_manager->lua_state(), sol::new_table(param_count));
		for (uint8_t i = 0; i < param_count; i++)
		{
			std::visit(
			    [&](type_info_utils::type_info_ext type_ext)
			    {
				    if (auto type = std::get_if<type_info_utils::type_info_>(&type_ext))
				    {
					    // clang-format off
						switch (*type)
						{
						case type_info_utils::type_info_::RValue_ptr_: 
							args[i + 1] = params->get<RValue*>(i); 
							break;
						case type_info_utils::type_info_::CInstance_ptr_:
							args[i + 1] = params->get<CInstance*>(i);
							break;
						case type_info_utils::type_info_::YYObjectBase_ptr_:
							args[i + 1] = params->get<YYObjectBase*>(i);
							break;
						case type_info_utils::type_info_::RefDynamicArrayOfRValue_ptr_:
							args[i + 1] = params->get<RefDynamicArrayOfRValue*>(i);
							break;
						}
					    // clang-format on
				    }
				    else if (auto type = std::get_if<lua::memory::type_info_t>(&type_ext))
				    {
					    if (*type == lua::memory::type_info_t::ptr_)
					    {
						    args[i + 1] = sol::make_object(big::g_lua_manager->lua_state(), lua::memory::pointer(params->get<uintptr_t>(i)));
					    }
					    else
					    {
						    args[i + 1] =
						        sol::make_object(big::g_lua_manager->lua_state(), lua::memory::value_wrapper_t(params->get_arg_ptr(i), *type));
					    }
				    }
			    },
			    dynamic_hook_mid_ptr_to_param_types[target_func_ptr][i]);
		}
		bool call_orig_if_true = true;

		auto cb = m_dynamic_hook_mid_callbacks.find(target_func_ptr);
		if (cb != m_dynamic_hook_mid_callbacks.end())
		{
			const auto new_call_orig_if_true = cb->second(args);

			if (call_orig_if_true && new_call_orig_if_true.valid() && new_call_orig_if_true.get_type() == sol::type::boolean
			    && new_call_orig_if_true.get<bool>() == false)
			{
				call_orig_if_true = false;
			}
		}
		return call_orig_if_true;
	}

	struct make_central_script_result
	{
		big::lua_module_ext* m_this_lua_module = nullptr;
		void* m_original_func_ptr              = nullptr;
		bool m_is_game_script_func             = false;
	};

	static std::unordered_map<int, std::string> script_index_to_name;

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
			std::unordered_map<std::string, uintptr_t> gml_func_cache;

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
	// Name: dynamic_hook_mid
	// Param: hook_name: string: The name of the hook.
	// Param: param_captures_targets: table<string>: Addresses of the parameters which you want to capture. Register should be placed in front of the address, if you captrue an XMM register and an XMM address in the same hook.
	// Param: param_captures_types: table<string>: Types of the parameters which you want to capture.
	// Param: stack_restore_offset: int: An offset used to restore stack, only need when you want to interrupt the function.
	// Param: param_restores: table<string, string>: Restore targets and restore sources used to restore function, only need when you want to interrupt the function.
	// Param: target_func_ptr: memory.pointer: The pointer to the function to detour.
	// Param: mid_callback: function: The function that will be called when the program reaches the position. The callback must match the following signature: ( args (If it's a GM struct, it will be a pointer, else will be a value_wrapper) ) -> Returns false (boolean) if you want to interrupt the function.
	// **Example Usage:**
	// ```lua
	// local ptr = memory.scan_pattern("some ida sig")
	// gm.dynamic_hook_mid("test_hook", {"rax", "rcx", "[rcx+rdx*4+11]"}, {"int", "RValue*", "int"}, "8", 0, {}, ptr, function(args)
	//     log.info("trigger", args[1]:get(), args[2].value, args[3]:set(1))
	// end)
	// ```
	// But scan_pattern may be affected by the other hooks.

	static void dynamic_hook_mid(const std::string& hook_name_str, sol::table param_captures_targets, sol::table param_captures_types, int stack_restore_offset, sol::table restores_table, lua::memory::pointer& target_func_ptr_obj, sol::protected_function lua_mid_callback, sol::this_environment env)
	{
		auto mdl = (big::lua_module_ext*)big::lua_module::this_from(env);
		if (mdl)
		{
			if (lua_mid_callback.valid())
			{
				const auto target_func_ptr = target_func_ptr_obj.get_address();
				if (!hooks_original_func_ptr_to_info.contains(target_func_ptr))
				{
					auto parse_table_to_string = [](const sol::table& table, std::vector<std::string>& target_vector)
					{
						for (const auto& [k, v] : table)
						{
							if (v.is<const char*>())
							{
								target_vector.push_back(v.as<const char*>());
							}
						}
					};
					std::vector<std::string> param_captures;
					parse_table_to_string(param_captures_targets, param_captures);
					std::vector<std::string> param_types;
					parse_table_to_string(param_captures_types, param_types);
					for (const std::string& s : param_types)
					{
						dynamic_hook_mid_ptr_to_param_types[target_func_ptr].push_back(type_info_utils::get_type_info_ext_from_string(s));
					}

					std::vector<std::string> restore_targets;
					std::vector<std::string> restore_sources;
					for (const auto& [k, v] : restores_table)
					{
						if (k.is<const char*>())
						{
							restore_targets.push_back(k.as<const char*>());
						}
						if (v.is<const char*>())
						{
							restore_sources.push_back(v.as<const char*>());
						}
					}
					std::stringstream hook_name;
					hook_name << mdl->guid() << " | " << hook_name_str << " | " << target_func_ptr;
					LOG(INFO) << "hook_name: " << hook_name.str();

					std::unique_ptr<qstd::runtime_func> runtime_func = std::make_unique<qstd::runtime_func>();

					const auto JIT = runtime_func->make_jit_midfunc(param_types, param_captures, stack_restore_offset, restore_targets, restore_sources, asmjit::Arch::kHost, mid_callback, target_func_ptr);

					hooks_original_func_ptr_to_info.emplace(target_func_ptr, std::move(runtime_func));

					hooks_original_func_ptr_to_info[target_func_ptr]->create_and_enable_hook(hook_name.str(), target_func_ptr, JIT);

					m_dynamic_hook_mid_callbacks[target_func_ptr] = lua_mid_callback;
					mdl->m_data.m_pre_cleanup.push_back(
					    [target_func_ptr]()
					    {
							dynamic_hook_mid_ptr_to_param_types[target_func_ptr].clear();
						    hooks_original_func_ptr_to_info[target_func_ptr]->m_detour->disable();
						    hooks_original_func_ptr_to_info.erase(target_func_ptr);
					    });
				}
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
						    if (!gm::is_valid_call(key_str))
						    {
							    return sol::lua_nil;
						    }

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
		// Name: CScriptRef
		// Class representing a game maker script reference.
		//
		// Can be called by having an instance and doing `someScriptRefInstance(self, other, someExtraArg)`.
		//
		// Atleast 2 args 'self' and 'other' game maker instances / structs need to be passed when calling the script.
		//
		// lua nil can also be passed if needed for those two args.
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
					    LOG(WARNING) << "Attempted to call a script reference without atleast 2 args 'self' and "
					                    "'other' game "
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

		ns["dynamic_hook_mid"] = dynamic_hook_mid;

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
		// Name: get_script_addr
		// Param: function_index: number: index of the game script / builtin game maker function.
		// Returns: pointer: A pointer to the found address.
		// **Example Usage**
		// ```lua
		// pointer = gm.get_script_addr(gm.constants.actor_death)
		// ```
		ns["get_script_addr"] = [](double function_index, sol::this_state this_state_) -> sol::object
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
		// Name: get_obj_func_addr
		// Param: function_name: string: the name of target function.
		// Returns: pointer: A pointer to the found address.
		// **Example Usage**
		// ```lua
		// pointer = gm.get_obj_func_addr("gml_Object_oStartMenu_Step_2")
		// ```
		ns["get_obj_func_addr"] = [](const std::string& function_name, sol::this_state this_state_) -> sol::object
		{
			uintptr_t ptr = get_object_function_ptr(function_name);
			if (ptr == 0)
			{
				return sol::lua_nil;
			}
			return sol::make_object(big::g_lua_manager->lua_state(), lua::memory::pointer(ptr));
		};

		ns["variable_global_get"] = lua_gm_variable_global_get;
		ns["variable_global_set"] = lua_gm_variable_global_set;

		ns["struct_create"] = lua_struct_create;

		auto meta_gm = state.create();
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
				                                  // TODO: Both of these wrapper should ideally early return nil if the function name doesn't exist.
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
