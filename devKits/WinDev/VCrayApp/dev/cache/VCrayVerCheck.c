/* VCrayVerCheck.c 0.0.1            UTF-8                         2023-02-11
   -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

                        DETERMINATION OF RAYLIB VERSION

   VCrayVerCheck.c determines the version of raylib that is currently used
   by VCrayApp functions.

   File raylib.h defines a preprocessor variable RAYLIB_VERSION in all
   versions starting with the raylib 4.0 release.  This variable is checked
   for and the value used if available.  Otherwise an unknown version is
   reported.

   VCrayApp creates a small batch file that can be used by VCrayApp.bat to
   determine what setup variations are required in the compilation options
   and list of raylib files to compile into the cache.

   */

#include <stdlib.h>     // for exit cases
#include <stdio.h>      // for output functions

// #include <raylib.h>

int main(void)
    {  //stub providing default behavior
       fputs( "ECHO VCrayVerCheck 0.0.0 Determination of raylib Version\n"
              "SET VCRAYVER=unknown\n"
              "EXIT 0\n",
              stdout);
       return EXIT_SUCCESS;
    }

/* 0.0.0 2023-02-12T05:53Z Stub providing default behavior

                      *** end of VCrayVerCheck.c ***
   */
