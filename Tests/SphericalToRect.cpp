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
			Assert::AreEqual(r*sin(M_PI/180*theta)*cos(M_PI/180*phi), x, 0.0001);
		}

		TEST_METHOD(ShouldComputeY)
		{
			double r = 10, phi = 5, theta = 6;
			double x,y,z;
			SphericalToRect(r,phi,theta,&x,&y,&z);
			Assert::AreEqual(r*sin(M_PI/180*theta)*sin(M_PI/180*phi), y, 0.0001);
		}

		TEST_METHOD(ShouldComputeZ)
		{
			double r = 10, phi = 5, theta = 6;
			double x,y,z;
			SphericalToRect(r,phi,theta,&x,&y,&z);
			Assert::AreEqual(r*cos(M_PI/180*theta), z, 0.0001);
		}

		TEST_METHOD(ShouldComputeXYZ)
		{
			double r = 7.00000000, phi = 56.30993247, theta = 31.0027191;
			double x,y,z;
			SphericalToRect(r,phi,theta,&x,&y,&z);
			Assert::AreEqual(2.0, x, 0.0001);
			Assert::AreEqual(3.0, y, 0.0001);
			Assert::AreEqual(6.0, z, 0.0001);
		}
	};
}