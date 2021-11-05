#version 460 core

//layout (isolines,equal_spacing,ccw,point_mode) in;
layout (isolines,fractional_odd_spacing,ccw) in;
//layout (isolines,fractional_even_spacing,ccw) in;


uniform mat4 u_model_matrix;
uniform mat4 u_view_matrix;
uniform mat4 u_projection_matrix;

void main(void)
{

	//TYPE 1
	//**********************************************************************************
	//interpolate along bottom edge using u tessCoord
//	vec4 p1 = mix(gl_in[0].gl_Position,gl_in[1].gl_Position,gl_TessCoord.x);

	//interpolate on top edge
//	vec4 p2 = mix(gl_in[2].gl_Position,gl_in[3].gl_Position,gl_TessCoord.x);

	//interpolate p1 p2 using v tessCoord

//	vec4 pos = mix(p1,p2,gl_TessCoord.y);

	//**********************************************************************************

	//TYPE 2
	float r = (gl_TessCoord.y + gl_TessCoord.x/gl_TessLevelOuter[0]);
	float t = gl_TessCoord.x * 2.0 * 3.14159265;

	vec4 pos = vec4(sin(t) * r , cos(t) * r , 0.5 , 1.0);

	
	gl_Position = u_projection_matrix * u_view_matrix * u_model_matrix * pos;
}
