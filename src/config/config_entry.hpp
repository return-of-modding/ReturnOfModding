#pragma once

#include <toml++/toml.hpp>

namespace big
{
	class config_entry_base
	{
	public:
		static std::vector<config_entry_base> instances;

		toml::node* m_value;
		toml::node* m_default_value;

		bool m_save_on_disk;
		std::string m_config_category_name;
		std::string m_config_entry_name;

		config_entry_base() = default;

		config_entry_base(toml::node* value, toml::node* default_value, bool save_on_disk, const std::string& config_category_name, const std::string& config_entry_name)
		{
			m_value         = value;
			m_default_value = default_value;

			m_save_on_disk = save_on_disk;

			if (config_category_name.size() && config_entry_name.size())
			{
				m_config_category_name = config_category_name;
				m_config_entry_name    = config_entry_name;
			}
			else
			{
				LOG(FATAL) << "config entry made with no config category name and entry name";

				big::g_abort = true;
			}
		}

		~config_entry_base()
		{
			const auto is_owned_ptr = !m_save_on_disk;
			if (is_owned_ptr)
			{
				LOG(INFO) << "delete m_value";
				delete m_value;
			}

			LOG(INFO) << "delete m_default_value";
			delete m_default_value;
		}

		template<typename T>
		inline static toml::node* make_value(bool save_on_disk, T default_value)
		{
			const auto need_ptr = !save_on_disk;
			if (need_ptr)
			{
				LOG(INFO) << "allocating m_value";

				auto res      = new toml::value<T>();
				*res->as<T>() = default_value;
				return res;
			}
			else
			{
				// TODO CONFIG: delay this into a delegate for g_config initialization (at this point the config isnt ready)
			}

			return nullptr;
		}

		template<typename T>
		inline static toml::node* make_default_value(T default_value)
		{
			auto res      = new toml::value<T>();
			*res->as<T>() = default_value;

			return res;
		}

		template<typename T, size_t N>
		inline static toml::node* make_array(bool save_on_disk, T default_value)
		{
			const auto need_ptr = !save_on_disk;
			if (need_ptr)
			{
				LOG(INFO) << "allocating m_value (array)";

				auto res = new toml::array();
				res->resize(N, default_value);

				return res;
			}
			else
			{
				// TODO CONFIG: delay this into a delegate for g_config initialization (at this point the config isnt ready)
			}

			return nullptr;
		}

		template<typename T, size_t N>
		inline static toml::node* make_default_array(T default_value)
		{
			LOG(INFO) << "allocating m_default_value (array)";

			auto res = new toml::array();
			res->resize(N, default_value);

			return res;
		}
	};

	template<typename T>
	class config_entry : public config_entry_base
	{
	public:
		std::optional<T> m_lower_bound;
		std::optional<T> m_upper_bound;

		config_entry() = default;

		config_entry(T default_value, bool save_on_disk, const std::string& config_category_name, const std::string& config_entry_name, std::optional<T> lower_bound = {}, std::optional<T> upper_bound = {}) :
		    m_lower_bound(lower_bound),
		    m_upper_bound(upper_bound),
		    config_entry_base(config_entry_base::make_value(save_on_disk, default_value), config_entry_base::make_default_value(default_value), save_on_disk, config_category_name, config_entry_name)
		{
		}

		config_entry<T>& operator=(const T& new_value)
		{
			T& current_value = value();
			if (current_value != new_value)
			{
				current_value = new_value;

				if (m_save_on_disk)
				{
					// TODO
				}
			}

			return *this;
		}

		T& value()
		{
			return m_value->ref<T>();
		}

		void reset_to_default_value()
		{
			m_value->ref<T>() = m_default_value->ref<T>();
		}

		const T& value() const
		{
			return m_value->ref<T>();
		}

		operator T() const
		{
			return m_value->ref<T>();
		}
	};

	template<typename T, size_t N>
	class config_entry_array : public config_entry_base
	{
	public:
		config_entry_array(T default_value, bool save_on_disk, const std::string& config_category_name, const std::string& config_entry_name) :
		    config_entry_base(config_entry_base::make_array<T, N>(save_on_disk, default_value), config_entry_base::make_default_array<T, N>(default_value), save_on_disk, config_category_name, config_entry_name)
		{
		}

		toml::array* value()
		{
			return m_value->as_array();
		}
	};


	class config_entry_array_any : public config_entry_base
	{
		template<std::size_t I = 0, typename... Tp>
		inline typename std::enable_if<I == sizeof...(Tp), void>::type make_array_any(toml::array*, const std::tuple<Tp...>&)
		{
		}

		// clang-format off
		template<std::size_t I = 0, typename... Tp>
		inline typename std::enable_if<I < sizeof...(Tp), void>::type make_array_any(toml::array* arr, const std::tuple<Tp...>& tuple)
		// clang-format on
		{
			arr->push_back(std::get<I>(tuple));

			make_array_any<I + 1, Tp...>(arr, tuple);
		}

		config_entry_array_any(bool save_on_disk, const std::string& config_category_name, const std::string& config_entry_name) :
		    config_entry_base(nullptr, nullptr, save_on_disk, config_category_name, config_entry_name)
		{
		}

	public:
		template<typename... Tp>
		static config_entry_array_any make(const std::tuple<Tp...> default_values, bool save_on_disk, const std::string& config_category_name, const std::string& config_entry_name)
		{
			config_entry_array_any inst(save_on_disk, config_category_name, config_entry_name);

			inst.m_default_value = new toml::array();
			inst.make_array_any((toml::array*)inst.m_default_value, default_values);

			const auto need_ptr = !save_on_disk;
			if (need_ptr)
			{
				LOG(INFO) << "allocating m_value (array)";

				inst.m_value = new toml::array();
				inst.make_array_any((toml::array*)inst.m_value, default_values);
			}
			else
			{
				// TODO CONFIG: delay this into a delegate for g_config initialization (at this point the config isnt ready)
			}

			return inst;
		}

		toml::array* value()
		{
			return m_value->as_array();
		}
	};
}
