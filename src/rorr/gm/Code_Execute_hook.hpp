#pragma once
#include "Code_Execute_trace.hpp"
#include "Code_Function_GET_the_function.hpp"

#include <lua/lua_manager_extension.hpp>
#include <string/string.hpp>

#include "lua/lua_memory_alloc.hpp"
#include "version.hpp"

namespace gm
{
	inline bool g_is_gml_safe_to_init = false;

	inline void init_lua_manager()
	{
		if (!big::g_abort)
		{
			gm::init_function_caches();

			YYObjectPinMap::init_pin_map();
		}

		big::g_running = true;

		g_lua_tlsf_pool = tlsf_create_with_pool(malloc(g_tlsf_pool_size), g_tlsf_pool_size);

		lua_State* L = lua_newstate(lua_custom_alloc, NULL);
		//lua_State* L = luaL_newstate();

		// Purposely leak it, we are not unloading this module in any case.
		auto lua_manager_instance = new big::lua_manager(L,
														 big::version::VERSION_NUMBER,
		                                                 big::g_file_manager.get_project_folder("config"),
		                                                 big::g_file_manager.get_project_folder("plugins_data"),
		                                                 big::g_file_manager.get_project_folder("plugins"),
		                                                 [](sol::state_view& state, sol::table& lua_ext)
		                                                 {
			                                                 big::lua_manager_extension::init_lua_api(state, lua_ext);
		                                                 });
		sol::state_view sol_state_view(L);
		big::lua_manager_extension::init_lua_base(sol_state_view);
		lua_manager_instance->init<big::lua_module_ext>(true);
		LOG(INFO) << "Lua manager initialized.";

		if (big::g_abort)
		{
			LOG(ERROR) << "ReturnOfModding failed to init properly, exiting.";
			big::g_running = false;
		}
	}

	static void rom_in_game_ui()
	{
		sol::state_view(big::g_lua_manager->lua_state()).script(R"rom_in_game_ui(
gm.post_code_execute("gml_Object_oStartMenu_Draw_0", function(self, other)
    if self.menu_transition < 1.0 then
        self:draw_set_font_w(gm.constants.fntNormal)
        self:draw_set_color(65280.0) -- https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Drawing/Colour_And_Alpha/Colour_And_Alpha.htm
        self:draw_set_alpha(0.5 * (1 - self.menu_transition))
        version_text = "Return of Modding v" .. _ROM.version
        self:draw_text_w(gm.variable_global_get("___view_l_x") + 6, gm.variable_global_get("___view_l_y") + 25, version_text)
        self:draw_set_alpha(1.0)
    end
end)

gm.post_script_hook(gm.constants.translate_load_active_language, function(self, other, result, args)
    gm.translate_load_file_internal(gm.variable_global_get("_language_map"), gm.json_parse(gm._rom_internal_json_lang()), "")
end)

gm.post_code_execute("gml_Object_oOptionsMenu_Create_0", function(self, other)
   gm.event_user(2) 
   local new_header_button = gm.struct_create()
   new_header_button.name = "MODS"
   new_header_button.show_new = false
   gm.array_push(self.header_buttons, new_header_button)
end)

gm.post_code_execute("gml_Object_oOptionsMenu_Other_11", function(self, other)
    local new_option_tab = gm.struct_create()

    new_option_tab.page_header_name_token = "MODS"
    new_option_tab.options = gm.array_create()

    local mods_rom_group_header = gm["@@NewGMLObject@@"](gm.constants.UIOptionsGroupHeader, "mods_rom_group_header")
    gm.array_push(new_option_tab.options, mods_rom_group_header)

    local my_button = gm.struct_create()
    my_button.mod_id = math.random()
    my_button_ui_object = gm["@@NewGMLObject@@"](gm.constants.UIOptionsButton2, "mods_rom_gui_keybind",
        gm.method(my_button, gm.constants.function_dummy)
    )
    gm.array_push(new_option_tab.options, my_button_ui_object)
    gm.pre_script_hook(gm.constants.function_dummy, function(self, other, result, args)
        if self.mod_id == my_button.mod_id then
            gui.reshow_onboarding()

            return false
        end
    end)

    gm.array_push(other.menu_pages, new_option_tab)
end)

)rom_in_game_ui");
	}

	inline bool hook_Code_Execute(CInstance* self, CInstance* other, CCode* code, RValue* result, int flags)
	{
		g_last_code_execute = code->name;

		bool no_error = true;
		if (big::g_lua_manager)
		{
			const auto call_orig_if_true = big::lua_manager_extension::pre_code_execute(self, other, code, result, flags);

			if (call_orig_if_true)
			{
				__try
				{
					no_error = big::g_hooking->get_original<hook_Code_Execute>()(self, other, code, result, flags);
				}
				__except (triple_exception_handler(GetExceptionInformation()), EXCEPTION_EXECUTE_HANDLER)
				{
				}
			}

			big::lua_manager_extension::post_code_execute(self, other, code, result, flags);
		}
		else
		{
			__try
			{
				no_error = big::g_hooking->get_original<hook_Code_Execute>()(self, other, code, result, flags);
			}
			__except (double_exception_handler(GetExceptionInformation()), EXCEPTION_EXECUTE_HANDLER)
			{
			}
		}

		if (!g_is_gml_safe_to_init && big::string::starts_with("gml_Object_oInit_Alarm_", code->name))
		{
			g_is_gml_safe_to_init = true;

			init_lua_manager();

			rom_in_game_ui();
		}

		g_last_code_execute = nullptr;
		return no_error;
	}
} // namespace gm
