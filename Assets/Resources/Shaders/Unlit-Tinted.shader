// Unlit alpha-blended tinted texture shader.
// - no lighting
// - no lightmap support

Shader "Unlit/Tinted" {
Properties {
	_Color ("Color Tint (A = Opacity)", Color) = (1,1,1,1)
	_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
}

SubShader {
	Tags { "RenderType"="Transparent" "Queue"="Transparent" "IgnoreProjector"="True" }
	
	Lighting Off
	ZWrite Off
	Blend SrcAlpha OneMinusSrcAlpha
	
	Pass {
		SetTexture [_MainTex] { ConstantColor[_Color] combine texture * constant } 
	}
}
} 
