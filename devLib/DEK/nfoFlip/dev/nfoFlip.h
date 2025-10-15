/* nfoFlip.h 0.1.5                  UTF-8                       2025-10-15
* --|----1----|----2----|----3----|----4----|----5----|----6----|----7----*
*
*              nfoFlip LAGGED-FIBONACCI PSEUDO-RANDOM NUMBERS
*              ----------------------------------------------
*
* nfoFlip is a transposition of Donald Knuth's Literate Program GB_FLIP
* in pp. 216-221 of "The Stanford GraphBase: A Platform for Combinatorial
* Computing", Addison-Wesley (Reading MA, 1993).  For the original CWEB code,
* see <https://www-cs-faculty.stanford.edu/~knuth/sgb.html>. Also see the
* GitHub repository  <https://github.com/ascherer/sgb> for the SGB files
* provided and maintained by Andreas Scherer.
*
* The §n section numbers refer to sections in the GB_FLIP text from which
* nfoFlip is derived.
*
* WARNING: nfoFlip is not thread-safe.  A single instance cannot be safely
*    used across multiple threads in the same program.
*
* STABILITY: nfoFlip procedures nfoFlipInit, nfoFlipNextRand, and
*     nfoFlipUniformRand provide the same functions as the GB_FLIP procedures
*     gb_init_rand, gb_next_rand, and gb_uniform_rand, respectively.  This
*     means that
*      - nfoFlip is an alternative for GB_FLIP in adaptation of other programs
*      - the same sequences of nfoFlipInit, nfoFlipNextRand, and
*        nfoFlipUniformRand with the same seed will yield an identical
*        sequence of results.
*/

extern const char * const nfoFlipVersion;

void nfoFlipInit(long seed); // §11
/* TODO: Recommend seed choices, and using the same seed for reproducibility
   */

extern long * _nfo_pFS;  // §5 pointer maintained privately by nfoFlip.c
/* _nfo_pFS is used in the operation of nfoFlipNextRand() defined below.
   It is not intended for use in user code.
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
/* Generate a uniformly distributed random number in the range [0, n-1].
   When n < 1, 0 is returned.
   */

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

0.1.5 2025-10-15T23:19Z Make nfoFlipVersion external
0.1.4 2025-10-15T18:58Z Correct nfoFlipVersion to match nfoFlipX.c
0.1.3 2025-10-15T17:26Z Reflect experimental modifications in nfoFlipX.c
0.1.2 2025-10-14T15:21Z Add nfoFlipVersion, smooth some comments.
0.1.1 2025-10-13T22:01Z Use consistent nfoFlipForm naming, smooth comments.
0.1.0 2025-10-09T23:41Z Rename to consistent nfoFlipInit( ) and nfoNextFlip( )
0.0.4 2025-10-08T23:32Z Switch to _nfo_pFS and rework comments.
0.0.3 2025-10-07T23:35Z Add §s and describe nfoUniformRand( ).
0.0.2 2025-10-07T23:06Z Touch-up
0.0.1 2025-10-07-21:48Z Use nfo_pFS instead of nfo_fptr.
0.0.0 2025-10-07-01:01Z Placeholder with draft starters.

                        *** end of nfoFlip.h ***

*/
