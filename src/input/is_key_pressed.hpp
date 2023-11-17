#pragma once

namespace big
{
	inline bool is_key_pressed(uint16_t key)
	{
		if (GetAsyncKeyState(key) & 0x8000)
		{
			return true;
		}

		return false;
	}
}