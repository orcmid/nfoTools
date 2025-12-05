/* nfoGenAIO.c 0.3.0                UTF-8                         2025-12-05
/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
*                 nfoGenAIO ASCII Input/Output Data Files
*                 ---------------------------------------
*
*   The nfoGenAIO Utility Procedures provide input and output of binary data
*   streams in ASCII format.  Data is read and written in hexadecimal format.
*
*   The functions produce and accept the format employed in George Marsaglia's
*   DieHard battery of RNG tests.  Those streams have chunks of 4096 32-bit
*   words, 10 words per line, 8 hexadecimal digits per word.
*
*   The interface contract and behaviours are defined in nfoGenAIO.h
*/
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include "nfoGenAIO.h"


int nfoGenAIO_write(uint32_t *buf, int nwords, FILE *fp)
  {    /* write nwords values from buf[] to fp in ASCII hexadecimal format,
        * up to 10 words per line, always starting at the beginning of
        * a line with no spaces before any of the encoded words.
        *
        * The return value is the number of words written.  It will be 0 if
        * no words could be written.  If it is EOF there has been an error and
        * the number of words written is unpredictable; feof(fp) and
        * ferror(fp) should be checked for details.
        */

    const char hex[] = "0123456789ABCDEF";

    /* Defend ourselves a little */
       if (buf == NULL) return 0; if (fp == NULL) return 0;
       if (nwords < 0) nwords = 0;

    size_t nWordsLeft = nwords;  // precondition:
    size_t iWordNext = 0;        //    nWordsLeft + iWordNext == nwords

    while (nWordsLeft)
          {  size_t nNextChunk = (10 < nWordsLeft) ? 10 : nWordsLeft;
                               // the number of words to fit on the next line

             while (nNextChunk--)
                   {  /* Advance one word */
                         uint32_t wordNow = buf[iWordNext++];
                         --nWordsLeft;

                      /* Convert wordNow to hexadecimal string */
                         int nNibbles = 8;
                         char hexChars[9];
                         hexChars[8] = '\0';

                         do {  hexChars[--nNibbles] = hex[wordNow & 0xF];
                               wordNow >>= 4;
                               }
                            while (nNibbles);

                      /* Emit the wordNow hex string */
                         if( fputs(hexChars, fp) == EOF ) return EOF;
                         }

             /* End the one-chunk line*/
                if (fputs("\n", fp) == EOF) return EOF;
             }

    return nwords - nWordsLeft;

    } /* nfoGenAIO_write */


const int8_t nibbles[]  /* HEX DIGITS FILTER FOR THE 128 BASIC ASCII CODES */

        /* NUL SOH STX ETX EOT ENQ ACK BEL BS  HT  LF  VT  FF  CR  SO  SI  */
    = {    -2, -3, -3, -3, -3, -3, -3, -3, -3, -1, -2, -1, -1, -1, -3, -3,

        /* DLE DC1 DC2 DC3 DC4 NAK SYN ETB CAN EM  SUB ESC FS  GS  RS  US  */
           -3, -3, -3, -3, -3, -3, -3, -3, -3, -3, -3, -3, -3, -3, -3, -3,

        /* ' ' '!' '"' '#' '$' '%' '&' ''' '(' ')' '*' '+' ',' '-' '.' '/' */
           -1, -3, -3, -3, -3, -3, -3, -3, -3, -3, -3, -3, -3, -3, -3, -3,

        /* '0' '1' '2' '3' '4' '5' '6' '7' '8' '9' ':' ';' '<' '=' '>' '?' */
            0,  1,  2,  3,  4,  5,  6,  7,  8,  9, -3, -3, -3, -3, -3, -3,

        /* '@' 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' */
           -3, 10, 11, 12, 13, 14, 15, -3, -3, -3, -3, -3, -3, -3, -3, -3,

        /* 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z' '[' '\' ']' '^' '_' */
           -3, -3, -3, -3, -3, -3, -3, -3, -3, -3, -3, -3, -3, -3, -3, -3,

        /* '`' 'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' */
           -3, 10, 11, 12, 13, 14, 15, -3, -3, -3, -3, -3, -3, -3, -3, -3,

        /* 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z' '{' '|' '}' '~' DEL */
           -3, -3, -3, -3, -3, -3, -3, -3, -3, -3, -3, -3, -3, -3, -3, -3,
        };

        /*  The values 0 - 15 are those for the valid hexadecimal digits.
            Value -1 indicates whitespace characters.
            Value -2 indicates `\0` or `\n`and assume line has ended.
            Value -3 indicates invalid characters.

            */

#define NFOGENAIO_MAX_LINE 255
    /* maximum length of an input line, including '\n' and '\0'
       This must be a value that will never be reached in practical operation.
       */

