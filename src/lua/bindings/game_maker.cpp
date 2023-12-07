#include "game_maker.hpp"

#include "rorr/gm/Code_Function_GET_the_function.hpp"
#include "rorr/gm/EVariableType.hpp"
#include "rorr/gm/Variable_BuiltIn.hpp"

#define BIND_USERTYPE(lua_variable, type_name, field_name) lua_variable[#field_name] = &type_name::field_name;

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

static RValue parse_variadic_args_as_single_RValue(sol::variadic_args args)
{
	for (const auto& arg : args)
	{
		if (arg.get_type() == sol::type::number)
			return RValue(arg.as<double>());
		else if (arg.get_type() == sol::type::string)
			return RValue(arg.as<std::string>());
		else if (arg.get_type() == sol::type::boolean)
			return RValue(arg.as<bool>());
		else if (arg.get_type() == sol::type::userdata)
			return arg.as<RValue>();
	}

	return {};
}

// Lua API: Table
// Name: gm
// Table containing helpers for interacting with the game maker engine.

namespace lua::game_maker
{
	// Lua API: Function
	// Table: gm
	// Name: pre_code_execute
	// Param: callback: function: callback that match signature function ( self (CInstance), other (CInstance), code (CCode), result (RValue), flags (number) )
	// Registers a callback that will be called right before any game function is called.
	static void pre_code_execute(sol::protected_function cb, sol::this_environment env)
	{
		big::lua_module* mdl = big::lua_module::this_from(env);
		if (mdl)
			mdl->m_pre_code_execute_callbacks.push_back(cb);
	}

	// Lua API: Function
	// Table: gm
	// Name: post_code_execute
	// Param: callback: function: callback that match signature function ( self (CInstance), other (CInstance), code (CCode), result (RValue), flags (number) )
	// Registers a callback that will be called right after any game function is called.
	static void post_code_execute(sol::protected_function cb, sol::this_environment env)
	{
		big::lua_module* mdl = big::lua_module::this_from(env);
		if (mdl)
			mdl->m_post_code_execute_callbacks.push_back(cb);
	}

	// Lua API: Function
	// Table: gm
	// Name: variable_global_get
	// Param: name: string: name of the variable
	// Returns: RValue: Returns the global variable value.
	static RValue lua_gm_variable_global_get(std::string_view name)
	{
		return gm::variable_global_get(name);
	}

	// Lua API: Function
	// Table: gm
	// Name: variable_global_set
	// Param: name: string: name of the variable
	// Param: new_value: any: new value
	static void lua_gm_variable_global_set(std::string_view name, sol::variadic_args args)
	{
		auto val = parse_variadic_args_as_single_RValue(args);
		gm::variable_global_set(name, val);
	}

	// Lua API: Function
	// Table: gm
	// Name: call
	// Param: name: string: name of the function to call
	// Param: self: CInstance: (optional)
	// Param: other: CInstance: (optional)
	// Param: args: any: (optional)
	// Returns: RValue: Returns the result of the function call if there is one.
	static RValue lua_gm_call(std::string_view name, CInstance* self, CInstance* other, sol::variadic_args args)
	{
		return gm::call(name, self, other, parse_variadic_args(args));
	}

	static RValue lua_gm_call_global(std::string_view name, sol::variadic_args args)
	{
		return gm::call(name, parse_variadic_args(args));
	}

