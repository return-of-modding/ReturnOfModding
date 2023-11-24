#include "game_maker.hpp"

#include "rorr/gm/Code_Function_GET_the_function.hpp"
#include "rorr/gm/EVariableType.hpp"
#include "rorr/gm/Variable_BuiltIn.hpp"

#define BIND_USERTYPE(lua_variable, type_name, field_name) lua_variable[#field_name] = &type_name::field_name;

namespace lua::game_maker
{
	static std::vector<RValue> parse_variadic_args(sol::variadic_args args)
	{
		std::vector<RValue> vec_args;
		for (const auto& arg : args)
		{
			if (arg.get_type() == sol::type::number)
				vec_args.push_back(arg.as<double>());
			else if (arg.get_type() == sol::type::string)
				vec_args.push_back(arg.as<std::string>());
			else if (arg.get_type() == sol::type::boolean)
				vec_args.push_back(arg.as<bool>());
			else if (arg.get_type() == sol::type::userdata)
				vec_args.push_back(arg.as<RValue>());
		}
		return vec_args;
	}

	static void pre_code_execute(sol::protected_function cb, sol::this_state state)
	{
		big::lua_module* mdl = sol::state_view(state)["!this"];

		mdl->m_pre_code_execute_callbacks.push_back(cb);
	}

	static void post_code_execute(sol::protected_function cb, sol::this_state state)
	{
		big::lua_module* mdl = sol::state_view(state)["!this"];

		mdl->m_post_code_execute_callbacks.push_back(cb);
	}

	static RValue lua_gm_global_variable_get(std::string_view name)
	{
		const auto res = gm::global_variable_get(name);
		return res.result;
	}

	static RValue lua_gm_call(std::string_view name, CInstance* self, CInstance* other, sol::variadic_args args)
	{
		return gm::call(name, self, other, parse_variadic_args(args));
	}

	static RValue lua_gm_call_global(std::string_view name, sol::variadic_args args)
	{
		return gm::call(name, parse_variadic_args(args));
	}

