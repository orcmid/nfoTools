/* testFlip.c 0.2.0                 UTF-8                       2025-10-13
* --|----1----|----2----|----3----|----4----|----5----|----6----|----7----*
*
*                 nfoFlip IMPLEMENTATION CONFIRMATION TEST
*                 ----------------------------------------
*
* testFlip confirms correct implementation of nfoFlip by testing for specific
* known results.  More details are provided in nfoFlip.c.
*
* testFlip is a transposition of the test_flip.c program published by Donald
* Knuth in the Literate Programming description of GB_FLIP, p. 216 §2, in "The
* Stanford GraphBase: A Platform for Combinatorial Computing".  See
* https://www-cs-faculty.stanford.edu/~knuth/sgb.html.
*
*/

#include <stdio.h>
#include <stdlib.h>

#include "nfoFlip.h"

int main(void)
{
    nfoFlipInit(-314159L);

    long first = nfoFlipNextRand();
    if (first != 119318998)
         { fputs("testFlip: Failure on the first try!\n", stderr);
           exit(-1);
           }

    for (int j = 1; j <= 133; j++) nfoFlipNextRand();

    if (nfoFlipUniformRand(0x55555555L) != 748103812)
         { fputs("testFlip: Failure on the second try!\n", stderr);
           exit(-2);
           }

    fputs("testFlip: OK, the nfoFlip routines seem to work.\n", stdout);

    exit(EXIT_SUCCESS);

    } /* main */

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

0.2.0 2025-10-13T22:15Z Adjust to current nfoFlip function names
0.1.1 2025-10-10T01:40Z Write fputs operands in correct order
0.1.0 2025-10-09T23:48Z Rename to the adjusted nfoFlip.h/c names
0.0.2 2025-20-08T23:04Z Makes the messages all of the same format
0.0.1 2025-10-07T21:31Z Added § for citing locations in GB_FLIP description.
0.0.0 2025-10-06-13:17Z Initial transposition based on Knuth's test_flip.c

                        *** end of testFlip.c ***

*/
