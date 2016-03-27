#include "stdafx.h"
#include "CppUnitTest.h"
#include "../Lib/Header.h"
#include <math.h>

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace Tests
{		
	TEST_CLASS(ParallelogramTests)
	{
	public:
		
		TEST_METHOD(ShouldComputeParallelogramMetrics)
		{
			PDATA pdata;
			pdata.A = 10;
			pdata.B = 20;
			pdata.Alpha = 30;

			bool result = ComputeParallelogramMetrics(&pdata);
	
			Assert::IsTrue(result, L"Input is valid");
			Assert::AreEqual(sqrt(pdata.A*pdata.A + pdata.B*pdata.B - 2*pdata.A*pdata.B*cos(3.14*pdata.Alpha/180.0)),pdata.P,0.01);
		}

		TEST_METHOD(ShouldCheckIfABiggerThanZero)
		{
			PDATA pdata;
			pdata.A = -1;
			pdata.B = 1;
			pdata.Alpha = 90;
			bool result = ComputeParallelogramMetrics(&pdata);	
			Assert::IsFalse(result);
		}

		TEST_METHOD(ShouldCheckIfAIsNotEqualToZero)
		{
			PDATA pdata;
			pdata.A = 0;
			pdata.B = 1;
			pdata.Alpha = 1;			
			bool result = ComputeParallelogramMetrics(&pdata);	
			Assert::IsFalse(result);
		}

		TEST_METHOD(ShouldCheckIfBBiggerThanZero)
		{
			PDATA pdata;
			pdata.B = -1;
			pdata.A = 1;
			pdata.Alpha = 1;
			bool result = ComputeParallelogramMetrics(&pdata);	
			Assert::IsFalse(result);
		}

		TEST_METHOD(ShouldCheckIfBIsNotEqualToZero)
		{
			PDATA pdata;
			pdata.B = 0;
			pdata.A = 1;
			pdata.Alpha = 1;
			bool result = ComputeParallelogramMetrics(&pdata);	
			Assert::IsFalse(result);
		}

		TEST_METHOD(ShouldCheckIfAlphaIsBiggetThanZero)
		{
			PDATA pdata;
			pdata.Alpha = -1;
			pdata.A = 1;
			pdata.B = 1;
			bool result = ComputeParallelogramMetrics(&pdata);
			Assert::IsFalse(result);
		}

		TEST_METHOD(ShouldCheckIfAlphaIsNotEqualToZero)
		{
			PDATA pdata;
			pdata.Alpha = 0;
			pdata.A = 1;
			pdata.B = 1;
			bool result = ComputeParallelogramMetrics(&pdata);
			Assert::IsFalse(result);
		}

		TEST_METHOD(ShouldCheckIfAlphaIsLessThan180)
		{
			PDATA pdata;
			pdata.Alpha = 181;
			pdata.A = 1;
			pdata.B = 1;
			bool result = ComputeParallelogramMetrics(&pdata);
			Assert::IsFalse(result);
		}

		TEST_METHOD(ShouldCheckIfAlphaIsNotEqualTo180)
		{
			PDATA pdata;
			pdata.Alpha = 180;
			pdata.A = 1;
			pdata.B = 1;
			bool result = ComputeParallelogramMetrics(&pdata);
			Assert::IsFalse(result);
		}

		TEST_METHOD(ShouldCheckIfAlphaIsNotNan)
		{
			PDATA pdata;
			pdata.Alpha = std::numeric_limits<double>::quiet_NaN();
			pdata.A = 1;
			pdata.B = 1;
			bool result = ComputeParallelogramMetrics(&pdata);
			Assert::IsFalse(result);
		}
	};
}