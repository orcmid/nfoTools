/* nfoGenAIO.h 0.2.3                UTF-8                         2025-12-05
/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
*                 nfoGenAIO ASCII Input/Output Data Files
*                 ---------------------------------------
*
*   The nfoGenAIO Utility Procedures provide input and output of binary data
*   streams in ASCII format.  Data is read and written in 32-bit words each
*   coded in 8 hexadecimal digits.
*
*   The output streams conform to the format employed in George Marsaglia's
*   DieHard battery of RNG tests.  Those streams have chunks of 4096 32-bit
*   words, written with 10 consecutive 8-digit hexadecimal words in each full
*   line.  (The last line has only 6 words.)
*
*   This implementation provides any size of data stream blocks, in any
*   mixture, not just ones of 4096 words.  For compatibility with DieHard,
*   however, blocks of 4096 words should be used with no variation.
*
*   Input streams are accepted in the same format as output streams.  In
*   addition, nfoGenAIO_read() is more forgiving, allowing spacing and
*   other format variations that may be present.
*/

#define NFOGENAIO_VERSION "nfoGenAIO-0.2.3"
   /* Version string for nfoGenAIO module.  This is updated whenever
      nfoGenAIO.c and nfoGenAIO.h are changed in any way.  The versions
      are now synchronized between the two files.
      */

#include <stdint.h>
#include <stdio.h>

#define NFOGENAIO_MAX_LINE 255
    /* maximum length of an input line, including '\n' and '\0'
       This must be a value that will never be reached in practical operation.
       */

int nfoGenAIO_write(uint32_t *buf, int nwords, FILE *fp);
   /* writes nwords values from buf[] to fp in ASCII hexadecimal format,
    * up to 10 words per line, always starting at the beginning of a line
    *
    * The return value is the number of words written.  It will be 0
    * if no words could be written.  If it is EOF there has been an error and
    * the number of words written is unpredictable; feof(fp) and ferror(fp)
    * should be checked for details.
    *
    * nfoGenAIO_write() always writes 10 words per line so long as there
    * are enough, producing a partial line only if necessary.  There are
    * no spaces before the ASCII of the hexadecimal words.  The dense
    * formatting preserves compatibility with DieHard format.
    *
    * The file *fp must be opened for writing before calling this function.
    *
    * Standard output (stdout) may also be used, whether or not being
    * redirected to a file.  When not expected to be redirected, as when
    * testing small streams, nwords should not be large.
    *
    * for non-standard outputs, perform fclose(fp) when done with all writing.
   */


int nfoGenAIO_read(uint32_t *buf, int nwords, FILE *fp);
    /* reads up to nwords values decoded from ASCII hexadecimal format into
     * buf[].
     *
     * nfoGenAIO_read() accepts input formatted in the form produced by the
     * same nwords output via nfoGenAIO_write().
     *
     * The return value is the number of words actually read.  It
     * may be less than nwords if end-of-file is reached before nwords
     * values are read.
     *
     * If an error occurs during reading, 0 is returned.
     *
     * Use feof(fp) to check for end-of-file, and ferror(fp) to check
     * for read errors.
     *
     * The file *fp must be opened for reading before calling this function.
     * Any subsequent closing of file *fp is the responsibility of the caller.
     * standard input (stdin) may also be used, whether or not being
     * redirected from a file.
     *
     * IMPORTANT: **********************************************************
     *    nfoGenAIO_read() operations must all be performed with the
     *    same FILE *fp parameter. And no other use of that source should be
     *    made until nfoGenAIO_read() usage has completed. Otherwise, buffered
     *    data in nfoGenAIO_read() may be lost and further operation
     *    interfered with.
     * *********************************************************************
     *
     * nfoGenAIO_read() is forgiving of whitespace.  Any spaces and line
     * breaks between hexadecimal word values and at the beginning and ends
     * of lines are simply ignored.
     *
     * nfoGenAIO_read() also ignores blank lines and lines beginning with "#".
     *
     * The number of words per line also doesn't matter, so long as lines are
     * never close to NFOGENAIO_MAX_LINE characters.
     *
     * If the last line read from has additional hexadecimal words beyond the
     * nwords amount successfully read, they will be included on the next call
     * to nfoGenAIO_read().
     */

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

0.2.3  2025-12-05T00:31Z Align nfoGenAIO.h and nfoGenAIO.c version numbers
0.2.1  2025-12-02T21:01Z Add and align NFOGENAIO_VERSION with nfoGenAIO.c
0.2.0  2025-12-01T23:45Z Introduce NFOGENAIO_MAX_LINE and smooth descriptions
0.1.0  2025-11-29T22:11Z Clean up nfoGenAIO_read() description.
0.0.2  2025-11-28:23:50Z Fix words per line and revise write error return
0.0.1  2025-11-28T18:03Z Tighten/touch-up descriptions
0.0.0  2025-11-26T03:11Z Initial version.

                          *** end of nfoGenAIO.h ***

   */
