/* nfoGenAIO-test1.c 1.0.0          UTF-8                         2025-12-03
/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
*                    TEST 1: nfoGenAIO ASCII OUTPUT
*                    ------------------------------
*
*   This test does some simple output cases to verify the correct results
*   consisting of simple word patterns in 8-character hexadecimal. It should
*   be easy to sightcheck the output.  When successful, this test is also a
*   nice one to pipe into a test of nfoGenAIO_read().
*
*   The test output is written to stdout, which may be redirected or piped
*   as desired for further processing.
*/
#define TEST_VERSION "nfoGenAIO-test1-1.0.0"

#include  <stdio.h>
#include  <stdint.h>
#include  <stdlib.h>

#include  "nfoGenAIO.h"

int main(void)
{
    uint32_t  test1[ ]
              = { 0x00000000, 0x11111111, 0x22222222, 0x33333333, 0x44444444,
                  0x55555555, 0x66666666, 0x77777777, 0x88888888, 0x99999999,
                  0xAAAAAAAA, 0xBBBBBBBB, 0xCCCCCCCC, 0xDDDDDDDD, 0xEEEEEEEE,
                  0xFFFFFFFF, 0x80000000, 0x7FFFFFFF, 0x01234567, 0x89ABCDEF,
                  0xFEDCBA98, 0x76543210
                  };

    int test1words = sizeof(test1)/sizeof(test1[0]);

    fputs("\n[test1] " NFOGENAIO_VERSION " testing via " TEST_VERSION "\n\n",
          stderr );

    int written = nfoGenAIO_write( test1, test1words, stdout );

    if ( written == test1words )
         { fputs( "\n\n       SUCCESS? All words written. "
                  "Please check them visually or by nfoGenAIO_read().\n",
                  stderr );
           return EXIT_SUCCESS;
           }

    if ( written == EOF )
         { fputs("\n\n       FAILURE: EOF result.\n", stderr );
           return EXIT_FAILURE;
           }

    if ( written == 0)
         { fputs("\n\n       FAILURE: 0 result ERROR condition.\n", stderr );
           return EXIT_FAILURE;
           }

    fprintf(stderr, "\n\n       FAILURE: Only %d of %d words written.\n",
            written, test1words );
    return EXIT_FAILURE;

    } /* nfoGenAIO-test1.c */

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
* 1.0.0  2025-12-03T00:56Z Finalized with adjusted messages.
* 0.0.2  2025-12-03T00:48Z Complete test and result messages.
* 0.0.1  2025-12-02T23:01Z After simple fix here, perfectly clean compile !!
* 0.0.0  2025-12-02T22:58Z Stub version to get minimal compile error checking.
*
*                  *** end of nfoGenAIO-test1.c ***
*/
