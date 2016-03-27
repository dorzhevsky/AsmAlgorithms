#ifndef MYLIB
#define MYLIB

#ifdef __cplusplus
extern "C" {
#endif

typedef struct
{
	double A; // Length of left and right
	double B; // Length of top and bottom
	double Alpha; // Angle alpha in degrees
	double Beta; // Angle beta in degrees
	double H; // Height of parallelogram
	double Area; // Parallelogram area
	double P; // Length of diagonal P
	double Q; // Length of diagonal Q
	bool BadValue; // Set to true if A, B, or Alpha is invalid
	char Pad[7]; // Reserved for future use
} PDATA;

_declspec(dllexport) unsigned __int16 Min(unsigned __int8* a, int len);
_declspec(dllexport) __int32 SphereSufraceVolume(float r, float* a, float* v);
_declspec(dllexport) bool ComputeParallelogramMetrics(PDATA* pdata);
_declspec(dllexport) void ComputeLeastSquareRoots(const double* x, const double* y, int n, double* m, double* b);


#ifdef __cplusplus
}
#endif


#endif