#pragma once

#include "pointers.hpp"
#include "string/hash.hpp"

namespace gm
{
	static std::unordered_map<std::string, gm::RVariableRoutineGetter, big::string::transparent_string_hash, std::equal_to<>> getter_cache;
	static std::unordered_map<std::string, gm::RVariableRoutineSetter, big::string::transparent_string_hash, std::equal_to<>> setter_cache;

	struct get_result
	{
		bool success{};
		RValue result{};
	};

	inline get_result global_variable_get(std::string_view variable_name)
	{
		if (const auto it = getter_cache.find(variable_name.data()); it != getter_cache.end())
		{
			RValue result{};
			bool success = it->second(nullptr, nullptr, &result);
			return get_result{success, result};
		}

		const auto size = *big::g_pointers->m_rorr.m_builtin_variable_count;
		for (int i = 0; i < size; i++)
		{
			const auto& builtin_variable = big::g_pointers->m_rorr.m_builtin_variables[i];

			const auto same_name = !strcmp(builtin_variable.name, variable_name.data());
			if (same_name && builtin_variable.getter)
			{
				getter_cache[variable_name.data()] = builtin_variable.getter;

				RValue result{};
				bool success = builtin_variable.getter(nullptr, nullptr, &result);
				return get_result{success, result};
			}
		}

		return {};
	}

	inline bool global_variable_set(std::string_view variable_name, RValue& new_value)
	{
		if (const auto it = setter_cache.find(variable_name.data()); it != setter_cache.end())
		{
			RValue result{};
			return it->second(nullptr, nullptr, &result);
		}

		const auto size = *big::g_pointers->m_rorr.m_builtin_variable_count;
		for (int i = 0; i < size; i++)
		{
			const auto& builtin_variable = big::g_pointers->m_rorr.m_builtin_variables[i];

			const auto same_name = !strcmp(builtin_variable.name, variable_name.data());
			if (same_name && builtin_variable.setter)
			{
				setter_cache[variable_name.data()] = builtin_variable.setter;

				return builtin_variable.setter(nullptr, nullptr, &new_value);
			}
		}

		return false;
	}

	inline void print_all_builtin_variables()
	{
		for (size_t i = 0; i < *big::g_pointers->m_rorr.m_builtin_variable_count; i++)
		{
			const auto& builtin_variable = big::g_pointers->m_rorr.m_builtin_variables[i];

			LOG(INFO) << builtin_variable.name;
			LOG(INFO) << HEX_TO_UPPER_OFFSET(builtin_variable.getter);
			LOG(INFO) << HEX_TO_UPPER_OFFSET(builtin_variable.setter);
		}
	}
}