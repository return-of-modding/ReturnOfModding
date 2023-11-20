#include "game_maker.hpp"
//#include "lua_module.hpp"
#include "rorr/gm/Code_Function_GET_the_function.hpp"
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

		// RValue
		{
			sol::usertype<RValue> type = state.new_usertype<RValue>("RValue", sol::constructors<RValue(), RValue(double), RValue(const char*)>());

			BIND_USERTYPE(type, RValue, Kind);

			BIND_USERTYPE(type, RValue, Real);
			BIND_USERTYPE(type, RValue, I32);
			BIND_USERTYPE(type, RValue, I64);

			type["string"] = sol::property(&RValue::get_string, &RValue::set_string);
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
	}
}