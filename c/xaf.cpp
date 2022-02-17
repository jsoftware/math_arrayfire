// shared library with arrayfire routines - for use with J-ArrayFire bindings

#ifdef _WIN32
#pragma warning (disable:4275)
#endif

#include <arrayfire.h>
#include <stdio.h>
using namespace af;

#ifdef _WIN32
#include <cstdlib>
int WINAPI DllMain (HINSTANCE hDLL, DWORD dwReason, LPVOID lpReserved){return TRUE;}
#else
#define _stdcall
#endif

#ifdef _WIN32
#define CDPROC extern "C" 
#elif defined(__GNUC__)
#define CDPROC extern "C" __attribute__ ((visibility ("default")))
#else
#define CDPROC
#endif

CDPROC int _stdcall test(){return 23;};

// cdf'' can fail to unload - use datetime to check for use of latest build
CDPROC int _stdcall xaf_datetime(char** qresult)
{
*qresult= (char*)__DATE__ "T" __TIME__;
return 0;
}

// matmul example - error if: Input types are not the same
CDPROC int _stdcall xaf_matmul(af_array* aresult,af_array a,af_array b)
{
printf("%s\n","here we are");
array a1= array(a);
array b1= array(b);
try
{
 array a= matmul(a1,b1,AF_MAT_NONE,AF_MAT_NONE);
 af_retain_array(aresult,a.get());
 return 0;
}
catch (...) //(af::exception& e) // exceptions do not work - cpp dll called from JE
{
 printf("%s\n","fubar");
 return 1000;
}
}

// cpp array result - af_retain to inc ref count and .get() for the af_array*

// cpp example
CDPROC int _stdcall xaf_randu(af_array* aresult,int n)
{
array a= randu(n,n);
af_retain_array(aresult,a.get());
return 0;
}

// cpp example
CDPROC int _stdcall xaf_randu_s64(af_array* aresult,int n)
{
array a= randu(n,n,s64);
af_retain_array(aresult,a.get());
return 0;
}

array a666;

CDPROC long long _stdcall testex(int n)
{
try
{
 if(n==123)return 123;
 if(n==124)throw af::exception( "bad bad bad" );
 array a1=randu(3,3,f32);
 array a2=randu(3,3,f32);
 array a2i=randu(3,3,s64);
 if(n==125)
{ 
 array a666=matmul(a1,a2);
 return (long long)(void*)&a666;
}
if(n==126)
{
 array a4=matmul(a1,a2i);
 return n; 
}
 return 0;
}
catch (af::exception&e)
{
 printf("%i %s\n",e.err(),e.what());
 return 666;
}
}


// cpp example from arrayfire code - https://arrayfire.org/docs/matrixmanipulation.htm
CDPROC af_array _stdcall xaf_gridxy(af_array* aresult,int n)
{
array a= join(1,tile(seq(1, n), n),flat( transpose(tile(seq(1, n), 1, n)) ));
af_retain_array(aresult,a.get());
return 0;
}
