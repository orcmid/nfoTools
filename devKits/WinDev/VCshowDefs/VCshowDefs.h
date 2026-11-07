/* VCshowDefs.h 1.0.0               UTF-8                         2026-11-07
 * -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
 *
 *             SHOW PRESENCE OF VISUAL C/C++ PREPROCESSOR DEFINES
 *
 *      Procedure to report on selected compiler definitions that were
 *      set or not when it was compiled.
 *
 *      Include this header in a console application in any configura-
 *      tion of a VC/C++ compiler.  Use the SHOW(x, SP) macro to produce
 *      any definition for the token x.
 * 
 *      The program VCshowDevs.c provides an illustrative case for the
 *      definitions that can be found in Win32 and the standard C library.
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

static char *tv; /* pointer to the token value string, used globally */

          /* The macro prints a line where the token X is justified
             after the string of spaces SP, and then followed with one of
             " is defined" (with no value), " undefined" (with no value)
             or "=" followed by what X is #define-ed to.

             See the VCShowDefs.c application to see how preprocessor
             definitions are arranged. to see how to add and vary the pre-
             processor definitions to check for.
          
             */

#ifdef _MSC_VER
#pragma warning(disable: 4003)
/* Do not warn about TV(x) when not enough parameters (i.e., x empty) */
#endif



/*
 1.0.0  2026-11-07T04:26Z Extraction from VCshowDefs.c 1.2.1
 */

/*                        *** end of VCshowDefs.h ***                      */
