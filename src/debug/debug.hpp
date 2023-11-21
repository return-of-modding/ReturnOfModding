#pragma once

namespace big
{
	inline void wait_until_debugger()
	{
		while (!IsDebuggerPresent())
		{
			std::this_thread::sleep_for(1s);
		}
	}
}