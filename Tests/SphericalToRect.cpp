#include "stdafx.h"
#include "CppUnitTest.h"
#include "../Lib/Header.h"

#define _USE_MATH_DEFINES
#include <math.h>

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace Tests
{		
	TEST_CLASS(SphericalToRectTests)
	{
	public:
		
		TEST_METHOD(ShouldComputeX)
		{
			double r = 10, phi = 5, theta = 6;
			double x,y,z;
			SphericalToRect(r,phi,theta,&x,&y,&z);
			Assert::AreEqual(r*sin(theta)*cos(phi), x, 0.0001);
		}

		TEST_METHOD(ShouldComputeY)
		{
			double r = 10, phi = 5, theta = 6;
			double x,y,z;
			SphericalToRect(r,phi,theta,&x,&y,&z);
			Assert::AreEqual(r*sin(theta)*sin(phi), y, 0.0001);
		}

		TEST_METHOD(ShouldComputeZ)
		{
			double r = 10, phi = 5, theta = 6;
			double x,y,z;
			SphericalToRect(r,phi,theta,&x,&y,&z);
			Assert::AreEqual(r*cos(theta), z, 0.0001);
		}
	};
}