/* nfoGenBIO.h 0.1.1                UTF-8                         2025-12-29
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
*   Note: These files may not be appropriate for piping/redirecting because
*         they do not have text formatting and may be misinterpreted.  It
*         might be useful to pipe the names of the files.
*    XXX: Experimental use of binary piping is being introduced to confirm
*         that it is feasible in some environments, especially on Windows.
*
*   -----------------------------------------------------------------------
*    Attribution: This program is copilot assisted and scientist reviewed.
*   -----------------------------------------------------------------------
*/

#define NFOGENBIO_VERSION "nfoGenBIO-0.1.1"
   /* Version string for this nfoGenBIO module.  It is coordinated with the
    * version in nfoGenBIO-*.c for the platform-specific components.
    */

#include <stdbool.h>

#include <stdint.h>

#include <stdio.h>

#include <string.h>

bool isGenBIO_terminal( FILE *fp );
   /* Returns true if the given FILE* is associated with a terminal device
    * (console, terminal window, etc.) rather than a disk file or pipe.
    *    Note that stdin and stdout may be associated with terminal devices
    * or with files or pipes, depending on how the program is run.
    *    nfGenBIO I/O should not be performed on terminal devices and an
    * explicit (temp) file name should be supplied instead.
    */

FILE* nfoGenBIO_startOutput( char *template, int templateSize);
    /* Generate a temporary file name based on template, open it for binary
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

     * Otherwise, a non-NULL FILE* is returned for use in nfoGenBIO_write()
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
     * a typical modification of the template string (and used in fopen)
     * is something like "tmp/nfoGenBIOa04862" consisting of a letter and
     * five digits in place of the six 'X'.
     *
     * A relative path, such as that shown, is relative to the current
     * working directory.
     *
     * Note that '/' is usable as the path separator even on Windows systems.
     */



size_t nfoGenBIO_write(uint32_t *buf, size_t nwords, FILE *fp)
  { /* writes nwords of values from buf[0] to buf[nwords-1] to fp in direct
     *  binary format.
     *
     * The file *fp must be opened for binary writing before calling this
     * function.  nfoGenBIO_startOutput() is designed for this purpose.
     * If an output is being redirected, with no filename specified, stdout
     * may be used, but only if it is not associated with a terminal device.
     * In this case, and as a precaution, stderr should be used for all
     * messages.
     *
     * The return value is the number of words actually written.  It may be
     * less than nwords if an error occurs during writing or if the the space
     * available for the file is exhausted.
     *
     * Standard outputs (stdout and stderr) must not be used.
     * XXX: Need to confirm whether binary output to stdout is feasible.
     *
     * Perform fclose(fp) when all writing is complete.
     * XXX: Need to consider whether fflush(fp) is needed or useful here.
     *      Also need to ensure that fclose(stdout) is not a problem.
     */

     if (buf == NULL || fp == NULL || nwords == 0)
          return 0;

     return fwrite(buf, sizeof(uint32_t), nwords, fp);

     } /* nfoGenBIO_write */


FILE* nfoGenBIO_startInput( char *filename, size_t filenameSize)
    {  /* Open the file named in filename[] for binary reading and return
        * FILE* for the opened file.
        *
        * If filename is NULL or filenameSize < 1, NULL is returned.
        *
        * If the file cannot be opened for reading, NULL is also returned.
        *
        * Otherwise, a non-NULL FILE* is returned for use in nfoGenBIO_read()
        *
        * The supplied filename string must be a legitimate file (relative or
        * absolute) path and name with no spaces.  One generated by
        * nfoGenBIO_startOutput() is suitable, with default for the same
        * working directory.
        *
        * NOTE: This procedure is not appropriate if the input is being
        *       taken from stdin (piped input).  In that case, stdin should be
        *       used directly in nfoGenBIO_read().
        */

        if ( filename == NULL || filename[0] == '\0' )  return NULL;

        if (strlen_s(filename, filenameSize) == filenameSize) return NULL;
            /* filename[ ] must be an ASCII string of length less than
               filenameSize not including the '\0' terminator
               */

        FILE* inputFile;

        if (fopen_s(&inputFile, filename, "rb" ) != 0 ) return NULL;

        return inputFile;

        } /* nfoGenBIO_startInput */


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
     * XXX: Need to consider whether fflush(fp) is needed or useful here.
     *      Also need to ensure that fclose(stdin) is not a problem.
     */

     if (buf == NULL || fp == NULL || nwords == 0)
          return 0;

     return fread(buf, sizeof(uint32_t), nwords, fp);
     }

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

0.1.1  2025-12-29T20:07Z Add isGenBIO_terminal( ) and consider redirections.
0.1.0  2025-12-26T23:56Z Complete nfo nfoGenBIO_startInput( ) along with
       nfoGen_startOutputdescription to include templateSize parameter.
0.0.6  2025-12-22T19.25Z Touch up and explain template[ ] usage in
       nfoGenBIO_startOutput( ).
0.0.5  2025-12-20T01:56Z Update nfoGenBIO_startOutput( ) prototype, touch up.
0.0.4  2025-12-19T22:22Z Cleanup, add StartOutput prototype and description
0.0.3  2025-12-16T05:30Z (skipped, used in error at top of 0.0.2)
0.0.2  2025-12-16T05:30Z More pondering, touching up comments.
0.0.1  2025-12-12T20:35Z Complete read and write procedures
0.0.0  2025-12-12T01:27Z Initial draft.

                          *** end of nfoGenBIO.h ***

   */
