#pragma once
// based on https://github.com/YAL-GameMaker/shader_replace_unsafe/blob/main/shader_replace_unsafe/gml_internals.h
#include <d3d11.h>
#include <d3dcompiler.h>
#include <initializer_list>
#include <wrl/client.h>

typedef unsigned int UINT;

struct YYShaderPair
{
	char *vertexShader = nullptr;
	char *pixelShader  = nullptr;
	YYShaderPair()     = default;
};

enum class YYShaderKind : int
{
	Vertex = 0,
	Pixel,
};

struct YYShaderConstBuf
{
	int reg;
	int size; // rounded up?
	YYShaderKind type = YYShaderKind::Vertex;
	uint8_t *data;
	ID3D11Buffer *buffer;
	bool dirty;
	YYShaderConstBuf() = delete;
	~YYShaderConstBuf();
};

struct YYShaderSampler
{
	char *name;
	int reg;
	YYShaderKind type = YYShaderKind::Pixel;
	YYShaderSampler() = delete;
	~YYShaderSampler();
};

enum class YYShaderVarType : UINT
{
	Void = 0,
	Bool,
	Int,
	Uint,
	Byte,
	Float,
	Double,
};

struct YYShaderConstBufVar
{
	char *name;
	uint8_t *data; // = buffer->data + this->offset
	int bufferIndex;
	int offset;
	int size;
	YYShaderVarType type;
	int cols;
	int rows;
	int elementCount;
	YYShaderConstBufVar() = delete;
	~YYShaderConstBufVar();
};

enum class YYShaderInputSemantic : UINT
{
	None = 0,
	Position,
	Color,
	Normal,
	TexCoord,
	BlendWeight,
	BlendIndex,
	PSize,
	Tangent,
	Binormal,
	Unknown1,
	Unknown2,
	Fog,
	Depth,
	Sample,
};

struct YYShaderInputParam
{
	YYShaderInputSemantic semantic;
	int semanticIndex;
};

struct YYShaderInputLayout
{
	int format;
	ID3D11InputLayout *layout;
	YYShaderInputLayout() = delete;
	~YYShaderInputLayout();
};

struct YYShader;

static ankerl::unordered_dense::map<int, YYShader *> _YYCustomShaderPool;

enum class YYShaderLanguage : int
{
	NONE = 0,
	GLSL_ES,
	GLSL,
	HLSL_9,
	HLSL_11,
};

struct YYShader
{
	int id     = -1;
	char *name = nullptr;

	YYShaderLanguage type = YYShaderLanguage::HLSL_11;
	YYShaderPair GLSLES, GLSL, HLSL9, HLSL11;
	YYShaderPair mysteryPairs[3] = {};
	int mysteryPadding[4]        = {};

	char *error_str       = nullptr;
	bool is_pixel_error   = false;
	int attributeCount    = 0;
	char **attributeNames = nullptr;

	int native_shader_handle = -1;
	int a11                  = 0;
	int gm_BaseTexture       = 0;
	int gm_Matrices          = 0;
	int gm_Lights_Direction  = 0;
	int gm_Lights_PosRange   = 0;
	int gm_Lights_Colour     = 0;
	int gm_AmbientColour     = 0;
	int gm_LightingEnabled   = 0;

	YYShader() = default;
	YYShader(std::string name, int id, const std::vector<char> &vertexShaderRaw, const std::vector<char> &pixelShaderRaw);
	~YYShader();

	void *operator new(size_t size);
	void *operator new[](size_t size) = delete;

	void operator delete(void *ptr, size_t size);
	void operator delete[](void *ptr, size_t size) = delete;
};

template<UINT N>
struct YYShaderFakeData
{
	char *name = nullptr;
	UINT a1[N] = {};

	YYShaderFakeData() = default;

	YYShaderFakeData(const char *n, std::initializer_list<UINT> args) :
	    a1{}
	{
		size_t len = strlen(n);
		name       = new char[len + 1];
		strcpy(name, n);

		len     = std::min(args.size(), (size_t)N);
		auto it = args.begin();
		for (size_t i = 0; i < len; i++)
		{
			a1[i] = *it;
			++it;
		}
	}

	~YYShaderFakeData()
	{
		if (name != nullptr)
		{
			delete[] name;
			name = nullptr;
		}
	}

