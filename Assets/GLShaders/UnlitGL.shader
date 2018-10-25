Shader "Unlit/UnlitGL"
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
			void main() {
				vec3 mypos=gl_Vertex.xyz;
				//gl_Position =  gl_ModelViewProjectionMatrix * gl_Vertex;
				gl_Position =gl_ProjectionMatrix*gl_ModelViewMatrix * gl_Vertex;
				normal=gl_Normal;
				vUV=gl_MultiTexCoord0.xy;
			}
			#endif 
			#ifdef FRAGMENT
			varying vec2 vUV;
			uniform vec4 _Color;
			varying vec3 normal;
			void main() {

				//mat4x4 modelMatrix = gl_ModelViewMatrix - gl_ModelView;
				mat4x4 modelMatrix = gl_ModelViewMatrix + inverse(gl_ModelViewMatrix);
			//_WorldSpaceLightPos0
			//+vec4(normal,0)
				gl_FragColor = vec4(_Color.xyz,1);
			}
			#endif
			ENDGLSL
		}
	}
	
}
