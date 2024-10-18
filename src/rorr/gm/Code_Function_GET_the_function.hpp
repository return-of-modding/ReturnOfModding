#pragma once
#include "CScript.hpp"
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

	inline RValue call(std::string_view name, CInstance* self, CInstance* other, RValue* args = nullptr, size_t arg_count = 0)
	{
		const auto& func_info = get_code_function(name);

		RValue res{};

		if (func_info.function_ptr)
		{
			try
			{
				func_info.function_ptr(&res, self, other, arg_count, args);
			}
			catch (const YYGMLException& e)
			{
				gml_exception_handler(e.GetExceptionObject());
			}

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

					cscript->m_funcs->m_script_function(self, other, &res, arg_count, arranged_args);
				}

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

						cscript->m_funcs->m_script_function(self, other, &res, arg_count, arranged_args);
					}

					return res;
				}
			}
		}

		LOG(WARNING) << name << " function not found!";

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
} // namespace gm
