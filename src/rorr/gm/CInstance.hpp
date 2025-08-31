#pragma once

#include "YYObjectBase.hpp"

// To update this check the YYC internal function that assign the getters and setters of the builtin variables
// In the binary just look for the strings like hspeed, vspeed etc
struct CInstance : YYObjectBase
{
	__int64 m_CreateCounter;
	void* m_pObject;
	void* m_pPhysicsObject;
	void* m_pSkeletonAnimation;
	void* m_pControllingSeqInst;
	uint64_t m_unk_1;
	unsigned int m_Instflags;
	int id;
	int object_index;
	int sprite_index;
	float i_sequencePos;
	float i_lastSequencePos;
	float i_sequenceDir;
	float image_index;
	unsigned int m_unk_2;
	float image_speed;
	float image_xscale;
	float image_yscale;
	float image_angle;
	float image_alpha;
	unsigned int image_blend;
	float x;
	float y;
	float xstart;
	float ystart;
	float xprevious;
	float yprevious;
	float direction;
	float speed;
	float friction;
	float gravity_direction;
	float gravity;
	float hspeed;
	float vspeed;
	int bbox[4];
	int timer[12];
	void* m_pPathAndTimeline;
	CCode* i_initcode;
	CCode* i_precreatecode;
	void* m_pOldObject;
	void* m_unk_3;
	int layer;
	int mask_index;
	__int16 m_nMouseOver;
	CInstance* m_pNext;
	CInstance* m_pPrev;
	void* m_collisionLink[3]; // SLink
	void* m_dirtyLink[3];     // SLink
	void* m_withLink[3];      // SLink
	float depth;
	float i_currentdepth;
	float i_lastImageNumber;
	unsigned int m_collisionTestNumber;

	void imgui_dump();

	void imgui_dump_instance_variables();

	const std::string& object_name() const;

	RValue get(const char* variable_name);
	bool get_bool(const char* variable_name);
	double get_double(const char* variable_name);
	std::string get_string(const char* variable_name);

	void set(const char* variable_name, RValue& new_value);
	void set_bool(const char* variable_name, bool new_value);
	void set_double(const char* variable_name, double new_value);
	void set_string(const char* variable_name, const char* new_value);
};
