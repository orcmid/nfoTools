/* nfoGenBIO-Win32-temps.c 0.1.1    UTF-8                         2025-12-20
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
*         be suitable; that is not being considered here.  The solution
*         in nfoGenBIO-Win32.c shall be portable to other Windows only.
*
*   Without decoration, _mktemp_s( ) generates files names based on what
*   ones are already opened.  This is no problem for nfoGenBIO, for which
*   multiple files are not opened.  There may be a problem about what ones
*   exist, so there is a small likelihood of collision with existing files
*   on an open.  So long as the temporary files are deleted after use,
*   this should not be a problem.
*
*   The default location for _mktemp_s( ) is the current working directory.
*   This may be good enough.
*
*   If the prefix begins with "\\", the root of the current working drive
*   is used.  Not so great.  But "dir\\.." seems to work fine, putting the
*   temporary files in a folder beneath the current working directory.
*
*   The prefix can contain `/`, interchangeable with `\\`, allowing some
*   platform-independence in the usage, although this is a Windows-specific
*   implementation.
*
*   The template is a string that must contain a six trailing "XXXXXX" without
*   any extension.  If that pattern is not satisfied, _mktemp_s( ) crashes
*   out of the program.
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
       and not a full path and all of that gunk, unless in the template */

       fputs ( "[GenTemps] Temporary Filename Generation Experiment 0.1.1\n",
            stdout );

    #define TEMPLATE "grt/nfoGenBIOXXXXXX"
            /* Note platform neutral use of `/`*/

/* ATTEMPT CONTROLLING DIRECTORY */

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

    fputs( "[GenTemps] This is a temporary file created for nfoGenBIO\n"
           "           created at ", temp1);
    fputs( tmpname, temp1);
    fputs( "\n", temp1);

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

    fputs( "[GenTemps] This is a temporary file created for nfoGenBIO\n"
           "           created at ", temp2);
    fputs( tmpname, temp2);
    fputs( "\n", temp1);

    /* CLEAN UP */

    fclose( temp1 );
    fclose( temp2 );

    return EXIT_SUCCESS;
    } /* GenTemps */

/* XXX:

        The descriptions of these for the VC/C++ Windows run-time library
        are pretty awful and also unclear.

        I'm going to start with simple tests to see what all of this does
        and now to get control of it, especially with regard to choosing
        the file locations in some simple way.

        Since I may need to use Windows-specific <direct.h> functions, and
        maybe have to look at settings, Shucks, I already be in a state of sin
        because I am using <io.h> for _mktemp_s( ).
        */


/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

   0.1.1  2025-12-20T23:09Z Touch up and demonstrate `/` in template.
   0.1.0  2025-12-17T23:29Z The final successful test form.
   0.0.8  2025-12-17T23:21Z Adding .bin extension to template fails..
   0.0.7  2025-12-17T23.11Z Confirmed template beginning with "grt\\".
   0.0.6  2025-12-17T22.58Z Successful try of "\\" beginning a template.
   0.0.5  2025-12-16T22:52Z Open and write both temp files.
   0.0.4  2025-12-16T21:20Z Spell strcpy_s and #include <string.h>.
   0.0.3  2025-12-16T21:17Z Refresh the template before second use.
   0.0.2  2025-12-16T21:02Z Eliminated double declaration of err
   0.0.1  2025-12-16T20:49Z Initial experiment with _mktemp_s.
   0.0.0  2025-12-16T18:09Z Initial placeholder.

                    *** end of nfoGenBIO-Win32-temps.c ***

   */
