﻿Shader "Unlit/GLTEST"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			GLSLPROGRAM // here begins the part in Unity's GLSL
			#include "UnityCG.glslinc"
			
         #ifdef VERTEX // here begins the vertex shader

         void main() // all vertex shaders define a main() function
         {
            gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
               // this line transforms the predefined attribute 
               // gl_Vertex of type vec4 with the predefined
               // uniform gl_ModelViewProjectionMatrix of type mat4
               // and stores the result in the predefined output 
               // variable gl_Position of type vec4.
         }

         #endif // here ends the definition of the vertex shader


         #ifdef FRAGMENT // here begins the fragment shader

         void main() // all fragment shaders define a main() function
         {
            gl_FragColor = vec4(1.0, sin(_Time.w), 0.0, 1.0); 
               // this fragment shader just sets the output color 
               // to opaque red (red = 1.0, green = 0.0, blue = 0.0, 
               // alpha = 1.0)
         }

         #endif // here ends the definition of the fragment shader

         ENDGLSL // here ends the part in GLSL 
		}
	}
}
