// Unlit colored shader. Simplest possible color shader.
// - no lighting
// - no lightmap support
// - no texture

Shader "Unlit/Colored" {
Properties {
	_Color ("Color Tint (A = Opacity)", Color) = (1,1,1,1)
}

SubShader {
	Tags { "RenderType"="Transparent" "Queue"="Transparent" "IgnoreProjector"="True" }

	ZWrite Off
	Blend SrcAlpha OneMinusSrcAlpha 
	
	Pass {
		Lighting Off
		Color [_Color]
	}
}
}
