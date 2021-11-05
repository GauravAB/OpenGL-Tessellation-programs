#include "shader.h"


char* readTextFile(char* fileName)
{
	FILE *fp = fopen(fileName, "rb");
	char* content = NULL;
	long numVal;

	//go till end
	fseek(fp, 0L, SEEK_END);
	
	//get count bytes 
	numVal = ftell(fp);

	//reset
	fseek(fp, 0L, SEEK_SET);

	content = (char*)malloc(sizeof(char)*(numVal + 1));

	//read into buffer
	fread(content, 1, numVal, fp);
	content[numVal] = '\0';

	fclose(fp);
	return content;
}

void checkLinkError(GLuint program, FILE* gpFile)
{
	void uninitialize();

	GLint iShaderLinkStatus;
	int iInfoLogLength;
	char *szInfoLog;

	glGetProgramiv(program, GL_LINK_STATUS, &iShaderLinkStatus);

	if (iShaderLinkStatus == GL_FALSE)
	{
		glGetProgramiv(program, GL_INFO_LOG_LENGTH, &iInfoLogLength);
		if (iInfoLogLength > 0)
		{
			GLsizei written;
			szInfoLog = (char*)malloc(iInfoLogLength);
			if (szInfoLog != NULL)
			{
				glGetProgramInfoLog(program, iInfoLogLength, &written, szInfoLog);
				fprintf(gpFile, "program link error log : %s", szInfoLog);
				free(szInfoLog);
				uninitialize();
				exit(0);
			}
		}
	}

}

void checkCompileError(GLuint shaderID, char* type, FILE* gpFile)
{
	void uninitialize();

	GLint iCompileStatus;
	GLint iInfoLogLength;
	char *szInfoLog = NULL;

	glGetShaderiv(shaderID, GL_COMPILE_STATUS, &iCompileStatus);
	if (iCompileStatus == GL_FALSE)
	{
		glGetShaderiv(shaderID, GL_INFO_LOG_LENGTH, &iInfoLogLength);
		if (iInfoLogLength > 0)
		{
			szInfoLog = (char*)malloc(iInfoLogLength);
			GLsizei written;
			glGetShaderInfoLog(shaderID, iInfoLogLength, &written, szInfoLog);
			fprintf(gpFile, "%s compile error Log : %s", type, szInfoLog);
			free(szInfoLog);
			uninitialize();
			exit(0);
		}
	}

}

GLuint createShaderProgram(char* vs,  char* cs,  char* es, char* gs, char* fs, FILE *gpFile)
{
	GLuint program;
	GLuint vertShaderID;
	GLuint fragShaderID;
	GLuint tessControlShaderID;
	GLuint tessEvaluationShaderID;
	GLuint geometryShaderID;


	const char* vtext;
	const char* ftext;
	const char* ctext;
	const char* etext;
	const char* gtext;


	if (vs)
	{
		vtext = readTextFile(vs);
		vertShaderID = glCreateShader(GL_VERTEX_SHADER);
		glShaderSource(vertShaderID, 1, (const char**)&vtext, NULL);
		glCompileShader(vertShaderID);
		checkCompileError(vertShaderID,"vertex shader",gpFile);
	}

	if (fs)
	{
		ftext = readTextFile(fs);
		fragShaderID = glCreateShader(GL_FRAGMENT_SHADER);
		glShaderSource(fragShaderID, 1, (const char**)&ftext, NULL);
		glCompileShader(fragShaderID);
		checkCompileError(fragShaderID, "fragment shader", gpFile);
	
	}

	if (cs)
	{
		ctext = readTextFile(cs);
		tessControlShaderID = glCreateShader(GL_TESS_CONTROL_SHADER);
		glShaderSource(tessControlShaderID, 1, (const char**)&ctext, NULL);
		glCompileShader(tessControlShaderID);
		checkCompileError(tessControlShaderID, "tess control shader", gpFile);

	}

	if (es)
	{
		etext = readTextFile(es);
		tessEvaluationShaderID = glCreateShader(GL_TESS_EVALUATION_SHADER);
		glShaderSource(tessEvaluationShaderID, 1, (const char**)&etext, NULL);
		glCompileShader(tessEvaluationShaderID);
		checkCompileError(tessEvaluationShaderID, "tess evaluation shader", gpFile);
	}

	if (gs)
	{
		etext = readTextFile(gs);
		geometryShaderID = glCreateShader(GL_GEOMETRY_SHADER);
		glShaderSource(geometryShaderID, 1, (const char**)&gtext, NULL);
		glCompileShader(geometryShaderID);
		checkCompileError(geometryShaderID, "geometry shader", gpFile);
	}


	program = glCreateProgram();

	if (vs)
	{
		glAttachShader(program, vertShaderID);
	}
	if (cs)
	{
		glAttachShader(program, tessControlShaderID);
	}
	if (es)
	{
		glAttachShader(program, tessEvaluationShaderID);

	}
	if (gs)
	{
		glAttachShader(program, geometryShaderID);
	}
	if (fs)
	{
		glAttachShader(program, fragShaderID);
	}

	glLinkProgram(program);
	checkLinkError(program, gpFile);

	if (vs)
	{
		glDetachShader(program, vertShaderID);
		glDeleteShader(vertShaderID);

	}
	
	if (cs)
	{
		glDetachShader(program, tessControlShaderID);
		glDeleteShader(tessControlShaderID);
	}
	if (es)
	{
		glDetachShader(program, tessEvaluationShaderID);
		glDeleteShader(tessEvaluationShaderID);

	}
	if (gs)
	{
		glDetachShader(program, geometryShaderID);
		glDeleteShader(geometryShaderID);
	}

	if (fs)
	{
		glDetachShader(program, fragShaderID);
		glDeleteShader(fragShaderID);
	}
	

	return program;
}