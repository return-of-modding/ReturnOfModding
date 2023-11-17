#pragma once

enum EVariableType : int
{
	VAR_SELF     = -1,
	VAR_OTHER    = -2,
	VAR_ALL      = -3,
	VAR_NOONE    = -4,
	VAR_GLOBAL   = -5,
	VAR_BUILTIN  = -6,
	VAR_LOCAL    = -7,
	VAR_STACKTOP = -9,
	VAR_ARGUMENT = -15,
};