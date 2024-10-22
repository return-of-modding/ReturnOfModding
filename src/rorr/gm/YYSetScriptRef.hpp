#pragma once

struct RValue;
struct YYObjectBase;

using YYSetScriptRef_t = void* (*)(RValue* result, void* function_pointer, YYObjectBase* context_can_be_null);
