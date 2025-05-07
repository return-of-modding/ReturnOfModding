// based on https://github.com/YAL-GameMaker/shader_replace_unsafe/blob/main/shader_replace_unsafe/gml_internals.h
#include <d3d11.h>
#include <d3dcompiler.h>
#include <initializer_list>
#include <wrl/client.h>

typedef unsigned int UINT;

struct YYShaderPair
{
	char *vertexShader   = nullptr;
	char *fragmentShader = nullptr;
	YYShaderPair()       = default;
};
enum class YYShaderKind : int
{
	NONE = 0,
	GLSL_ES,
	GLSL,
	HLSL_9,
	HLSL_11,
};

struct YYShader
{
	int id           = -1;
	const char *name = nullptr;

	YYShaderKind type = YYShaderKind::HLSL_11;
	YYShaderPair GLSLES, GLSL, HLSL9, HLSL11;
	YYShaderPair mysteryPairs[3] = {};
	int mysteryPadding[4]        = {};

	const char *error_str = nullptr;
	bool is_pixel_error   = false;

	int attributeCount          = 0;
	const char **attributeNames = nullptr;

	int native_shader_handle = -1;

	int gm_BaseTexture      = 0;
	int gm_Matrices         = 0;
	int gm_Lights_Direction = 0;
	int gm_Lights_PosRange  = 0;
	int gm_Lights_Colour    = 0;
	int gm_AmbientColour    = 0;
	int gm_LightingEnabled  = 0;

	YYShader() = default;
};

template<unsigned int N>
struct YYShaderFakeData
{
	const char *name = nullptr;
	UINT a1[N]       = {};

	YYShaderFakeData() = default;

	YYShaderFakeData(const char *n, std::initializer_list<UINT> args) :
	    name(n),
	    a1{}
	{
		size_t len = std::min(args.size(), (size_t)N);
		auto it    = args.begin();
		for (size_t i = 0; i < len; i++)
		{
			a1[i] = *it;
			++it;
		}
	}
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

	using ConstBufVarData = YYShaderFakeData<8>;
	ConstBufVarData *cbufvar_data;

	using SamplerData = YYShaderFakeData<2>;
	SamplerData *sampler_data;

	using TexturerData = YYShaderFakeData<2>;
	TexturerData *texture_data; // it seems useless.

	using InputData = YYShaderFakeData<4>;
	InputData *semantic_data;

	char *shader_data;

	char *copy_string(const char *origin)
	{
		size_t len = strlen(origin);
		char *copy = new char[len + 1];
		strcpy(copy, origin);
		return copy;
	}

	YYShaderVarType D3DtoGMLvarType(_D3D_SHADER_VARIABLE_TYPE t)
	{
		switch (t)
		{
		case D3D_SVT_VOID:
		case D3D_SVT_BOOL:
		case D3D_SVT_INT:  return (YYShaderVarType)t;

		case D3D_SVT_FLOAT: return YYShaderVarType::Float;

		case D3D_SVT_UINT: return YYShaderVarType::Uint;

		case D3D_SVT_DOUBLE:
			return YYShaderVarType::Double;

			// Is it min8int? if so, then it's won't be avaliable in GM
		case D3D_SVT_UINT8: return YYShaderVarType::Byte;

		default: return YYShaderVarType::Void;
		}
	}

	YYShaderDataHeader(const Microsoft::WRL::ComPtr<ID3DBlob> &blob, const Microsoft::WRL::ComPtr<ID3D11ShaderReflection> &reflection)
	{
		version = 1; // unknown

		D3D11_SHADER_DESC rsd;
		reflection->GetDesc(&rsd);

		input_count   = rsd.InputParameters;
		semantic_data = new YYShaderFakeData<4>[input_count];
		for (auto i = 0u; i < input_count; i++)
		{
			D3D11_SIGNATURE_PARAMETER_DESC rid;
			reflection->GetInputParameterDesc(i, &rid);

			new (&semantic_data[i]) YYShaderFakeData<4>(copy_string(rid.SemanticName), {rid.SemanticIndex});
		}

		cbuf_count = rsd.ConstantBuffers;
		cbuf_data  = new YYShaderFakeData<4>[cbuf_count];
		for (auto i = 0u; i < cbuf_count; i++)
		{
			D3D11_SHADER_BUFFER_DESC rbd;
			auto rb = reflection->GetConstantBufferByIndex(i);
			rb->GetDesc(&rbd);
			new (&cbuf_data[i]) YYShaderFakeData<4>(copy_string(rbd.Name), {i, 0, 0, rbd.Size});

			std::vector<YYShaderFakeData<8>> cvars{};
			for (auto j = 0u; j < rbd.Variables; j++)
			{
				D3D11_SHADER_VARIABLE_DESC rvd;
				auto rv = rb->GetVariableByIndex(j);
				rv->GetDesc(&rvd);

				D3D11_SHADER_TYPE_DESC rtd;
				auto rt = rv->GetType();
				rt->GetDesc(&rtd);

				auto vname   = rvd.Name;
				auto vexists = false;
				for (auto &v : cvars)
				{
					if (strcmp(v.name, vname) == 0)
					{
						vexists = true;
						break;
					}
				}
				if (vexists)
				{
					continue;
				}
				cvars.push_back(YYShaderFakeData<8>(copy_string(vname), {i, rvd.StartOffset, rvd.Size, (UINT)D3DtoGMLvarType(rtd.Type), rtd.Columns, rtd.Rows, rtd.Elements}));
			}
			cbufvar_count = cvars.size();
			cbufvar_data  = new YYShaderFakeData<8>[cbufvar_count];
			memcpy(cbufvar_data, cvars.data(), sizeof(YYShaderFakeData<8>) * cbufvar_count);
		}

		sampler_count = rsd.BoundResources;
		sampler_data  = new YYShaderFakeData<2>[sampler_count];
		for (auto i = 0u; i < rsd.BoundResources; i++)
		{
			D3D11_SHADER_INPUT_BIND_DESC bdesc;
			auto ru = reflection->GetResourceBindingDesc(i, &bdesc);
			if (bdesc.Name[0] == '$')
			{
				continue; // $Globals..?
			}

			new (&sampler_data[i]) YYShaderFakeData<2>(copy_string(bdesc.Name), {bdesc.BindPoint, 0});
		}

		shader_size = blob->GetBufferSize();

		shader_data = new char[shader_size];
		memcpy(shader_data, blob->GetBufferPointer(), shader_size);
	}

