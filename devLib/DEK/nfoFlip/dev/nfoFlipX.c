/* nfoFlipX.c 0.3.2                  UTF-8                       2025-10-15
* --|----1----|----2----|----3----|----4----|----5----|----6----|----7----*
*
*             nfoFlip LAGGED-FIBONACCI PSEUDO-RANDOM NUMBERS
*             ----------------------------------------------
*
* nfoFlip is a transposition of the Literate Program GB_FLIP presented by
* Donald Knuth in pp. 216-221 of "The Stanford GraphBase: A Platform for
* Combinatorial Computing", Addison-Wesley (Reading MA, 1993).  See
* <https://www-cs-faculty.stanford.edu/~knuth/sgb.html> where the original
* CWEB code is available.  <https://github.com/ascherer/sgb> is a GitHub
* repository of that source provided and maintained by Andreas Scherer.
*
* The §n section numbers refer to sections in the GB_FLIP text from which
* nfoFlip is derived.
*/

#include "nfoFlip.h"

static long FS[56] = { -1 };  // {§4}
   // Elements FS[55] to FS[1] are values of the current state from which
   // numbers are taken in decreasing index order. FS[0] is always -1 to
   // force detection that the list has been exhausted and a new cycle must be
   // generated.

extern long *_nfo_pFS = &FS[0];  // {§5 §6}
   // Pointer at the FS[i] having the next generated number to be used.
   // When *_nfo_pFS is -1, the list is exhausted and a new cycle must be
   // generated.  See nfoFlipNextRand() in nfoFlip.h.

#define mod_diff(x,y) (((x)-(y)) & 0x7fffffff)
   // Compute (x - y) mod 2**31 for new elements of the FS[] array.
   // XXX: This version presumes 2's complement arithmetic. For a more general
   //      solution, see GB_FLIP §7.

long nfoFlipCycle(void)  // {§7}
{  // Generate a new cycle of 55 pseudo-random numbers in the FS[] array
   // using the lagged-Fibonacci method.  Return FS[55], the first of the
   // new cycle.

   for (int i = 1; i <= 24; i++)
      FS[i] = mod_diff(FS[i], FS[i+31]);
   for (int i = 25; i <= 55; i++)
      FS[i] = mod_diff(FS[i], FS[i-24]);
        // XXX Delegating GB_FLIP pointer tricks to compiler optimization.

   _nfo_pFS = &FS[54];       // Designate the second of the new cycle.

   return (FS[55]);          // Return the first of the new cycle.
   }

void nfoFlipInit(long seed)  // {§8}
{  // Initialize the FS[] array using the given seed.

   long prev, next = 1;

   seed = prev = mod_diff(seed, 0); // XXX: Strip off 2's complement sign bit

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

   } /* nfoInitFlip */


long nfoFlipUniformRand(long m)  // {§12}
{  // Generate a uniformly distributed random number in the range [0, m-1].

   #define twoTo31 ((unsigned long) 0x80000000)

   unsigned long t = twoTo31 - (twoTo31 % m);
      // the largest multiple of m not exceeding 2**31, a uniform block of
      // m cases


   long r;

   if (m < 1) return 0; // avoid nonsense

   do { r = nfoFlipNextRand(); }
      while (t <= (unsigned long) r);

   return (r % m);
   }

/* TODO Improve when the same m is used repeatedly. See how much better
        speedFlip works.
        */

/* TODO See if can improve the need to do casts and still get the loop to
   work properly.
   */

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

0.3.2 2025-10-15T17:30Z Make experimental version for performance improvement.
0.3.1 2025-10-14T05:06Z Adjust TODOs based on speedFlip results.
0.3.0 2025-10-13T22:10Z Use consistent nfoFlipForm naming, smooth comments.
0.2.0 2025-10-10T01:37Z Repair nfoFlipCycle() to match GB_FLIP correctly
0.1.2 2025-10-09T23:53Z Correct to nfoNextFlip() in nfoUniformFlip()
0.1.1 2025-10-09T23:44Z Rename to nfoInitFlip() for some consistency
0.1.0 2025-10-09T23:23Z Add nfoUniformRand(),complete GB_FLIP transposition.
0.0.4 2025-10-09T03:54Z Introduce nfoRandomInit(), skeleton nfUniformRand().
0.0.3 2025-10-08T23:31Z Switch to _nfo_pfs and smooth nfoFlipCycle a bit.
0.0.2 2025-10-07T22:45Z Add mod_diff and nfoFlipCycle aided by Co-Pilot.
0.0.1 2025-10-07T21:52Z Use nfo_pFS instead of nfo_fptr. Use § section ids
0.0.0 2025-10-07T05:20Z Starting up.

                            *** end of nfoFlipX.c ***

*/
