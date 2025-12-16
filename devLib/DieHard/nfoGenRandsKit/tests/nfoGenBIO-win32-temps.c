/* nfoGenBIO-Win32-temps.c 0.0.0    UTF-8                         2025-12-16
** -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
*                   nfoGenBIO Temporary File Experiments
*                   ------------------------------------
*
*   nfoGenBIO-Win32-temps-temps.c is a *platform-specific* test to determine
*   appropriate handling of temporary files for nfoGenBIO-Win32.c.
*
*   The idea is to provide temporary file handling that is appropriate for
*   the Win32 platform, using the Microsoft C/C++ run-time library functions.
*
*   I prefer to use Standard C Language functions where possible, but the
*   assumption of directory paths and also use of filename extensions seems
*   problematic.
*
*   The Microsoft Learn documentation is not very helpful and the C11
*   documentation that I have may not be what has become standard at some
*   level of the ISO Standard for the C Language.
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

        Use of <io.h> is required for _mktemp_s( ).  I would like to use
        Standard C <stdio.h> functions, but they don't seem to provide the
        required flexibility on Windows.  I will try them and see what
        happens, especially with regard to file locations and path names.

        Since I may need to use Windows-specific <direct.h> functions, and
        maybe have to look at settings, I may already be in a state of sin.
        */




/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*


   0.0.0  2025-12-16T18:09Z Initial placeholder.

                    *** end of nfoGenBIO-Win32-temps.c ***

   */
