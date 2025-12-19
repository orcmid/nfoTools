/* nfoGenBIO.h 0.0.4                UTF-8                         2025-12-19
** -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
*                 nfoGenBIO Binary Input/Output Data Files
*                 ----------------------------------------
*
*   nfoGenBIO is a mostly-header library.  Most procedures are simple and will
*   likely be expanded inline by optimizing compilers.
*
*   nfoGenBIO procedures provide utility input and output of binary data
*   streams in pure binary format.  Data is read and written in 32-bit words
*   of 8-bit bytes.
*
*   These binary streams correspond to the preferred format employed in George
*   Marsaglia's DieHard battery of RNG tests.  Those streams are produced and
*   consumed in blocks of 4096 32-bit words.
*
*   IMPORTANT: nfoGenBIO-formatted files are intended for generated data
*      retained only long enough for processing in DieHard and similar tests.
*      The files need not be retained further, and they are not suitable for
*      interchange.  When used as streams of random-number generator output,
*      they are theoretically not compressible for storage (something that
*      should be demonstratable).
*
*   The binary format used by nfoGenBIO is not compatible with standard
*   text-based formats. It is also not suitable for interchange from one
*   computer to another because of differences in internal representations and
*   their communication in binary formats.
*
*   Note: These files are not appropriate for piping/redirecting because the
*         do not have text formatting and may be misinterpreted.  However,
*         it can be useful to pipe the names of the files.
*/

#define NFOGENBIO_VERSION "nfoGenBIO-0.0.4"
   /* Version string for this nfoGenBIO module.  It is coordinated with the
    * version in nfoGenBIO-*.c for the platform-specific components.
    */

#include <stdint.h>

#include <stdio.h>


FILE* nfoGenBIO_startOutput( char *template);
    /* Generate a temporary file name based on template, open it for binary
     * writing, and return the FILE* for the opened file. The template string
     * is replaced with the created filename.
     *
     * If template is NULL or the string is in incorrect format, NULL is
     * returned.
     *
     * If the generated filename cannot be opened for writing, NULL is also
     * returned. In this case, template has been modified.

     * Otherwise, a non-NULL FILE* is returned for use in nfoGenBIO_write()
     * operations.  The file can also be rewound and read.  Perform fclose()
     * when all writing and any reading, are complete.
     *
     * The modified template can also be communicated for use in a subsequent
     * file-open operation in the same or different application.
     *
     * TODO: Explain template format and usage for use in conjunction with
     *       nfoGenRands and DieHard tests.
     */


size_t nfoGenBIO_write(uint32_t *buf, size_t nwords, FILE *fp)
  { /* writes nwords of values from buf[0] to buf[nwords-1] to fp in direct
     *  binary format.
     *
     * The file *fp must be opened for binary writing before calling this
     * function.
     *
     * The return value is the number of words actually written.  It may be
     * less than nwords if an error occurs during writing or if the the space
     * available for the file is exhausted.
     *
     * Standard outputs (stdout and stderr) must not be used.
     *
     * Perform fclose(fp) when all writing is complete.
     */

    if (buf == NULL || fp == NULL || nwords == 0)
         return 0;

    return fwrite(buf, sizeof(uint32_t), nwords, fp);

    }


size_t nfoGenBIO_read(uint32_t *buf, size_t nwords, FILE *fp);
   { /* reads up to nwords values in uint32_t binary format into buf[].
     *
     * The file *fp must be opened for reading before calling this function.
     * The file must be in the format written by nfoGenBIO_write() on the same
     * system.
     *
     * The return value is the number of words actually read.  It may be
     * less than nwords if end-of-file is reached before nwords values are
     * read.
     *
     * If an error occurs during reading, 0 is returned. The status of buf[]
     * is undefined in that case.
     *
     * Use feof(fp) to check for end-of-file, and ferror(fp) to check
     * for read errors.
     *
     * Use fclose(fp) when all reading is complete.
     */

     if (buf == NULL || fp == NULL || nwords == 0)
          return 0;

     return fread(buf, sizeof(uint32_t), nwords, fp);
     }

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

0.0.4  2025-12-19T22:22Z Cleanup, add SartOutput prototype and description
0.0.3  2025-12-16T05:30Z (skipped, used in error at top of 0.0.2)
0.0.2  2025-12-16T05:30Z More pondering, touching up comments.
0.0.1  2025-12-12T20:35Z Complete read and write procedures
0.0.0  2025-12-12T01:27Z Initial draft.

                          *** end of nfoGenBIO.h ***

   */
