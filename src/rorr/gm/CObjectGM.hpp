#pragma once
#include "CHashMap.hpp"
#include "CInstance.hpp"

#include <cstddef>
#include <string>

template<typename T>
struct CObjectHashNode
{
	CObjectHashNode* m_prev;
	CObjectHashNode* m_next;
	uint32_t m_key;
	uint32_t m_padding;
	T* m_object;
};

template<typename T>
struct CObjectHashBucket
{
	CObjectHashNode<T>* m_head;
	CObjectHashNode<T>* m_tail;
};

template<typename T>
struct CObjectHashMap
{
	CObjectHashBucket<T>* m_buckets;
	uint32_t m_mask;
	uint32_t m_count;

	T* find_object(uint32_t key) const
	{
		if (!m_buckets)
		{
			return nullptr;
		}
		uint32_t index              = key & m_mask;
		for (auto node = m_buckets[index].m_head; node; node = node->m_next)
		{
			if (node->m_key == key)
			{
				return node->m_object;
			}
		}
		return nullptr;
	}
};

template<typename T>
struct LinkedList
{
	T* m_First;
	T* m_Last;
	int32_t m_Count;
	int32_t m_DeleteType;
};

struct CPhysicsDataGM
{
	float* m_PhysicsVertices;
	bool m_IsPhysicsObject;
	bool m_IsPhysicsSensor;
	bool m_IsPhysicsAwake;
	bool m_IsPhysicsKinematic;
	int m_PhysicsShape;
	int m_PhysicsGroup;
	float m_PhysicsDensity;
	float m_PhysicsRestitution;
	float m_PhysicsLinearDamping;
	float m_PhysicsAngularDamping;
	float m_PhysicsFriction;
	int m_PhysicsVertexCount;
};

struct CObjectGM
{
	const char* m_Name;
	CObjectGM* m_ParentObject;
	CHashMap<int, CObjectGM*>* m_ChildrenMap;
	CHashMap<int64_t, struct CEvent*>* m_EventsMap;
	CPhysicsDataGM m_PhysicsData;
	LinkedList<CInstance> m_Instances;
	LinkedList<CInstance> m_InstancesRecursive;
	uint32_t m_Flags;
	int32_t m_SpriteIndex;
	int32_t m_Depth;
	int32_t m_Parent;
	int32_t m_Mask;
	int32_t m_object_index;
};
