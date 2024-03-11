#include "CInstance.hpp"

#include "Code_Function_GET_the_function.hpp"

void CInstance::imgui_dump()
{
	ImGui::Text("Instance ID: %d", id);
	ImGui::Text("Position: %.2f, %.2f", x, y);
	ImGui::Text("Gravity: %.2f (Direction: %.2f)", gravity, gravity_direction);
	ImGui::Text("Speed: %.2f", speed);
	ImGui::Text("Object Name: %s (Index: %d) ", object_name().c_str(), object_index);

	const auto sprite_name = gm::call("sprite_get_name", sprite_index);
	if (sprite_name.type == RValueType::STRING)
	{
		ImGui::Text("Sprite Name: %s (Index: %d) ", sprite_name.ref_string->m_thing, sprite_index);
	}

	const auto layer_name = gm::call("layer_get_name", layer);
	if (layer_name.type == RValueType::STRING)
	{
		ImGui::Text("Layer Name: %s (Index: %d) ", layer_name.ref_string->m_thing, layer);
	}

	ImGui::Text("Depth: %.2f | %.2f", depth, i_currentdepth);
}

void CInstance::imgui_dump_instance_variables()
{
	RValue instance_variable_names = gm::call("variable_instance_get_names", id);
	ImGui::Text("Var Count: %d", instance_variable_names.ref_array->length);
	ImGui::Text("Ref Count: %d", instance_variable_names.ref_array->m_refCount);
	ImGui::Text("Flags: %d", instance_variable_names.ref_array->m_flags);
	ImGui::Text("Owner: %d", instance_variable_names.ref_array->m_Owner);
	ImGui::Text("Visited: %d", instance_variable_names.ref_array->visited);
	for (int i = 0; i < instance_variable_names.ref_array->length; i++)
	{
		if (instance_variable_names.ref_array->m_Array[i].type == RValueType::STRING)
		{
			const auto& var_name = instance_variable_names.ref_array->m_Array[i].ref_string->m_thing;
			ImGui::Text("%d: %s (Ref: %d)", i, var_name, instance_variable_names.ref_array->m_Array[i].ref_string->m_refCount);
			ImGui::SameLine();
			static std::unordered_map<std::string, std::array<char, 256>> var_to_input_texts;
			ImGui::InputText(std::format("##{}", var_name).c_str(), var_to_input_texts[var_name].data(), 256);
			ImGui::SameLine();
			if (ImGui::Button(std::format("SAVE ##btn{}", var_name).c_str()))
			{
				gm::call("variable_instance_set",
				         std::to_array<RValue, 3>({id, var_name, std::stod(var_to_input_texts[var_name].data())}));
			}
		}
	}
}

static std::unordered_map<int, std::string> object_index_to_name;
static std::string dummy;

const std::string& CInstance::object_name() const
{
	if (!object_index_to_name.contains(object_index))
	{
		const auto object_name = gm::call("object_get_name", object_index);
		if (object_name.type == RValueType::STRING)
		{
			object_index_to_name[object_index] = object_name.ref_string->m_thing;
			return object_index_to_name[object_index];
		}
	}
	else
	{
		return object_index_to_name[object_index];
	}

	return dummy;
}
