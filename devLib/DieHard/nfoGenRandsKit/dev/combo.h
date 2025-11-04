/* combo.h 0.0.4                    UTF-8                         2025-11-04
/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
*                 MARSAGLIA'S COMBO RANDOM NUMBER GENERATOR
*                 -----------------------------------------
*
*   combo.h is a header-only derivative of George Marsaglia's COMBO
*   RNG included in the original DIEHARD software.
*
*   It works by combining two separate RNGs such that the combined period
*   exceeds 2^60.5.  These are Marsaglia's claims and description.

*   The first RNG is x(n)=x(n-1)*x(n-2) mod 2^32 with a period of 3*2^29
*   when the seeds are odd and one is 3 or 5 mod 8.  This is assured in
*   the seeding.
*
*   The second RNG is a multiply-with-carry (MWC) generator
*   z(n) = 30903*z(n-1) + carry mod 2^16 where carry = floor(z(n-1)/2^16).
*   That period is 30903*2^15-1=1012629503
*
*   In th original Fortran code, the MWC is implemented as
*   z(n) = 30903*iand(z(n-1),65535)+ishft(z(n-1),-16)
*
*   The two results are combined by addition: x(n)+z(n)mod 32.
*
*   This generator seems to pass all tests in DIEHARD and is quite fast.
*   It is simple to program in Fortran or C.
*
*   The present version is offered in nfoTools devLib as useful and also
*   for verification of DieHard operation and results.
*
*/

#define NFOGENVERSION "combo-0.0.4"

    unsigned long Xcombo, Ycombo, Zcombo;
        /* Wonky names for original x, y, z to avoid possible name clashes
           where combo.h might be included.  Theses are going to be
           static variables in the program that includes combo.h
           */

    void combo_init(long x, long y, long z)
        { Xcombo = x + x + 1;            // make odd, 2*x + 1
          Xcombo = 3 * Xcombo * Xcombo;  // why is this 3 or 5 mod 8?
          Ycombo = y + y + 1;            // make odd also
          Zcombo = z;
          }

    unsigned long combo_rand()
        { unsigned long v = Xcombo * Ycombo;   // new x(n)
          Xcombo = Ycombo;                     // next x(n-2)
          Ycombo = v;                          // next x(n-1)
          Zcombo = 30903 * (Zcombo & 65535) + (Zcombo >> 16);
            /* TODO: Ensure Zcombo >> 16 matches the Fortran right-shift.
               In the Fortran ishift(), 0 is shifted in on the left,
               but in Standard C that is assured only for unsigned types. */
          return v + Zcombo;
          }

/* TODO Plenty
   * Confirm that the range is 0 to 2^32-1.
   * I need a way to test this with what makewhat.f was going to produce.
     Perhaps this can be found in the C Language version.
   * We are operating on the assumption that unsigned long is exactly 33 bits.
   * It might be better to use uint32_t from stdint.h.
   */

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

   0.0.4  2025-11-04T16:27Z Create free-standing and testable combo.h
   0.0.3  2025-10-30T20:22Z Hand wring about range and unsigned values
   0.0.2  2025-10-26T16:55Z Keep noodling
   0.0.1  2025-10-25T21:52Z Paste in description from diehard makef.txt.
   0.0.0  2025-10-23T19:25Z Starting up.

                           *** end of combo.h ***

   */
