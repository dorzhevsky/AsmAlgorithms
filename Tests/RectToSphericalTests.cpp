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
		
		TEST_METHOD(ShouldComputeRectToSphericalWhenRIsZero)
		{
			double x = 0, y = 0, z = 0;
			double r,phi, theta;
			RectToSpherical(x,y,z, &r, &phi, &theta);

			Assert::AreEqual(0, r, 0.001);
			Assert::AreEqual(0, phi, 0.001);
			Assert::AreEqual(0, theta, 0.001);
		}

		TEST_METHOD(ShouldComputeR)
		{
			double x = 1, y = 2, z = 3;
			double r,phi, theta;
			RectToSpherical(x,y,z, &r, &phi, &theta);

			Assert::AreEqual(sqrt(x*x + y*y + z*z), r, 0.001);
		}

		TEST_METHOD(ShouldComputePhi)
		{
			double x = 1, y = 2, z = 3;
			double r,phi, theta;
			RectToSpherical(x,y,z, &r, &phi, &theta);

			Assert::AreEqual(atan((y/x)), phi, 0.001);
		}

		TEST_METHOD(ShouldComputeTheta)
		{
			double x = 1, y = 2, z = 3;
			double r,phi, theta;
			RectToSpherical(x,y,z, &r, &phi, &theta);

			Assert::AreEqual(acos(z/sqrt(x*x + y*y + z*z)), theta, 0.001);
		}
	};
}