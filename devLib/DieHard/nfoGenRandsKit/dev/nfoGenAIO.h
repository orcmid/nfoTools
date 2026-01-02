/* nfoGenAIO.h 0.4.1                UTF-8                         2026-01-02
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

#define NFOGENAIO_VERSION "nfoGenAIO-0.4.1"
   /* Version string for nfoGenAIO module.  This is updated whenever
      nfoGenAIO.c and nfoGenAIO.h are changed in any way.  The versions
      are now synchronized between the two files.
      */
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

bool isGenAIO_terminal( FILE *fp );
   /* Returns true if the given FILE* is associated with a terminal device
    * (console, terminal window, etc.) rather than a disk file or pipe.
    *    Note that stdin and stdout may be associated with terminal devices
    * or with files or pipes, depending on how the program is run.
     */

FILE* nfoGenAIO_startOutput( char *template, int templateSize);
    /* Generate a temporary file name based on template, open it for ASCII
     * writing, and return the FILE* for the opened file. The template string
     * is replaced with the created filename.
     *
     * templateSize is the size of the template[] string, including the
     * '\0' terminator.
     *
     * If template is NULL or the string is in incorrect format, NULL is
     * returned.  If templateSize < 7, NULL is also returned.
     *
     * If the generated filename cannot be opened for writing, NULL is also
     * returned.

     * Otherwise, a non-NULL FILE* is returned for use in nfoGenAIO_write()
     * operations.  The file can also be rewound and read.  Perform fclose()
     * when all writing and any reading are complete.
     *
     * Only in the case of successful File Open is the template parameter
     * successfully modified to the actual filename used. In all other cases
     * the template[] value is not predictable.
     *
     * A successfully-modified template may be communicated for use in a
     * subsequent file-system operation in the same or different application.
     *
     * TEMPLATE FORMATTING
     *
     * The supplied template string must be a legitimate file (relative or
     * absolute) path and name with no spaces; and it must end with exactly
     * six 'X' characters and no extension. For example:
     * "tmp/nfoGenBIOXXXXXX".
     *
     * a typical modification of the template string (and usable in fopen)
     * is something like "tmp/nfoGenAIOa04862" consisting of a letter and
     * five digits in place of the six 'X'.
     *
     * A relative path, such as that shown, is relative to the current
     * working directory.
     *
     * Note that '/' is usable as the path separator even on Windows systems.
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

0.4.1  2026-01-02T21:44Z Synchronize version with nfoGenAIO.c
0.4.0  2026-01-02T20:57Z Add isGenAIO_terminal() and nfoGenAIO_startOutput()
0.3.0  2025-12-05T03:01Z nfoGenAIO-test2 successful run and visual check
0.2.4  2025-12-05T02:32Z Move NFOGENAIO_MAX_LINE definition to nfoGenAIO.c
0.2.3  2025-12-05T00:31Z Align nfoGenAIO.h and nfoGenAIO.c version numbers
0.2.1  2025-12-02T21:01Z Add and align NFOGENAIO_VERSION with nfoGenAIO.c
0.2.0  2025-12-01T23:45Z Introduce NFOGENAIO_MAX_LINE and smooth descriptions
0.1.0  2025-11-29T22:11Z Clean up nfoGenAIO_read() description.
0.0.2  2025-11-28:23:50Z Fix words per line and revise write error return
0.0.1  2025-11-28T18:03Z Tighten/touch-up descriptions
0.0.0  2025-11-26T03:11Z Initial version.

                          *** end of nfoGenAIO.h ***

   */
