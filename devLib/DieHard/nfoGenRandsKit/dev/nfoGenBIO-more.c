/* nfoGenBIO-more.c 0.0.4           UTF-8                         2025-12-29
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
#define MORE_VERSION "nfoGenBIO-more-0.0.4"

#include  <stdbool.h>
#include  <stdint.h>
#include  <stdio.h>
#include  <stdlib.h>
#include  <string.h>

#include  "nfoGenAIO.h"
#include  "nfoGenBIO.h"

#define wordsChunk (16*8)
    /* The number of uint32 words that are converted to 16 lines of 8 words
       each. The blocks of 4096 words used for DieHard will take 32 chunks
       each.  Chunk byte offsets will always be multiples of 512 (0x200)*/

#define bytesChunk (wordsChunk*4)
    /* This is needed for chunk-offset positioning of the input and for
       identification of chunk lines in the output. */


int main( int argc, char *argv[] )

{
    uint32_t chunk[ wordsChunk+9 ] = { 0 }; /* with protection buffer*/
         /* One buffer for presenting 16 lines of 8 words each*/

    /* Choosing a chunk size corresponding to what goes nice on a 24-line
       80-column display with room for offset numbers but not any kind of
       ASCII representation.
       */

    fputs("\n[more] " MORE_VERSION " Viewer for binary data-file chunks.\n",
          stdout );

    /* XXX: We need to provide the help display or get the name of the input
            file from the command line.
            We might want to see if stdin is a pipe when no filename is given.
            This will take some testing to see if binary data can be piped
            reliably.
        */

    /* XXX: Expand this to allow for /* and possible source as stated */
    if ( argc < 2)
         {  /* Provide Help Information when no input file is specified */}
            fputs( "\n       USAGE: nfoGenBIO-more [/? | source]"
                   "\n              where [source] is the filename of a binary"
                   "\n              file in DieHard acceptable format."
                   "\n              If omitted, stdin is used (piped input)."
                   "\n              SPACE or ENTER to advance 16 lines,"
                   "\n              BACKSPACE to go back 16 lines,"
                   "\n              ^S and ^Q to start and stop scrolling "
                                   "chunks,"
                   "\n              ^C, or ^D to quit\n\n",
                   stderr )
            exit( EXIT_SUCCESS );
            }

    /* Assume we have a valid filename for input
       XXX: This is where we need to be able to check for stdin being
            piped, just as with the regular "more" utility.
            */

    FILE* fp = nfoGenBIO_startInput( argv[1], strlen_s( argv[1],
                                                        FILENAME_MAX  )
                                     );

    if ( fp == NULL )
         { fputs( "\n\n       FAILURE: Cannot open input file.\n", stderr );
           exit( EXIT_FAILURE );
            }

    /* SETUP TO READ THE FILE */

    u32int_t fileOffset = 0; /* byte offset of next chunk */

    do { /* Run through the chunks*/
         size_t wordsRead = nfoGenBIO_read( chunk, wordsChunk, fp );

         if ( !wordsRead )
              { /* No (more) data - report status */

                if ( fileOffset )
                     { /* there had been input */
                          if (feof( fp ))
                               {  /* report how far we got */
                                  fprintf( stderr,
                                           "\n        %d words read up to "
                                           "byte offset 0x%08X.\n\n",
                                           fileOffset/4, fileOffset-1 );
                                  exit( EXIT_SUCCESS );
                                  }
                         if (ferror)
                         {
                            /* code */
                         }


                 )  }
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
*(0.0.4  2025-12-29T19:30Z Fix help message and add stdin piping note.)
* 0.0.3  2025-12-28T20:41Z Start fleshing command-line handling and finding
*        the input file.
* 0.0.2  2025-12-26T21:02Z Start fleshing out main program structure.
* 0.0.1  2025-12-26T18:39Z Add noodling comments and a bit of structure.
* 0.0.0  2025-12-26T18:10Z Grab nfoGenAIO-test2.c 0.1.1 to pillage for more.
*
*                     *** end of nfoGenBIO-more.c ***
*/
