#include "game_maker.hpp"

#include "rorr/gm/Code_Function_GET_the_function.hpp"
#include "rorr/gm/EVariableType.hpp"
#include "rorr/gm/Variable_BuiltIn.hpp"

#define BIND_USERTYPE(lua_variable, type_name, field_name) lua_variable[#field_name] = &type_name::field_name;

static RValue parse_sol_object(sol::object arg)
{
	if (arg.get_type() == sol::type::number)
		return RValue(arg.as<double>());
	else if (arg.get_type() == sol::type::string)
		return RValue(arg.as<std::string>());
	else if (arg.get_type() == sol::type::boolean)
		return RValue(arg.as<bool>());
	else if (arg.get_type() == sol::type::userdata)
		return arg.as<RValue>();

	return {};
}

static std::vector<RValue> parse_variadic_args(sol::variadic_args args)
{
	std::vector<RValue> vec_args;
	for (const auto& arg : args)
	{
		vec_args.push_back(parse_sol_object(arg));
	}
	return vec_args;
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
	static void lua_gm_variable_global_set(std::string_view name, sol::reference new_value)
	{
		auto val = parse_sol_object(new_value);
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

		// Lua API: Table
		// Name: YYObjectBaseType
		// Table containing all possible types of an YYObjectBaseType
		{
			state.new_enum<YYObjectBaseType>("YYObjectBaseType",
			    {
			        // Lua API: Field
			        // Table: YYObjectBaseType
			        // Field: YYOBJECTBASE: YYOBJECTBASE
			        {"YYOBJECTBASE", YYObjectBaseType::YYOBJECTBASE},

			        // Lua API: Field
			        // Table: YYObjectBaseType
			        // Field: CINSTANCE: CINSTANCE
			        {"CINSTANCE", YYObjectBaseType::CINSTANCE},

			        // Lua API: Field
			        // Table: YYObjectBaseType
			        // Field: ACCESSOR: ACCESSOR
			        {"ACCESSOR", YYObjectBaseType::ACCESSOR},

			        // Lua API: Field
			        // Table: YYObjectBaseType
			        // Field: SCRIPTREF: SCRIPTREF
			        {"SCRIPTREF", YYObjectBaseType::SCRIPTREF},

			        // Lua API: Field
			        // Table: YYObjectBaseType
			        // Field: PROPERTY: PROPERTY
			        {"PROPERTY", YYObjectBaseType::PROPERTY},

			        // Lua API: Field
			        // Table: YYObjectBaseType
			        // Field: ARRAY: ARRAY
			        {"ARRAY", YYObjectBaseType::ARRAY},

			        // Lua API: Field
			        // Table: YYObjectBaseType
			        // Field: WEAKREF: WEAKREF
			        {"WEAKREF", YYObjectBaseType::WEAKREF},

			        // Lua API: Field
			        // Table: YYObjectBaseType
			        // Field: CONTAINER: CONTAINER
			        {"CONTAINER", YYObjectBaseType::CONTAINER},

			        // Lua API: Field
			        // Table: YYObjectBaseType
			        // Field: SEQUENCE: SEQUENCE
			        {"SEQUENCE", YYObjectBaseType::SEQUENCE},

			        // Lua API: Field
			        // Table: YYObjectBaseType
			        // Field: SEQUENCEINSTANCE: SEQUENCEINSTANCE
			        {"SEQUENCEINSTANCE", YYObjectBaseType::SEQUENCEINSTANCE},

			        // Lua API: Field
			        // Table: YYObjectBaseType
			        // Field: SEQUENCETRACK: SEQUENCETRACK
			        {"SEQUENCETRACK", YYObjectBaseType::SEQUENCETRACK},

			        // Lua API: Field
			        // Table: YYObjectBaseType
			        // Field: SEQUENCECURVE: SEQUENCECURVE
			        {"SEQUENCECURVE", YYObjectBaseType::SEQUENCECURVE},

			        // Lua API: Field
			        // Table: YYObjectBaseType
			        // Field: SEQUENCECURVECHANNEL: SEQUENCECURVECHANNEL
			        {"SEQUENCECURVECHANNEL", YYObjectBaseType::SEQUENCECURVECHANNEL},

			        // Lua API: Field
			        // Table: YYObjectBaseType
			        // Field: SEQUENCEKEYFRAMESTORE: SEQUENCEKEYFRAMESTORE
			        {"SEQUENCEKEYFRAMESTORE", YYObjectBaseType::SEQUENCEKEYFRAMESTORE},

			        // Lua API: Field
			        // Table: YYObjectBaseType
			        // Field: SEQUENCEKEYFRAME: SEQUENCEKEYFRAME
			        {"SEQUENCEKEYFRAME", YYObjectBaseType::SEQUENCEKEYFRAME},

			        // Lua API: Field
			        // Table: YYObjectBaseType
			        // Field: SEQUENCEEVALTREE: SEQUENCEEVALTREE
			        {"SEQUENCEEVALTREE", YYObjectBaseType::SEQUENCEEVALTREE},

			        // Lua API: Field
			        // Table: YYObjectBaseType
			        // Field: SEQUENCEEVALNODE: SEQUENCEEVALNODE
			        {"SEQUENCEEVALNODE", YYObjectBaseType::SEQUENCEEVALNODE},

			        // Lua API: Field
			        // Table: YYObjectBaseType
			        // Field: SEQUENCEEVENT: SEQUENCEEVENT
			        {"SEQUENCEEVENT", YYObjectBaseType::SEQUENCEEVENT},

			        // Lua API: Field
			        // Table: YYObjectBaseType
			        // Field: NINESLICE: NINESLICE
			        {"NINESLICE", YYObjectBaseType::NINESLICE},
			    });
		}

		// Lua API: Class
		// Name: YYObjectBase
		// Class representing an object coming from the game maker engine
		{
			sol::usertype<YYObjectBase> type = state.new_usertype<YYObjectBase>("YYObjectBase");

			// Lua API: Field
			// Class: YYObjectBase
			// Field: type: YYObjectBaseType
			BIND_USERTYPE(type, YYObjectBase, type);

			// Lua API: Field
			// Class: YYObjectBase
			// Field: cinstance: CInstance
			type["cinstance"] = sol::property([](YYObjectBase& inst) {
				return (CInstance*)&inst;
			});
		}


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
			sol::usertype<RValue> type = state.new_usertype<RValue>("RValue", sol::constructors<RValue(), RValue(bool), RValue(double), RValue(const char*)>(), sol::meta_function::garbage_collect, sol::destructor(&RValue::__localFree));

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
			// Field: object: YYObjectBase
			type["object"] = sol::property([](RValue& inst) {
				return inst.asObject();
			});

			// Lua API: Field
			// Class: RValue
			// Field: cinstance: CInstance
			type["cinstance"] = sol::property([](RValue& inst) {
				return (CInstance*)inst.asObject();
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
		// Class representing a game maker object instance.
		//
		// You can use most if not all of the builtin game maker variables (For example `myCInstance.x`) [listed here](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Asset_Management/Instances/Instance_Variables/Instance_Variables.htm).
		//
		// To know the specific instance variables of a given object defined by the game call dump_vars() on the instance
		{
			sol::usertype<CInstance> type = state.new_usertype<CInstance>(
			    "CInstance",
			    sol::meta_function::index,
			    [](sol::this_state this_state_, sol::object self, sol::stack_object key) -> sol::reference {
				    auto v = self.as<sol::table&>().raw_get<sol::optional<sol::reference>>(key);
				    if (v)
				    {
					    return v.value();
				    }
				    else
				    {
					    if (!key.is<const char*>())
					    {
						    return sol::lua_nil;
					    }

					    const auto res =
					        gm::call("variable_instance_get", std::to_array<RValue, 2>({self.as<CInstance&>().id, key.as<const char*>()}));

					    switch (res.type & MASK_TYPE_RVALUE)
					    {
					    case REAL:
					    case STRING: return sol::make_object<const char*>(this_state_, res.ref_string->get());
					    case _BOOL:
					    case _INT32:
					    case _INT64: return sol::make_object<double>(this_state_, res.asReal());
					    case ARRAY:
						    return sol::make_object<std::span<RValue>>(this_state_,
						        res.ref_array && res.isArray() ? res.ref_array->array() : dummy_rvalue_array);
					    case REF:
					    case PTR: return sol::make_object<void*>(this_state_, res.ptr);
					    case OBJECT: return sol::make_object<CInstance*>(this_state_, (CInstance*)res.ptr);
					    case UNDEFINED:
					    case UNSET: return sol ::lua_nil;
					    default: return sol::make_object<RValue>(this_state_, res);
					    }
				    }
			    },
			    sol::meta_function::new_index,
			    [](sol::object self, sol::stack_object key, sol::stack_object value) {
				    auto v = self.as<sol::table&>().raw_get<sol::optional<sol::reference>>(key);
				    if (v)
				    {
					    self.as<sol::table&>().raw_set(key, value);
				    }
				    else
				    {
					    if (!key.is<const char*>())
					    {
						    return;
					    }

					    gm::call("variable_instance_set", std::to_array<RValue, 3>({self.as<CInstance&>().id, key.as<const char*>(), parse_sol_object(key)}));
				    }
			    });

			BIND_USERTYPE(type, CInstance, m_CreateCounter);

			BIND_USERTYPE(type, CInstance, m_Instflags);

			// Lua API: Field
			// Class: CInstance
			// Field: id: number
			BIND_USERTYPE(type, CInstance, id);

			// Lua API: Field
			// Class: CInstance
			// Field: object_index: number
			BIND_USERTYPE(type, CInstance, object_index);

			// Lua API: Field
			// Class: CInstance
			// Field: sprite_index: number
			BIND_USERTYPE(type, CInstance, sprite_index);

			BIND_USERTYPE(type, CInstance, i_sequencePos);
			BIND_USERTYPE(type, CInstance, i_lastSequencePos);
			BIND_USERTYPE(type, CInstance, i_sequenceDir);

			// Lua API: Field
			// Class: CInstance
			// Field: image_index: number
			BIND_USERTYPE(type, CInstance, image_index);

			// Lua API: Field
			// Class: CInstance
			// Field: image_speed: number
			BIND_USERTYPE(type, CInstance, image_speed);

			// Lua API: Field
			// Class: CInstance
			// Field: image_xscale: number
			BIND_USERTYPE(type, CInstance, image_xscale);

			// Lua API: Field
			// Class: CInstance
			// Field: image_yscale: number
			BIND_USERTYPE(type, CInstance, image_yscale);

			// Lua API: Field
			// Class: CInstance
			// Field: image_angle: number
			BIND_USERTYPE(type, CInstance, image_angle);

			// Lua API: Field
			// Class: CInstance
			// Field: image_alpha: number
			BIND_USERTYPE(type, CInstance, image_alpha);

			// Lua API: Field
			// Class: CInstance
			// Field: image_blend: number
			BIND_USERTYPE(type, CInstance, image_blend);

			// Lua API: Field
			// Class: CInstance
			// Field: x: number
			BIND_USERTYPE(type, CInstance, x);

			// Lua API: Field
			// Class: CInstance
			// Field: y: number
			BIND_USERTYPE(type, CInstance, y);

			// Lua API: Field
			// Class: CInstance
			// Field: xstart: number
			BIND_USERTYPE(type, CInstance, xstart);

			// Lua API: Field
			// Class: CInstance
			// Field: ystart: number
			BIND_USERTYPE(type, CInstance, ystart);

			// Lua API: Field
			// Class: CInstance
			// Field: xprevious: number
			BIND_USERTYPE(type, CInstance, xprevious);

			// Lua API: Field
			// Class: CInstance
			// Field: yprevious: number
			BIND_USERTYPE(type, CInstance, yprevious);

			// Lua API: Field
			// Class: CInstance
			// Field: direction: number
			BIND_USERTYPE(type, CInstance, direction);

			// Lua API: Field
			// Class: CInstance
			// Field: speed: number
			BIND_USERTYPE(type, CInstance, speed);

			// Lua API: Field
			// Class: CInstance
			// Field: friction: number
			BIND_USERTYPE(type, CInstance, friction);

			// Lua API: Field
			// Class: CInstance
			// Field: gravity_direction: number
			BIND_USERTYPE(type, CInstance, gravity_direction);

			// Lua API: Field
			// Class: CInstance
			// Field: gravity: number
			BIND_USERTYPE(type, CInstance, gravity);

			// Lua API: Field
			// Class: CInstance
			// Field: hspeed: number
			BIND_USERTYPE(type, CInstance, hspeed);

			// Lua API: Field
			// Class: CInstance
			// Field: vspeed: number
			BIND_USERTYPE(type, CInstance, vspeed);

			// Lua API: Field
			// Class: CInstance
			// Field: bbox: number[4] array
			BIND_USERTYPE(type, CInstance, bbox);

			// Lua API: Field
			// Class: CInstance
			// Field: timer: number
			BIND_USERTYPE(type, CInstance, timer);

			// Lua API: Field
			// Class: CInstance
			// Field: layer: number
			BIND_USERTYPE(type, CInstance, layer);

			// Lua API: Field
			// Class: CInstance
			// Field: mask_index: number
			BIND_USERTYPE(type, CInstance, mask_index);

			// Lua API: Field
			// Class: CInstance
			// Field: m_nMouseOver: number
			BIND_USERTYPE(type, CInstance, m_nMouseOver);

			// Lua API: Field
			// Class: CInstance
			// Field: m_pNext: CInstance
			BIND_USERTYPE(type, CInstance, m_pNext);

			// Lua API: Field
			// Class: CInstance
			// Field: m_pPrev: CInstance
			BIND_USERTYPE(type, CInstance, m_pPrev);

			// Lua API: Field
			// Class: CInstance
			// Field: depth: number
			BIND_USERTYPE(type, CInstance, depth);

			// Lua API: Field
			// Class: CInstance
			// Field: i_currentdepth: number
			BIND_USERTYPE(type, CInstance, i_currentdepth);

			BIND_USERTYPE(type, CInstance, i_lastImageNumber);
			BIND_USERTYPE(type, CInstance, m_collisionTestNumber);

			// Lua API: Field
			// Class: CInstance
			// Field: object_name: string
			type["object_name"] = sol::property(&CInstance::object_name);

			// Lua API: Function
			// Class: CInstance
			// Name: dump_vars
			// Log dump to the console all the variable names of the given object, for example with an `oP` (Player) object instance you will be able to do `print(myoPInstance.user_name)`
			type["dump_vars"] = [](CInstance& self) {
				const auto var_names = gm::call("variable_instance_get_names", self.id).asArray();
				for (int i = 0; i < var_names->length; i++)
				{
					LOG(INFO) << var_names->m_Array[i].asString();
				}
			};

			auto CInstance_table = ns["CInstance"].get_or_create<sol::table>();

			// Lua API: Field
			// Table: gm.CInstance
			// Field: instances_all: CInstance table of all (active or unactive) game maker object instances
			CInstance_table["instances_all"] = &gm::CInstances_all;

			// Lua API: Field
			// Table: gm.CInstance
			// Field: instances_active: CInstance table of all active game maker object instances
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

		// Constants
		{
			// Lua API: Field
			// Table: gm
			// Field: constants: table of gml/game constants name to their asset index.
			auto constants = ns["constants"].get_or_create<sol::table>();

			// Lua API: Field
			// Table: gm
			// Field: constant_types: table of gml/game constants name to their type name
			auto constant_types = ns["constant_types"].get_or_create<sol::table>();

			// Lua API: Field
			// Table: gm
			// Field: constants_type_sorted: constants_type_sorted[type_name][i] = constant_name
			auto constants_type_sorted = ns["constants_type_sorted"].get_or_create<sol::table>();

			auto asset_loop_over = [&](std::string type, const std::string& custom_type_name = "", double start = 0.0) {
				const char* asset_name{"<undefined>"};

				std::string routine_name = type + "_get_name";

				if (custom_type_name.size())
				{
					type = custom_type_name;
				}

				double i;

				try
				{
					for (i = start; true; ++i)
					{
						RValue asset = gm::call(routine_name, i);
						if (asset.type == RValueType::STRING)
						{
							asset_name = asset.ref_string->m_thing;
							// if the asset does not exist, its name will be "<undefined>"
							// but since in GM an asset can't start with '<', it's faster to just check for the first character.
							// (It seems GM internally does the exact same check)
							if (asset_name && asset_name[0] != '<')
							{
								constants[asset_name]                                      = i;
								constant_types[asset_name]                                 = type;
								constants_type_sorted[type].get_or_create<sol::table>()[i] = asset_name;
							}
							else
							{
								break;
							}
						}
						else
						{
							break;
						}
					}
				}
				catch (...)
				{
					// thrown by shader_get_name, just ignore it.
				}

				return i;
			};

			auto room_loop_over = [&]() {
				std::string room = "room";

				const char* asset_name{"<undefined>"};
				// arbitrary random limit,
				// can't use room_last because room added through room_add which happens a lot here are not counted by it
				constexpr double arbitrary_limit = 1000.0;
				for (double i = 0; i < arbitrary_limit; ++i)
				{
					RValue asset = gm::call(room + "_get_name", i);
					if (asset.type == RValueType::STRING)
					{
						asset_name = asset.ref_string->m_thing;
						// if the asset does not exist, its name will be "<undefined>"
						// but since in GM an asset can't start with '<', it's faster to just check for the first character.
						// (It seems GM internally does the exact same check)
						if (asset_name && asset_name[0] != '<')
						{
							state["gm"]["constants"][asset_name]                                      = i;
							state["gm"]["constant_types"][asset_name]                                 = room;
							state["gm"]["constants_type_sorted"][room].get_or_create<sol::table>()[i] = asset_name;
						}
					}
				}
			};

			asset_loop_over("object");
			asset_loop_over("sprite");
			room_loop_over();
			asset_loop_over("font");
			asset_loop_over("audio");
			asset_loop_over("path");
			asset_loop_over("timeline");
			asset_loop_over("tileset");
			asset_loop_over("shader");
			asset_loop_over("script");                         // runtime funcs
			asset_loop_over("script", "gml_script", 100001.0); // gml scripts

			ns["_returnofmodding_constants_internal_"].get_or_create<sol::table>()["update_room_cache"] = room_loop_over;
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