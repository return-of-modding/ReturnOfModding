#include "YYShader.hpp"

#include "../../pointers.hpp"

YYShaderVarType YYShaderDataHeader::D3DtoGMLvarType(_D3D_SHADER_VARIABLE_TYPE t)
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

YYShaderDataHeader::YYShaderDataHeader(const Microsoft::WRL::ComPtr<ID3DBlob> &blob, const Microsoft::WRL::ComPtr<ID3D11ShaderReflection> &reflection)
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

		new (&semantic_data[i]) InputData(rid.SemanticName, {rid.SemanticIndex});
	}

	cbuf_count = rsd.ConstantBuffers;
	cbuf_data  = new ConstBufData[cbuf_count];
	std::vector<ConstBufVarData> cvars{};

	for (auto i = 0u; i < cbuf_count; i++)
	{
		D3D11_SHADER_BUFFER_DESC rbd;
		auto rb = reflection->GetConstantBufferByIndex(i);
		rb->GetDesc(&rbd);
		new (&cbuf_data[i]) ConstBufData(rbd.Name, {i, 0, 0, rbd.Size});

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
			for (const auto &v : cvars)
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
			cvars.emplace_back(ConstBufVarData(vname, {i, rvd.StartOffset, rvd.Size, (UINT)D3DtoGMLvarType(rtd.Type), rtd.Columns, rtd.Rows, rtd.Elements}));
		}
	}

	cbufvar_count = cvars.size();
	cbufvar_data  = new ConstBufVarData[cbufvar_count];
	for (int i = 0; i < cbufvar_count; i++)
	{
		cbufvar_data[i] = cvars[i];
	}

	std::vector<SamplerData> samplers{};
	for (auto i = 0u; i < rsd.BoundResources; i++)
	{
		D3D11_SHADER_INPUT_BIND_DESC bdesc;
		auto ru = reflection->GetResourceBindingDesc(i, &bdesc);
		if (bdesc.Name[0] == '$')
		{
			continue; // $Globals..?
		}
		samplers.emplace_back(SamplerData(bdesc.Name, {bdesc.BindPoint, 0}));
	}

	sampler_count = samplers.size();
	sampler_data  = new SamplerData[sampler_count];
	for (int i = 0; i < sampler_count; i++)
	{
		sampler_data[i] = samplers[i];
	}

	shader_size = blob->GetBufferSize();
	shader_data = new char[shader_size];
	memcpy(shader_data, blob->GetBufferPointer(), shader_size);
}

YYShaderDataHeader::~YYShaderDataHeader()
{
	delete[] cbuf_data;
	delete[] cbufvar_data;
	delete[] sampler_data;
	delete[] texture_data;
	delete[] semantic_data;
	delete[] shader_data;
}

