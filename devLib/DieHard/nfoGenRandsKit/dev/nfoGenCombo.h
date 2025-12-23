/* nfoGenCombo.h 0.0.1              UTF-8                     2025-12-22
/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
*         HEADER FOR NFOGENRANDS TEST STREAM OF MARSAGLIA'S COMBO RNG
*         -----------------------------------------------------------
*
*   This nfoGenCombo.h file provides parameters to nfoGenRands.c for
*   generating a test stream using the COMBO random-number generator
*   designed by George Marsaglia.
*
*   This worked file serves as the model from which nfoGenTemplate.h
*   is derived.  This file is intended to be used as a demonstration
*   and confirmation of the adequacy of nfoGenTemplate.h in specifying
*   test-stream generations for many different random-number generators.

*   See nfoGenTemplate.h for instructions on customizing for other
*   generators.
*
*   -----------------------------------------------------------------------
*   Attribution: This program is copilot assisted.
*   -----------------------------------------------------------------------
*/

#include "combo.h"
/* Include the combo.h header-only implementation of the COMBO RNG.
   This provides the combo_init() and combo_rand() functions used
   below.  It also defines NFOGENRNGNAME and NFOGENVERSION macros
   for use by nfoGenRands.c.
   */

#define NEXT_RANDOM( ) combo_rand()
    /* Macro to produce the next random uint32_t from the RNG.
       This macro is invoked by nfoGenRands.c to get each random
       integer for the generated test stream.
       */

#define SEED_THE_RAND( ) combo_init(12345, 67890, 13579)
    /* Macro to seed the RNG before generating the test stream.
       This is invoked by nfoGenRands.c once before any
       random numbers are requested.

       It is generally expected that the seeding parameters will
       be input from the command line to nfoGenRands.c or
       otherwise  varied.  This fixed seeding is provided here
       only for demonstration and testing purposes.
       */


/* NOTES AND TODOS



   * Describe copying and renaming this template file as the second step.

   * Fill in the naming of the generator and version in the third step.

   * We'll need to figure out the parameters needed and how it works with
     the nfoGenRands.c provision of command-line options/parameters.

   * I'm thinking that using the command line is best, but then it needs
     to be supplied here as part of the SEED_THE_RAND() operation.

   * There's then the offering of help and doing other things to make this
     all user-friendly.

   * We can also expect that the build of a customized nfoGenRands.c will
     have an executable name that reflects the generator being used.

   */

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

   0.0.1  2025-12-22-23:51Z Thinking out loud and baby steps.
   0.0.0  2025-10-24T22:24Z Starting up.


                       *** end of nfoGenCombo.h ***
   */
