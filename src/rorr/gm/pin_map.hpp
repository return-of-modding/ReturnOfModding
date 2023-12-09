#pragma once
#include "Code_Function_GET_the_function.hpp"

struct YYObjectPinMap
{
	inline static std::unordered_map<YYObjectBase*, size_t> m_refcounts;

	// a ds map for pinnable objects.
	inline static RValue m_pin_map{};

	inline static void init_pin_map()
	{
		YYObjectPinMap::m_pin_map = gm::call("ds_map_create");
		gm::call("variable_global_set", std::to_array<RValue, 2>({"__returnofmodding_gc_pin_ds_map_index", YYObjectPinMap::m_pin_map}));
	}

	inline static void pin(YYObjectBase* obj)
	{
		if (!m_refcounts.contains(obj) || m_refcounts[obj] <= 0)
		{
			gm::call("ds_map_replace", std::to_array<RValue, 3>({YYObjectPinMap::m_pin_map, (void*)obj, obj}));

			//LOG(FATAL) << "pin(): first " << HEX_TO_UPPER(obj);

			// TODO: Can't figure a nice way to do it cleanly.
			m_refcounts[obj]++;
		}

		m_refcounts[obj]++;

		//LOG(FATAL) << "pin() refcount " << m_refcounts[obj];

		//LOG(FATAL) << "pin() map size: " << gm::call("ds_map_size", YYObjectPinMap::m_pin_map).value << " | " << m_refcounts.size();
	}

	inline static void unpin(YYObjectBase* obj)
	{
		if (m_refcounts.contains(obj))
		{
			auto& refcount = m_refcounts[obj];

			refcount--;

			//LOG(FATAL) << "unpin() refcount " << refcount;

			if (refcount <= 0)
			{
				gm::call("ds_map_delete", std::to_array<RValue, 2>({YYObjectPinMap::m_pin_map,(void*)obj}));

				//LOG(FATAL) << "unpin(): delete " << HEX_TO_UPPER(obj);

				m_refcounts.erase(obj);
			}
		}

		//LOG(FATAL) << "unpin() map size: " << gm::call("ds_map_size", YYObjectPinMap::m_pin_map).value << " | " << m_refcounts.size();
	}

	inline static void cleanup_pin_map()
	{
		if (YYObjectPinMap::m_pin_map.type != RValueType::UNSET)
		{
			gm::call("ds_map_destroy", YYObjectPinMap::m_pin_map);

			m_refcounts.clear();
		}
	}
};