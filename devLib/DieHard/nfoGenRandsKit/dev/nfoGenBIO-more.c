/* nfoGenBIO-more.c 0.0.1           UTF-8                         2025-12-26
/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
*              nfoGenBIO-more: MORE UTILITY FOR BINARY I/O FILES
*              -------------------------------------------------
*
*   This utility is part of the nfoGenRandKits devLib utilities for viewing
*   binary files containing 32-bit words, such as those produced by the
*   nfoGenBIO-emitting nfoGenRandsKit programs.
*
*   The output is written to stdout.  It does not assume anything about
*   console/terminal formatting beyond unadorned command shell output,
*   although a CUA version would be nice.
*   -----------------------------------------------------------------------
*    Attribution: This program is copilot assisted and scientist reviewed.
*   -----------------------------------------------------------------------
*/
#define MORE_VERSION "nfoGenBIO-more-0.0.0"

#include  <stdio.h>
#include  <stdint.h>
#include  <stdlib.h>

#include  "nfoGenAIO.h"

#define test2words 4096

int main( int argc, char )

{
    uint32_t  test2[ test2words+9 ] = { 0 }; /* protection buffer*/

    /* XXX: We need a different buffer size corresponding to what goes nice
            on a 24-line display.  That will be the chunk size. I'm thinking
            about doing 8 words per line in a kind of dump format with
            spaces between the words.  That gives room for addresses but
            not for any ASCII representation.  I need to work in nice powers
            of two for the words per line and lines per screen.  So 16 lines
            looks like the chunk size.  16 lines * 64 bytes = 256 bytes.
            Nice number.

       XXX: We need to deal with cases where the last chunk is not full and
            it is not any multiple of 8 bytes.
            */

    fputs("\n[more] " MORE_VERSION " some-thing, something\n",
          stdout );
    /* XXX: The input filename needs to be known befure we can report the
            input, so this output is needed but needs to be simpler.
            */

/* XXX: We need to provide the help display or get the name of the input
        file from the command line.
        */
    int wordsRead = nfoGenAIO_read( test2, test2words, stdin );

    if ( !wordsRead )
         { fputs( "\n\n        NO WORDS WERE RETURNED.\n", stderr );
           if ( feof( stdin ) )
                fputs( "        FAILURE: EOF on read.\n", stderr );
           if ( ferror( stdin ) )
                fputs( "        FAILURE: ERROR on read.\n", stderr );

           clearerr( stdin ); /* even if not the problem*/

           return EXIT_FAILURE;
           }


    /* SOME WORDS WERE READ.  SHOW WHAT THEY WERE. */
    /* This mimics the procedure of nfoGenAIO-test1.c */

    fprintf(stderr, "\n\n        %d words were read. Here they come.\n\n",
            wordsRead );

    int written = nfoGenAIO_write( test2, wordsRead, stdout );

    if ( written == wordsRead )
         { fputs( "\n\n        CORRECT? Please check visually.\n",
                  stderr );
           return EXIT_SUCCESS;
           }

    if ( written == EOF )
         { fputs("\n\n        FAILURE: EOF output result.\n", stderr );
           return EXIT_FAILURE;
           }

    if ( written == 0)
         { fputs("\n\n       FAILURE: 0 written ERROR condition.\n", stderr );
           return EXIT_FAILURE;
           }

    fprintf(stderr, "\n\n       FAILURE: Only %d of %d words written.\n",
            written, wordsRead );
    return EXIT_FAILURE;

    } /* nfoGenAIO-test2.c */

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
* 0.0.1  2025-12-26T18:39Z Add noodling comments and a bit of structure.
* 0.0.0  2025-12-26T18:10Z Grab nfoGenAIO-test2.c 0.1.1 to pillage for more.
*
*                     *** end of nfoGenBIO-more.c ***
*/
