#version 120

uniform sampler2D uTexture;

varying vec4 vColor;
varying vec2 vUv;

void main(void)
{
    vec4 tex = texture2D(uTexture, vUv);
    gl_FragColor = vec4(vColor.rgb, vColor.a * tex.a);
}
