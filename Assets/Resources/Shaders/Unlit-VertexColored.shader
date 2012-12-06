// Unlit alpha-blended tinted texture shader.
// - no lighting
// - no lightmap support

Shader "Unlit/VertexColored" {
Properties {
	_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
}

SubShader {
	Tags { "RenderType"="Transparent" "Queue"="Transparent" "IgnoreProjector"="True" }
	
	Lighting Off
	ZWrite Off
	Blend SrcAlpha OneMinusSrcAlpha
	
	BindChannels {
		Bind "Color", color
		Bind "Vertex", vertex
		Bind "TexCoord", texcoord
	}
	
	Pass {
		SetTexture [_MainTex] {
			Combine texture * primary
		}
	}
}
} 
