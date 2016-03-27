#include "stdafx.h"
#include <windows.h>
#include "corelib.h"
#include "Header.h"
#include <math.h>

int wmain(void)
{
	const int len = 10;
	double x[len] = {1,2,3,4,5,6,7,8,9,10};
	double y[len] = {1,2,3,4,5,6,7,8,9,10};
	double m,b;
	ComputeLeastSquareRoots(x, y, len, &m, &b);

	return 0;
}