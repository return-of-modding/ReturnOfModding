#pragma once
#include "CCode.hpp"
#include "CInstance.hpp"

namespace gm
{
	using Code_Execute = bool (*)(CInstance* self, CInstance* other, CCode* code, RValue* a4, int a5);
}
