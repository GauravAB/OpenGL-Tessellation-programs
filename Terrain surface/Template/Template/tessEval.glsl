#version 460 core

uniform float uTimer;


layout( quads , fractional_odd_spacing)in;

uniform mat4 u_model_matrix;
uniform mat4 u_view_matrix;
uniform mat4 u_projection_matrix;

in TCS_OUT
{
	vec2 tc;
}tes_in[];

out TES_OUT
{
	vec2 tc;
} tes_out;



float random(float p)
{
	return (fract(sin(p*9999.0)));
}

float noise(vec2 p)
{
	return (random(sin(p.x + p.y*9999.0)));
}


vec2 sw(vec2 p) { return vec2(floor(p.x), floor(p.y)); }
vec2 se(vec2 p) { return vec2(ceil(p.x), floor(p.y)); }
vec2 nw(vec2 p) { return vec2(floor(p.x), ceil(p.y)); }
vec2 ne(vec2 p) { return vec2(ceil(p.x), ceil(p.y)); }

float smoothNoise(vec2 p)
{
	//smoothsaw
	vec2 inter = smoothstep(0.0, 1.0, fract(p));
	float s = mix(noise(sw(p)), noise(se(p)), inter.x);
	float n = mix(noise(nw(p)), noise(ne(p)), inter.x);
	return mix(s, n, inter.y);
}
mat2 m2  = mat2(1.6,-1.2,1.2,1.6);



float  fbm(vec2 p)
{
	float f = 0.0;

	f += 0.5000*smoothNoise(p); p *= m2*2.01;
	f += 0.2500*smoothNoise(p); p *= m2*2.04;
	f += 0.1250*smoothNoise(p); p *= m2*2.03;
	f += 0.0625*smoothNoise(p); p *= m2*2.05;

	f /= 0.9375;

	return f;
}

const float noiseFrequency = 0.2;

void main(void)
{

	vec2 tc1 = mix(tes_in[0].tc,tes_in[1].tc,gl_TessCoord.x);
	vec2 tc2 = mix(tes_in[2].tc,tes_in[3].tc,gl_TessCoord.x);
	vec2 tc  = mix(tc2,tc1,gl_TessCoord.y);


	vec4 p1 = mix(gl_in[0].gl_Position,gl_in[1].gl_Position,gl_TessCoord.x);
	vec4 p2 = mix(gl_in[2].gl_Position,gl_in[3].gl_Position,gl_TessCoord.x);
	vec4 pos = mix(p2,p1,gl_TessCoord.y);

	pos.y += 2.2*smoothNoise(vec2(pos.x,pos.z)*noiseFrequency);	
	
	gl_Position = u_projection_matrix * u_view_matrix * u_model_matrix * pos;
	tes_out.tc = tc;
}











