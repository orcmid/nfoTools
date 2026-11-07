/* VCshowDefs2.c 1.0.0              UTF-8                         2026-11-07
 * -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
 *
 *             SHOW PRESENCE OF VISUAL C/C++ PREPROCESSOR DEFINES
 *
 *      This is a derivative of VCshowDefs.c 1.2.1 that is used to verify
 *      usage of VCshowDefs.h to achieve the same results.
 *
 *      Compile this program as a console application in any configura-
 *      tion of a VC/C++ compiler.  Execution of the program prints a
 *      a list of selected pre-processor variables with either their
 *      value, the notation "is defined" or the notation "undefined".
 *
 *   Further details and additional customizations are available at
 *   <https://orcmid.github.io/nfoTools/dev/D230201>.
 *
 *   Copyright 2005, 2014, 2021, 2023, 2026 Dennis E. Hamilton
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

#include "VCshowDefs.h"


int main(void)
   {/* Report the status of predefined pre-processor variables that
       were defined or not when this program was compiled.
       */

   
       fputs(  "VCshowDefs2> 1.0.0 Check for documented pre-processor macros",
              stdout);
       fputs("\n            that might be predefined in this compile.\n",
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

       fputs("\n  Supported (VC++) reflection support:\n", stdout);

       SHOW(__COUNTER__, "             ");
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


/*
 *  1.0.0  2026-11-07T20:35Z Adapted from VCshowDefs.c 1.2.1
  *
 * $Header:  $
 */
/*                       *** end of VCshowDefs2.c ***                      */