	void bind(sol::state& state)
	{
		auto ns = state["gm"].get_or_create<sol::table>();

		// RefDynamicArrayOfRValue
		{
			sol::usertype<RefDynamicArrayOfRValue> type = state.new_usertype<RefDynamicArrayOfRValue>("RefDynamicArrayOfRValue");

			BIND_USERTYPE(type, RefDynamicArrayOfRValue, length);
			BIND_USERTYPE(type, RefDynamicArrayOfRValue, m_refCount);
			BIND_USERTYPE(type, RefDynamicArrayOfRValue, m_Owner);
			BIND_USERTYPE(type, RefDynamicArrayOfRValue, visited);
			BIND_USERTYPE(type, RefDynamicArrayOfRValue, m_flags);

			type["array"] = sol::property(&RefDynamicArrayOfRValue::array);
		}

		// RValue
		{
			sol::usertype<RValue> type = state.new_usertype<RValue>("RValue", sol::constructors<RValue(), RValue(bool), RValue(double), RValue(const char*)>());

			BIND_USERTYPE(type, RValue, kind);

			BIND_USERTYPE(type, RValue, real);
			BIND_USERTYPE(type, RValue, v32);
			BIND_USERTYPE(type, RValue, v64);

			BIND_USERTYPE(type, RValue, pRefArray);

			type["tostring"] = sol::property([](RValue& inst) {
				return inst.asString();
			});

			type["new_int"] = [](int value) {
				return RValue(value);
			};

			type["string"] = sol::property([](RValue& inst) {
				return inst.pRefString->m_thing;
			});

			type["string_ref_count"] = sol::property([](RValue& inst) {
				return inst.pRefString->m_refCount;
			});

			type["string_size"] = sol::property([](RValue& inst) {
				return inst.pRefString->m_size;
			});
		}

		// RValue Kind
		{
			state.new_enum<RValueType>("RValueType",
			    {
			        {"REAL", RValueType::REAL},
			        {"STRING", RValueType::STRING},
			        {"ARRAY", RValueType::ARRAY},
			        {"PTR", RValueType::PTR},
			        {"VEC3", RValueType::VEC3},
			        {"UNDEFINED", RValueType::UNDEFINED},
			        {"OBJECT", RValueType::OBJECT},
			        {"INT32", RValueType::_INT32},
			        {"VEC4", RValueType::VEC4},
			        {"MATRIX", RValueType::MATRIX},
			        {"INT64", RValueType::_INT64},
			        {"ACCESSOR", RValueType::ACCESSOR},
			        {"JSNULL", RValueType::JSNULL},
			        {"BOOL", RValueType::_BOOL},
			        {"ITERATOR", RValueType::ITERATOR},
			        {"REF", RValueType::REF},
			        {"UNSET", RValueType::UNSET},
			    });
		}

		// EVariableType
		{
			state.new_enum<EVariableType>("EVariableType",
			    {
			        {"SELF", EVariableType::SELF},
			        {"OTHER", EVariableType::OTHER},
			        {"ALL", EVariableType::ALL},
			        {"NOONE", EVariableType::NOONE},
			        {"GLOBAL", EVariableType::GLOBAL},
			        {"BUILTIN", EVariableType::BUILTIN},
			        {"LOCAL", EVariableType::LOCAL},
			        {"STACKTOP", EVariableType::STACKTOP},
			        {"ARGUMENT", EVariableType::ARGUMENT},
			    });
		}

		// CInstance
		{
			sol::usertype<CInstance> type = state.new_usertype<CInstance>("CInstance");

			BIND_USERTYPE(type, CInstance, m_CreateCounter);
			BIND_USERTYPE(type, CInstance, m_Instflags);
			BIND_USERTYPE(type, CInstance, i_id);
			BIND_USERTYPE(type, CInstance, i_objectindex);
			BIND_USERTYPE(type, CInstance, i_spriteindex);
			BIND_USERTYPE(type, CInstance, i_sequencePos);
			BIND_USERTYPE(type, CInstance, i_lastSequencePos);
			BIND_USERTYPE(type, CInstance, i_sequenceDir);
			BIND_USERTYPE(type, CInstance, i_imageindex);
			BIND_USERTYPE(type, CInstance, i_imagespeed);
			BIND_USERTYPE(type, CInstance, i_imagescalex);
			BIND_USERTYPE(type, CInstance, i_imagescaley);
			BIND_USERTYPE(type, CInstance, i_imageangle);
			BIND_USERTYPE(type, CInstance, i_imagealpha);
			BIND_USERTYPE(type, CInstance, i_imageblend);
			BIND_USERTYPE(type, CInstance, i_x);
			BIND_USERTYPE(type, CInstance, i_y);
			BIND_USERTYPE(type, CInstance, i_xstart);
			BIND_USERTYPE(type, CInstance, i_ystart);
			BIND_USERTYPE(type, CInstance, i_xprevious);
			BIND_USERTYPE(type, CInstance, i_yprevious);
			BIND_USERTYPE(type, CInstance, i_direction);
			BIND_USERTYPE(type, CInstance, i_speed);
			BIND_USERTYPE(type, CInstance, i_friction);
			BIND_USERTYPE(type, CInstance, i_gravitydir);
			BIND_USERTYPE(type, CInstance, i_gravity);
			BIND_USERTYPE(type, CInstance, i_hspeed);
			BIND_USERTYPE(type, CInstance, i_vspeed);
			BIND_USERTYPE(type, CInstance, i_bbox);
			BIND_USERTYPE(type, CInstance, i_timer);
			BIND_USERTYPE(type, CInstance, m_nLayerID);
			BIND_USERTYPE(type, CInstance, i_maskindex);
			BIND_USERTYPE(type, CInstance, m_nMouseOver);
			BIND_USERTYPE(type, CInstance, m_pNext);
			BIND_USERTYPE(type, CInstance, m_pPrev);
			BIND_USERTYPE(type, CInstance, i_depth);
			BIND_USERTYPE(type, CInstance, i_currentdepth);
			BIND_USERTYPE(type, CInstance, i_lastImageNumber);
			BIND_USERTYPE(type, CInstance, m_collisionTestNumber);

			type["object_name"] = sol::property(&CInstance::object_name);

			type["get"]        = &CInstance::get;
			type["get_bool"]   = &CInstance::get_bool;
			type["get_double"] = &CInstance::get_double;
			type["get_string"] = &CInstance::get_string;

			type["set"] = sol::overload(&CInstance::set, &CInstance::set_bool, &CInstance::set_double, &CInstance::set_string);

			auto CInstance_table                = ns["CInstance"].get_or_create<sol::table>();
			CInstance_table["instances_all"]    = &gm::CInstances_all;
			CInstance_table["instances_active"] = &gm::CInstances_active;
		}

		// CCode
		{
			sol::usertype<CCode> type = state.new_usertype<CCode>("CCode");

			BIND_USERTYPE(type, CCode, i_CodeIndex);
			BIND_USERTYPE(type, CCode, i_pName);
		}

		ns["pre_code_execute"]  = pre_code_execute;
		ns["post_code_execute"] = post_code_execute;

		ns["call"] = sol::overload(lua_gm_call, lua_gm_call_global);

		ns["global_variable_get"] = lua_gm_global_variable_get;
		ns["global_variable_set"] = gm::global_variable_set;
	}
}