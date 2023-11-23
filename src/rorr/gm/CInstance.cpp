#include "CInstance.hpp"

#include "Code_Function_GET_the_function.hpp"

void CInstance::imgui_dump()
{
	ImGui::Text("Instance ID: %d", i_id);
	ImGui::Text("Position: %.2f, %.2f", i_x, i_y);
	ImGui::Text("Gravity: %.2f (Direction: %.2f)", i_gravity, i_gravitydir);
	ImGui::Text("Speed: %.2f", i_speed);
	ImGui::Text("Object Name: %s (Index: %d) ", object_name().c_str(), i_objectindex);

	RValue sprite_index    = i_spriteindex;
	const auto sprite_name = gm::call("sprite_get_name", sprite_index);
	if (sprite_name.kind == RValueType::STRING)
		ImGui::Text("Sprite Name: %s (Index: %d) ", sprite_name.pRefString->m_thing, i_spriteindex);

	RValue layer_id       = m_nLayerID;
	const auto layer_name = gm::call("layer_get_name", layer_id);
	if (layer_name.kind == RValueType::STRING)
		ImGui::Text("Layer Name: %s (Index: %d) ", layer_name.pRefString->m_thing, m_nLayerID);

	ImGui::Text("Depth: %.2f | %.2f", i_depth, i_currentdepth);
}

void CInstance::imgui_dump_instance_variables()
{
	RValue instance_variable_names = gm::call("variable_instance_get_names", i_id);
	ImGui::Text("Var Count: %d", instance_variable_names.pRefArray->length);
	ImGui::Text("Ref Count: %d", instance_variable_names.pRefArray->m_refCount);
	ImGui::Text("Flags: %d", instance_variable_names.pRefArray->m_flags);
	ImGui::Text("Owner: %d", instance_variable_names.pRefArray->m_Owner);
	ImGui::Text("Visited: %d", instance_variable_names.pRefArray->visited);
	for (int i = 0; i < instance_variable_names.pRefArray->length; i++)
	{
		if (instance_variable_names.pRefArray->m_Array[i].kind == RValueType::STRING)
		{
			const auto& var_name = instance_variable_names.pRefArray->m_Array[i].pRefString->m_thing;
			ImGui::Text("%d: %s (Ref: %d)", i, var_name, instance_variable_names.pRefArray->m_Array[i].pRefString->m_refCount);
			ImGui::SameLine();
			static std::unordered_map<std::string, std::array<char, 256>> var_to_input_texts;
			ImGui::InputText(std::format("##{}", var_name).c_str(), var_to_input_texts[var_name].data(), 256);
			ImGui::SameLine();
			if (ImGui::Button(std::format("SAVE ##btn{}", var_name).c_str()))
			{
				gm::call("variable_instance_set",
				    std::to_array<RValue, 3>({i_id, var_name, std::stod(var_to_input_texts[var_name].data())}));
			}
		}
	}
}

static std::unordered_map<int64_t, std::string> object_index_to_name;
static std::string dummy;
const std::string& CInstance::object_name() const
{
	if (!object_index_to_name.contains((int64_t)i_objectindex))
	{
		RValue object_index    = i_objectindex;
		const auto object_name = gm::call("object_get_name", object_index);
		if (object_name.kind == RValueType::STRING)
		{
			object_index_to_name[(int64_t)i_objectindex] = object_name.pRefString->m_thing;
			return object_index_to_name[(int64_t)i_objectindex];
		}
	}
	else
	{
		return object_index_to_name[(int64_t)i_objectindex];
	}

	return dummy;
}

template <typename T>
static T variable_instance_get(int instance_id, const char* variable_name)
{
	RValue res = gm::call("variable_instance_get", std::to_array<RValue, 2>({instance_id, variable_name}));
	if constexpr (std::is_same_v<T, RValue>)
	{
		return res;
	}

	if constexpr (std::is_same_v<T, double>)
	{
		return res.asReal();
	}

	if constexpr (std::is_same_v<T, bool>)
	{
		return res.asBoolean();
	}

	if constexpr (std::is_same_v<T, std::string>)
	{
		return res.asString();
	}
}

RValue CInstance::get(const char* variable_name)
{
	auto r = variable_instance_get<RValue>(i_id, variable_name);
	return variable_instance_get<RValue>(i_id, variable_name);
}

bool CInstance::get_bool(const char* variable_name)
{
	return variable_instance_get<bool>(i_id, variable_name);
}

double CInstance::get_double(const char* variable_name)
{
	return variable_instance_get<double>(i_id, variable_name);
}

std::string CInstance::get_string(const char* variable_name)
{
	return variable_instance_get<std::string>(i_id, variable_name);
}

template<typename T>
static void variable_instance_set(int instance_id, const char* variable_name, T& new_value)
{
	gm::call("variable_instance_set", std::to_array<RValue, 3>({instance_id, variable_name, new_value}));
}

void CInstance::set(const char* variable_name, RValue& new_value)
{
	variable_instance_set(i_id, variable_name, new_value);
}

void CInstance::set_bool(const char* variable_name, bool new_value)
{
	variable_instance_set(i_id, variable_name, new_value);
}

void CInstance::set_double(const char* variable_name, double new_value)
{
	variable_instance_set(i_id, variable_name, new_value);
}

void CInstance::set_string(const char* variable_name, const char* new_value)
{
	variable_instance_set(i_id, variable_name, new_value);
}
