/* VCshowDefs.c 1.1.0               UTF-8                         2023-02-12
 * -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
 *
 *             SHOW PRESENCE OF VISUAL C/C++ PREPROCESSOR DEFINES
 *
 *      Program to report on selected compiler definitions that were
 *      set or not when it was compiled.
 *
 *      Compile this program as a console application in any configura-
 *      tion of a VC/C++ compiler.  Execution of the program prints a
 *      a list of selected pre-processor variables with either their
 *      value, the notation "is defined" or the notation "undefined".
 *
 *   Copyright 2005, 2014, 2021 Dennis E. Hamilton
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
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
                                     : TV(is defined to X) ), \
                           stdout); \
                    fputc('\n', stdout);

      /* The macro prints a line where the token X is right-justified
         after the string of spaces SP, and then followed with one of
         " is defined" (with no value), " undefined" (with no value)
         or " is defined to " followed by what X is #define-ed to.
         See the body of main() to see how to add and vary the pre-
         processor definitions to check for.
            See the companion file, showdefs.txt for ways to compile
         the program to discover the settings that were applied at
         compile time.
            See the main() function for declaration of the string
         variable tv that is set and used in the SHOW macro.
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

       fputs(  "VCshowDefs> 1.0.25 Check for documented pre-processor macros",
              stdout);
       fputs("\n            that might be predefined in this compile.\n",
              stdout);


       fputs("\n  Supported ANSI/ISO Macros:\n", stdout);

       SHOW(__DATE__, "                ");
       SHOW(__FILE__, "                ");
       SHOW(__LINE__, "                ");
       SHOW(__STDC__, "                ");
       SHOW(__STDC_HOSTED__, "         ");
       SHOW(__STDC_IEC_559__, "        ");
       SHOW(__STDC_IEC_599_COMPLEX__, "");
       SHOW(__STDC_ISO_10646__, "      ");
       SHOW(__STDC_VERSION__, "        ");
       SHOW(__TIME__, "                ");

       fputs("\n  Supported (VC++?) reflection support:\n", stdout);

       SHOW(__COUNTER__, "             ");
       SHOW(__cplusplus, "             ");
       SHOW(__FSTREXP, "               ");
       SHOW(__FUNCTION__, "            ");
       SHOW(__FUNCDNAME__, "           ");
       SHOW(__FUNCSIG__, "             ");
       SHOW(__TIMESTAMP__, "           ");

       fputs("\n  VC++ MS-Specific Macros:\n", stdout);

       SHOW(_ATL_VER, "                ");
       SHOW(_CHAR_UNSIGNED, "          ");
       SHOW(_CPPLIB_VER, "             ");
       SHOW(_CPPRTTI, "                ");
       SHOW(_CPPUNWIND, "              ");
       SHOW(_DEBUG, "                  ");
       SHOW(_DLL, "                    ");
       SHOW(_M_ALPHA, "                ");
       SHOW(_M_AMD64, "                ");
       SHOW(_M_IA64, "                 ");
       SHOW(_M_IX86, "                 ");
       SHOW(_M_MPPC, "                 ");
       SHOW(_M_MRX000, "               ");
       SHOW(_M_PPC, "                  ");
       SHOW(_MANAGED, "                ");
       SHOW(_MFC_VER, "                ");
       SHOW(_MSC_EXTENSIONS, "         ");
       SHOW(_MSC_VER, "                ");
       SHOW(__MSVC_RUNTIME_CHECKS, "   ");
       SHOW(_MT, "                     ");
       SHOW(_NATIVE_WCHAR_T_DEFINED, " ");
       SHOW(_WCHAR_T_DEFINED, "        ");
       SHOW(_WIN32, "                  ");
       SHOW(_WIN64, "                  ");

       fputs("\n  And some favorites when compiling Windows code:\n",
             stdout);

       SHOW(_INC_WINDOWS, "            ");
       SHOW(_MAC, "                    ");
       SHOW(RC_INVOKED, "              ");
       SHOW(WIN32_LEAN_AND_MEAN, "     ");
       SHOW(_WIN32NLS, "               ");
       SHOW(_WINDEF_, "                ");
       SHOW(_WINDOWS_, "               ");
       SHOW(__WINDOWS__, "             ");
       SHOW(WINVER, "                  ");
       SHOW(_X64_, "                   ");
       SHOW(_X86_, "                   ");



       /* This list can be extended to check known predefines of
          other compilers too.  This program is the basis for
          being able to confirm the settings and options as part
          of making sure that a build condition is reproducible by
          making defaults explicit.
          */

       return 0;

       } /* main() */


/*  1.1.0  2023-02-12T22:48T Claw back from Maiko version as general utility
 *  1.0.26 2021-11-28T21:54Z Add Byte order checking
 *  1.0.25 2021-11-28T21:36Z Introduce in MAIKO windev branch
 *  1.0.24 2021-11-28T21:05Z Update for MAIKO settings, touching up
 *    1.00 2005-09-13-16:09 This programs uses preprocessor tricks to see
 *         what the settings of possibly pre-defined macros are.
 *
 * $Header:  $
 */
/*                        *** end of VCshowDefs.c ***                      */
