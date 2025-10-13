/* nfoFlip.h 0.1.1                  UTF-8                       2025-10-13
* --|----1----|----2----|----3----|----4----|----5----|----6----|----7----*
*
*              nfoFlip LAGGED-FIBONACCI PSEUDO-RANDOM NUMBERS
*              ----------------------------------------------
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
*
* WARNING: nfoFlip is not thread-safe.  A single instance cannot be safely
*    used by multiple threads in the same application.
*
* STABILITY: nfoFlip procedures nfoFlipInit, nfoFlipNextRand, and
*     nfoFlipUniformRand provide the same functions as the GB_FLIP procedures
*     gb_init_rand, gb_next_rand, and gb_uniform_rand, respectively.  This
*     means that
*      - nfoFlip is a drop-in alternative for GB_FLIP in other programs
*      - the same sequences of nfoFlipInit, nfoFlipNextRand, and
*        nfoFlipUniformRand with the same seed will yield an identical
*        sequence of results.
*/

void nfoFlipInit(long seed); // §11
/* TODO: Recommend seed choices, and using the same seed for reproducibility
   */

extern long * _nfo_pFS;  // §5 pointer into the nfoFlip state array.
/* _nfo_pFS is managed privately by nfoFlip.c in support of the high-
   performance macro nfoFlipNextRand() defined below. It must not be used directly in user code.
   */

#define nfoFlipNextRand( ) (*_nfo_pFS >= 0 ? *_nfo_pFS-- : nfoFlipCycle( ))
/* §6 nfoFlipNextRand is a high-performance macro for delivering the next
   from a pre-computed array or, if necessary, from a new cycle of the array.
   */

long nfoFlipCycle(void); // used to advance FS[] to a fresh set of values §6
/* nfoFlipCycle is used automatically by nfoFlipNextRand and other operations
   of nfoFlip.  It can also be used to "stir the pot", generating a fresh
   block of values and delivering the first of them.
   */

long nfoFlipUniformRand(long n); // §13
// Generate a uniformly distributed random number in the range [0, n-1].
// When n < 1, 0 is returned.



/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

0.1.1 2025-10-13T22:01Z Use consistent nfoFlipForm naming, smooth comments.
0.1.0 2025-10-09T23:41Z Rename to consistent nfoFlipInit( ) and nfoNextFlip( )
0.0.4 2025-10-08T23:32Z Switch to _nfo_pFS and rework comments.
0.0.3 2025-10-07T23:35Z Add §s and describe nfoUniformRand( ).
0.0.2 2025-10-07T23:06Z Touch-up
0.0.1 2025-10-07-21:48Z Use nfo_pFS instead of nfo_fptr.
0.0.0 2025-10-07-01:01Z Placeholder with draft starters.

                        *** end of nfoFlip.h ***

*/
