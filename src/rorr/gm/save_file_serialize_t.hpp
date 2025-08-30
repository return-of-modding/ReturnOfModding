#pragma once

namespace gm
{
	using save_file_serialize_t   = RValue* (*)(CInstance* a1, CInstance* a2, RValue* a3, int a4, RValue** a5);
	using save_file_deserialize_t = RValue* (*)(CInstance* a1, CInstance* a2, RValue* a3, int a4, RValue** a5);
	using json_parse_t            = void (*)(RValue* res, CInstance* a2, CInstance* a3, __int64 a4, RValue* arg);
} // namespace gm
