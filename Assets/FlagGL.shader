Shader "Unlit/FlagGL"
{
	Properties
	{
		_MainTex ("Textura", 2D) = "white" {}
		_Color ("Minha cor", Color) = (1,0.5,0.5,1)
	}
	SubShader
	{
		Cull off //renderiza dos 2 lados
		Tags { "RenderType"="Opaque" }
		LOD 100
		Pass
		{
			GLSLPROGRAM
			#include "UnityCG.glslinc"
			#ifdef VERTEX 
			varying vec2 vUV;
			

			
			void main() {
				vec4 calcvec=  gl_Vertex;
				
				float wobble = sin(_Time.z+calcvec.x)*(calcvec.x-5)*0.1;

				gl_Position = gl_ModelViewProjectionMatrix * calcvec+vec4(0,wobble,0,0);
				

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
