/* VCrayConfirm.c 0.1.14               UTF-8                       2023-05-03
   -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

                    CONFIRMATION OF RAYLIB APP CACHE SETUP

   ************************************************************************
   *                                                                      *
   * THIS PROGRAM IS MEANT TO BE RETAINED IN A VCrayApp cache\ FOLDER AND *
   * USED INTERNALLY BY VcrayApp.bat.  IT IS ONLY SUPPORTED AS INTENDED   *
   * IN THAT LOCATION WITHIN VCrayApp RELEASES AND ANY EMBEDDED USAGE.    *
   *                                                                      *
   ************************************************************************

   raylib is licensed under an unmodified zlib/libpng license (View raylib.h
   for details).

   VCrayConfirm.c is inspired by raylib/projects/scripts/core_basic_windows.c
   Copyright (c) 2013-2016 Ramon Santamaria (@raysan5).  VCrayConfirm.c has
   more details and dependency on operation under VCrayApp.bat.

   VCrayConfirm is used following successful compilation of the VCrayApp
   cache of raylib .obj files to demonstrate a successful build, confirming
   working of the cache with VC/C++ under a VS Developer Command Prompt.

   For further details, see <https://orcmid.github.io/nfoTools/dev/D211101>
   and, for background, <https://orcmid.github.io/nfoTools/tools/>.

   VCrayConfirm.c FEATURES REQUIRE STANDARD C11 OR LATER COMPILATION.

   */

#define VCRAYCONFIRM "VCrayConfirm 0.1.14"

#include <stddef.h>   // for NULL
#include <string.h>   // for strncat_s(), strncmp()
#include <stdbool.h>  // for bool type, true and false

#include <raylib.h>   // for the raylib API

#ifdef _MSC_VER
 #pragma warning(disable: 4996)
   /* Do not warn about getenv() */
#endif
#define _CRT_SECURE_NO_WARNINGS

#include <stdlib.h>   // for getenv() and exit()

    // *** IMPORTANT ***
    // VCrayConfirm usages of getenv() are both thread safe and safe from any
    // buffer over-runs in the line[] arrays.  For this reason, and this
    // reason alone, compiling with _CRT_SECURE_NO_WARNINGS is safe.
    // This technique is specific to VC/VC++ and Standard C11 or later.

