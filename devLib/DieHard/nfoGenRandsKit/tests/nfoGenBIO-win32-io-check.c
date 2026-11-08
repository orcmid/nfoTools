/* nfoGenBIO-Win32-io-check.c 0.0.2 UTF-8                         2026-11-07
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
    /* for Microsoft-specific file-handling functions and defintions */

#include <stdint.h>

#include <stdio.h>

#include <stdlib.h>

#include <string.h>

#include "VCshowDefs.h"



int main( void )

{      fputs ( "[io-check] 0.0.2 Determine <io.h> behavior for nfoGenBIO"
               " usage\n",
               stdout );


    return EXIT_SUCCESS;
    } /* GenTemps */

    /* XXX:

            The description of large/native files for the Win32 x64 Windows run-time library are pretty awful and also unclear.

            I'm starting with very simple skeletal tests to confirm compilation
            and essential behavior.

            There is also information on Stack Overflow, such as
            <https://stackoverflow.com/questions/63101309/is-there-a-way-to-get-size-of-a-file-on-windows-using-c>
            And also <https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-getfilesizeex
            */

    /* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

    0.0.2  2026-11-07T21:30Z Minimal stub for confirmation of compilation.
    0.0.1  2026-11-07T16:23Z Placeholder copy of nfoGenBIO-Win32-temps.c 0.1.1

                   *** end of nfoGenBIO-Win32-io-check.c ***

       */
