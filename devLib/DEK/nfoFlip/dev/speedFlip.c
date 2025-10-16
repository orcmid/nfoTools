/* speedFlip.c 0.1.1                 UTF-8                       2025-10-16
* --|----1----|----2----|----3----|----4----|----5----|----6----|----7----*
*
*                          nfoFlip SPEED TESTING
*                          ---------------------
*
* speedFlip demonstrates nfoFlip performance by timing how quickly a
* specified number of random-number calls are performed.
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "nfoFlip.h"

char * const commaNumbered(unsigned long long n)
{   /* Express the number with commas (Co-Pilot assisted) */

    static char commad[32];
    int p = sizeof(commad) - 1;

    commad[p] = '\0';

    do { if (p % 4 == 0 && p != sizeof(commad) - 1)
              commad[--p] = ',';
         commad[--p] = '0' + (n % 10);
         n /= 10;
         } while (n != 0);

    return &commad[p];
    } /* commaNumbered */

int main(int argc, char *argv[])
{
    unsigned long long const defaultReps = 10000000000;
    unsigned long long reps = defaultReps; /* default repetitions */

    time_t startTime, finishTime;  /* in whatever units time() uses */
    double elapsed;                /* elapsed time in seconds */

    long lastRand;                 /* final random number obtained */

    printf("\n[speedFlip] 0.1.1 Performance checking %s\n",
           nfoFlipVersion);


    if (argc > 1) reps = strtoull(argv[1], NULL, 10);
    if (reps == 0) reps = defaultReps;

    char * commad = commaNumbered(reps);

    nfoFlipInit(-314159L);

    startTime = time(NULL);
    for (unsigned long long i = 0; i < reps; i++)
        lastRand = nfoFlipNextRand();
    finishTime = time(NULL);
    elapsed = difftime(finishTime, startTime);

    printf( "\n            %s nfoFlipNextRand()s took %.0f seconds",
            commad, elapsed);
    printf( "\n            ending with %ld\n", lastRand);

    startTime = time(NULL);
    for (unsigned long long i = 0; i < reps; i++)
        lastRand = nfoFlipUniformRand(0x55555555L);
    finishTime = time(NULL);
    elapsed = difftime(finishTime, startTime);

    printf( "\n            %s nfoFlipUniformRand()s more took %.0f seconds",
            commad, elapsed);
    printf( "\n            ending with %ld\n\n", lastRand);

    exit(EXIT_SUCCESS);

    } /* main */

/* TODO: Have a Help option */

/* TODO: Allow commas in the input parameter */

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

0.1.1 2025-10-16T22:56Z cleanup spacing in output lines, update version
0.1.0 2025-10-16T22:47Z Change to commaNumbered output of reps
0.0.7 2025-10-15T22:59Z Omit decimal places, add TODO
0.0.6 2025-10-15T22:43Z Use external nfoFlipVersion
0.0.5 2025-10-15T05:17Z Add TODOs
0.0.4 2025-10-15T01:16Z Use %llu format for unsigned long long
0.0.3 2025-10-15T01:11Z Make long long reps count because we need it
0.0.2 2025-10-15T01:00Z Replace reserved default with defaultReps
0.0.1 2025-10-15T00:44Z First draft version


                        *** end of speedFlip.c ***

*/
