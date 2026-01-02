/* nfoGenAIO-Win32.c 0.4.0          UTF-8                         2026-02-01
** -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
*                   nfoGenAIO ASCII Transfer File Setup
*                   ------------------------------------
*
*   nfoGenAIO-Win32.c is a *platform-specific* component for nfoGenA`IO.  The
*   name identifies its encapsulation of Windows-specific functionality for
*   handling command-line redirections via the nfoGenAIO.h procedures.
*
*   The intention is accomodation of other platforms by distinctly-suffixed
*   file names on the same pattern, with compilation and linking done using
*   the appropriate nfoGenAIO-*.c file.
*   -----------------------------------------------------------------------
*   Attribution: This program is copilot assisted.
*   -----------------------------------------------------------------------
*/

#include <io.h>
    /* for Microsoft-specific _isatty() */

#include "nfoGenAIO.h"

#include <stdbool.h>
#include <stdio.h>

bool isGenAIO_terminal( FILE *fp )
    { /* Returns true if the given FILE* is associated with a terminal device
       * (console, terminal window, etc.) rather than a disk file or pipe.
       *    Note that stdin and stdout may be associated with terminal devices
       * or with files or pipes, depending on how the program is run.
       *    Bye convention, stderr is presumed to be a terminal device, but
       * it is not necessary to check if that is the actual case for the
       * intended applications of nfoGenAIO.
       */

        if ( fp == NULL ) return false;
        if (_fileno( fp ) <0) return false;
        return (_isatty( _fileno(fp )) != 0 );
        }


FILE* nfoGenAIO_startOutput( char *template, int templateSize)
    { /* Generate a temporary file name based on template, open it for ASCII
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
       * See nfoGenAIO.h for further information.
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

        if (fopen_s(&temp1, template, "w+" ) != 0 ) return NULL;

        return temp1;

        } /* nfoGenAIO_startOutput */


/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

0.4.0  2026-01-02T20:46Z Synchronize version with nfoGenAIO.h
0.1.0  2026-01-02T20:39Z Transpose from nfoGenBIO-Win32.c

                       *** end of nfoGenAIO-Win32.c ***

   */
