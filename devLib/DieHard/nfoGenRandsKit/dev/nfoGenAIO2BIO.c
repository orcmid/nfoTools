/* nfoGenAsc2Bin.c 0.0.1            UTF-8                         2025-12-30
/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
*              nfoGenAsc2Bin: Convert nfoGenAIO to nfoGenBIO Files
*              ---------------------------------------------------
*
*   This utility is part of the nfoGenRandKits devLib utilities for working
*   with ASCII and binary files containing 32-bit binary words.
*
*   Generally, nfoGen ASCII files are relatively small and created for
*   testing purposes.  This converter is also useful in creating test files
*   for binary input to other utilities and tests.
*
*   This program is inspired by the Fortran program provided with George
*   Marsaglia's Asc2Bin utility in the original 1996-01-26 DieHard release.
*
*   -----------------------------------------------------------------------
*    Attribution: This program is copilot assisted and scientist reviewed.
*   -----------------------------------------------------------------------
*/

#define ASC2BIN_VERSION "nfoGenAsc2Bin-0.0.0"

#include  <stdbool.h>
#include  <stdint.h>
#include  <stdio.h>
#include  <stdlib.h>
#include  <string.h>

#include  "nfoGenAIO.h"
#include  "nfoGenBIO.h"

int main( int argc, char *argv[] )
{  uint32_t m[4096] ;
     /* The buffer for 32-bit words in typical DieHard blocks */

   fputs( "[Asc2Bin] " ASC2BIN_VERSION
          " Converting DieHard AIO file to BIO file\n",
          stderr);


   } /* main */

/* XXX: We don't want all of this description here.  We do want an usage
        similar to that for copying files:
          nfGenAsc2Bin [/? | [AOO-source [BOO-dest] ]

        When there is no BOO-dest, and stdout is a terminal, no conversion
        occurs.  I could generate a temporary file, but don't have good
        information for naming it.

        When there is no AOO-source, and stdin is a terminal, no conversion
        occurs.

        This is still not the best interface.  I think I need to reverse
        things and have the output be required more than the input because
        a binary form is more likely to be needed as a file.

        Detecting redirection/piping sort of interferes with this.  The
        question is how to explain it in a clean way.

        I could have both required and point out that redirection and
        piping counts.  This is probably the best way, but it depends on
        whether BIO works reliably and that's going to take some serious
        testing.

        */
/* Scraps of Original Fortran code being salvaged:

       character*15 ascfile,binfile
      print*,'  This program reads an ascii file of 32-bit integers'
      print*,'  and converts it to a binary file for use in DIEHARD.'
      print*,'      '
             print*,'  To continue, hit space ret'
             read 852,dum
 852  format( a1)
      print*,'  You must first create the ascii file.  To do that,'
      print*,' generate your 32-bit integers and write them to a file,'
      print*,' in hex format, 80 characters (ten 32-bit integers) per'
      print*,' line.  For example, in Fortran, if your array is, say,'
      print*,' mran(5000), then the statements'
      print*,'            write(1,21) mran  '
      print*,'     21     format(10z8)'
      print*,' will cause your 5000 integers to be written to the'
      print*,' file designated unit 1.   Of course you must have first'
      print*,' opened that unit with a statement such as'
      print*,'             open(1,file=''whatever'')'
      print*,'      '
      print*,'  You must first create the ascii file.  To do that,'
             print*,'  To continue, hit space ret'

         jk=0
              do 2 i=1,700
                 read(1,21) m
21       format(10z8)
          jk=jk+1
2             write(2,rec=jk) m
       print 23,binfile
5      close(2)
23     format( '  OK, binary file ',a15,' has been created.')
        end

*/ /* end of scraps */

/*
   0.0.1 2025-12-30T21:40Z More XXX and pondering on usage
   0.0.0 2025-12-28T20:32Z Skeleton with scraps of original Fortran

                   *** end of nfoGenAsc2Bin.c ***
   */
