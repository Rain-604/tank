#version 120

// Attributes
attribute vec3 aVertexPosition;
attribute vec3 aVertexNormal;
attribute vec2 aVertexTexcoord;

uniform mat4x4 MVMatrix_uniform;
uniform mat4x4 ProjMatrix_uniform;
uniform vec3   LightPosition_uniform;

varying vec3 vPosition;
varying vec3 vNormal;
varying vec2 vTexCoord;

void main( void )
{
   vTexCoord = aVertexTexcoord;
   vPosition = vec3(MVMatrix_uniform * vec4(aVertexPosition, 1.0));
   vNormal   = (MVMatrix_uniform * vec4(aVertexNormal, 0.0)).xyz;
   gl_Position = ProjMatrix_uniform * vec4(vPosition, 1.0);
}
