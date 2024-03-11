#pragma once

enum EVariableType : int
{
	SELF     = -1,
	OTHER    = -2,
	ALL      = -3,
	NOONE    = -4,
	GLOBAL   = -5,
	BUILTIN  = -6,
	LOCAL    = -7,
	STACKTOP = -9,
	ARGUMENT = -15,
};
