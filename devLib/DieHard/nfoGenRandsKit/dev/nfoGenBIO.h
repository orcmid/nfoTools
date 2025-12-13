/* nfoGenBIO.h 0.0.2                UTF-8                         2025-12-12
** -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
*
*                 nfoGenBIO Binary Input/Output Data Files
*                 ----------------------------------------
*
*   nfoGenBIO is a mostly-header library.  Mostprocedures are simple and will
*   likely be expanded inline by optimizing compilers.
*
*   nfoGenBIO procedures provide utility input and output of binary data
*   streams in pure binary format.  Data is read and written in 32-bit words
*   of 8-bit bytes.
*
*   These binary streams correspond to the preferred format employed in George
*   Marsaglia's DieHard battery of RNG tests.  Those streams have blocks of
*   4096 32-bit words.
*
*   IMPORTANT: nfoGenBIO-formatted files are intended for generated data
*      retained only long enough for processing in DieHard (and other) tests.
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

#define NFOGENBIO_VERSION "nfoGenBIO-0.0.1"
   /* Version string for this nfoGenBIO module.
      */

#include <stdint.h>
#include <stdio.h>

/* XXX: Use L_tmpnam as the size of string to get a generated temporary
        filename.
        Following the last read and closing of an input file, a remove
        operation might be performed.  This should be the case if the name
        is obtained via piping.  This could be confusing.  Think this through.
        Maybe need L_tmpnam_s and tmpnam_s( ).
          In C11, these are part of an Extended Library.  I need to know if
        that changes for later versions of the ISO C Language Standard.
          One problem is I want temporary files to be in the current working
        directory, not the global TMP or TEMP locations.
          The examples on Windows show complete paths into AppData.  That's
        undesirable because of file sizes and limited C:\ capacity.
          On Windows it is possible to fudge the TMP environment variable
        and then fudge it back to the TEMP value ???
        */

size_t nfoGenBIO_write(uint32_t *buf, size_t nwords, FILE *fp)
  { /* writes nwords values from buf[0] to buf[nwords-1] out to fp in direct
    *  binary format.
    *
    * The file *fp must be opened for writing before calling this function.
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

0.0.1  2025-12-12T20:35Z Complete read and write procedures
0.0.0  2025-12-12T01:27Z Initial draft.

                          *** end of nfoGenBIO.h ***

   */