	YYShaderFakeData &operator=(const YYShaderFakeData &other)
	{
		memcpy(&a1, &other.a1, N * sizeof(UINT));
		if (this != &other)
		{
			if (name != nullptr)
			{
				delete[] name;
				name = nullptr;
			}
			if (other.name != nullptr)
			{
				name = new char[strlen(other.name) + 1];
				strcpy(name, other.name);
			}
		}
		return *this;
	}

	YYShaderFakeData(const YYShaderFakeData &other)
	{
		memcpy(&a1, &other.a1, N * sizeof(UINT));
		if (other.name != nullptr)
		{
			name = new char[strlen(other.name) + 1];
			strcpy(name, other.name);
		}
	}

	std::pair<std::vector<char>, std::string> convertToRaw(UINT n_offset)
	{
		std::string n(name);

		size_t offset_size = sizeof(UINT);
		size_t a1_size     = sizeof(UINT) * N;
		n_offset           = (n.size() == 0) ? 0 : n_offset;

		std::vector<char> raw_data(offset_size + a1_size);
		memcpy(raw_data.data(), &n_offset, offset_size);
		memcpy(raw_data.data() + offset_size, &a1, a1_size);
		return std::make_pair(std::move(raw_data), std::move(n));
	}
};

struct YYShaderDataHeader
{
	UINT version;
	UINT cbuf_count;
	UINT cbufvar_count;
	UINT sampler_count;
	UINT texture_count; // it seems useless.
	UINT input_count;
	UINT shader_size;

	using ConstBufData = YYShaderFakeData<4>;
	ConstBufData *cbuf_data;

	using ConstBufVarData = YYShaderFakeData<7>;
	ConstBufVarData *cbufvar_data;

	using SamplerData = YYShaderFakeData<2>;
	SamplerData *sampler_data;

	using TexturerData = YYShaderFakeData<2>;
	TexturerData *texture_data; // it seems useless.

	using InputData = YYShaderFakeData<4>;
	InputData *semantic_data;

	char *shader_data;

	YYShaderVarType D3DtoGMLvarType(_D3D_SHADER_VARIABLE_TYPE t);
	std::vector<char> convertToRaw();

	YYShaderDataHeader(const Microsoft::WRL::ComPtr<ID3DBlob> &blob, const Microsoft::WRL::ComPtr<ID3D11ShaderReflection> &reflection);

	~YYShaderDataHeader();

	YYShaderDataHeader(const YYShaderDataHeader &)            = delete;
	YYShaderDataHeader &operator=(const YYShaderDataHeader &) = delete;

	void *operator new(size_t size)   = delete;
	void *operator new[](size_t size) = delete;

	void operator delete(void *ptr)   = delete;
	void operator delete[](void *ptr) = delete;
};

struct YYNativeShader
{
	ID3D11VertexShader *vertexShader = nullptr;
	ID3D11PixelShader *pixelShader   = nullptr;

	YYShaderDataHeader *vertexHeader = nullptr;
	YYShaderDataHeader *pixelHeader  = nullptr;

	uint8_t mysteryZero = 0;

	int constBufferCount           = 0;
	YYShaderConstBuf *constBuffers = nullptr;

	int samplerCount          = 0;
	YYShaderSampler *samplers = nullptr;

	int constBufVarCount              = 0;
	YYShaderConstBufVar *constBufVars = nullptr;

	int inputCount             = 0;
	YYShaderInputParam *inputs = nullptr;

	int inputLayoutCount               = 0;
	YYShaderInputLayout **inputLayouts = nullptr;
	int lastUsedInputLayout            = -1;

	YYNativeShader(char *vertexShaderRaw, char *pixelShaderRaw, int &result);

	~YYNativeShader();

	YYNativeShader(const YYNativeShader &other)            = delete;
	YYNativeShader &operator=(const YYNativeShader &other) = delete;

	void *operator new(size_t size);
	void operator delete(void *ptr, size_t size);
};

namespace gm
{
	using ShaderCreate_t         = bool (*)(YYShader *shader);
	using GenShaderDataHeader_t  = YYShaderDataHeader *(*)(char *raw_data);
	using NativeShaderGenCBuf_t  = YYShaderDataHeader *(*)(YYNativeShader *native);
	using NativeShaderCreate_t   = int (*)(YYNativeShader *native);
	using FreeShaderDataHeader_t = void (*)(YYShaderDataHeader **header);
} // namespace gm