	~YYShaderDataHeader()
	{
#define FREE_FAKE_DATA(_count, _data)  \
	for (auto i = 0u; i < _count; i++) \
	{                                  \
		delete[] _data[i].name;        \
	};
		FREE_FAKE_DATA(cbuf_count, cbuf_data);
		FREE_FAKE_DATA(cbufvar_count, cbufvar_data);
		FREE_FAKE_DATA(sampler_count, sampler_data);
		FREE_FAKE_DATA(texture_count, texture_data);
		FREE_FAKE_DATA(input_count, semantic_data);
#undef FREE_FAKE_DATA
		delete[] shader_data;
	}

	YYShaderDataHeader(const YYShaderDataHeader &)            = delete;
	YYShaderDataHeader &operator=(const YYShaderDataHeader &) = delete;

	char *convertToRaw()
	{
		size_t size = sizeof(int) * 13 + cbuf_count * sizeof(ConstBufData) + cbufvar_count * sizeof(ConstBufVarData) + sampler_count * sizeof(SamplerData) + texture_count * sizeof(TexturerData) + input_count * sizeof(InputData) + shader_size;
		char *raw_data    = new char[size];
		char *current_ptr = raw_data;

#define COPY_TO_BUFFER(_target_ptr, _type)           \
	memcpy(current_ptr, _target_ptr, sizeof(_type)); \
	current_ptr += sizeof(_type);
		COPY_TO_BUFFER(&version, int);
		COPY_TO_BUFFER(&cbuf_count, int);
		COPY_TO_BUFFER(&cbufvar_count, int);
		COPY_TO_BUFFER(&sampler_count, int);
		COPY_TO_BUFFER(&texture_count, int);
		COPY_TO_BUFFER(&input_count, int);
		COPY_TO_BUFFER(&shader_size, int);
		int cbuf_offset     = sizeof(int) * 13;
		int cbufvar_offset  = cbuf_offset + cbuf_count * sizeof(ConstBufData);
		int sampler_offset  = cbufvar_offset + cbufvar_count * sizeof(ConstBufVarData);
		int texture_offset  = sampler_offset + sampler_count * sizeof(SamplerData);
		int semantic_offset = texture_offset + texture_count * sizeof(TexturerData);
		int shader_offset   = semantic_offset + input_count * sizeof(InputData);
		COPY_TO_BUFFER(&cbuf_offset, int);
		COPY_TO_BUFFER(&cbufvar_offset, int);
		COPY_TO_BUFFER(&sampler_offset, int);
		COPY_TO_BUFFER(&texture_offset, int);
		COPY_TO_BUFFER(&semantic_offset, int);
		COPY_TO_BUFFER(&shader_offset, int);
		COPY_TO_BUFFER(cbuf_data, cbuf_count * sizeof(ConstBufData));
		COPY_TO_BUFFER(cbufvar_data, cbufvar_count * sizeof(ConstBufVarData));
		COPY_TO_BUFFER(sampler_data, sampler_count * sizeof(SamplerData));
		COPY_TO_BUFFER(texture_data, texture_count * sizeof(TexturerData));
		COPY_TO_BUFFER(semantic_data, input_count * sizeof(semantic_data));
		COPY_TO_BUFFER(shader_data, shader_size);
#undef COPY_TO_BUFFER
		return raw_data;
	};
};

namespace gm
{
	using ShaderCreate_t = bool (*)(YYShader *shader);
}
