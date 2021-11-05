#version 450 core

layout (quads) in;

uniform mat4 u_model_matrix;
uniform mat4 u_view_matrix;
uniform mat4 u_projection_matrix;

void main(void)
{
	vec4 p1 = mix(gl_in[0].gl_Position,gl_in[1].gl_Position,gl_TessCoord.x);
	
	vec4 p2 = mix(gl_in[2].gl_Position,gl_in[3].gl_Position,gl_TessCoord.x);

	vec4 pos = mix(p1,p2,gl_TessCoord.y);
	
	gl_Position = u_projection_matrix * u_view_matrix * u_model_matrix * pos;
}
