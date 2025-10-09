/* nfoFlip.c 0.0.4                  UTF-8                       2025-10-09
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
   // using the lagged-Fibonacci method.  Return FS[55], the first of the
   // new cycle.

   for (int i = 1; i <= 24; i++)
      FS[i] = mod_diff(FS[i + 31], FS[i]);

   for (int i = 25; i <= 55; i++)
      FS[i] = mod_diff(FS[i - 24], FS[i]);

   _nfo_pFS = &FS[54];       // Designate the second of the new cycle.

   return (FS[55]);          // Return the first of the new cycle.
   }

void nfoFlipInit(long seed)  // {§8}
{  // Initialize the FS[] array using the given seed.

   long prev, next = 1;

   seed = prev = mod_diff(seed, 0); // Strip off 2's complement sign bit

   FS[55] = prev;
   for (int i = 21; i; i = (i + 21) % 55)
       { FS[i] = next;
         /* Compute new next based on next, prev and seed §9 */
         next = mod_diff(prev, next);
         if (seed & 1)
              seed = 0x40000000 + (seed >> 1); // rotating seed right 1
         else seed = seed >> 1;
         next = mod_diff(next, seed);
         prev = FS[i];
         }

   /* Get the FS values "warmed up" §10 */
   nfoFlipCycle( );
   nfoFlipCycle( );
   nfoFlipCycle( );
   nfoFlipCycle( );
   nfoFlipCycle( );  // ending with _nfo_pFS = &FS[54]

   } /* nfoFlipInit */

long nfoUniformRand(long n)  // {§12}
{  // Generate a uniformly distributed random number in the range [0, n-1].

/* XXX: REVIEW THIS CO_OP SUGGESTION AGAINST {§12}

   long limit, x;

   if (n <= 1)
      return 0;  // trivial case

   limit = (0x7fffffff / n) * n; // largest limit < 2**31 that is a
                                  // multiple of n

   do
      x = nfoNextRand( );
   while (x >= limit);

   return (x % n);
*/
   }


/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

0.0.4 2025-10-09T03:54Z Introduce nfoRandomInit(), skeleton nfUniformRand().
0.0.3 2025-10-08T23:31Z Switch to _nfo_pfs and smooth nfoFlipCycle a bit.
0.0.2 2025-10-07T22:45Z Add mod_diff and nfoFlipCycle aided by Co-Pilot.
0.0.1 2025-10-07T21:52Z Use nfo_pFS instead of nfo_fptr. Use § section ids
0.0.0 2025-10-07T05:20Z Starting up.

                            *** end of nfoFlip.c ***

*/
