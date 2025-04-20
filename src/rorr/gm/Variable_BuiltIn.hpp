#pragma once

#include "pointers.hpp"
#include "rorr/gm/Code_Function_GET_the_function.hpp"
#include "string/hash.hpp"

namespace gm
{
	static ankerl::unordered_dense::map<std::string, gm::RVariableRoutineGetter, big::string::transparent_string_hash, std::equal_to<>> builtin_getter_cache;
	static ankerl::unordered_dense::map<std::string, gm::RVariableRoutineSetter, big::string::transparent_string_hash, std::equal_to<>> builtin_setter_cache;

	static ankerl::unordered_dense::set<std::string, big::string::transparent_string_hash, std::equal_to<>> game_defined_cache;

	inline RValue variable_global_get(std::string_view variable_name)
	{
		if (const auto it = builtin_getter_cache.find(variable_name.data()); it != builtin_getter_cache.end())
		{
			RValue result{};
			it->second(nullptr, nullptr, &result);
			return result;
		}

		if (const auto it = game_defined_cache.find(variable_name.data()); it != game_defined_cache.end())
		{
			return gm::call("variable_global_get", variable_name.data());
		}

		const auto size = *big::g_pointers->m_rorr.m_builtin_variable_count;
		for (int i = 0; i < size; i++)
		{
			const auto& builtin_variable = big::g_pointers->m_rorr.m_builtin_variables[i];

			const auto same_name = !strcmp(builtin_variable.name, variable_name.data());
			if (same_name && builtin_variable.getter)
			{
				builtin_getter_cache[variable_name.data()] = builtin_variable.getter;

				RValue result{};
				builtin_variable.getter(nullptr, nullptr, &result);
				return result;
			}
		}

		const auto global_exists = gm::call("variable_global_exists", variable_name.data()).asBoolean();
		if (global_exists)
		{
			game_defined_cache.insert(variable_name.data());

			return gm::call("variable_global_get", variable_name.data());
		}

		return {};
	}

	inline bool variable_global_set(std::string_view variable_name, RValue& new_value)
	{
		if (const auto it = builtin_setter_cache.find(variable_name.data()); it != builtin_setter_cache.end())
		{
			RValue result{};
			return it->second(nullptr, nullptr, &result);
		}

		if (const auto it = game_defined_cache.find(variable_name.data()); it != game_defined_cache.end())
		{
			return gm::call("variable_global_set", std::to_array<RValue, 2>({variable_name.data(), new_value}));
		}

		const auto size = *big::g_pointers->m_rorr.m_builtin_variable_count;
		for (int i = 0; i < size; i++)
		{
			const auto& builtin_variable = big::g_pointers->m_rorr.m_builtin_variables[i];

			const auto same_name = !strcmp(builtin_variable.name, variable_name.data());
			if (same_name && builtin_variable.setter)
			{
				builtin_setter_cache[variable_name.data()] = builtin_variable.setter;

				return builtin_variable.setter(nullptr, nullptr, &new_value);
			}
		}

		const auto global_exists = gm::call("variable_global_exists", variable_name.data()).asBoolean();
		if (global_exists)
		{
			game_defined_cache.insert(variable_name.data());

			return gm::call("variable_global_set", std::to_array<RValue, 2>({variable_name.data(), new_value}));
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
} // namespace gm
