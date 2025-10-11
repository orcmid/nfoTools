/* nfoFlip.h 0.0.5                  UTF-8                       2025-10-08
* --|----1----|----2----|----3----|----4----|----5----|----6----|----7----*
*
*              nfoFlip LAGGED-FIBONACCI PSEUDO-RANDOM NUMBERS
*              ----------------------------------------------
*
* nfoFlip is a transposition of the Literate Programming GB_FLIP program
* by Donald Knuth in pp. 216-221 of "The Stanford GraphBase: A Platform for
* Combinatorial Computing", Addison-Wesley (Reading MA, 1993).  See
* <https://www-cs-faculty.stanford.edu/~knuth/sgb.html>.
*
* XXX: Explain that nfoFlip functions are not thread-safe and also say a
* little bit about reproducibility.
*
* The §-numbers refer to sections in the GB_FLIP text from which the code is
* derived.
*/

void nfoFlipInit(long seed); // §11

extern long * _nfo_pFS;  // pointer into the nfoFlip state array FS[] §6
/* _nfo_pFS is managed privately by nfoFlip.c in support of the high-
   performance macro nfoNextFlip() defined below. It is initialized by
   nfoFlipInit and updated in operation of nfoNextFlip, nfoFlipCycle, and
   nfoUniformFlip.  It must not be accessed directly by user code.
   */

#define nfoNextFlip( ) (*_nfo_pFS >= 0 ? *_nfo_pFS-- : nfoFlipCycle( ))
/* nfoNextFlip is a high-performance macro for delivering the next number
   from a pre-computed array or, if necessary, from a new cycle of the array.
   */

long nfoFlipCycle(void); // used to advance FS[] to a fresh set of values §6
/* nfoFlipCycle is used automatically by nfoNextFlip and other operations
   of nfoFlip.  It can also be used to "stir the pot", generating a fresh
   block of values and delivering the first of them.
   */

long nfoUniformFlip(long n); // §13
// Generate a uniformly distributed random number in the range [0, n-1].



/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

0.1.0 2025-10-09T23:41Z Rename to consistent nfoFlipInit( ) and nfoNextFlip( )
0.0.4 2025-10-08T23:32Z Switch to _nfo_pFS and rework comments.
0.0.3 2025-10-07T23:35Z Add §s and describe nfoUniformRand( ).
0.0.2 2025-10-07T23:06Z Touch-up
0.0.1 2025-10-07-21:48Z Use nfo_pFS instead of nfo_fptr.
0.0.0 2025-10-07-01:01Z Placeholder with draft starters.

                        *** end of nfoFlip.h ***

*/
