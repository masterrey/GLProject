﻿Shader "RealShadowCG"
{
	Properties
	{
		_Color ("Minha cor", Color) = (1,0.5,0.5,1)
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float3 normal :NORMAL;
			};
			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
				float3 normal : NORMAL;
			};
			float4 _Color;
			sampler2D _MainTex;
			float4 _MainTex_ST;
			v2f vert (appdata v)
			{
				v2f myout;
				myout.vertex = UnityObjectToClipPos(v.vertex);
				myout.uv = TRANSFORM_TEX(v.uv, _MainTex);
				myout.normal=v.normal;
				UNITY_TRANSFER_FOG(myouto,myout.vertex);
				return myout;
			}
			fixed4 frag (v2f input) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, input.uv);
				float3 lightVector =normalize(_WorldSpaceLightPos0.xyz);
				float3 worldnormal=(mul(unity_ObjectToWorld,float4(input.normal,0))).xyz;
				UNITY_APPLY_FOG(i.fogCoord, col);
				float brightness = dot( worldnormal, lightVector);
				return float4((col*brightness)*_LightColor0*_Color.xyz,1);
			}
			ENDCG
		}
		UsePass "Legacy Shaders/VertexLit/SHADOWCASTER"
	}
}
