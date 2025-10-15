/* speedFlip.c 0.0.5                 UTF-8                       2025-10-15
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

int main(int argc, char *argv[])
{
    unsigned long long const defaultReps = 10000000000;
    unsigned long long reps = defaultReps; /* default repetitions */

    time_t startTime, finishTime;  /* in whatever units time() uses */
    double elapsed;                /* elapsed time in seconds */

    long lastRand;                 /* final random number obtained */

    fputs("\n[speedFlip] 0.0.0 Performance checking " nfoFlipVersion "\n",
          stdout);

    if (argc > 1) reps = strtoull(argv[1], NULL, 10);
    if (reps == 0) reps = defaultReps;

    nfoFlipInit(-314159L);

    startTime = time(NULL);
    for (unsigned long long i = 0; i < reps; i++)
        lastRand = nfoFlipNextRand();
    finishTime = time(NULL);
    elapsed = difftime(finishTime, startTime);

    printf( "\n            %llu nfoFlipNextRand()s took %.2f seconds",
            reps, elapsed);
    printf( "\n            ending with  %ld\n", lastRand);

    startTime = time(NULL);
    for (unsigned long long i = 0; i < reps; i++)
        lastRand = nfoFlipUniformRand(0x55555555L);
    finishTime = time(NULL);
    elapsed = difftime(finishTime, startTime);

    printf( "\n            %llu nfoFlipUniformRand()s more took %.2f seconds",
            reps, elapsed);
    printf( "\n            ending with  %ld\n\n", lastRand);


    exit(EXIT_SUCCESS);

    } /* main */

/* TODO: Find a better way to enter durations as powers of ten.
   */
/* TODO: Have a Help option */

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

0.0.5 2025-10-15T05:17Z Add TODOs
0.0.4 2025-10-15T01:16Z Use %llu format for unsigned long long
0.0.3 2025-10-15T01:11Z Make long long reps count because we need it
0.0.2 2025-10-15T01:00Z Replace reserved default with defaultReps
0.0.1 2025-10-15T00:44Z First draft version


                        *** end of speedFlip.c ***

*/
