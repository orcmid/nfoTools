/* nfoGenAIO-test2.c 0.1.1          UTF-8                         2025-12-04
/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
*                    TEST 2: nfoGenAIO ASCII OUTPUT
*                    ------------------------------
*
*   This test accepts a reasonably-sized input under 4096 words and, if the
*   read is successful, reports the number read and then writes them to
*   output in the same form produced by nfoGenAIO_write().
*
*   The test output is written to stdout, which may be redirected or piped
*   as desired for further processing.
*/
#define TEST_VERSION "nfoGenAIO-test2-0.1.1"

#include  <stdio.h>
#include  <stdint.h>
#include  <stdlib.h>

#include  "nfoGenAIO.h"

#define test2words 4096

int main(void)
{
    uint32_t  test2[ test2words+9 ] = { 0 }; /* protection buffer*/

    fputs("\n[test2] " NFOGENAIO_VERSION " testing via " TEST_VERSION "\n\n",
          stderr );

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
* 0.1.1  2025-12-05T02:58Z Output formatting touch-up
* 0.1.0  2025-12-04T00:27Z Adaptation from nfoGenAIO-test1.c to test
*
*                  *** end of nfoGenAIO-test2.c ***
*/
