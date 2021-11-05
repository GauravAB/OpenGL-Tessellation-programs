#version 460 core

uniform mat4 u_model_matrix;
uniform mat4 u_view_matrix;
uniform mat4 u_projection_matrix;

void main(void)
{
	//hardcoded vertices
	const vec4 vertices[] = vec4[](vec4(-0.5,0.0,-0.5,1.0),
								   vec4( 0.5,0.0,-0.5,1.0),
								   vec4(-0.5,0.0, 0.5,1.0),
								   vec4( 0.5,0.0, 0.5,1.0));
	int x = gl_InstanceID & 63;
	int y = gl_InstanceID >> 6;
	
	gl_Position = vertices[gl_VertexID] + vec4(float(x - 32),0.0,float(y - 32),0.0);
}

