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
			#ifdef VERTEX 
			void main() {
				gl_Position =  gl_ModelViewProjectionMatrix * gl_Vertex;
			}
			#endif 
			#ifdef FRAGMENT
			uniform vec4 _Color;
			void main() {
				gl_FragColor = vec4(_Color.xyz,1);
			}
			#endif
			ENDGLSL
		}
	}
	
}
