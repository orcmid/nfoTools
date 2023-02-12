/* VCrayVerCheck.c 0.0.2            UTF-8                         2023-02-12
   -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

                        DETERMINATION OF RAYLIB VERSION

   VCrayVerCheck.c determines the version of raylib that is currently used
   by a VCrayApp-based project.

   File raylib.h defines a preprocessor variable RAYLIB_VERSION in all
   versions starting with the raylib 4.0 release.  This variable is checked
   for and the value used if available.  Otherwise an unknown version is
   reported.

   VCrayApp creates a small batch file that can be used by VCrayApp.bat to
   determine what setup variations are required in the compilation options
   and list of raylib files to compile into the cache.

   VCrayVerCheck.c is compiled, with cache\ the current directory, using the
   command

        CL @VCoptions.opt VCrayVerCheck.c

   If compilation succeeds, VCrayVerCheck.exe can be run to inspect what
   was determined about the raylib\ that is installed as a peer of the
   VCrayApp-based project.

   VCrayApp.bat compiles VCrayVercheck.c and executes a successful result
   with a command equivalent to

        VCrayVerCheck >VCrayVer.bat

   Calling VCrayVer.bat will set environment variable VCRAYVER to either
   "unknown" or the value of RAYLIB_VERSION from raylib.h in the nearby
   raylib\src directory.

   This is accomplished as part of VCrayApp.bat cache-creation operation in
   order to select raylib-version-compatible compilation options.

   */

#define TV(X) #X ""
      /* Turns pre-processor variables into string arguments */

#include <stdlib.h>     // for exit cases
#include <stdio.h>      // for output functions

#include <raylib.h>

int main(void)
    {
       fputs( "ECHO VCrayVerCheck 0.0.0 Determination of raylib Version\n",
              stdout );
       # if   !defined(RAYLIB_VERSION)
             fputs( "SET VCRAYVER=unknown\n"
                    "EXIT 0\n",
                    stdout);
       # else
              fputs( "SET VCRAYVER=" TV(RAYLIB_VERSION) "\n"
                     "EXIT 0\n",
                     stdout );
       # endif

       return EXIT_SUCCESS;
    }

/* 0.0.2 2023-02-12T23:01T Use VCshowDefs TV(X) definition to enstring the
         value of RAYLIB_VERSION
   0.0.1 2023-02-12T20:18Z Touch-up description and try raylib.h inclusion
   0.0.0 2023-02-12T05:53Z Stub providing default behavior

                      *** end of VCrayVerCheck.c ***
   */
