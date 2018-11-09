Shader "Custom/Rust" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_RustTex("Rust (RGB)", 2D) = "white" {}
		_MaskTex("Mask (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		_RustForce("Rust", Range(0,1)) = 0.0
		_Normal("Normal (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 4.0

		sampler2D _MainTex;
		sampler2D _RustTex;
		sampler2D _MaskTex;
		sampler2D _Normal;
		struct Input {
			float2 uv_MainTex;
			float2 uv_MaskTex;
			float2 uv_Normal;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;
		half _RustForce;
		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			fixed4 r = tex2D(_RustTex, IN.uv_MainTex);
			fixed4 m = tex2D(_MaskTex, IN.uv_MaskTex);
			fixed3 n = UnpackNormal(tex2D(_Normal, IN.uv_Normal));
			/*
			if (m.x < _RustForce) {
				o.Albedo = c.rgb;
				o.Smoothness = _Glossiness;
			}
			else {
				o.Albedo = r.rgb;
				o.Normal = n;
			}
			*/

			o.Smoothness = _Glossiness * m * _RustForce;
			o.Albedo = (c.rgb*((1-m*_RustForce))+ r.rgb*m*_RustForce)/2;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
