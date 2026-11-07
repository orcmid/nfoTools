/* nfoGenBIO-Win32-io-check.c 0.0.1 UTF-8                         2026-11-07
** -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
*                nfoGenBIO Win32 Binary File Handling Checks
*                -------------------------------------------
*
*   nfoGenBIO-Win32-io-check.c is a *platform-specific* exercise to determine
*   how Win32 <io.h> functions and definitions apply for x64 Windows-specific
*   builds.
*
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

   0.0.1  2026-11-07T16:23Z Placeholder copy of nfoGenBIO-Win32-temps.c 0.1.1
   
               *** end of nfoGenBIO-Win32-io-check.c ***

   */