std::vector<char> YYShaderDataHeader::convertToRaw()
{
	std::vector<char> raw_data(sizeof(UINT) * 13);

	auto data_append = [&](const void *data, size_t size)
	{
		if (size > 0 && data != nullptr)
		{
			raw_data.insert(raw_data.end(), (const char *)data, (const char *)data + size);
		}
	};

#define APPEND_DATA(_data, _count, _offset)                                 \
	do                                                                      \
	{                                                                       \
		UINT name_offset = _offset;                                         \
		std::vector<std::string> name_cache;                                \
		for (UINT i = 0; i < _count; i++)                                   \
		{                                                                   \
			auto [data, name] = _data[i].convertToRaw(name_offset);         \
			if (name_offset == _offset)                                     \
			{                                                               \
				name_offset += _count * data.size();                        \
				memcpy(data.data(), &name_offset, sizeof(UINT));            \
			}                                                               \
			data_append(data.data(), data.size());                          \
			if (name.size() > 0)                                            \
			{                                                               \
							name_offset += (name.size() + 1);                           \
				name_cache.emplace_back(std::move(name));                   \
			}                                                               \
		}                                                                   \
		for (const auto &name : name_cache)                                 \
		{                                                                   \
			data_append(name.c_str(), name.size() + 1);                     \
		}                                                                   \
		_offset = name_offset;                                              \
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

	return std::move(raw_data);
};

YYShader::YYShader(std::string n, int id, const std::vector<char> &vertexShaderRaw, const std::vector<char> &pixelShaderRaw) :
    id(id)
{
	if (auto s = _YYCustomShaderPool.find(id); s != _YYCustomShaderPool.end())
	{
		delete s->second;
	}
	_YYCustomShaderPool[id] = this;

	name = new char[n.length() + 1];
	strcpy(name, n.c_str());

	HLSL11.vertexShader = new char[vertexShaderRaw.size()];
	memcpy(HLSL11.vertexShader, vertexShaderRaw.data(), vertexShaderRaw.size());

	HLSL11.pixelShader = new char[pixelShaderRaw.size()];
	memcpy(HLSL11.pixelShader, pixelShaderRaw.data(), pixelShaderRaw.size());
}

YYShader::~YYShader()
{
	if (attributeNames != nullptr)
	{
		big::g_pointers->m_rorr.m_memorymanager_free(attributeNames);
	}
	if (_YYCustomShaderPool.count(id) == 1)
	{
		if (name != nullptr)
		{
			delete[] name;
		}
		if (HLSL11.vertexShader != nullptr)
		{
			delete[] HLSL11.vertexShader;
		}
		if (HLSL11.pixelShader != nullptr)
		{
			delete[] HLSL11.pixelShader;
		}
	}
	else
	{
		big::g_pointers->m_rorr.m_memorymanager_free(this);
	}
}

YYNativeShader::YYNativeShader(char *vertexShaderRaw, char *pixelShaderRaw, int &result)
{
	vertexHeader = big::g_pointers->m_rorr.m_gen_shader_data_header(vertexShaderRaw);
	pixelHeader  = big::g_pointers->m_rorr.m_gen_shader_data_header(pixelShaderRaw);
	big::g_pointers->m_rorr.m_native_shader_gen_cbuf(this);
	result = big::g_pointers->m_rorr.m_native_shader_create(this);
}

YYNativeShader::~YYNativeShader()
{
#define FreeStruct(_data, _count)                                                     \
	if (_data)                                                                        \
	{                                                                                 \
		for (int i = 0; i < _count; i++)                                              \
		{                                                                             \
			big::g_pointers->m_rorr.m_memorymanager_free(&_data[i]);                  \
		}                                                                             \
		big::g_pointers->m_rorr.m_memorymanager_free((void *)((uintptr_t)_data - 8)); \
		_data = nullptr;                                                              \
	}
	FreeStruct(samplers, samplerCount);
	FreeStruct(constBufVars, constBufVarCount);
	FreeStruct(constBuffers, constBufferCount);
#undef FreeStruct

#define m_free_if_exists(_thing) \
	if (_thing)                  \
	{                            \
		_thing->Release();       \
		_thing = nullptr;        \
	}
	if (constBuffers)
	{
		for (int i = 0; i < constBufferCount; i++)
		{
			m_free_if_exists(constBuffers[i].buffer);
		}
	}
	if (inputs)
	{
		big::g_pointers->m_rorr.m_memorymanager_free(inputs);
		inputs = nullptr;
	}
	if (inputLayouts)
	{
		for (int i = 0; i < inputLayoutCount; i++)
		{
			YYShaderInputLayout *inputLayout = inputLayouts[i];
			if (inputLayout)
			{
				m_free_if_exists(inputLayout->layout);
			}
			big::g_pointers->m_rorr.m_memorymanager_free(inputLayout);
		}
		big::g_pointers->m_rorr.m_memorymanager_free(inputLayouts);
		inputLayouts = nullptr;
	}
	inputLayoutCount    = 0;
	lastUsedInputLayout = -1;

	m_free_if_exists(vertexShader);
	m_free_if_exists(pixelShader);
#undef m_free_if_exists
	big::g_pointers->m_rorr.m_free_shader_data_header(vertexHeader);
	big::g_pointers->m_rorr.m_free_shader_data_header(pixelHeader);
}
