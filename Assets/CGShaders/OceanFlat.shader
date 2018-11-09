Shader "Custom/OceanFlat" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_FoamTex ("Foam (RGB)", 2D) = "white" {}
		_NormalTex ("Normal (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.
		_Rot ("rotatetex", Range(0,1)) = 0.

	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows vertex:vert alpha

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _NormalTex;
		sampler2D _FoamTex;
	
		struct Input {
			float2 uv_MainTex;
			float2 uv_NormalTex;
			float2 uv_FoamTex;
			float3 worldPos;

		};
		void vert(inout appdata_full v){

			v.vertex.xyz+=v.normal*sin(_Time.y+v.vertex.x*10000)+v.normal*cos(_Time.y+v.vertex.z*10000);

		}

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;
		float _Rot;
		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			float2 nuv= float2(IN.uv_NormalTex.x+_Time.x,IN.uv_NormalTex.y);
			float2 nuv2= float2(IN.uv_NormalTex.x-_Time.x,IN.uv_NormalTex.y);
			///linha opcional
			nuv2=mul(nuv2,float2x2(cos(_Rot),-sin(_Rot),sin(_Rot),cos(_Rot)));

			fixed4 n = tex2D (_NormalTex, nuv);
			fixed4 n2 = tex2D (_NormalTex, nuv2);
			
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			
;

			o.Smoothness = clamp(_Glossiness+(tex2D (_FoamTex, IN.uv_FoamTex+(_Time.xy*0.01))*.5),0,1);
			o.Alpha = c.a;
			o.Normal=UnpackNormal((n+n2)/2);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
