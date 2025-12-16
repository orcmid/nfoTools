/* nfoGenBIO-Win32-temps.c 0.0.1    UTF-8                         2025-12-16
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
*
*   NOTE: This exercise is specific to the Windows 10 configuration at
*         orcmid's personal computer.  Other Windows configurations may
*         be suitable; that is not being considered here.
*
*   -----------------------------------------------------------------------
*   Attribution: This program is co-pilot assisted.
*   -----------------------------------------------------------------------
*/

#include <io.h>
    /* for Microsoft-specific _mktemp_s() */

#include <stdint.h>

#include <stdio.h>

#include <stdlib.h>



int main( void )
{   /* The first test is to generate two temp names, confirming how the
       successive uses of a "template" work.

       Preference for _mktemp_s is that it generates just the file name
       and not a full path and all of that gunk. */

       fputs ( "[GenTemps] Temporary Filename Generation Experiment 0.0.1\n",
            stdout );

    char tmpname[ ] = "nfoGenBIOXXXXXX";

    errno_t err = _mktemp_s( tmpname, sizeof( tmpname ) );


    if ( err != 0 )
         {  printf( "           _mktemp_s ERRNO: %d\n", err );
            return EXIT_FAILURE;
            }

    printf( "           First temporary filename: %s\n", tmpname );

    errno_t err = _mktemp_s( tmpname, sizeof( tmpname ) );

    if ( err != 0 )
         {  printf( "           Second _mktemp_s ERRNO: %d\n", err );
            return EXIT_FAILURE;
            }

    printf( "           Second temporary filename: %s\n", tmpname );

    return EXIT_SUCCESS;
    } /* GenTemps */

/* XXX: Following the last read and closing of an input file, a remove
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

        Since I may need to use Windows-specific <direct.h> functions, and
        maybe have to look at settings, I may already be in a state of sin.
        */




/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

   0.0.1  2025-12-16T20:49Z Initial experiment with _mktemp_s.
   0.0.0  2025-12-16T18:09Z Initial placeholder.

                    *** end of nfoGenBIO-Win32-temps.c ***

   */
