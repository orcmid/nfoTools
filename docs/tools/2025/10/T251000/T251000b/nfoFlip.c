/* nfoFlip.c 0.0.0                  UTF-8                       2025-10-07
* --|----1----|----2----|----3----|----4----|----5----|----6----|----7----*
*
*             nfoFlip LAGGED-FIBONACCI PSEUDO-RANDOM NUMBERS
*             ----------------------------------------------
*
* nfoFlip is a transposition of the CB_FLIP.c routine published as a Literate
* Programming module on pp. 216-221 of "Stanford GraphBase: A Platform for
* Combinatorial Computing" Addison-Wesley (Reading,MA: 1993).
* See [Knuth1993b](https://orcmid.github.io/bib/compsci.htm#Knuth1993b)
* and also <https://www-cs-faculty.stanford.edu/~knuth/sgb.html>.
*
*/

#include "nfoFlip.h"

static long A[56] = { -1 };  // {4}
   // Elements A[55] to A[1] are values of the current state from which
   // numbers are taken, in decreasing index order. A[0] is always -1 to force
   // detection that the list has been exhausted and a new cycle must be
   // generated.

extern long *nfo_fptr = &A[0];  // {6}
   // Pointer at the A[i] having the next generated number to be used.
   // When *nfo_fptr is -1, the list is exhausted and a new cycle must be
   // generated.

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

   0.0.0 2025-10-07T05:20Z Starting up.

                            *** end of nfoFlip.c ***

*/
