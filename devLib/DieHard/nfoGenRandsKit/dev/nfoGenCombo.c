/* nfoGenCombo.c 0.0.2              UTF-8                         2025-12-24
/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
*              GENERATE TEST STREAM FROM MARSAGLIA'S COMBO RNG
*              -----------------------------------------------
*
*   This nfoGenCombo.c file produces a stream of random number values
*   using the COMBO random-number generator designed by George Marsaglia.
*
*   This version served as the model from which nfoGenRNG-template.c
*   is derived.  nfoGenCombo.c serves as a demonstration and confirmation
*   of the adequacy of nfoGenRNG-template.c for producing test-stream
*   generators for many different random-number generators.

*   See nfoGenRNG-template.c for instructions on customizing for other
*   generators.
*
*   -----------------------------------------------------------------------
*   Attribution: This program is copilot assisted.
*   -----------------------------------------------------------------------
*/

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include "nfoGenBIO.h"

#include "combo.h"
/* Include the combo.h header-only implementation of the COMBO RNG.
   This provides the combo_init() and combo_rand() functions used
   below.  It also defines NFOGENRNGNAME and NFOGENVERSION macros
   for describing nfoGenCombo and the COMBO RNG versions.
   */



int main(int argc, char *argv[])
    {   uint32_t B[4096];

        FILE *fp = nfoGenBIO_startOutput( template, templateSize);

        /* XXX: I need to figure out a tidy way to get the file name
           set up.  I think the key method is to use the NFOGENRNGNAME
           except that it needs to be part of a file name, and I need
           a way to know where the file is to be created.
              It looks like the command line is the best way to get that
           information into the program.
           I need to make the template[] and think this through.
           */

       combo_init(12345, 67890, 13579);
         /* XXX: This fixed suggestion is good for now.  It would be
            interesting to generate them somehow, though.
            These could be made command-line parameters perhaps.        .
            */

       for (int i=1; i<=700; i++)
           { for (int j=0; j<=4095; j++)
                 B[j] = combo_rand();
             nfoGenBIO_write(B, 4096, fp);
             }

       STOP_GENERATING();

       exit(EXIT_SUCCESS);

       }

/* NOTES AND TODOS



   * Get the file-naming template worked out and implemented.


   */

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

   0.0.2  2025-12-24T22:11Z Layout main() and continue sketching
   0.0.1  2025-12-22-23:51Z Thinking out loud and baby steps.
   0.0.0  2025-10-24T22:24Z Starting up.


                        *** end of nfoGenCombo.c ***
   */
