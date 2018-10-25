Shader "lit/LitGL"
{
	Properties
	{
		_Color ("Minha cor", Color) = (1,0.5,0.5,1)
	}
	SubShader
	{
		Tags{ "LightMode" = "ForwardBase" }
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
				normal= normalize((unity_ObjectToWorld *vec4(gl_Normal, 0)).xyz);
				vUV=gl_MultiTexCoord0.xy;
			}
			#endif 
			#ifdef FRAGMENT
			uniform vec4 _Color;

			varying vec2 vUV;
			varying vec3 normal;
			varying vec3 vPosition;

			void main() {
			 vec3 lightVector =_WorldSpaceLightPos0.xyz;
			 float brightness = dot( lightVector, normal);
			 gl_FragColor = vec4(_Color.xyz*brightness,1);
			}
			#endif
			ENDGLSL
		}
	}
	
}
