Shader "Unlit/CGUnlit"
{
	Properties
	{
		_Color ("Minha cor", Color) = (1,0.5,0.5,1)
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
			v2f vert (appdata v)
			{
				v2f myout;
				myout.vertex = UnityObjectToClipPos(v.vertex);
				myout.uv = v.uv;
				//UNITY_TRANSFER_FOG(myouto,myout.vertex);
				return myout;
			}
			fixed4 frag (v2f input) : SV_Target
			{
				
				//UNITY_APPLY_FOG(i.fogCoord, col);
				return _Color;
			}
			ENDCG
		}
	}
}
