#include "stdafx.h"
#include "CppUnitTest.h"
#include "../Lib/Header.h"

#define _USE_MATH_DEFINES
#include <math.h>

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace Tests
{		
	TEST_CLASS(RectToSphericalTests)
	{
	public:
		
		TEST_METHOD(ShouldComputeR)
		{
			double x = 1, y = 2, z = 3;
			double r,phi, teta;
			RectToSpherical(x,y,z, &r, &phi, &teta);

			Assert::AreEqual(sqrt(x*x + y*y + z*z), r, 0.001);
		}

		TEST_METHOD(ShouldComputePhi)
		{
			double x = 1, y = 2, z = 3;
			double r,phi, teta;
			RectToSpherical(x,y,z, &r, &phi, &teta);

			Assert::AreEqual(atan(M_PI*(y/x)/180.0), phi, 0.001);
		}

		TEST_METHOD(ShouldComputeTeta)
		{
			double x = 1, y = 2, z = 3;
			double r,phi, teta;
			RectToSpherical(x,y,z, &r, &phi, &teta);

			Assert::AreEqual(acos(M_PI*z/sqrt(x*x + y*y + z*z)/180.0), teta, 0.001);
		}
	};
}