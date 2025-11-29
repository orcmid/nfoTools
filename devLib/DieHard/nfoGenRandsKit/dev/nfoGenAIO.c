/* nfoGenAIO.c 0.0.3                UTF-8                         2025-11-29
/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
*                 nfoGenAIO ASCII Input/Output Data Files
*                 ---------------------------------------
*
*   The nfoGenAIO Utility Procedures provide input and output of binary data
*   streams in ASCII format.  Data is read and written in hexadecimal format.
*
*   The streams conform to the format employed in George Marsaglia's DieHard
*   battery of RNG tests.  Those streams have chunks of 4096 32-bit words,
*   10 words per line, 8 hexadecimal digits per word.
*
*   The interface contract and behaviours are defined in nfoGenAIO.h
*/
#include <stdlib.h>

#include <stdio.h>

#include <stdint.h>

#include "nfoGenAIO.h"


size_t nfoGenAIO_write(uint32_t *buf, size_t nwords, FILE *fp);
  {    /* write nwords values from from buf[] to fp in ASCII hexadecimal
        * format, up to 10 words per line, always starting at the beginning of
        * a line.
        *
        * The return value is the number of words written.  It will
        * be the same as nwords unless an error occurs, in which case EOF
        * is returned.
        */

    const char hex[] = "0123456789ABCDEF";

    /* Defend ourselves a little */
       if (buf == NULL) return 0; if (fp == NULL) return 0;
       if (nwords < 0) nwords = 0;

    size_t wordsLeft = nwords;  // precondition:
    size_t iWordNext = 0;       //    wordsLeft + iWordNext == nwords

    while (wordsLeft)
          { int nNextChunk = (10 < wordsLeft) ? 10 : (int) wordsLeft;
                             // the number of words to fit on the next line

            while (nNextChunk--)
                  { /* Advance one word */
                       uint32_t wordNow = buf[iWordNext++];
                       --wordsLeft;

                    /* Convert wordNow to hexadecimal string */
                       int nNibbles = 8;
                       char hexChars[9];
                       hexChars[8] = '\0';

                       do { hexChars[--nNibbles] = hex[wordNow & 0xF];
                            wordNow >>= 4;
                            }
                          while (nNibbles);

                    /* Emit the wordNow hex string */
                       if(fputs(hexChars, fp) == EOF) return EOF;
                    }

            /* End the one-chunk line*/
               if (fputs("\n", fp) == EOF) return EOF;
            }

    return nwords - wordsLeft;
    }

const char nibbles[]  /* HEX DIGITS FILTER FOR THE 128 BASIC ASCII CODES */

        /* NUL SOH STX ETX EOT ENQ ACK BEL BS  HT  LF  VT  FF  CR  SO  SI  */
    = {    19, 17, 17, 17, 17, 17, 17, 17, 17, 16, 16, 16, 16, 16, 17, 17,

        /* DLE DC1 DC2 DC3 DC4 NAK SYN ETB CAN EM  SUB ESC FS  GS  RS  US  */
           17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17,

        /* ' ' '!' '"' '#' '$' '%' '&' ''' '(' ')' '*' '+' ',' '-' '.' '/' */
           16, 17, 17, 18, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17,

        /* '0' '1' '2' '3' '4' '5' '6' '7' '8' '9' ':' ';' '<' '=' '>' '?' */
            0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 17, 17, 17, 17, 17, 17,

        /* '@' 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' */
           17, 10, 11, 12, 13, 14, 15, 17, 17, 17, 17, 17, 17, 17, 17, 17,

        /* 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z' '[' '\' ']' '^' '_' */
           17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17,

        /* '`' 'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' */
           17, 10, 11, 12, 13, 14, 15, 17, 17, 17, 17, 17, 17, 17, 17, 17,

        /* 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z' '{' '|' '}' '~' DEL */
           17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17
        };

        /*  The values 0 - 15 are those for the valid hexadecimal digits.
            Value 16 indicates whitespace characters.
            Value 17 indicates invalid characters.
            Value 18 indicates '#' and may be a misplaced comment starter.
            Value 19 indicates `\0` and may be a stray end-of-string.
            */

size_t nfoGenAIO_read(uint32_t *buf, size_t nwords, FILE *fp);
    /* reads up to nwords values encoded in ASCII hexadecimal format into
     * buf[].  Each value must be represented by 8 hexadecimal digits.
     *
     * The return value is the number of words actually read.  It
     * may be less than nwords if end-of-file is reached before nwords
     * values are read.
     *
     * If an error occurs during reading, 0 is returned.  The amount of
     * data read into buf[] before the error occurred is unpredictable.
     *
     * nfoGenAIO_read() accepts input formatted in the form produced by the
     * same nwords output via nfoGenAIO_write().  The procedure is forgiving
     * of whitespace.  Any spaces and line breaks between the hexadecimal word
     * values are simply ignored. The number of words per line also doesn't
     * matter.  nfoGenAIO_read() also ignores blank lines and lines beginning
     * with "#".
     *
     * If the last line read from has additional hexadecimal words, they
     * will be read on the next call to nfoGenAIO_read(), if any.
     */

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

   0.0.3  2025-11-29T02:40Z Work up the nibbles[] table for hex digit decoding
   0.0.2  2025-11-28T23:47Z Improve error cases
   0.0.1  2025-11-28T22:48Z First complete nfoGenAIO_write()
   0.0.0  2025-11-28T18:03Z Tighten/touch-up descriptions


                          *** end of nfoGenAIO.c ***

   */
