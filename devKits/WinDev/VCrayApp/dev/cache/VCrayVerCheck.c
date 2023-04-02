
/* VCrayVerCheck.c 0.1.3            UTF-8                         2023-04-02
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256


   -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

                        DETERMINATION OF RAYLIB VERSION

  ************************************************************************
  *                                                                      *
  * THIS PROGRAM IS MEANT TO BE RETAINED IN A VCrayApp cache\ FOLDER AND *
  * USED INTERNALLY BY VcrayApp.bat.  IT IS ONLY SUPPORTED AS INTENDED   *
  * IN THAT LOCATION WITHIN A VCrayApp RELEASE.                          *
  *                                                                      *
  ************************************************************************

   VCrayVerCheck.c determines the version of raylib that is currently used
   by a VCrayApp-based project.

   File raylib.h defines a preprocessor variable RAYLIB_VERSION in all
   versions starting with the raylib 4.0 release.  This variable is checked
   for and the value used if available.  Otherwise an unidentified version is
   reported.  (There are further ways VCrayApp.bat resolves such cases.)

   The console output from VCrayVercheck.exe is in the form of a small batch
   file that VCrayApp saves to VCrayVer.bat and then CALLs to have the version
   available to the VCrayApp.bat procedure.  THIS OUTPUT RELIES ON %VCterse%
   BEING SET BY THE CALLING VCrayApp.bat script if at all.

   VCrayVerCheck.c is compiled, with cache\ the current directory, using a
   command equivalent to

        CL @VCoptions.opt VCrayVerCheck.c

   On a successful compilation VCrayApp.bat executes the result with command
   equivalent to

        VCrayVerCheck >VCrayVer.bat

   Performing VCrayVer.bat will then set environment variable VCRAYVER to the
   value of RAYLIB_VERSION from raylib.h in the nearby raylib\src directory.
   If RAYLIB_VERSION is not set, the value "unidentified" is reported. The
   result guides further VCrayApp.bat action.

   The technique for capturing preprocessor variable RAYLIB_VERSION is a
   variation on VCshowDefs, <https://orcmid.github.io/nfoTools/dev/D230201/>.

   */

#define TV(X) #X ""
      /* Turns pre-processor variables into string arguments.
         The extra "" works whether #X provides a quoted string
         or provides nothing. This and the fputs() below rely on
         the fact that string constants separated only by white
         space are automatically concatenated into a single string. */

#define SHOW(X) TV(X)
      /* Stringifies any defined value of the pre-processor argument.
         XXX: RAYLIB_VERSION values are expected to be quoted strings */

#include <stdlib.h>     // for exit() and its defined cases
#include <stdio.h>      // for fputs() and EOF

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
                     "SET VCRAYVER=\"unidentified\"%VCterse%\n",
                     stdout )
       # else
              fputs( "ECHO [VCrayApp] Using version "
                           SHOW(RAYLIB_VERSION)
                           " of raylib %VCterse%\n"
                     "SET VCRAYVER="SHOW(RAYLIB_VERSION)"%VCterse%\n",
                     stdout )
       # endif

            )  // checking for unlikely fputs( ) failure case.
            return EXIT_FAILURE;
       else return EXIT_SUCCESS;
    }

/*
   0.1.3  2023-04-03T19:40Z Clear armor sign for release
   0.1.2  2023-04-02T17:35Z Touch up for release candidate
   0.1.1  2023-03-22T21:22Z Clean up spacing in the output SET commands
   0.1.0  2023-02-26T19:40Z Cleaned-up VCrayApp 0.1.0 release candidate
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

                      *** end of VCrayVerCheck.c ***
-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEBNBDIpebhN4QdwM0+W6J/9RWYooFAmQp2C8SHG9yY21pZEBh
cGFjaGUub3JnAAoJEPluif/UVmKK58wH/1ccHGaHCmNYmoj6K805XW4lbJLXXaAF
i9WuUfgI8M5oa8QgksMaUDNgx/xyopI43mz2p+mQomsqxbo6KBb8z4M/a0IqxOfR
oI3vT9NRbGbUIaWOQFPUuXRwAy82vYeC6DnIw7y1OuCQ1sqkxT2VmksIJ8OMxYiT
m53uoVlqw4vC3jhuc9UtfFRvEoNhEsR793xJtbhyYugucbtUu4IFnRzlWijP2nGa
FtE+R5nzpmw6eX7Lr9ZpNqtwxx8vb3XMoRN1ljHhbFNyRhGckNc2hXmHwMyE9cE9
lJM3QmYJm5Yt3/+K8Y97SRjAJJhM7XnXDiupWrzXCWpiCvYIA6l4wYc=
=L6TR
-----END PGP SIGNATURE-----
*/
