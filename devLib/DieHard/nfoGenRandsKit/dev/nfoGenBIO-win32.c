/* nfoGenBIO-Win32.c 0.0.3          UTF-8                         2025-12-16
** -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
*                   nfoGenBIO Binary Transfer File Setup
*                   ------------------------------------
*
*   nfoGenBIO-Win32.c is a *platform-specific* component for nfoGenBIO.  The
*   name identifies its encapsulation of Windows-specific functionality for
*   handling binary transfer files via the nfoGenBIO.h procedures.
*
*   The intention is accomodation of other platforms by distinctly-suffixed
*   file names on the same pattern, with compilation and linking done using
*   the appropriate nfoGenBIO-*.c file.
*   -----------------------------------------------------------------------
*   Attribution: This program is copilot assisted.
*   -----------------------------------------------------------------------
*/

#include <stdint.h>
#include <stdio.h>

#include <io.h>

/* XXX: Provisionally: Use _mktemp_s generated temporary filename using a
        given basename template "baseXXXXXX", where base is chosen to reflect
        the application (such as the RNG being tested).  The XXXXXX will be
        changed in-place to a unique alphanumeric string by _mktemp_s( ).

        The result is a rewrite filename without any path components.

        Examples tend to use 8-character names with no file extension.  That
        should be acceptable here, but I wonder if it can be done better.

        Following the last read and closing of an input file, a remove
        operation might be performed.  This should be the case if the name
        is obtained via piping.  This could be confusing.  Think this through.
        Maybe need L_tmpnam_s and tmpnam_s( ).
          In C11, these are part of an Extended Library.  I need to know if
        that changes for later versions of the ISO C Language Standard.
        It appears that the changes have been permanent since at lease C21.
          One problem is I want temporary files to be in the current working
        directory, not the global TMP or TEMP locations.
          The examples on Windows show complete paths into AppData.  That's
        undesirable because of file sizes and limited C:\ capacity.
          On Windows is it possible to fudge the TMP environment variable
        and then fudge it back to the TEMP value ???

           The descriptions of these for the VC/C++ Windows run-time library
        are pretty awful and also unclear.

        There may be some help in the use of <direct.h> and using _chdir.
        There's also _getcwd.  I might not need a complete <windows.h> include
        for that.

        I'm going to start with simple tests to see what all of this does
        and now to get control of it, especially with regard to choosing
        the file locations in some simple way.
        */




/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

0.0.2  2025-12-16T05:29Z More pondering
0.0.1  2025-12-14T17:41Z More thinking outloud. copilot attribution.
0.0.0  2025-12-13T21:13Z Initial placeholder.

                       *** end of nfoGenBIO-Win32.c ***

   */
