/* VCrayVerCheck.c 0.0.8            UTF-8                         2023-02-19
   -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

                        DETERMINATION OF RAYLIB VERSION

   VCrayVerCheck.c determines the version of raylib that is currently used
   by a VCrayApp-based project.

   File raylib.h defines a preprocessor variable RAYLIB_VERSION in all
   versions starting with the raylib 4.0 release.  This variable is checked
   for and the value used if available.  Otherwise an unidentified version is
   reported.  (There may be other ways to resolve such cases.)

   The console output from VCrayVercheck.exe is in the form of a small batch
   file that VCrayApp saves to VCrayVer.bat and then calls to have the version
   available to the VCrayApp.bat procedure.  THIS OUTPUT DEPENDS ON %VCterse%
   BEING SET BY THE CALLING SCRIPT, AS VCrayApp.bat does.  The script reports
   its operation as a report from VCrayApp.

   VCrayApp uses the detected raylib version and the version of VS Build Tools
   to determine what setup variations are required in the VCrayApp compilation
   options, the list of raylib files to cache, and the ability of certain
   raylib features to be used.

   VCrayVerCheck.c is compiled, with cache\ the current directory, using the
   command

        CL @VCoptions.opt VCrayVerCheck.c

   If compilation succeeds, VCrayVerCheck.exe can be run to inspect what
   was determined about the raylib\ that is installed as a peer of the
   VCrayApp-based project.

   VCrayApp.bat compiles VCrayVercheck.c and executes a successful result
   with command

        VCrayVerCheck >VCrayVer.bat

   Calling VCrayVer.bat will set environment variable VCRAYVER to either
   "unknown" or the value of RAYLIB_VERSION from raylib.h in the nearby
   raylib\src directory.

   The technique for capturing preprocessor variable RAYLIB_VERSION is a
   variation on VCshowDefs, <https://orcmid.github.io/nfoTools/dev/D230201/>.

   */

#define TV(X) #X ""
      /* Turns pre-processor variables into string arguments */

#define SHOW(X) TV(X)
      /* Stringifies any defined value of pre-processor arugment X */

#include <stdlib.h>     // for exit cases
#include <stdio.h>      // for fputs()

#include <raylib.h>     // for RAYLIB_VERSION

int main(void)
    {   /* Determining what, if any, RAYLIB_VERSION is defined.
           Note that different code is compiled depending on whether
           definition of RAYLIB_VERSION is supplied by raylib.h
           */

       if (EOF ==
       # if   !defined(RAYLIB_VERSION)
             fputs( "ECHO [VCrayApp] Using unidentified"
                          " version of raylib %VCterse%\n"
                    "SET VCRAYVER=unknown   %VCterse%\n"
       # else
              fputs( "ECHO [VCrayApp] Using version "
                           SHOW(RAYLIB_VERSION)
                           " of raylib %VCterse%\n"
                     "SET VCRAYVER=" SHOW(RAYLIB_VERSION) "   %VCterse%\n"
       # endif
                     "EXIT /B 0  %VCterse%\n",
                     stdout )
            )  // checking for unlikely fputs( ) failure case.
            return EXIT_FAILURE;
       else return EXIT_SUCCESS;
    }

/*
   0.0.8 2023-02-19T18:32Z Prefer "unidentified" over "unknown"
   0.0.7 2023-02-19T18:11Z Tidy up, explaining the procedure better.
   0.0.6 2023-02-18T22:59Z Incorporate %VCterse% in the generated .bat
         use batch exit
   0.0.5 2023-02-18T21:49Z Add EOF handling of the fputs( ) used.
   0.0.4 2023-02-13T00:06Z Clean up reporting on version
   0.0.3 2023-02-12T23:47Z Struggling to get TV(X) to glom the value
   0.0.2 2023-02-12T23:01Z Use VCshowDefs TV(X) definition to enstring the
         value of RAYLIB_VERSION
   0.0.1 2023-02-12T20:18Z Touch-up description and try raylib.h inclusion
   0.0.0 2023-02-12T05:53Z Stub providing default behavior

                      *** end of VCrayVerCheck.c ***
   */
