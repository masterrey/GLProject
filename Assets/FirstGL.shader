Shader "Unlit/FirstGL"
{
	Properties
	{
		_MainTex ("Textura", 2D) = "white" {}
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
			
			void main() {
				vec3 mypos=gl_Vertex.xyz;
				gl_Position =  gl_ModelViewProjectionMatrix * gl_Vertex+vec4(0,sin(_Time.z)*mypos.x,0,0);
				vUV=gl_MultiTexCoord0.xy;
			}
			#endif 
			#ifdef FRAGMENT
			varying vec2 vUV;
			uniform vec4 _Color;
			void main() {
				gl_FragColor = vec4(_Color.xyz*vUV.x,1);
			}
			#endif
			ENDGLSL
		}
	}
	
}
