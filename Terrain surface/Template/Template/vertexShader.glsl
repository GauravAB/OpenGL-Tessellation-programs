#version 460 core


out VS_OUT
{
	vec2  tc;
} vs_out;


void main(void)
{
	const vec4 vertices[] = vec4[] (
		vec4(-0.5, 0.0,-0.5, 1.0),
		vec4( 0.5, 0.0,-0.5, 1.0),
		vec4(-0.5, 0.0, 0.5, 1.0),
		vec4( 0.5, 0.0, 0.5, 1.0 ) );

		//calculate offsets on every patch
		int x = gl_InstanceID & 255;
		int y = gl_InstanceID  >> 8;
		vec2 offs = vec2(x,y);

		vs_out.tc = (vertices[gl_VertexID].xz + offs + vec2(0.5))/256.0;
		//top left offset from (-32.0,0.0,-32.0) to bottom right (8.0,0.0,8.0);
		gl_Position = vertices[gl_VertexID] + vec4(float(x-128),0.0,float(y-128),0.0);
}