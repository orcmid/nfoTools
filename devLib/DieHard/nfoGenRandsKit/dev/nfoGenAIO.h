/* nfoGenAIO.h 0.1.0                UTF-8                         2025-11-29
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
*   10 words per line, 8 hexadecimal digits per word.  (Note that the last
*   line has only 6 words.)  nfoGenAIO.h provides procedures to read and
*   write such streams.
*
*   This implementation provides any size of data stream blocks, in any
*   mixture, not just ones of 4096 words.  For compatibility with DieHard,
*   however, blocks of 4096 words should be used with no variation.
*/

#include <stdio.h>

#include <stdint.h>


size_t nfoGenAIO_write(uint32_t *buf, size_t nwords, FILE *fp);
   /* writes nwords values from from buf[] to fp in ASCII hexadecimal
    * format, up to 10 words per line, always starting at the beginning of a
    * line.
    *
    * The return value is the number of words written.  It will
    * be the same as nwords unless an error occurs.
    *
    * When the return value does not match nwords, an error has occurred
    * and EOF is returned.
    *
    * nfoGenAIO_write() always writes 10 words per line so long as there
    * are enough, producing a partial line only if necessary  There are
    * no spaces between the ASCII of successive hexadecimal words.  The
    * dense formatting preserves compatibility with DieHard format.
    *
    * The file *fp must be opened for writing before calling this function.
    *
    * Standard output (stdout) may also be used, whether or not being
    * redirected to a file.  When not expected to be redirected, as when
    * testing small streams, nwords should not be large.
    *
    * for non-standard outputs, remember to fclose(fp) when done writing.
   */


size_t nfoGenAIO_read(uint32_t *buf, size_t nwords, FILE *fp);
    /* reads up to nwords values encoded in ASCII hexadecimal format into
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
     * nfoGenAIO_read is forgiving of whitespace.  Any spaces and line breaks
     * breaks between hexadecimal word values are simply ignored.
     *
     * The number of words per line also doesn't matter, so long as lines are
     * no longer than around 128 characters.
     *
     * nfoGenAIO_read() also ignores blank lines and lines beginning
     * with "#".
     *
     * If the last line read from has additional hexadecimal words beyond the
     * nwords amount successful read, they will be included on the next call
     * to nfoGenAIO_read().
     */

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*


0.1.0  2025-11-29T22:11Z Clean up nfoGenAIO_read() description.
0.0.2  2025-11-28:23:50Z Fix words per line and revise write error return
0.0.1  2025-11-28T18:03Z Tighten/touch-up descriptions
0.0.0  2025-11-26T03:11Z Initial version.

                          *** end of nfoGenAIO.h ***

   */
