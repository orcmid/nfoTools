/* nfoGenBIO-Win32.c 0.1.1          UTF-8                         2025-12-29
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

#include <io.h>
    /* for Microsoft-specific _mktemp_s() */

#include "nfoGenBIO.h"

#include <stdbool.h>
#include <stdio.h>

bool isGenBIO_terminal( FILE *fp )
    { /* Returns true if the given FILE* is associated with a terminal device
       * (console, terminal window, etc.) rather than a disk file or pipe.
       *    Note that stdin and stdout may be associated with terminal devices
       * or with files or pipes, depending on how the program is run.
       */

        if ( fp == NULL ) return false;
        if (_fileno( fp ) <0) return false;
        return (_isatty( _fileno(fp )) != 0 );
        }


FILE* nfoGenBIO_startOutput( char *template, int templateSize)
    { /* Generate a temporary file name based on template, open it for binary
       * writing, and return the FILE* for the opened file. The template
       * string is replaced with the created filename.
       *
       * If template is NULL or the string is in incorrect format, NULL is
       * returned.
       *
       * If the generated filename cannot be opened for writing, NULL is also
       * returned.

       * When NULL is returned, the value of template is not predictable. It
       * should be considered mutilated and not usable.
       *
       * See nfoGenBIO.h for further information.
       */

       if ( template == NULL || templateSize < 7 )  return NULL;
            /* template[ ] must be an ASCII string for at least "XXXXXX"
               including the '\0' terminator
               */

        /* Guard to ensure final "XXXXXX"
           */
        int guardIndex = templateSize;
        if  (    template[--guardIndex] != `\0`
              || template[--guardIndex] != 'X'
              || template[--guardIndex] != 'X'
              || template[--guardIndex] != 'X'
              || template[--guardIndex] != 'X'
              || template[--guardIndex] != 'X'
              || template[--guardIndex] != 'X'
              )
            return NULL;

        errno_t err = _mktemp_s( template, templateSize );

        if ( err != 0 ) return NULL;

        FILE* temp1;

        if (fopen_s(&temp1, template, "wb+" ) != 0 ) return NULL;

        return temp1;

        } /* nfoGenBIO_startOutput */






/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

0.1.1  2025-12-29T20:18Z Add isGenBIO_terminal( ) implementation.
0.0.6  2025-12-22T19:29Z Tie to nfoGenBIO.h
0.0.4  2025-12-20T23:37Z Add guard-check on "XXXXXX" ending the template
0.0.3  2025-12-20T01:50Z Add nfoGenBIO_startOutput( ) implementation.
0.0.2  2025-12-16T05:29Z More pondering
0.0.1  2025-12-14T17:41Z More thinking outloud. copilot attribution.
0.0.0  2025-12-13T21:13Z Initial placeholder.

                       *** end of nfoGenBIO-Win32.c ***

   */
