/* nfoGenBIO-Win32-io-check.c 0.0.6 UTF-8                         2026-11-11
** -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
*                nfoGenBIO Win32 Binary File Handling Checks
*                -------------------------------------------
*
*   nfoGenBIO-Win32-io-check.c is a *platform-specific* exercise to determine
*   how Win32 <io.h> functions and definitions apply for x64 Windows-specific
*   builds.
*
*   -----------------------------------------------------------------------
*   Attribution: This program is co-pilot assisted.
*   -----------------------------------------------------------------------
*/

#include <io.h>
    /* for Microsoft-specific file-handling functions and definitions.
       Although this file is reported to be deprecated, it is still
       provided in the Microsoft C/C++ Build Tools runtime library and
       implemented at ucrt\corecrt_io.h.
       */

#include <stdint.h>

#include <stdio.h>

#include <stdlib.h>

#include <string.h>

#include "VCshowDefs.h"

void showSize(char x[], size_t sz, char sp[]) 
{  /* simulate SHOW for sizeof(type) expressions */

   fputs(sp, stdout);
   fprintf(stdout, "%s = %zu\n", x, sz);
   
   }



   int main(void)

   {
           fputs("[io-check] 0.0.6 Determine <io.h> behavior for nfoGenBIO"
                 " usage\n\n",
                 stdout);

           fputs("           corecrt_io.h INITIAL DEFINITIONS\n\n",
                 stdout);

           SHOW(_finddata_t, "                 ");
           SHOW(_finddatai64_t, "              ");
           SHOW(_fsize_t, "                    ");
           showSize("sizeof(_fsize_t)",
                sizeof(_fsize_t), "            ");
           SHOW(__int64, "                     ");
           showSize("sizeof(__int64)",
                sizeof(__int64), "             ");
           SHOW(_findfirst, "                  ");
           SHOW(_findnext, "                   ");
           SHOW(_findfirsti64, "               ");
           SHOW(_findfirst64, "                ");
           SHOW(_findnexti64, "                ");
           SHOW(_findnext64, "                 ");

           fputs("\n", stdout);

           return EXIT_SUCCESS;
   } /* main */

    /* XXX:

            The description of large/native files for the Win32 x64 Windows run-time library are pretty awful and also unclear.

            I'm starting with very simple skeletal tests to confirm compilation
            and essential behavior.

            There is also information on Stack Overflow, such as
            <https://stackoverflow.com/questions/63101309/is-there-a-way-to-get-size-of-a-file-on-windows-using-c>
            And also <https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-getfilesizeex
            */

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

    0.0.6  2026-11-11T19:51Z Try showSize for sizeof(type) expressions 
    0.0.5  2026-11-11T19:05Z  sizeof(type) for the types in SHOW macros
    0.0.4  2026-11-11T18:16Z Updated version to examine <io.h> definitions
    0.0.3  2026-11-11T18:16Z Initial version to examine <io.h> definitions
    0.0.2  2026-11-07T21:30Z Minimal stub for confirmation of compilation.
    0.0.1  2026-11-07T16:23Z Placeholder copy of nfoGenBIO-Win32-temps.c 0.1.1

                   *** end of nfoGenBIO-Win32-io-check.c ***

       */