int main(void)
{   // SETUP DISPLAYED TEXT LINES
    // **************************
    // getenv() is used to snag environment variable values quickly into
    // strings so that getenv() can then be reused for a different variable.

    #define LINE_MAX 200
    // A length that should never be reached in any of the built strings.

    // INCORPORATE VSCMD_VER IN THE line1[] TOP MESSAGE.
    // -------------------------------------------------

    char *pVCcmdVer = getenv("VSCMD_VER");
    if (pVCcmdVer == NULL)
         pVCcmdVer = "unknown";

    char line1[LINE_MAX+1] = { '\0'};
         // assuring always a final '\0' "after" the buffer.
         // See definition of strncat about this.

    strncat_s( line1, LINE_MAX,
               "Compiling with VC/C++ VS version ", _TRUNCATE);
    strncat_s( line1, LINE_MAX,
               pVCcmdVer, _TRUNCATE);

    // CAPTURE VCRAYVER verstring[] FOR REPORTING
    // ------------------------------------------

    char *pVCrayVer = getenv("VCRAYVER");
    if (pVCrayVer == NULL)
         pVCrayVer = "unidentified version";

    char verstring[LINE_MAX+1] = { '\0' };

    strncat_s( verstring, LINE_MAX,
               pVCrayVer, _TRUNCATE);
        // capturing VCRAYVER

    // INCORPORATE verstring[] IN THE line2[] MESSAGE
    // ----------------------------------------------

    char line2[LINE_MAX+1] = { '\0' };

    strncat_s( line2, LINE_MAX,
               "Using raylib ", _TRUNCATE);
    strncat_s( line2, LINE_MAX,
               verstring, _TRUNCATE);


    // DETERMINE VARIABLE INFORMATION
    // ******************************
    // These determinations will govern subsequent messages
    // in the confirmation display.


    // DETERMINE IF A DEV VERSION IS BEING USED
    // ----------------------------------------
    // this will be false if VCRAYVER is unidentified

    bool isDev = false;
    int i = 0;

    while ( verstring[i] )
          if ( !strncmp(&verstring[i++], "-dev\"", 5) )
               { isDev = true;
                 break; }

    // ADAPT TO VCAPPEXE, AND VCAPPSRC CASES
    // -------------------------------------

    // DETERMINE isSRC, isDefault, AND VCSRC[]
    char VCSRC[LINE_MAX+1] = { '\0' };

    bool isSRC = true;
    char *pVCappSRC = getenv("VCAPPSRC");
    if( pVCappSRC == NULL )
         { pVCappSRC = "not defined";
           isSRC = false; }

    strncat_s( VCSRC, LINE_MAX,
               pVCappSRC, _TRUNCATE );

    bool isDefault = false;
    if ( !strncmp(VCSRC, "src\\*.c", 10) )
         { isDefault = true;
           strncat_s( VCSRC, LINE_MAX,
                      " (default)", _TRUNCATE );
           }

    // DETERMINE hasEXE AND VCEXE[]
    char VCEXE[LINE_MAX+1] = { '\0' };

    bool hasEXE = true;
    char *pVCappEXE = getenv("VCAPPEXE");
    if ( pVCappEXE == NULL)
         { pVCappEXE = "not defined";
           hasEXE = false; }

     strncat_s( VCEXE, LINE_MAX,
               pVCappEXE, _TRUNCATE );


    // IDENTIFY SOURCE IN line3[] DEFINED OR NOT
    // -----------------------------------------

    char line3[LINE_MAX+1] = { '\0' };
    strncat_s( line3, LINE_MAX,
               "SRC is ", _TRUNCATE);
    strncat_s( line3, LINE_MAX,
               VCSRC, _TRUNCATE );

    // IDENTIFY EXE IN line4[], DEFINED OR NOT
    // ---------------------------------------

    char line4[LINE_MAX+1] = { '\0' };
    strncat_s( line4, LINE_MAX,
               "EXE is ", _TRUNCATE);
    strncat_s( line4, LINE_MAX,
               VCEXE, _TRUNCATE );


    // DETERMINE hasHostName AND VCrayAppHost[]
    // ----------------------------------------

    char VCrayAppHost[LINE_MAX+1] = { '\0' };

    bool hasHostName = true;
    char *pVCrayAppHost = getenv("VCrayAppHost");
    if ( pVCrayAppHost == NULL )
         {  pVCrayAppHost = "not defined";
            hasHostName = false; }

    strncat_s( VCrayAppHost, LINE_MAX,
               pVCrayAppHost, _TRUNCATE);

    // DETERMINE hasURL AND VCrayAppHostURL[]
    // --------------------------------------

    char VCrayAppHostURL[LINE_MAX+1] = { '\0' };

    bool hasURL = true;
    char *pVCrayAppHostURL = getenv("VCrayAppHostURL");
    if (pVCrayAppHostURL == NULL)
         { pVCrayAppHostURL = "not defined";
           hasURL = false; }

    strncat_s( VCrayAppHostURL, LINE_MAX,
               pVCrayAppHostURL, _TRUNCATE);

    // DETERMINE isSpliced WHETHER HOST NAMED OR NOT
    // ---------------------------------------------

    char *pVCsplice = getenv("VCsplice");
    if (pVCsplice == NULL)
         pVCsplice = "";
    bool isSpliced = !strncmp(pVCsplice, "+", 1);


    // PREPARE IDENTIFICATION OF HOST AND URL IN CASE RELEVANT
    // -------------------------------------------------------

    char line5[LINE_MAX+1] = { '\0' };
    strncat_s( line5, LINE_MAX,
               "Host ", _TRUNCATE);
    strncat_s( line5, LINE_MAX,
               VCrayAppHost, _TRUNCATE);


    char line6[LINE_MAX+1] = { '\0' };
    strncat_s( line6, LINE_MAX,
               "URL ", _TRUNCATE );
    strncat_s( line6, LINE_MAX,
               VCrayAppHostURL, _TRUNCATE );


    // RAYLIB DISPLAY
    // **************


    const int screenWidth = 800;
    const int screenHeight = 450;

    InitWindow(screenWidth, screenHeight,
               "VCrayApp 0.1.0 (beta) Cache Confirmation");

    SetTargetFPS(60);

    // MAIN DISPLAY LOOP
    // -----------------

    while (!WindowShouldClose())    // Detect window close button or ESC key
    {
        // Draw
        //--------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText(VCRAYCONFIRM,
                     90, 50, 20, GRAY);

            DrawText(line1, // VS Command Prompt version
                     90, 100, 20, BLUE);
            DrawText("17.5.0 and later have "
                     "improved C99/C11 support.",
                     140, 130, 20, GRAY);

            DrawText(line2, // presumed raylib Version
                     90, 160, 20, BLUE);

            int nextLine = 185;
                // used as something like a line counter

            if (isDev)
                 { DrawText("Thank you for testing with a -dev version.",
                            140, nextLine, 20, GRAY);
                   DrawText("When stable builds required, "
                            "use a release version.",
                            140, nextLine+25, 20, GRAY);
                   nextLine += 55; }

            DrawText(line3, // SRC location
                     90, nextLine, 20, BLUE );
            DrawText(line4, // EXE location
                     90, nextLine+25, 20, BLUE);
            nextLine += 60;

            if (hasHostName || isSpliced)
                 { DrawText( line5, // Host Name
                             90, nextLine, 20, BLUE );
                   DrawText( line6, // URL
                             90, nextLine+25, 20, GRAY );
                   nextLine += 50;
                   }

            if (isSpliced && !hasHostName)
                 { DrawText( "Embedded operation (option \"+\") "
                             "should have a host.",
                             90, nextLine, 20, RED);
                   DrawText( "See <https://orcmid.github.io/nfoTools/"
                             "dev/D211101/D211101b>",
                             140, nextLine+25, 20, GRAY );
                   }

            DrawText("Press ESC to Continue",
                     90, 400, 20, BLUE);

        EndDrawing();
        //--------------------------------------------------------------------
        }

    // De-Initialization
    //------------------------------------------------------------------------
    CloseWindow();        // Close window and OpenGL context
    //------------------------------------------------------------------------

    exit(EXIT_SUCCESS);
}

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

   0.1.14 2023-05-03T20:28z Align with revised VCrayApp.bat API
   0.1.13 2023-04-08T21:35Z Clearsign as release candidate now
   0.1.12 2023-04-08T21:22Z Provide link to further information
   0.1.11 2023-04-05T17:42Z Clearsign as release candidate
   0.1.10 2023-04-03T21:37Z Adjust to the embedding changes in VCrayApp.bat
   0.1.9 2023-03-10T02:16Z Complete draft beta candidate
   0.1.8 2023-03-02T21:08Z Capture VCrayAppHost and VCrayAppHostURL presence.
   0.1.7 2023-02-27T20:19Z Defend against getenv() NULL returns
   0.1.6 2023-02-26T20:16Z VCrayApp 0.1.0 Release candidate
   0.1.5 2023-02-25T01:41Z Complete analyzing/reporting versions
   0.1.4 2023-02-24T19:55Z Touch-up comments and display layout, suppress
         getenv safety warnings
   0.1.3 2023-02-23T21:57Z Add announcements of RAYVER and VSCMD_VER
   0.1.2 2023-02-23T17:24Z Bring message lines closer together, clean exit
   0.1.1 2023-02-23T18:57Z Initial adjustments to new name and purpose.
   0.1.0 2023-01-14T18:52Z Adapt to reflect VCRayApp 0.1.0 (beta)
   0.0.1 2021-11-06T16:35Z draft reformatting and commentary
   0.0.0 2021-11-04T23:33Z boilerplate core_basic_windows.c distributed in the
         raylib 3.7.0.zip release downloaded 2021-10-08T00:41

                        *** end of VCrayConfirm.c ***
*/
