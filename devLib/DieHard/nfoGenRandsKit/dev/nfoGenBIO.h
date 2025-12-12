/* nfoGenBIO.h 0.0.0                UTF-8                         2025-12-12
** -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
*                 nfoGenBIO Binary Input/Output Data Files
*                 ----------------------------------------
*
*   The nfoGenBIO Utility Procedures provide input and output of binary data
*   streams in pure binary format.  Data is read and written in 32-bit words
*   of 8-bit bytes.
*
*   These binary streams correspond to the preferred format employed in George
*   Marsaglia's DieHard battery of RNG tests.  Those streams have blocks of
*   4096 32-bit words.
*
*   The C Language stdio fread( ), fwrite( ), and fpos( ) functions are rather
*   straightforward, but not so commonly used.  The nfoGenBIO functions are
*   specific to the purposes of DieHard-like operation using a simplified API.
*
*   IMPORTANT: nfoGenBIO-formatted files are intended for generated data
*      retained only long enough for processing in DieHard (and other) tests.
*      The files need not be retained further, and they are not suitable for
*      interchange.  They are not (or should not be) compressible for storage.
*
*   The binary format used by nfoGenBIO is not compatible with standard
*   text-based formats. It is also not suitable for interchange from one
*   computer to another because of differences in internal representations and
*   their communication in binary formats.
*/

#define NFOGENBIO_VERSION "nfoGenBIO-0.0.0"
   /* Version string for nfoGenBIO module.  This is updated whenever
      nfoGenBIO.c and nfoGenBIO.h are changed in any way.  The versions
      are synchronized between the two files.
      */

#include <stdint.h>
#include <stdio.h>


size_t nfoGenBIO_write(uint32_t *buf, size_t nwords, FILE *fp);
   /* writes nwords values from buf[0] to buf[nwords-1]out to fp in direct
    *  binary format.
    *
    * The file *fp must be opened for writing before calling this function.
    *
    * Standard outputs (stdout and stderr) must not be used.
    *
    * Perform fclose(fp) when all writing is complete.
   */


int nfoGenBIO_read(uint32_t *buf, int nwords, FILE *fp);
    /* reads up to nwords values in uint32_t binary format into buf[].
     *
     * The file *fp must be opened for reading before calling this function.
     * The file must be in the format written by nfoGenBIO_write() on the same
     * system.
     *
     * The return value is the number of words actually read.  It may be
     * less than nwords if end-of-file is reached before nwords values are
     * read.
     *
     * If an error occurs during reading, 0 is returned.
     *
     * Use feof(fp) to check for end-of-file, and ferror(fp) to check
     * for read errors.
     *
     */

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

    0.0.0  2025-12-12T01:27Z Initial draft.

                          *** end of nfoGenBIO.h ***

   */
