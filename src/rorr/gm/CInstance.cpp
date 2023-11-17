#include "CInstance.hpp"

#include "CDynamicArray.hpp"
#include "Code_Function_GET_the_function.hpp"
#include "RefThing.hpp"

static std::unordered_map<int64_t, std::string> object_index_to_name;

void CInstance::imgui_dump()
{
	if (!object_index_to_name.contains((int64_t)i_objectindex))
	{
		RValue object_index                          = i_objectindex;
		const auto object_name                       = gm::call_global_function("object_get_name", object_index);
		if (object_name.Kind == RVKind::VALUE_STRING)
			object_index_to_name[(int64_t)i_objectindex] = object_name.String->m_Thing;
	}

	ImGui::Text("Instance ID: %d", i_id);
	ImGui::Text("Position: %.2f, %.2f", i_x, i_y);
	ImGui::Text("Gravity: %.2f (Direction: %.2f)", i_gravity, i_gravitydir);
	ImGui::Text("Speed: %.2f", i_speed);
	ImGui::Text("Object Name: %s (Index: %d) ", object_index_to_name[(int64_t)i_objectindex].c_str(), i_objectindex);

	RValue sprite_index    = i_spriteindex;
	const auto sprite_name = gm::call_global_function("sprite_get_name", sprite_index);
	if (sprite_name.Kind == RVKind::VALUE_STRING)
		ImGui::Text("Sprite Name: %s (Index: %d) ", sprite_name.String->m_Thing, i_spriteindex);

	RValue layer_id       = m_nLayerID;
	const auto layer_name = gm::call_global_function("layer_get_name", layer_id);
	if (layer_name.Kind == RVKind::VALUE_STRING)
		ImGui::Text("Layer Name: %s (Index: %d) ", layer_name.String->m_Thing, m_nLayerID);

	ImGui::Text("Depth: %.2f | %.2f", i_depth, i_currentdepth);
}

void CInstance::imgui_dump_instance_variables()
{
	RValue instance_variable_names = gm::call_global_function("variable_instance_get_names", i_id);

	for (int i = 0; i < instance_variable_names.RefArray->length; i++)
	{
		if (instance_variable_names.RefArray->m_Array[i].Kind == RVKind::VALUE_STRING)
		{
			const auto& var_name = instance_variable_names.RefArray->m_Array[i].String->m_Thing;
			ImGui::Text("Var: %s", var_name);
			ImGui::SameLine();
			static std::unordered_map<std::string, std::array<char, 256>> var_to_input_texts;
			ImGui::InputText(std::format("##{}", var_name).c_str(), var_to_input_texts[var_name].data(), 256);
			ImGui::SameLine();
			if (ImGui::Button(std::format("SAVE ##btn{}", var_name).c_str()))
			{
				gm::call_global_function("variable_instance_set",
				    std::to_array<RValue, 3>({i_id, var_name, std::stod(var_to_input_texts[var_name].data())}));
			}
		}
	}
}

std::string CInstance::object_name()
{
	if (object_index_to_name.contains((int64_t)i_objectindex))
	{
		return object_index_to_name[(int64_t)i_objectindex];
	}

	return "";
}

RValue CInstance::get(const char* variable_name)
{
	return {};
}

void CInstance::set(const char* variable_name, RValue& new_value)
{
}
