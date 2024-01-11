#pragma once

namespace lua::window
{
	// mod guid -> window name -> is the window open
	inline std::unordered_map<std::string, std::unordered_map<std::string, bool>> is_open;
}