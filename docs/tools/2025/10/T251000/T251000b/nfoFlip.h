/* nfoFlip.h 0.0.3                  UTF-8                       2025-10-07
* --|----1----|----2----|----3----|----4----|----5----|----6----|----7----*
*
*              nfoFlip LAGGED-FIBONACCI PSEUDO-RANDOM NUMBER
*              ---------------------------------------------
*
* nfoFlip is a transposition of the gbflip.c program published by Donald
* Knuth in the Literate Programming description of GB_FLIP, pp. 216-221 in
* "The Stanford GraphBase: A Platform for Combinatorial Computing".  See
* https://www-cs-faculty.stanford.edu/~knuth/sgb.html.
*/


void nfoInitRand(long seed); // §11

extern long * nfo_pFS;  // pointer into the nfoFlipState array §6
// XXX Explain how this pointer is always to the next random number in
//     the array, the generated numbers are always non-negative, and
//     the first element is always -1 to cause a new cycle to be
//     generated.  Elements are always consumed backwards from the
//     end of the array.

#define nfoNextRand( ) (*nfo_pFS >= 0 ? *nfo_pFS-- : nfoFlipCycle( ))

long nfoFlipCycle(void); // §6
// XXX To avoid failing the birthday spacing test, this function should
// be called twice in nfoNextRand().  See GB_FLIP §6.


long nfoUniformRand(long n); // §13
// Generate a uniformly distributed random number in the range [0, n-1).



/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

0.0.3 2025-10-07T23:35Z Add §s and describe nfoUniformRand( ).
0.0.2 2025-10-07T23:06Z Touch-up
0.0.1 2025-10-07-21:48Z Use nfo_pFS instead of nfo_fptr.
0.0.0 2025-10-07-01:01Z Placeholder with draft starters.

                        *** end of nfoFlip.h ***

*/
