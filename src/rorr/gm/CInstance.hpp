#pragma once

#include "YYObjectBase.hpp"

struct CInstance : YYObjectBase
{
	__int64 m_CreateCounter;
	void* m_pObject;
	void* m_pPhysicsObject;
	void* m_pSkeletonAnimation;
	void* m_pControllingSeqInst;
	unsigned int m_Instflags;
	int i_id;
	int i_objectindex;
	int i_spriteindex;
	float i_sequencePos;
	float i_lastSequencePos;
	float i_sequenceDir;
	float i_imageindex;
	float i_imagespeed;
	float i_imagescalex;
	float i_imagescaley;
	float i_imageangle;
	float i_imagealpha;
	unsigned int i_imageblend;
	float i_x;
	float i_y;
	float i_xstart;
	float i_ystart;
	float i_xprevious;
	float i_yprevious;
	float i_direction;
	float i_speed;
	float i_friction;
	float i_gravitydir;
	float i_gravity;
	float i_hspeed;
	float i_vspeed;
	int i_bbox[4];
	int i_timer[12];
	void* m_pPathAndTimeline;
	CCode* i_initcode;
	CCode* i_precreatecode;
	void* m_pOldObject;
	int m_nLayerID;
	int i_maskindex;
	__int16 m_nMouseOver;
	CInstance* m_pNext;
	CInstance* m_pPrev;
	void* m_collisionLink[3]; // SLink
	void* m_dirtyLink[3];     // SLink
	void* m_withLink[3];      // SLink
	float i_depth;
	float i_currentdepth;
	float i_lastImageNumber;
	unsigned int m_collisionTestNumber;

	void imgui_dump();

	void imgui_dump_instance_variables();

	const char* object_name() const;

	RValue get(const char* variable_name);

	void set(const char* variable_name, RValue& new_value);
};