static char textLine[NFOGENAIO_MAX_LINE+9] = { '\0' };  // with safety margin
static bool bTextLineEmpty = true;     // nothing there to process yet
static int iTextLineNext = 0;          // next char to process

        /* Initial conditions are as if the buffer is empty and it's ready
           to be filled.  In future calls there may be some data still in
           the buffer and continuation will be from that point.*/

int nfoGenAIO_read(uint32_t *buf, int nwords, FILE *fp)
  {    /* reads up to nwords values encoded in ASCII hexadecimal format into
        * buf[].  Each value must be represented by 8 hexadecimal digits.
        *
        * The return value is the number of words actually read.  It
        * may be less than nwords if end-of-file is reached before nwords
        * values are read.
        *
        * If an error occurs during reading, 0 is returned.  The amount of
        * data read into buf[] before the error occurred is unpredictable.
        * There is no recovery.  nfoGenAIO_read() should not be called any
        * more.
        *
        * Details of operations are specified in nfoGenAIO.h.
        */

    /* Defend ourselves a little */
       if (buf == NULL) return 0; if (fp == NULL) return 0;
       if (nwords < 0) nwords = 0;

    size_t nWordsLeft = nwords;           // precondition:
    size_t iWordNext = 0;                 // nWordsLeft + iWordNext == nwords

    do { if (bTextLineEmpty)
              { /* it's time to read a line of input. */
                   if (fgets(textLine, NFOGENAIO_MAX_LINE, fp) == NULL )
                        /* EOF or error */
                           return (int)iWordNext;
                                /* delivering any data read so far under the
                                   assumption that a future request will get
                                   nothing and report 0 for certain
                                   */

                   if (    textLine[0] == '\0'
                        || textLine[0] == '\n'
                        || textLine[0] == '#'
                        )
                        continue; /* skipping empty and #-comment lines */

                   iTextLineNext = 0;
                   bTextLineEmpty = false;
                   }

         /* Gobble any words that are here now */

            do { char cNibbleNow = textLine[iTextLineNext++];
                 if ((cNibbleNow & 0x80) != 0)
                     return 0; /* error - non-ASCII character */

                 int8_t cNibbleType = nibbles[(size_t)cNibbleNow];

                 if (cNibbleType > -1)
                      { /* valid hex digit */

                        uint32_t wordNow = (uint32_t)cNibbleType;
                        int nNibblesNeeded = 7;

                        while (nNibblesNeeded--)
                              { cNibbleNow = textLine[iTextLineNext++];
                                if ((cNibbleNow & 0x80) != 0)
                                      return 0; /* error - non-ASCII */

                                cNibbleType = nibbles[(size_t)cNibbleNow];

                                if (cNibbleType < 0)
                                  return 0; /* error - incomplete word */

                                wordNow = (wordNow << 4)
                                          | (uint32_t)cNibbleType;
                               }


                        buf[iWordNext++] = wordNow;

                        if (--nWordsLeft == 0)
                            return iWordNext; /* success */

                        continue; /* for more words */
                        }

                 if (cNibbleType == -2)
                      { bTextLineEmpty = true;
                        break;    /* no more line */
                        }

                 /* cNibbleType must be -1 */
                 }
               while (true);

         }
    while (true);

  } /* nfoGenAIO_read */



/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

   0.3.0  2025-12-05T02:56Z Fix erroneous check on non-ASCII characters
   0.2.3  2025-12-04T05:50Z Correct gathering of words exact hex digits
   0.2.2  2025-12-04T01:23Z Correct return of words read on success
   0.2.1  2025-12-02T21:03Z Aligh with nfoGenAIO.h NFOGENAIO_VERSION
   0.1.1  2025-12-02T20:52Z Fix VS Code lint warnings
   0.1.0  2025-12-02T06:52Z Refactor nfoGenAIO_read() to favor hex word items.
   0.0.7  2025-12-01T23:48Z Smooth error cases, especially in nfoGenAIO_read()
   0.0.6  2025-12-01T16:56Z Touch up nfoGenAIO_write()
   0.0.5  2025-12-01T04:18Z Complete nfoGenAIO_read()
   0.0.4  2025-11-29T20:52Z Clean up nibbles[] to use int8_t cases
   0.0.3  2025-11-29T02:40Z Work up the nibbles[] table for hex digit decoding
   0.0.2  2025-11-28T23:47Z Improve error cases
   0.0.1  2025-11-28T22:48Z First complete nfoGenAIO_write()
   0.0.0  2025-11-28T18:03Z Tighten/touch-up descriptions


                          *** end of nfoGenAIO.c ***

   */
