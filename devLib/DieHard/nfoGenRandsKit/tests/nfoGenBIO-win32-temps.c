/* nfoGenBIO-Win32-temps.c 0.0.5    UTF-8                         2025-12-16
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

#include <string.h>



int main( void )
{   /* The first test is to generate two temp names, confirming how the
       successive uses of a "template" work.

       Preference for _mktemp_s is that it generates just the file name
       and not a full path and all of that gunk. */

       fputs ( "[GenTemps] Temporary Filename Generation Experiment 0.0.5\n",
            stdout );

    #define TEMPLATE "nfoGenBIOXXXXXX"

/* MAKE FIRST TEMP FILE */

    char tmpname[ ] = TEMPLATE;

    errno_t err = _mktemp_s( tmpname, sizeof( tmpname ) );


    if ( err != 0 )
         {  printf( "           _mktemp_s ERRNO: %d\n", err );
            return EXIT_FAILURE;
            }

    printf( "           First temporary filename: %s\n", tmpname );

    /* The template has been modified by this first call to _mktemp_s.
       If this name is not used, resubmitting the same template will not
       result in a new name.
       */

    FILE* temp1;
    if (fopen_s(&temp1, tmpname, "w" ) != 0 )
        {  printf( "           Unable to create: %s\n", tmpname);
           return EXIT_FAILURE;
           }

    printf( "           %s opened successfully.\n\n", tmpname );

    fputs( "[GenTemps] This is a temporary file created for nfoGenBIO.\n"
           "           Find where I am created :)!\n",
           temp1 );

/* MAKE SECOND TEMP FILE */


    strcpy_s( tmpname, sizeof( tmpname ), TEMPLATE );
       /* resetting the template for second use */

    err = _mktemp_s( tmpname, sizeof( tmpname ) );

    if ( err != 0 )
         {  printf( "           Second _mktemp_s ERRNO: %d\n", err );
            return EXIT_FAILURE;
            }

    printf( "           Second temporary filename: %s\n", tmpname );

    FILE* temp2;
    if (fopen_s(&temp2, tmpname, "w" ) != 0 )
        {  printf( "           Unable to create: %s\n", tmpname );
           return EXIT_FAILURE;
           }

    printf( "           %s opened successfully.\n\n", tmpname );

    fputs( "[GenTemps] This is a temporary file created for nfoGenBIO.\n"
           "           Find where I am created :)!\n",
           temp2 );

    /* CLEAN UP */

    fclose( temp1 );
    fclose( temp2 );

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


   0.0.5  2025-12-16T22:52Z Open and write both temp files.
   0.0.4  2025-12-16T21:20Z Spell strcpy_s and #include <string.h>.
   0.0.3  2025-12-16T21:17Z Refresh the template before second use.
   0.0.2  2025-12-16T21:02Z Eliminated double declaration of err
   0.0.1  2025-12-16T20:49Z Initial experiment with _mktemp_s.
   0.0.0  2025-12-16T18:09Z Initial placeholder.

                    *** end of nfoGenBIO-Win32-temps.c ***

   */
