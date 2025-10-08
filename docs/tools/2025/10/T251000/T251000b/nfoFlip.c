/* nfoFlip.c 0.0.3                  UTF-8                       2025-10-08
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

static long FS[56] = { -1 };  // {§4}
   // Elements FS[55] to FS[1] are values of the current state from which
   // numbers are taken, in decreasing index order. FS[0] is always -1 to
   // force detection that the list has been exhausted and a new cycle must be
   // generated.

extern long *_nfo_pFS = &FS[0];  // {§5 §6}
   // Pointer at the FS[i] having the next generated number to be used.
   // When *_nfo_pFS is -1, the list is exhausted and a new cycle must be
   // generated.

#define mod_diff(x,y) (((x)-(y)) & 0x7fffffff)
   // Compute (x - y) mod 2**31 for new elements of the FS[] array.
   // XXX: This version presumes 2's complement arithmetic. For a more general
   //      solution, see GB_FLIP §7.

long nfoFlipCycle(void)  // {§7}
{  // Generate a new cycle of 55 pseudo-random numbers in the FS[] array
   // using the lagged-Fibonacci method.  Return the first to be delivered in
   // the new cycle, FS[55].

   for (int i = 1; i <= 24; i++)
      FS[i] = mod_diff(FS[i + 31], FS[i]);

   for (int i = 25; i <= 55; i++)
      FS[i] = mod_diff(FS[i - 24], FS[i]);

   _nfo_pFS = &FS[54];       // Designate the second of the new cycle.

   return (FS[55]);          // Return the first of the new cycle.
   }


/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

0.0.3 2025-10-08T23:31Z Switch to _nfo_pfs and smooth nfoFlipCycle a bit.
0.0.2 2025-10-07T22:45Z Add mod_diff and nfoFlipCycle aided by Co-Pilot.
0.0.1 2025-10-07T21:52Z Use nfo_pFS instead of nfo_fptr. Use § section ids
0.0.0 2025-10-07T05:20Z Starting up.

                            *** end of nfoFlip.c ***

*/
