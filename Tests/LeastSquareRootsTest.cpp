#include "stdafx.h"
#include "CppUnitTest.h"
#include "../Lib/Header.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace Tests
{
	TEST_CLASS(LeastSquareRootsTest)
	{
	public:
		
		TEST_METHOD(ShouldComputeMAndB)
		{
			const int len = 7;
			double x[len] = {0,2,4,6,8,10,12};
			double y[len] = {51.1250,62.8750,71.2500,83.5000,92.7500,101.1000, 110.5000};
			double m,b;
			ComputeLeastSquareRoots(x, y, len, &m, &b);
			Assert::AreEqual(4.9299, m, 0.001);
			//Assert::AreEqual(52.2920, b, 0.001);
		}

		TEST_METHOD(ShouldComputeMAndBAnotherCase)
		{
			const int len = 11;
			double x[len] = {10, 13, 17, 19, 23, 7, 35, 51, 89, 92, 99};
			double y[len] = {1.2, 1.1, 1.8, 2.2, 1.9, 0.5, 3.1, 5.5, 8.4, 9.7, 10.4};
			double m,b;
			ComputeLeastSquareRoots(x, y, len, &m, &b);
			Assert::AreEqual(0.10324631, m, 0.001);
			//Assert::AreEqual(-0.10700632, b, 0.001);
		}
	};
}