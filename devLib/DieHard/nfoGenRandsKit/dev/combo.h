/* combo.h 0.0.5                    UTF-8                         2025-11-05
/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
*                 MARSAGLIA'S COMBO RANDOM NUMBER GENERATOR
*                 -----------------------------------------
*
*   combo.h is a header-only derivative of George Marsaglia's COMBO
*   RNG that included in the original DIEHARD software.
*
*   It works by combining two separate RNGs such that the combined period
*   exceeds 2^60.5.  These are Marsaglia's claims and lightly-edited
*   description.

*       The first RNG is x(n)=x(n-1)*x(n-2) mod 2^32 with a period of 3*2^29
*       when the seeds are odd and one is 3 or 5 mod 8.  This is assured in
*       the seeding.
*
*       The second RNG is a multiply-with-carry (MWC) generator
*       z(n) = 30903*z(n-1) + carry mod 2^16 where carry = floor(z(n-1)/2^16).
*       That period is 30903*2^15-1=1012629503.
*
*       The two results are combined by addition: x(n)+z(n)mod 32.
*
*       This generator seems to pass all tests in DIEHARD and is quite fast.
*       It is simple to program in Fortran or C.
*
*   In th original Fortran code, the MWC is implemented as
*   z(n) = 30903*iand(z(n-1),65535)+ishft(z(n-1),-16)
*
*   The present version is offered in nfoTools devLib as useful and also
*   for verification of DieHard operation and results.
*/

#include <stdint.h>

#define NFOGENVERSION "combo-0.0.5"
    /* For identification when used for generating RNG test input */

uint32_t _comboX, _comboY, _comboZ;
    /* Wonky names for original x, y, z to avoid possible name clashes
       where combo.h might be included.  These are going to be static
       variables in the program that includes combo.h
       */

void combo_init(uint32_t x, uint32_t y, uint32_t z)
    { _comboX = x + x + 1;              // make odd, 2*x + 1
      _comboX = 3 * _comboX * _comboX;  // XXX why is this 3 or 5 mod 8?
      _comboY = y + y + 1;              // make odd also
      _comboZ = z;
      }

uint32_t combo_rand()
    { uint32_t v = _comboX * _comboY;   // new x(n)
      _comboX = _comboY;                // next x(n-2)
      _comboY = v;                      // next x(n-1)

      _comboZ = 30903 * (_comboZ & 65535) + (_comboZ >> 16);
        /* TODO: Ensure _comboZ >> 16 matches the Fortran right-shift.
           In the Fortran ishift(), 0 is shifted in on the left,
           but in Standard C that is assured only for unsigned types. */

      return v + _comboZ;
      }

/* TODO Plenty
   * Confirm that the intended range is 0 to 2^32-1.
   * I need a way to test this with what makewhat.f was going to produce.
     Perhaps this can be found in the C Language version.
   */

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

   0.0.5  2025-11-06T00:23Z Touchup, refactor to use uint32_t
   0.0.4  2025-11-04T16:27Z Create free-standing and testable combo.h
   0.0.3  2025-10-30T20:22Z Hand wring about range and unsigned values
   0.0.2  2025-10-26T16:55Z Keep noodling
   0.0.1  2025-10-25T21:52Z Paste in description from diehard makef.txt.
   0.0.0  2025-10-23T19:25Z Starting up.

                           *** end of combo.h ***

   */
