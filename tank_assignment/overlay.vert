#version 120

attribute vec2 aPosition;
attribute vec4 aColor;
attribute vec2 aTexcoord;

uniform mat4 uProjection;

varying vec4 vColor;
varying vec2 vUv;

void main(void)
{
    vColor = aColor;
    vUv = aTexcoord;
    gl_Position = uProjection * vec4(aPosition.xy, 0.0, 1.0);
}
