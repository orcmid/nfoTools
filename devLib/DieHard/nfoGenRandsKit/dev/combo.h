/* combo.h 0.0.2                    UTF-8                         2025-10-23
/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
*        COMBO RANDOM NUMBER GENERATOR NFOGENRANDS CUSTOMIZATION
*        -------------------------------------------------------
*
*   combo.h is a customization of nfoGenRands.h. It is based on George
*   Marsaglia's COMBO RNG included in the original DIEHARD software.

*   period> 2^60.5
*   x(n)=x(n-1)*x(n-2) mod 2^32 period is 3*2^29 if seeds odd and one is +or-3
*   mod
*   period of x(n)=x(n-1)*x(n-2) is 3*2^29 if seeds odd, and one is +or-3 mod
*   easy to ensure: replace seed x with 3*x*x.
*   mwc z=30903*iand(z,65535)+ishft(z,-16)
*
*   FIND BETTER EXPLANATION, USING THIS FROM makef.txt FROM diehard-fortran.
::   This program creates the binary file combo.32, containing   ::
     :: 11+ megabytes of integers from a simple but very good combi-  ::
     :: nation generator.  It combines, by addition mod 2^32,         ::
     ::             x(n)=x(n-1)*x(n-2) mod 2^32                       ::
     ::    and                                                        ::
     ::             y(n)=30903*y(n-1) + carry mod 2^16                ::
     :: The period of the first is 3*2^29, on odd integers, and the   ::
     :: period of the second, a multiply-with-carry generator, is     ::
     :: 30903*2^15-1=1012629503, so the period of combo exceeds 2^60. ::
     :: This generator is simple to program in Fortran or C and quite ::
     :: fast.   It seems to pass all tests in DIEHARD.  Try it.       ::
     :: You will be prompted for three seed integers.  The x's of the ::
     :: seeds x1,x2,y must be 3 or 5 mod 8, which is ensured by repla-::
     :: cing  x1 by 3*(x1+x1+1)^2 and x2 by 2*x2+1.
*/

#define NFOGENVERSION "combo-0.0.2"

    long Xcombo, Ycombo, Zcombo;
        /* Wonky names for x, y, z to avoid possible name clashes
           where combo.h might be included.  Theses are going to be
           static variables in the program that includes combo.h
           */

    void combo_init(long x, long y, long z)
        { Xcombo = x + x + 1;
          Xcombo = 3 * Xcombo * Xcombo;
          Ycombo = y + y + 1;
          Zcombo = z;
          }

    long combo_rand()
        { long v = Xcombo * Ycombo;
          Xcombo = Ycombo;
          Ycombo = v;
          Zcombo = 30903 * (Zcombo & 65535) + (Zcombo >> 16);
            /* TODO: Ensure Zcombo >> 16 matches the Fortran right-shift. */
          return Ycombo + Zcombo;
          }

/* TODO Plenty
   * Confirm that the range is 0 to 2^32-1.
   * Add a version number that can be used in nfoGenRands.c identification.
   * I need a way to test this with what makewhat.f was going to produce.
     Perhaps this can be found in the C Language version.
   */

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

   0.0.2  2025-10-26T16:55Z Keep noodling
   0.0.1  2025-10-25T21:52Z Paste in description from diehard makef.txt.
   0.0.0  2025-10-23T19:25Z Starting up.

                           *** end of combo.h ***

   */
