#version 460 core
layout(vertices = 4) out;

void main(void)
{
	//set the tessellation levels for first invocation
	if(gl_InvocationID == 0)
	{	
		gl_TessLevelOuter[0] = 5.0;
		gl_TessLevelOuter[1] = 5.0;
	}

	gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
