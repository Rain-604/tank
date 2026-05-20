#version 120

uniform vec4        Ambient_uniform;
uniform vec4        Specular_uniform;
uniform float       SpecularPower_uniform;
uniform vec3        LightPosition_uniform;
uniform sampler2D   TextureMap_uniform;

varying vec3 vPosition;
varying vec3 vNormal;
varying vec2 vTexCoord;

void main( void )
{
   vec3 N = normalize(vNormal);
   vec3 L = normalize(LightPosition_uniform - vPosition);
   vec3 V = normalize(-vPosition);
   vec3 H = normalize(L + V);

   // Blinn-Phong Diffuse
   float diff = max(dot(N, L), 0.0);
   
   // Blinn-Phong Specular
   float spec = pow(max(dot(N, H), 0.0), SpecularPower_uniform);
   
   vec4 texColor = texture2D(TextureMap_uniform, vTexCoord);
   
   // Ambient: constant base light
   // Diffuse: light based on angle
   // Specular: shiny highlights
   vec3 ambient = Ambient_uniform.rgb * 1.5; // Slight boost to ambient
   vec3 diffuse = diff * vec3(1.0, 0.95, 0.9); // Warm sunlight tint
   vec3 specular = spec * Specular_uniform.rgb;

   // Combine
   vec3 lighting = ambient + diffuse + specular;
   
   gl_FragColor = vec4(texColor.rgb * lighting, texColor.a);
}

