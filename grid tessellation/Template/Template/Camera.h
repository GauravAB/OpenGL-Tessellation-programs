#pragma once
#include "vmath.h"

class Camera
{
public:
	Camera(int width, int height);
	~Camera() {};

	void updateCameraFront(float xPos, float yPos);
	void updateCameraPositionFront();
	void updateCameraPositionBack();
	void updateCameraPositionRight();
	void updateCameraPositionLeft();
	
	vmath::vec3 getCameraPos();
	vmath::vec3 getCameraFront();
	vmath::vec3 getCameraUp();

private:
	float xCoord;
	float yCoord;
	float xPrevCoord;
	float yPrevCoord;
	float yaw;
	float pitch;
	float roll;
	float sensitivity;
	vmath::vec3 cameraPos;
	vmath::vec3 cameraFront;
	vmath::vec3 cameraUp;
	float cameraSpeed;
	bool firstEnter = false;
	vmath::vec3 front;
};

