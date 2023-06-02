/* ShowC11defs.c 1.0.0              UTF-8                         2023-06-02
 * -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
 *
 *             SHOW ISO C11 SPECIFIED PREPROCESSOR DEFINES
 *
 *      Program to report on selected compiler definitions that were
 *      set or not when it was compiled.
 *
 *      Compile this program as a console application in any configura-
 *      tion of a C Language compiler.  Execution of the program prints a
 *      a list of selected pre-processor variables with either their
 *      value, the notation "is defined" or the notation "undefined".
 *
 *   Further details and additional customizations are available at
 *   <https://orcmid.github.io/nfoTools/dev/D230201>.
 */

#include <stdio.h>
      /* for stdout, fputs() and fputc() */

#include <string.h>
      /* for strlen() */

#define TV(X) #X ""
      /* Always produce a string, even when X is empty */

#define SHOW(X, SP) fputs(SP #X " ", stdout);  \
                    fputs( ( tv = TV(X), \
                             strlen(tv) == 0 \
                                ? "is defined" \
                                : strcmp(tv, #X) == 0 \
                                     ? "undefined" \
                                     : TV(=X) ), \
                           stdout); \
                    fputc('\n', stdout);

      /* See the <https://orcmid.github.io/nfoTools/dev/D230201>
         documentation for ways to compile the program and to discover
         the settings that were applied at compile time.

         **** IMPORTANT: The handling of TV(X) and #-stringification
              is not portable among all compilers.  The usage has been
              confirmed only with recent VC/C++ compilers.

         */

#ifdef _MSC_VER
#pragma warning(disable: 4003)
   /* Do not warn about TV(x) when not enough parameters (i.e., x empty) */
#endif


int main(void)
   {/* Report the status of predefined pre-processor variables that
       were defined or not when this program was compiled.
       */

       char *tv;  /* pointer to the token value string */

       fputs(  "ShowC11defs> 1.0.0 "
               "Check for C11-required pre-processor macros",
              stdout);
       fputs("\n             and their definitions in this compile.\n",
              stdout);


       fputs("\n  Required ISO C11 Definitions:\n", stdout);

       SHOW(__DATE__, "                ");
       SHOW(__FILE__, "                ");
       SHOW(__LINE__, "                ");
       SHOW(__STDC__, "                ");
       SHOW(__STDC_HOSTED__, "         ");
       SHOW(__STDC_VERSION__, "        ");
       SHOW(__TIME__, "                ");

       fputs("\n  Conditionally-definable ISO C11 Definitions:\n", stdout);
       fputs(  "  Related to Unicode Support:\n", stdout);

       SHOW(__STDC_ISO_10646__, "      "); // Unicode wchar_t support
       SHOW(__STDC_MB_MIGHT_NEQ_W__, " "); // when values wchar_t, char differ
       SHOW(__STDC_UTF_16__, "         "); // char16_t are UTF-16
       SHOW(__STDC_UTF_32__, "         "); // char32_t are UTF-32

       fputs(  "  Related to supported features:\n", stdout);

       SHOW(__STDC_ANALYZABLE__, "     ");
       SHOW(__STDC_IEC_559__, "        ");
       SHOW(__STDC_IEC_599_COMPLEX__, "");
       SHOW(__STDC_LIB_EXT1__, "       ");
       SHOW(__STDC_NO_ATOMICS__, "     ");
       SHOW(__STDC_NO_COMPLEX__, "     ");
       SHOW(__STDC_NO_THREADS__, "     ");
       SHOW(__STDC_NO_VLA__, "         ");

       fputs("\n  Only when compiled as C++:\n", stdout);
       SHOW(__cplusplus, "             ");
       SHOW(_MSVC_LANG, "              "); // VC/C++ specific


       /* This list can be extended to check known predefines of
          other compilers too.  This program is the basis for
          being able to confirm the settings and options as part
          of making sure that a build condition is reproducible by
          making defaults explicit.
          */

       return 0;

       } /* main() */


/*
 *  1.0.0  2023-06-02T21:19Z based on ShowDefs.c 1.2.1 with narrowing to C11 only.
 *
 *                       *** end of ShowC11defs.c ***                      */
