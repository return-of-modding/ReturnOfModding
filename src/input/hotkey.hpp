#pragma once

#include <toml.hpp>

namespace big
{
	class hotkey
	{
		std::string m_name;
		toml::node* m_vk = nullptr;
		int64_t m_default_vk;

	public:
		hotkey() = delete;
		hotkey(const std::string& name, int64_t default_vk);

		~hotkey();

		int64_t& vk();

		static inline std::unordered_map<std::string, hotkey*> hotkeys;
		static inline constexpr auto m_file_name = "ReturnOfModding-ReturnOfModding-Hotkeys.cfg";
		static inline std::filesystem::path m_file_path;
		static inline toml::table m_table;
		static inline toml::table m_last_saved_table;
		static void init_hotkeys();
		static void save_hotkeys_if_needed();
		static void save_hotkeys();
	};
} // namespace big
