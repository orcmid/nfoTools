/* nfoGenRNG-template.c 0.0.0            UTF-8                    2025-12-23
/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
*        PRODUCE 2,867,200 RANDOM NUMBERS WITH A SPECIFIED GENERATOR
*        -----------------------------------------------------------
*
* nfoGenRNG-template.c is a template for a program that will produce test
* samples for specific random-number generators (RNGs).  To set up sampling
* of a particular RNG, copy and rename this file, editing it to make samples
* samples using the specific RNG.
*
* For examples, inspect the existing customizations for nfoGenCombo.c and
* others in the nfoGenRandKit/dev/ folder.
*
* APPROACH TO CUSTOMIZATION:
*
*   customize nfoGenRands.h and save the customization with a name that
*   distinguishes the generator to be tested.  See nfoGenRands.h for guidance.

*   See combo.h for an example customization using the Marsaglia COMBO
*   generator.
*
*   Another example , GenStdRand.h, is provided to generate test streams
*   using the Standard C library random number generator.  See how that is
*   used along with mkGenRands.bat to produce an executable file named
*   GenStdRand.exe.
*
* BACKGROUND:
*
*   nfoGenRNG-template is derived from the 1995 diehard generator makecmbo.f
*   by George Marsaglia. The RNG sample files to be produced are compatible
*   for RNG assessment using the DieHard and DieHarder test suites.
*/

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include "nfoGenBIO.h"

#include "mkGenRands.h"
/* A customization of nfoGenRands.h is copied to mkGenRands.h by the script
   mkGenRands.bat. It will provide all of the definitions for the macros
   referenced in the program code, below.
   */



int main(int argc, char *argv[])
{
    uint32_t B[4096];

/* TODO: Identify ourselves, along with the RNG and its version.
         Use the RNG NAME to generate a filename template for the
         "temporary" binary file to be produced.

         We *might* use nfoGenAIO at first for short testing, then
         use nfoGenBIO for the big job.

         It would be nice to have some command-line control of that,
         but we may be over-thinking this. Better to have a test
         program that uses the specified generator but not with this
         production emphasis perhaps.  We do need to test streams
         with small volumes somehow. At least enough with small
         ASCII and binary-ASCII conversions for comparisons.

         The binary-ASCII conversion might also reduce the need for
         a binary-file viewer/editor.*/

    START_GENERATING();

    SEED_THE_RAND();

    for (int i=1; i<=700; i++)
      { for (int j=0; j<=4095; j++)
            B[j] = NEXT_RANDOM();
        WRITE_BLOCK(B);
        }

    STOP_GENERATING();

    exit(EXIT_SUCCESS);


    } /* main */

/* TODO Plenty
   * Add a title line that includes the nfoGenRands.c and generator versions

   * Add a command-line option to specify the output formatting (default A)

   * Consider base64 output option, which gets 15 longs into 80 characters
     instead of 10 for the ASCII option.

   * The binary file case is difficult because of endianness issues.  We
     consider the output streams to be transient and not used cross-
     platform.

   * We need to know the performance differences among the formats, both
     for output and for subsequent input.  Input would seem to be more
     telling when multiple tests are run on the same data.

   * We need utilities to go the reverse directions and provide a basis
     for checking the results.  I think the ASCII format is the most easy
     to work with for that purpose.  That or I need to get my hands on a
     binary-file viewer/editor.

   */

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

   0.0.0  2025-12-23T22:15Z Create Placeholder from abandoned nfoGenRands.c


                      *** end of nfoGenRNG-template.c ***

   */
