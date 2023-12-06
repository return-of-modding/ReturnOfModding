#pragma once
#include "log.hpp"

#include "lua/lua_module.hpp"

namespace lua::log
{
	static sol::protected_function tostring;

	static void log_internal(sol::variadic_args& args, sol::this_environment& env, al::eLogLevel level)
	{
		std::stringstream data;

		for (const auto& arg : args)
		{
			data << tostring(arg).get<const char*>() << '\t';
		}

		LOG(level) << big::lua_module::guid_from(env) << ": " << data.str();
	}

	// Lua API: Table
	// Name: log
	// Table containing functions for printing to console / log file.

	// Lua API: Function
	// Table: log
	// Name: info
	// Param: args: any
	// Logs an informational message.
	static void info(sol::variadic_args args, sol::this_environment env)
	{
		log_internal(args, env, INFO);
	}

	// Lua API: Function
	// Table: log
	// Name: warning
	// Param: args: any
	// Logs a warning message.
	static void warning(sol::variadic_args args, sol::this_environment env)
	{
		log_internal(args, env, WARNING);
	}

	// Lua API: Function
	// Table: log
	// Name: debug
	// Param: args: any
	// Logs a debug message.
	static void debug(sol::variadic_args args, sol::this_environment env)
	{
		log_internal(args, env, VERBOSE);
	}

	// Lua API: Function
	// Table: log
	// Name: error
	// Param: args: any
	// Logs an error message.
	static void error(sol::variadic_args args, sol::this_environment env)
	{
		log_internal(args, env, FATAL);
	}

	void bind(sol::state& state)
	{
		tostring = state["tostring"];

		state["print"] = info;
		state["error"] = error;

		auto ns       = state["log"].get_or_create<sol::table>();
		ns["info"]    = info;
		ns["warning"] = warning;
		ns["debug"]   = debug;
		ns["error"]   = error;
	}
}