#include "Header.h"
#include <stdio.h>
#define _USE_MATH_DEFINES 
#include <math.h>

extern "C" const double DegToRad = M_PI/180.0;

extern "C" unsigned __int16 Min_(unsigned __int8* a, int len);
unsigned __int16 Min(unsigned __int8* a, int len)
{
	return Min_(a, len);
}

extern "C" __int32 SphereSufraceVolume_(float r, float* a, float* v);
__int32 SphereSufraceVolume(float r, float* a, float* v)
{
	return SphereSufraceVolume_(r, a, v);
}

extern "C" bool ComputeParallelogramMetrics_(PDATA* pdata);
bool ComputeParallelogramMetrics(PDATA* pdata)
{
	return ComputeParallelogramMetrics_(pdata);
}

extern "C" void ComputeLeastSquareRoots_(const double* x, const double* y, int len, double* m, double* b);
void ComputeLeastSquareRoots(const double* x, const double* y, int len, double* m, double* b)
{
	ComputeLeastSquareRoots_(x, y, len, m, b);
}

extern "C" void RectToSpherical_(double x, double y, double z, double* r, double* phi, double* teta);
void RectToSpherical(double x, double y, double z, double* r, double* phi, double* teta)
{
	RectToSpherical_(x, y, z, r, phi, teta);
}

extern "C" void SphericalToRect_(double r, double phi, double theta, double* x, double* y, double* z);
void SphericalToRect(double r, double phi, double theta, double* x, double* y, double* z)
{
	SphericalToRect_(r, phi, theta, x, y, z);
}


