#version 460 core
out vec4 fragColor;
uniform vec2 u_resolution;
uniform float u_timer;
uniform sampler2D texture_sample;


in TES_OUT
{
	vec2 tc;
} fs_in;


void main(void)
{
	vec2 uv = gl_FragCoord.xy / u_resolution;
	
	vec3 color = texture(texture_sample,fs_in.tc * 2.0).rgb;

	fragColor = vec4(color,1.0);
}