	static std::span<RValue, 0> dummy_rvalue_array{};
	void bind(sol::state& state)
	{
		auto ns = state["gm"].get_or_create<sol::table>();

		// Lua API: Class
		// Name: RValue
		// Class representing a value coming from the game maker engine
		{
			// Lua API: Constructor
			// Class: RValue
			// Param: value: boolean: value
			// Returns an RValue instance

			// Lua API: Constructor
			// Class: RValue
			// Param: value: number: value
			// Returns an RValue instance

			// Lua API: Constructor
			// Class: RValue
			// Param: value: string: value
			// Returns an RValue instance
			sol::usertype<RValue> type = state.new_usertype<RValue>("RValue", sol::constructors<RValue(), RValue(bool), RValue(double), RValue(const char*)>());

			// Lua API: Field
			// Class: RValue
			// Field: type: RValueType
			BIND_USERTYPE(type, RValue, type);

			// Lua API: Field
			// Class: RValue
			// Field: value: number
			type["value"] = sol::property([](RValue& inst) {
				return inst.asReal();
			});

			// Lua API: Field
			// Class: RValue
			// Field: array: table of RValues
			type["array"] = sol::property([](RValue& inst) {
				return inst.ref_array && inst.isArray() ? inst.ref_array->array() : dummy_rvalue_array;
			});

			// Lua API: Field
			// Class: RValue
			// Field: tostring: string representation of the RValue
			type["tostring"] = sol::property([](RValue& inst) {
				return inst.asString();
			});
		}

		// Lua API: Table
		// Name: RValueType
		// Table containing all possible types of an RValue
		{
			state.new_enum<RValueType>("RValueType",
			    {
			        // Lua API: Field
			        // Table: RValueType
			        // Field: REAL: REAL
			        {"REAL", RValueType::REAL},

			        // Lua API: Field
			        // Table: RValueType
			        // Field: STRING: STRING
			        {"STRING", RValueType::STRING},

			        // Lua API: Field
			        // Table: RValueType
			        // Field: ARRAY: ARRAY
			        {"ARRAY", RValueType::ARRAY},

			        // Lua API: Field
			        // Table: RValueType
			        // Field: PTR: PTR
			        {"PTR", RValueType::PTR},

			        // Lua API: Field
			        // Table: RValueType
			        // Field: VEC3: VEC3
			        {"VEC3", RValueType::VEC3},

			        // Lua API: Field
			        // Table: RValueType
			        // Field: UNDEFINED: UNDEFINED
			        {"UNDEFINED", RValueType::UNDEFINED},

			        // Lua API: Field
			        // Table: RValueType
			        // Field: OBJECT: OBJECT
			        {"OBJECT", RValueType::OBJECT},

			        // Lua API: Field
			        // Table: RValueType
			        // Field: INT32: INT32
			        {"INT32", RValueType::_INT32},

			        // Lua API: Field
			        // Table: RValueType
			        // Field: VEC4: VEC4
			        {"VEC4", RValueType::VEC4},

			        // Lua API: Field
			        // Table: RValueType
			        // Field: MATRIX: MATRIX
			        {"MATRIX", RValueType::MATRIX},

			        // Lua API: Field
			        // Table: RValueType
			        // Field: INT64: INT64
			        {"INT64", RValueType::_INT64},

			        // Lua API: Field
			        // Table: RValueType
			        // Field: ACCESSOR: ACCESSOR
			        {"ACCESSOR", RValueType::ACCESSOR},

			        // Lua API: Field
			        // Table: RValueType
			        // Field: JSNULL: JSNULL
			        {"JSNULL", RValueType::JSNULL},

			        // Lua API: Field
			        // Table: RValueType
			        // Field: BOOL: BOOL
			        {"BOOL", RValueType::_BOOL},

			        // Lua API: Field
			        // Table: RValueType
			        // Field: ITERATOR: ITERATOR
			        {"ITERATOR", RValueType::ITERATOR},

			        // Lua API: Field
			        // Table: RValueType
			        // Field: REF: REF
			        {"REF", RValueType::REF},

			        // Lua API: Field
			        // Table: RValueType
			        // Field: UNSET: UNSET
			        {"UNSET", RValueType::UNSET},
			    });
		}

		// Lua API: Table
		// Name: EVariableType
		// Table containing all possible kind / type of variable within the GM engine.
		{
			state.new_enum<EVariableType>("EVariableType",
			    {
			        // Lua API: Field
			        // Table: EVariableType
			        // Field: SELF: SELF
			        {"SELF", EVariableType::SELF},

			        // Lua API: Field
			        // Table: EVariableType
			        // Field: OTHER: OTHER
			        {"OTHER", EVariableType::OTHER},

			        // Lua API: Field
			        // Table: EVariableType
			        // Field: ALL: ALL
			        {"ALL", EVariableType::ALL},

			        // Lua API: Field
			        // Table: EVariableType
			        // Field: NOONE: NOONE
			        {"NOONE", EVariableType::NOONE},

			        // Lua API: Field
			        // Table: EVariableType
			        // Field: GLOBAL: GLOBAL
			        {"GLOBAL", EVariableType::GLOBAL},

			        // Lua API: Field
			        // Table: EVariableType
			        // Field: BUILTIN: BUILTIN
			        {"BUILTIN", EVariableType::BUILTIN},

			        // Lua API: Field
			        // Table: EVariableType
			        // Field: LOCAL: LOCAL
			        {"LOCAL", EVariableType::LOCAL},

			        // Lua API: Field
			        // Table: EVariableType
			        // Field: STACKTOP: STACKTOP
			        {"STACKTOP", EVariableType::STACKTOP},

			        // Lua API: Field
			        // Table: EVariableType
			        // Field: ARGUMENT: ARGUMENT
			        {"ARGUMENT", EVariableType::ARGUMENT},
			    });
		}

		// Lua API: Class
		// Name: CInstance
		// Class representing a game maker object instance
		{
			sol::usertype<CInstance> type = state.new_usertype<CInstance>("CInstance");

			// Lua API: Field
			// Table: CInstance
			// Field: m_CreateCounter: number
			BIND_USERTYPE(type, CInstance, m_CreateCounter);

			BIND_USERTYPE(type, CInstance, m_Instflags);

			// Lua API: Field
			// Table: CInstance
			// Field: i_id: number
			BIND_USERTYPE(type, CInstance, i_id);

			// Lua API: Field
			// Table: CInstance
			// Field: i_objectindex: number
			BIND_USERTYPE(type, CInstance, i_objectindex);

			// Lua API: Field
			// Table: CInstance
			// Field: i_spriteindex: number
			BIND_USERTYPE(type, CInstance, i_spriteindex);

			BIND_USERTYPE(type, CInstance, i_sequencePos);
			BIND_USERTYPE(type, CInstance, i_lastSequencePos);
			BIND_USERTYPE(type, CInstance, i_sequenceDir);

			// Lua API: Field
			// Table: CInstance
			// Field: i_imageindex: number
			BIND_USERTYPE(type, CInstance, i_imageindex);

			// Lua API: Field
			// Table: CInstance
			// Field: i_imagespeed: number
			BIND_USERTYPE(type, CInstance, i_imagespeed);

			// Lua API: Field
			// Table: CInstance
			// Field: i_imagescalex: number
			BIND_USERTYPE(type, CInstance, i_imagescalex);

			// Lua API: Field
			// Table: CInstance
			// Field: i_imagescaley: number
			BIND_USERTYPE(type, CInstance, i_imagescaley);

			// Lua API: Field
			// Table: CInstance
			// Field: i_imageangle: number
			BIND_USERTYPE(type, CInstance, i_imageangle);

			// Lua API: Field
			// Table: CInstance
			// Field: i_imagealpha: number
			BIND_USERTYPE(type, CInstance, i_imagealpha);

			// Lua API: Field
			// Table: CInstance
			// Field: i_imageblend: number
			BIND_USERTYPE(type, CInstance, i_imageblend);

			// Lua API: Field
			// Table: CInstance
			// Field: i_x: number
			BIND_USERTYPE(type, CInstance, i_x);

			// Lua API: Field
			// Table: CInstance
			// Field: i_y: number
			BIND_USERTYPE(type, CInstance, i_y);

			// Lua API: Field
			// Table: CInstance
			// Field: i_xstart: number
			BIND_USERTYPE(type, CInstance, i_xstart);

			// Lua API: Field
			// Table: CInstance
			// Field: i_ystart: number
			BIND_USERTYPE(type, CInstance, i_ystart);

			// Lua API: Field
			// Table: CInstance
			// Field: i_xprevious: number
			BIND_USERTYPE(type, CInstance, i_xprevious);

			// Lua API: Field
			// Table: CInstance
			// Field: i_yprevious: number
			BIND_USERTYPE(type, CInstance, i_yprevious);

			// Lua API: Field
			// Table: CInstance
			// Field: i_direction: number
			BIND_USERTYPE(type, CInstance, i_direction);

			// Lua API: Field
			// Table: CInstance
			// Field: i_speed: number
			BIND_USERTYPE(type, CInstance, i_speed);

			// Lua API: Field
			// Table: CInstance
			// Field: i_friction: number
			BIND_USERTYPE(type, CInstance, i_friction);

			// Lua API: Field
			// Table: CInstance
			// Field: i_gravitydir: number
			BIND_USERTYPE(type, CInstance, i_gravitydir);

			// Lua API: Field
			// Table: CInstance
			// Field: i_gravity: number
			BIND_USERTYPE(type, CInstance, i_gravity);

			// Lua API: Field
			// Table: CInstance
			// Field: i_hspeed: number
			BIND_USERTYPE(type, CInstance, i_hspeed);

			// Lua API: Field
			// Table: CInstance
			// Field: i_vspeed: number
			BIND_USERTYPE(type, CInstance, i_vspeed);

			// Lua API: Field
			// Table: CInstance
			// Field: i_bbox: number[4] array
			BIND_USERTYPE(type, CInstance, i_bbox);

			// Lua API: Field
			// Table: CInstance
			// Field: i_timer: number
			BIND_USERTYPE(type, CInstance, i_timer);

			// Lua API: Field
			// Table: CInstance
			// Field: m_nLayerID: number
			BIND_USERTYPE(type, CInstance, m_nLayerID);

			// Lua API: Field
			// Table: CInstance
			// Field: i_maskindex: number
			BIND_USERTYPE(type, CInstance, i_maskindex);

			// Lua API: Field
			// Table: CInstance
			// Field: m_nMouseOver: number
			BIND_USERTYPE(type, CInstance, m_nMouseOver);

			// Lua API: Field
			// Table: CInstance
			// Field: m_pNext: CInstance
			BIND_USERTYPE(type, CInstance, m_pNext);

			// Lua API: Field
			// Table: CInstance
			// Field: m_pPrev: CInstance
			BIND_USERTYPE(type, CInstance, m_pPrev);

			// Lua API: Field
			// Table: CInstance
			// Field: i_depth: number
			BIND_USERTYPE(type, CInstance, i_depth);

			// Lua API: Field
			// Table: CInstance
			// Field: i_currentdepth: number
			BIND_USERTYPE(type, CInstance, i_currentdepth);

			BIND_USERTYPE(type, CInstance, i_lastImageNumber);
			BIND_USERTYPE(type, CInstance, m_collisionTestNumber);

			// Lua API: Field
			// Table: CInstance
			// Field: object_name: string
			type["object_name"] = sol::property(&CInstance::object_name);

			// Lua API: Function
			// Class: CInstance
			// Name: get
			// Param: variable_name: string: name of the instance variable to get
			// Returns: RValue: Returns the variable value.
			type["get"] = &CInstance::get;

			// Lua API: Function
			// Class: CInstance
			// Name: get_bool
			// Param: variable_name: string: name of the instance variable to get
			// Returns: boolean: Returns the variable value.
			type["get_bool"] = &CInstance::get_bool;

			// Lua API: Function
			// Class: CInstance
			// Name: get_double
			// Param: variable_name: string: name of the instance variable to get
			// Returns: number: Returns the variable value.
			type["get_double"] = &CInstance::get_double;

			// Lua API: Function
			// Class: CInstance
			// Name: get_string
			// Param: variable_name: string: name of the instance variable to get
			// Returns: string: Returns the variable value.
			type["get_string"] = &CInstance::get_string;

			// Lua API: Function
			// Class: CInstance
			// Name: set
			// Param: variable_name: string: name of the instance variable to set
			// Param: new_value: any: new value
			type["set"] = sol::overload(&CInstance::set, &CInstance::set_bool, &CInstance::set_double, &CInstance::set_string);

			auto CInstance_table = ns["CInstance"].get_or_create<sol::table>();

			// Lua API: Field
			// Table: gm.CInstance
			// Field: instances_all: table of all (active or unactive) game maker object instances
			CInstance_table["instances_all"] = &gm::CInstances_all;

			// Lua API: Field
			// Table: gm.CInstance
			// Field: instances_active: table of all active game maker object instances
			CInstance_table["instances_active"] = &gm::CInstances_active;
		}

		// Lua API: Class
		// Name: CCode
		// Class representing a game function
		{
			sol::usertype<CCode> type = state.new_usertype<CCode>("CCode");

			// Lua API: Field
			// Class: CCode
			// Field: index: number
			// Index within the internal GM game functions table
			BIND_USERTYPE(type, CCode, index);

			// Lua API: Field
			// Class: CCode
			// Field: name: string
			// Name of the game function
			BIND_USERTYPE(type, CCode, name);
		}

		ns["pre_code_execute"]  = pre_code_execute;
		ns["post_code_execute"] = post_code_execute;

		ns["call"] = sol::overload(lua_gm_call, lua_gm_call_global);

		ns["variable_global_get"] = lua_gm_variable_global_get;
		ns["variable_global_set"] = lua_gm_variable_global_set;

		auto meta_gm = state.create_table();
		// Wrapper so that users can do gm.room_goto(new_room) for example instead of gm.call("room_goto", new_room)
		meta_gm.set_function(sol::meta_function::index, [](sol::table self, std::string key) -> sol::reference {
			auto v = self.raw_get<sol::optional<sol::reference>>(key);
			if (v)
			{
				return v.value();
			}
			else
			{
				self.raw_set(key,
				    sol::overload(
				        [key](sol::variadic_args args) {
					        return gm::call(key, parse_variadic_args(args));
				        },
				        [key](CInstance* self, CInstance* other, sol::variadic_args args) {
					        return gm::call(key, self, other, parse_variadic_args(args));
				        }));

				return self.raw_get<sol::reference>(key);
			}
		});
		meta_gm.set_function(sol::meta_function::new_index, [](lua_State* L) -> int {
			return luaL_error(L, "Can't define new game maker functions this way");
		});
		state["gm"][sol::metatable_key] = meta_gm;
	}
}