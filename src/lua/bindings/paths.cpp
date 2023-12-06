#pragma once
#include "paths.hpp"

#include "lua/lua_manager.hpp"

namespace lua::paths
{
	// Lua API: Table
	// Name: paths
	// Table containing helpers for retrieving ReturnOfModding related IO file/folder paths.

	// Lua API: Function
	// Table: paths
	// Name: config
	// Returns: string: Returns the ReturnOfModding/config folder path
	static std::string config()
	{
		return (char*)big::g_lua_manager->get_config_folder().get_path().u8string().c_str();
	}

	// Lua API: Function
	// Table: paths
	// Name: plugins_data
	// Returns: string: Returns the ReturnOfModding/plugins_data folder path
	static std::string plugins_data()
	{
		return (char*)big::g_lua_manager->get_plugins_data_folder().get_path().u8string().c_str();
	}

	void bind(sol::state& state)
	{
		auto ns            = state["paths"].get_or_create<sol::table>();
		ns["config"]       = config;
		ns["plugins_data"] = plugins_data;
	}
}