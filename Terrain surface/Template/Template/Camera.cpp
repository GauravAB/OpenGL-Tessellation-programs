#include "Camera.h"



Camera::Camera (int width, int height)
{
	xPrevCoord = width / 2;
	yPrevCoord = height / 2;
	cameraSpeed = 0.05f;
	yaw = -90.0f;
	pitch = 0.0f;
	sensitivity = 0.1f;
	cameraPos = vmath::vec3(0.0f, 2.0f, 3.0f);
	cameraFront = vmath::vec3(0.0f, 0.0f, -1.0f);
	cameraUp = vmath::vec3(0.0f, 1.0f, 0.0f);
}

vmath::vec3 Camera::getCameraPos() { return cameraPos; }
vmath::vec3 Camera::getCameraFront() { return cameraFront; }
vmath::vec3 Camera::getCameraUp() { return cameraUp; }

void Camera::updateCameraFront(float xPos, float yPos)
{
	xCoord = xPos;
	yCoord = yPos;

	if (firstEnter == false)
	{
		xPrevCoord = xPos;
		yPrevCoord = yPos;
		firstEnter = true;
	}

	float xOffset = xCoord - xPrevCoord;
	float yOffset = yPrevCoord - yCoord;
	xPrevCoord = xCoord;
	yPrevCoord = yCoord;

	xOffset *= sensitivity;
	yOffset *= sensitivity;

	yaw += xOffset;
	pitch += yOffset;

	if (pitch > 89.0f)
	{
		pitch = 89.0f;
	}
	if (pitch < -89.0f)
	{
		pitch = -89.0f;
	}

	front[0] = cos(vmath::radians(yaw))*cos(vmath::radians(pitch));
	front[1] = sin(vmath::radians(pitch));
	front[2] = sin(vmath::radians(yaw)) * cos(vmath::radians(pitch));
	cameraFront = normalize(front);
}

void Camera::updateCameraPositionFront()
{
	cameraPos += cameraSpeed * cameraFront;
}

void Camera::updateCameraPositionBack()
{
	cameraPos -= cameraSpeed * cameraFront;

}

void Camera::updateCameraPositionRight()
{
	cameraPos += normalize(cross(cameraFront, cameraUp)) * cameraSpeed;

}

void Camera::updateCameraPositionLeft()
{
	cameraPos -= normalize(cross(cameraFront, cameraUp)) * cameraSpeed;
}