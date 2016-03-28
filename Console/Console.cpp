#include "stdafx.h"
#include <windows.h>
#include "corelib.h"
#include "Header.h"
#include <math.h>

int wmain(void)
{
	double x = 0, y = 0, z = 0;
	double r,phi, theta;
	RectToSpherical(x,y,z, &r, &phi, &theta);

	return 0;
}