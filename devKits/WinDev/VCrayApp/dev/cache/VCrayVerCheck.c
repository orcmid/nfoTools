/* VCrayVerCheck.c 0.0.13            UTF-8                         2023-02-23
   -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

                        DETERMINATION OF RAYLIB VERSION

   VCrayVerCheck.c determines the version of raylib that is currently used
   by a VCrayApp-based project.

   File raylib.h defines a preprocessor variable RAYLIB_VERSION in all
   versions starting with the raylib 4.0 release.  This variable is checked
   for and the value used if available.  Otherwise an unidentified version is
   reported.  (There are further ways VCrayApp.bat can resolve such cases.)

   The console output from VCrayVercheck.exe is in the form of a small batch
   file that VCrayApp saves to VCrayVer.bat and then CALLs to have the version
   available to the VCrayApp.bat procedure.  THIS OUTPUT DEPENDS ON %VCterse%
   BEING SET BY THE CALLING VCrayApp.bat does.  The script announces the
   determination as part of VCrayApp.bat operation.

   VCrayVerCheck.c is compiled, with cache\ the current directory, using the
   command

        CL @VCoptions.opt VCrayVerCheck.c

   On a successful compilation VCrayApp.bat executes the result with command

        VCrayVerCheck >VCrayVer.bat

   Calling VCrayVer.bat will then set environment variable VCRAYVER to either
   "unidentified" or the value of RAYLIB_VERSION from raylib.h in the nearby
   raylib\src directory.  The result guides further VCrayApp.bat action.

   The technique for capturing preprocessor variable RAYLIB_VERSION is a
   variation on VCshowDefs, <https://orcmid.github.io/nfoTools/dev/D230201/>.

   */

#define TV(X) #X ""
      /* Turns pre-processor variables into string arguments */

#define SHOW(X) TV(X)
      /* Stringifies any defined value of pre-processor arugment
         XXX RAYLIB_VERSION values are expected to be quoted strings */

#include <stdlib.h>     // for exit cases
#include <stdio.h>      // for fputs()

#include <raylib.h>     // for RAYLIB_VERSION

int main(void)
    {   /* Determining what, if any, RAYLIB_VERSION is defined.
           Note that different code is compiled depending on whether
           definition of RAYLIB_VERSION is supplied by raylib.h
           */

       if (EOF ==
       # if !defined(RAYLIB_VERSION)
              fputs( "ECHO [VCrayApp] Using unidentified"
                          " version of raylib %VCterse%\n"
                     "SET VCRAYVER=\"unidentified\"   %VCterse%\n",
                     stdout )
       # else
              fputs( "ECHO [VCrayApp] Using version "
                           SHOW(RAYLIB_VERSION)
                           " of raylib %VCterse%\n"
                     "SET VCRAYVER=" SHOW(RAYLIB_VERSION) "   %VCterse%\n",
                     stdout )
       # endif

            )  // checking for unlikely fputs( ) failure case.
            return EXIT_FAILURE;
       else return EXIT_SUCCESS;
    }

/*
   0.0.13 2023-02-23T05:49Z Use "..." form on all VCRAYVER settings
   0.0.12 2023-02-21T01:39Z Revert back to VCrayVerCheck.c from .cx
   0.0.11 2023-02-21T01:13Z Remove EXIT command from the output script
   0.0.10 2023-02-20T00:20Z Touch up and use "unidentified" consistently
   0.0.9 2023-02-19T21:05Z Adjust for new name VCrayVerCheck.cx
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

                      *** end of VCrayVerCheck.cx ***
   */
