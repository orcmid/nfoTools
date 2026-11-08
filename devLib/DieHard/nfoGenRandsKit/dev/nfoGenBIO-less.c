/* nfoGenBIO-less.c 0.0.1           UTF-8                         2026-11-08
/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
*              nfoGenBIO-less: LESS UTILITY FOR BINARY I/O FILES
*              -------------------------------------------------
*
*   This utility is part of the nfoGenRandKits devLib utilities for viewing
*   binary files containing 32-bit words, such as those produced by the
*   nfoGenBIO-emitting nfoGenRandsKit programs.
*
*   The output is written to stdout.  It does not assume anything about
*   console/terminal formatting beyond unadorned command shell output,
*   although a CUA version would be nice.
*
*   nfoGenBIO-less is based on the *nix "less" utility, designed to mimic
*   the basic approach without any requirement for options beyond a "help"
*   (/?) option.  However, it is more like a hex dump than a text crawl.  The
*   output is shown in 8-hex (32 bit) blocks reflecting the application
*   in random-number and hash development.
*   -----------------------------------------------------------------------
*    Attribution: This program is copilot assisted and scientist reviewed.
*   -----------------------------------------------------------------------
*
*   0.0.0 WARNING: This placeholder is derived from the nfoGenBIO-more utility
*         0.0.6 AND HAS NOT BEEN TRANSFORMED IN ANY SIGNIFICANT MANNER BELOW
*         THIS WARNING.  THIS IS A PLACEHOLDER FOR FURTHER CUSTOMIZATION.
*
* XXX: Based on the description for Linux, the fundamental difference between
*      less and more is where the presentation starts.  Here is one set of
*      commands for less:
*
*      Spacebar: Scroll down one screen.
*      b: Scroll up one screen.
*      Enter: Move down one line.
*      y: Move up one line.
*      g: Go to the start of the file.
*      G: Go to the end of the file.
*      10G: Go to the 10th line.
*      Ctrl+F: Scroll forward full screen.
*      Ctrl+B: Scroll backward full screen.
*
*    and see <https://github.com/gwsw/less>, especially
*    <https://github.com/gwsw/less/blob/master/less.hlp.
*    I have no desire to be so comprehensive.  
*/
#define MORE_VERSION "nfoGenBIO-less-0.0.0"

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

void usage()
{ /* Explain the usage */
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
     }


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

    /* XXX: Expand this to allow for /? and possible source as stated */
    /* XXX: Also, this needs more elaboration and should probably be done
            in a better place, perhaps a simple internal procedure */
    if ( argc < 2) 
         { usage();
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

    } /* main nfoGenBIO-more.c */

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
* 0.0.1  2026-11-08T17:03Z Gather some information on Unix less command usage
* 0.0.0  2026-10-29T20:43Z Initial placeholder version copied from
*        nfoGenBIO-more.c 0.0.6
*
*                     *** end of nfoGenBIO-less.c ***
*/
