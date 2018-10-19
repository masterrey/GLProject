Shader "Unlit/ShadowGL"
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
			GLSLPROGRAM
			#include "UnityCG.glslinc"
			
			#ifdef VERTEX 
			varying vec2 vUV;
			varying vec3 normal;
			varying vec4 vPosition;
			
			void main() {
				gl_Position =gl_ProjectionMatrix*gl_ModelViewMatrix * gl_Vertex;
				normal=gl_Normal.xyz;
				vUV=gl_MultiTexCoord0.xy;
			}
			#endif 

			#ifdef FRAGMENT
			varying vec2 vUV;
			uniform vec4 _Color;
			varying vec3 normal;
			varying vec3 vPosition;
			void main() {
			 vec3 lightVector =normalize(_WorldSpaceLightPos0.xyz);
			 vec3 worldnormal=(unity_ObjectToWorld *vec4(normal,0)).xyz;
			 float brightness = dot( worldnormal, lightVector);
			 gl_FragColor = vec4(_Color.xyz*brightness,1);
			}
			#endif
			ENDGLSL
		}
	}
	
}
