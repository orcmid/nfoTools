/* nfoGenRands.c 0.0.2              UTF-8                       2025-10-23
/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
*        PRODUCE 2,867,200 RANDOM NUMBERS WITH A SPECIFIED GENERATOR
*        -----------------------------------------------------------
*
* nfoGenRands.c and the associated nfoGenRands.h header file are templates.
* Creation of a program to work with a specific random number generator is
* accomplished by making a renamed and customized copy of nfoGenRands.

*
* APPROACH TO CUSTOMIZATION:
*
*   customize nfoGenRands.h and save the customization with a name that
*   distinguishes the generator to be tested.  See nfoGenRands.h for guidance.

*   There is also an example customization, GenStdRand.h, provided to generate
*   test streams from the Standard C library random number generator.  See
*   how that is used along with mkGenRands.bat to produce an executable file
*   named GenStdRand.exe.
*
* BACKGROUND:
*
*   nfoGenRands is derived from the 1995 diehard generator makecmbo.f of
*   George Marsaglia.  The details of a generator to be tested are now
*   obtained from a customized copy of the header template nfoGenRands.h
*   rather than being hard-coded into this file.
*/

#include <stdio.h>
#include <stdlib.h>

#include "mkGenRands.h"
/* This file is responsible for generating random numbers using a specified
   algorithm via a customized nfoGenRands.c.  That file, with its distinctive
   name, is copied to mkGenRands.h by mkGenRands.bat. It can also be done
   manually as part of a different build procedure.  The rationale is to not
   have to touch this file, nfoGenRands.c, and to produce generator .exe
   files having names based on the generator being tested.
   */

int main(int argc, char *argv[])
{
    long b[4096];

    SEED_THE_RAND();

    START_GENERATING();

    for (int i=1; i<=700; i++)
      { for (int j=0; j<=4095; j++)
            b[j] = NEXT_RANDOM_INTEGER();
        WRITE_BLOCK(b);
        }

    STOP_GENERATING();

    exit(EXIT_SUCCESS);


    } /* main */

/* TODO Plenty
   */

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

   0.0.3  2025-10-23T21:48Z Fix the top-line ruler
   0.0.2  2025-10-23T17:11Z Improved header handling and explanation
   0.0.1  2025-10-22T22:24Z First draft looking like pseudo-code
   0.0.0  2025-10-22T04:22Z Starting up.

                         *** end of nfoGenRands.c ***

   */
