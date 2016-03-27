using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace PInvokeTest
{
    //[StructLayout(LayoutKind.Sequential)]
    struct PData
    {
	    public double A; // Length of left and right
        public double B; // Length of top and bottom
        public double Alpha; // Angle alpha in degrees
        public double Beta; // Angle beta in degrees
        public double H; // Height of parallelogram
        public double Area; // Parallelogram area
        public double P; // Length of diagonal P
        public double Q; // Length of diagonal Q
        public bool BadValue; // Set to true if A, B, or Alpha is invalid
    }

    class Program
    {
        static byte MinSlow(byte[] a)
        {
            byte min = 255;
            for (int i = 0; i < a.Length; i++)
            {
                if (a[i] < min)
                {
                    min = a[i];
                }
            }
            return min;
        }

        static byte MinFast(byte[] a)
        {
            return Min(a, a.Length);
        }

        static void Main(string[] args)
        {
            PData pdata = new PData();
            pdata.Alpha = 30;
            pdata.A = 10;
            pdata.B = 20;

            //IntPtr ptr = Marshal.AllocHGlobal(Marshal.SizeOf(pdata));
            //Marshal.StructureToPtr(pdata, ptr, false);

            ComputeParallelogramMetrics(ref pdata);

            // Set this Point to the value of the 
            // Point in unmanaged memory. 
            //PData anotherP = (PData)Marshal.PtrToStructure(ptr, typeof(PData));

            Console.WriteLine(pdata.Area);
            //float r = 2.0f, a, v;
            //int res = SphereSufraceVolume(r, out a, out v);
            //Console.WriteLine("Surface area:" + a);
            //Console.WriteLine("Volume:" + v);
            //prevent the JIT Compiler from optimizing Fkt calls away
            //long seed = Environment.TickCount;

            ////use the second Core/Processor for the test
            //Process.GetCurrentProcess().ProcessorAffinity = new IntPtr(2);

            ////prevent "Normal" Processes from interrupting Threads
            //Process.GetCurrentProcess().PriorityClass = ProcessPriorityClass.High;

            ////prevent "Normal" Threads from interrupting this thread
            //Thread.CurrentThread.Priority = ThreadPriority.Highest;

            //Random rand = new Random();
            //byte[] a = new byte[8];
            //for (int i = 0; i < a.Length; i++) 
            //{
            //    a[i] = (byte)(rand.Next(1, 100));
            //    Console.WriteLine(a[i]);
            //}

            ////warm up
            //byte b = MinFast(a);
            //Console.WriteLine("Result:");
            //Console.WriteLine(b);
            //Console.ReadLine();
            //var stopwatch = new Stopwatch();
            //for (int i = 0; i < 10; i++)
            //{
            //    stopwatch.Reset();
            //    stopwatch.Start();
            //    for (int j = 0; j < 1000000; j++)
            //        MinSlow(a);
            //    stopwatch.Stop();
            //    Console.WriteLine(stopwatch.Elapsed.TotalMilliseconds);
            //}



            //short val = Min(a, a.Length);
            //Console.WriteLine(val);
        }
        [DllImport("Lib", CallingConvention = CallingConvention.Cdecl)]
        private static extern byte Min(byte[] a, int len);

        [DllImport("Lib", CallingConvention = CallingConvention.Cdecl)]
        private static extern int SphereSufraceVolume(float r, out float a, out float v);

        [DllImport("Lib", CallingConvention = CallingConvention.Cdecl)]
        private static extern void ComputeParallelogramMetrics(ref PData pdata);
    }
}
