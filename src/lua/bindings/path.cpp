#pragma once
#include "path.hpp"

namespace lua::path
{
	// Lua API: Table
	// Name: path
	// Table containing helpers for manipulating file or directory paths

	// Lua API: Function
	// Table: path
	// Name: combine
	// Param: path: string: Any amount of string is accepted.
	// Returns: string: Returns the combined path
	// Combines strings into a path.
	static std::string combine(sol::variadic_args args)
	{
		try
		{
			std::filesystem::path res{};

			for (const auto& arg : args)
			{
				if (arg.is<std::string>())
				{
					if (res.empty())
					{
						res = arg.as<std::string>();
					}
					else
					{
						res /= arg.as<std::string>();
					}
				}
			}

			return res.string();
		}
		catch (const std::exception& e)
		{
			LOG(WARNING) << e.what();
		}

		return "";
	}

	// Lua API: Function
	// Table: path
	// Name: get_parent
	// Param: path: string: The path for which to retrieve the parent directory.
	// Returns: string: Returns the parent path
	// Retrieves the parent directory of the specified path, including both absolute and relative paths.
	static std::string get_parent(const std::string& path)
	{
		try
		{
			std::filesystem::path res = path;
			return res.parent_path().string();
		}
		catch (const std::exception& e)
		{
			LOG(WARNING) << e.what();
		}

		return "";
	}

	void bind(sol::state& state)
	{
		auto ns          = state["path"].get_or_create<sol::table>();
		ns["combine"]    = combine;
		ns["get_parent"] = get_parent;
	}
}