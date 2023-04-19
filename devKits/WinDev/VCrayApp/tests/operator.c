/* operator.c 0.1.1                 UTF-8                          2023-04-19
   -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

   A quick check to demonstrate C++ operator+ is not available in C11.
   */

#include <raylib.h>

Vector3 operator+(const Vector3& a, const Vector3& b)
{
    return (Vector3){a.x + b.x, a.y + b.y, a.z + b.z};
    }

int main()
{
    /* nothing to do here */

    return 0;
    }

    /* This VCrayApp test case is demonstrated standalone by copying
       operator.c into dev\src\ and setting %VCAPPEXE% to operator.exe.
        1. Run "VCrayApp.bat *" (terse).  Confirm :FAIL5.
        2. If there are no visible diagnostics, use plain "VCrayApp.bat"
           (verbose, no "*") and capture the result.

       On completion, delete operator.c from dev\src\.  Delete anything
       that ended up in dev\app\, and restore %VCAPPEXE% to "ReplaceMe.exe".
       A clean way to restore VCrayApp.bat is using Git to restore the
       working copy from its last check-in here in nfoTools.
       */

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

   0.1.1 2023-04-19T15:29Z Cleanup comments and layout
   0.1.0 2023-04-18T21:23Z VCrayApp tests version

                        ***** end of operator.c *****
   */
