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
			varying float wobble;
			void main() {
				vec4 calcvec=  gl_Vertex;
				wobble = sin(_Time.z+calcvec.x)*(calcvec.x-5)*0.1;
				gl_Position = gl_ModelViewProjectionMatrix * calcvec+vec4(0,wobble,0,0);
				vUV=gl_MultiTexCoord0.xy;
			}
			#endif 
			////////////////////////////////////////////////////////////////////////////////////
			#ifdef FRAGMENT
			varying vec2 vUV;
			varying float wobble;
			uniform vec3 _Color;
			uniform vec3 _Color2;
			void main() {
				vec2 ponto=vec2(0.5,0.5);
				 float pontomagnitude =length((vUV-ponto)*vec2(1.3,1.0));
				if(pontomagnitude>0.2){
					 gl_FragColor = vec4(_Color*(+0.5)*(wobble+0.8), 1.0 );
				}else{
					 gl_FragColor = vec4(_Color2*(+0.5)*(wobble+0.8), 1.0 );
				}
			}
			#endif
			ENDGLSL
		}
	}
	
}
