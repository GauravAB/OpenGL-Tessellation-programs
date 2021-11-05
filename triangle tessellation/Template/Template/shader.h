#include <cstdlib>
#include <fstream>
#include "glFiles.h"


char* readTextFile(char* fileName);
void checkCompileError(GLuint shaderID, char* type, FILE* gpFile);
void checkLinkError(GLuint program, FILE* gpFile);



GLuint createShaderProgram(char* vs, char* cs, char* es, char* gs, char* fs, FILE *gpFile);

