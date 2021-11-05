#version 460 core

//this shows 6 divisions of outer edge
//layout (triangles ,equal_spacing) in;

//this shows 4 divs of outer edge of equal space and 2 small divs
//layout (triangles ,fractional_even_spacing) in;

//this shows 4 divs of outer edge 
layout (triangles ,fractional_odd_spacing) in;

uniform mat4 u_model_matrix;
uniform mat4 u_view_matrix;
uniform mat4 u_projection_matrix;

void main(void)
{
	//using the barycentric coordinates from tesselator
	vec4 pos = gl_in[0].gl_Position * gl_TessCoord.x +
			   gl_in[1].gl_Position * gl_TessCoord.y +
			   gl_in[2].gl_Position * gl_TessCoord.z ;

	gl_Position = u_projection_matrix * u_view_matrix * u_model_matrix * pos;
}
