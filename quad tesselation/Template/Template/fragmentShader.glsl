#version 450 core
out vec4 fragColor;
uniform vec2 u_resolution;
uniform float u_timer;

void main(void)
{
	vec2 uv = gl_FragCoord.xy / u_resolution;
	
	fragColor = vec4(1.0);
}