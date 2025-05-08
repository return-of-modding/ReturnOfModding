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

template<UINT N>
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
		version       = 1; // unknown
		texture_count = 0;
		texture_data  = nullptr;

		D3D11_SHADER_DESC rsd;
		reflection->GetDesc(&rsd);

		input_count   = rsd.InputParameters;
		semantic_data = new InputData[input_count];
		for (auto i = 0u; i < input_count; i++)
		{
			D3D11_SIGNATURE_PARAMETER_DESC rid;
			reflection->GetInputParameterDesc(i, &rid);

			new (&semantic_data[i]) InputData(copy_string(rid.SemanticName), {rid.SemanticIndex});
		}

		cbuf_count = rsd.ConstantBuffers;
		cbuf_data  = new ConstBufData[cbuf_count];
		std::vector<ConstBufVarData> cvars{};

		for (auto i = 0u; i < cbuf_count; i++)
		{
			D3D11_SHADER_BUFFER_DESC rbd;
			auto rb = reflection->GetConstantBufferByIndex(i);
			rb->GetDesc(&rbd);
			new (&cbuf_data[i]) ConstBufData(copy_string(rbd.Name), {i, 0, 0, rbd.Size});

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
				cvars.emplace_back(ConstBufVarData(copy_string(vname), {i, rvd.StartOffset, rvd.Size, (UINT)D3DtoGMLvarType(rtd.Type), rtd.Columns, rtd.Rows, rtd.Elements}));
			}
		}

		cbufvar_count = cvars.size();
		cbufvar_data  = new ConstBufVarData[cbufvar_count];
		memcpy(cbufvar_data, cvars.data(), sizeof(ConstBufVarData) * cbufvar_count);

		std::vector<SamplerData> samplers{};
		for (auto i = 0u; i < rsd.BoundResources; i++)
		{
			D3D11_SHADER_INPUT_BIND_DESC bdesc;
			auto ru = reflection->GetResourceBindingDesc(i, &bdesc);
			if (bdesc.Name[0] == '$')
			{
				continue; // $Globals..?
			}
			samplers.emplace_back(SamplerData(copy_string(bdesc.Name), {bdesc.BindPoint, 0}));
		}

		sampler_count = samplers.size();
		sampler_data  = new SamplerData[sampler_count];
		memcpy(sampler_data, samplers.data(), sizeof(SamplerData) * sampler_count);

		shader_size = blob->GetBufferSize();
		shader_data = new char[shader_size];
		memcpy(shader_data, blob->GetBufferPointer(), shader_size);
	}

	~YYShaderDataHeader()
	{
#define FREE_FAKE_DATA(_count, _data)      \
	do                                     \
	{                                      \
		for (auto i = 0u; i < _count; i++) \
		{                                  \
			if (_data[i].name != nullptr)  \
			{                              \
				delete[] _data[i].name;    \
			}                              \
		};                                 \
		delete[] _data;                    \
	} while (0)

		FREE_FAKE_DATA(cbuf_count, cbuf_data);
		FREE_FAKE_DATA(cbufvar_count, cbufvar_data);
		FREE_FAKE_DATA(sampler_count, sampler_data);
		FREE_FAKE_DATA(texture_count, texture_data);
		FREE_FAKE_DATA(input_count, semantic_data);
#undef FREE_FAKE_DATA
		delete[] shader_data;
	}

	YYShaderDataHeader(const YYShaderDataHeader &) = delete;

	YYShaderDataHeader &operator=(const YYShaderDataHeader &) = delete;

	std::vector<char> convertToRaw()
	{
		std::vector<char> raw_data(sizeof(UINT) * 13);

		auto data_append = [&](const void *data, size_t size)
		{
			if (size > 0 && data != nullptr)
			{
				raw_data.insert(raw_data.end(), (const char *)data, (const char *)data + size);
			}
		};

#define APPEND_DATA(_data, _count, _offset)                         \
	do                                                              \
	{                                                               \
		UINT name_offset = _offset;                                 \
		std::vector<std::string> name_cache;                        \
		for (UINT i = 0; i < _count; i++)                           \
		{                                                           \
			auto [data, name] = _data[i].convertToRaw(name_offset); \
			if (name_offset == _offset)                             \
			{                                                       \
				name_offset += _count * data.size();                \
				memcpy(data.data(), &name_offset, sizeof(UINT));    \
			}                                                       \
			data_append(data.data(), data.size());                  \
			if (name.size() > 0)                                    \
			{                                                       \
				name_offset += (name.size() + 1);                   \
				name_cache.emplace_back(std::move(name));           \
			}                                                       \
		}                                                           \
		for (const auto &name : name_cache)                         \
		{                                                           \
			data_append(name.c_str(), name.size() + 1);             \
		}                                                           \
		_offset = name_offset;                                      \
	} while (false)
		UINT cbuf_offset    = sizeof(UINT) * 13;
		UINT cbufvar_offset = cbuf_offset;
		APPEND_DATA(cbuf_data, cbuf_count, cbufvar_offset);
		UINT sampler_offset = cbufvar_offset;
		APPEND_DATA(cbufvar_data, cbufvar_count, sampler_offset);
		UINT texture_offset = sampler_offset;
		APPEND_DATA(sampler_data, sampler_count, texture_offset);
		UINT semantic_offset = texture_offset;
		APPEND_DATA(texture_data, texture_count, semantic_offset);
		UINT shader_offset = semantic_offset;
		APPEND_DATA(semantic_data, input_count, shader_offset);
		data_append(shader_data, shader_size);

#undef APPEND_DATA
		char *current_ptr = raw_data.data();
#define COPY_TO_BUFFER(_target)                      \
	do                                               \
	{                                                \
		memcpy(current_ptr, &_target, sizeof(UINT)); \
		current_ptr += sizeof(UINT);                 \
	} while (0)
		COPY_TO_BUFFER(version);
		COPY_TO_BUFFER(cbuf_count);
		COPY_TO_BUFFER(cbufvar_count);
		COPY_TO_BUFFER(sampler_count);
		COPY_TO_BUFFER(texture_count);
		COPY_TO_BUFFER(input_count);
		COPY_TO_BUFFER(shader_size);
		COPY_TO_BUFFER(cbuf_offset);
		COPY_TO_BUFFER(cbufvar_offset);
		COPY_TO_BUFFER(sampler_offset);
		COPY_TO_BUFFER(texture_offset);
		COPY_TO_BUFFER(semantic_offset);
		COPY_TO_BUFFER(shader_offset);
#undef COPY_TO_BUFFER

		return raw_data;
	};
};

namespace gm

{
	using ShaderCreate_t = bool (*)(YYShader *shader);
}
