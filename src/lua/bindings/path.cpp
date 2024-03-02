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

	// Lua API: Function
	// Table: path
	// Name: get_directories
	// Param: root_path: string: The path to the directory to search.
	// Returns: string table: Returns the names of subdirectories under the given root_path
	static std::vector<std::string> get_directories(const std::string& root_path)
	{
		std::vector<std::string> res;

		try
		{
			for (const auto& entry : std::filesystem::recursive_directory_iterator(root_path, std::filesystem::directory_options::skip_permission_denied))
			{
				if (!entry.is_directory())
					continue;

				res.push_back((char*)entry.path().u8string().c_str());
			}
		}
		catch (const std::exception& e)
		{
			LOG(WARNING) << e.what();
		}

		return res;
	}

	// Lua API: Function
	// Table: path
	// Name: get_files
	// Param: root_path: string: The path to the directory to search.
	// Returns: string table: Returns the names of all the files under the given root_path
	static std::vector<std::string> get_files(const std::string& root_path)
	{
		std::vector<std::string> res;

		try
		{
			for (const auto& entry : std::filesystem::recursive_directory_iterator(root_path, std::filesystem::directory_options::skip_permission_denied))
			{
				if (entry.is_directory())
					continue;

				res.push_back((char*)entry.path().u8string().c_str());
			}
		}
		catch (const std::exception& e)
		{
			LOG(WARNING) << e.what();
		}

		return res;
	}

	void bind(sol::state& state)
	{
		auto ns               = state["path"].get_or_create<sol::table>();
		ns["combine"]         = combine;
		ns["get_parent"]      = get_parent;
		ns["get_directories"] = get_directories;
		ns["get_files"]       = get_files;
	}
}