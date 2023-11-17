#pragma once
#include <pointers.hpp>
#include <string/hash.hpp>

namespace gm
{
	struct code_function_info
	{
		const char* function_name = nullptr;
		TRoutine function_ptr     = nullptr;
		int function_arg_count    = 0;
	};
	static code_function_info dummy{};
	static std::unordered_map<std::string, code_function_info, big::string::transparent_string_hash, std::equal_to<>> code_function_cache;
	inline code_function_info& get_code_function(std::string_view name)
	{
		if (const auto it = code_function_cache.find(name.data()); it != code_function_cache.end())
		{
			return it->second;
		}

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

	inline RValue call_function(std::string_view name, CInstance* self, CInstance* other, RValue* args = nullptr, size_t arg_count = 0)
	{
		const auto& func_info = get_code_function(name);

		if (func_info.function_name)
		{
			RValue res;
			func_info.function_ptr(&res, self, other, arg_count, args);
			return res;
		}

		return {};
	}

	inline RValue call_global_function(std::string_view name, RValue* args = nullptr, size_t arg_count = 0)
	{
		return call_function(name, nullptr, nullptr, args, arg_count);
	}

	template<typename T>
	concept SpanCompatibleType = requires(T a) { std::span{a}; };

	template<typename T>
	    requires SpanCompatibleType<T>
	inline RValue call_function(std::string_view name, CInstance* self, CInstance* other, T args)
	{
		return call_function(name, self, other, args.data(), args.size());
	}

	template<typename T>
	    requires SpanCompatibleType<T>
	inline RValue call_global_function(std::string_view name, T args)
	{
		return call_function(name, nullptr, nullptr, args.data(), args.size());
	}

	inline RValue call_function(std::string_view name, CInstance* self, CInstance* other, RValue& arg)
	{
		return call_function(name, self, other, &arg, 1);
	}
	inline RValue call_function(std::string_view name, CInstance* self, CInstance* other, RValue&& arg)
	{
		return call_function(name, self, other, arg);
	}
	inline RValue call_global_function(std::string_view name, RValue& arg)
	{
		return call_function(name, nullptr, nullptr, arg);
	}
	inline RValue call_global_function(std::string_view name, RValue&& arg)
	{
		return call_function(name, nullptr, nullptr, arg);
	}

	inline void print_all_code_functions()
	{
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
}
