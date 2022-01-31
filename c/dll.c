// arrayfire - shared library 
#ifdef _WIN32
#include <windows.h>
int WINAPI DllMain (HINSTANCE hDLL, DWORD dwReason, LPVOID lpReserved)
{
	return TRUE;
}
typedef wchar_t wc;
typedef unsigned int uc;
#else
#define _stdcall
#define _cdecl
typedef unsigned short wc;
typedef unsigned int uc;
#endif
#ifdef _WIN32
#define CDPROC
#elif defined(__GNUC__)
#define CDPROC __attribute__ ((visibility ("default")))
#else
#define CDPROC
#endif

#include <stdio.h>

#if defined(_WIN64) || defined(_UNIX64)
#define SY_64 1
typedef long long I;
#else
#define SY_64 0
typedef long I;
#endif

#define sum {return a[0]=b+c[0]+c[1];}

typedef unsigned char BYTE;
typedef double D;
typedef float F;

// test pointer result
static char cd[]="test";
CDPROC char* _stdcall pc(){return cd;}


