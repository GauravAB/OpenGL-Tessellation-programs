#version 460 core

layout(vertices = 4)out;

in VS_OUT
{
	vec2 tc;
}tcs_in[];

out TCS_OUT
{
	vec2 tc;
} tcs_out[];

uniform mat4 u_model_matrix;
uniform mat4 u_view_matrix;
uniform mat4 u_projection_matrix;

void main(void)
{
	if(gl_InvocationID == 0)
	{
		mat4 mvp = u_projection_matrix * u_view_matrix * u_model_matrix;		
		
		vec4 p0 = mvp * gl_in[0].gl_Position;
		vec4 p1 = mvp * gl_in[1].gl_Position;
		vec4 p2 = mvp * gl_in[2].gl_Position;
		vec4 p3 = mvp * gl_in[3].gl_Position;

		//ndc coordinates
		p0 /= p0.w;
		p1 /= p1.w;
		p2 /= p2.w;
		p3 /= p3.w;

		//do not evaluate for quads behind the camera
		if( p0.z <= 0.0 || 
			p1.z <= 0.0 ||
			p2.z <= 0.0 ||
			p3.z <= 0.0 )
		{
			gl_TessLevelOuter[0] = 0.0;
			gl_TessLevelOuter[1] = 0.0;
			gl_TessLevelOuter[2] = 0.0;
			gl_TessLevelOuter[3] = 0.0;
		}
		else
		{
			//left edge * arbitrary scale plus some bias added
			float l0 = length(p2.xy - p0.xy) * 64.0 + 1.0;
			
			//top edge
			float l1 = length(p3.xy - p2.xy) * 64.0 + 1.0;
			
			//right edge
			float l2 = length(p3.xy - p1.xy) * 64.0 + 1.0;
			
			//bottom edge
			float l3 = length(p1.xy - p0.xy) * 64.0 + 1.0;

			gl_TessLevelOuter[0] = l0;
			gl_TessLevelOuter[1] = l1;
			gl_TessLevelOuter[2] = l2;
			gl_TessLevelOuter[3] = l3;

			gl_TessLevelInner[0] = min(l1,l3);
			gl_TessLevelInner[1] = min(l0,l2);
	
		}

	}
	gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
	tcs_out[gl_InvocationID].tc = tcs_in[gl_InvocationID].tc;
}


