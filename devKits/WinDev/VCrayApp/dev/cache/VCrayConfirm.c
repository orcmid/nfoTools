/* VCrayConfirm.c 0.1.9               UTF-8                       2023-03-10
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

#define VCRAYCONFIRM "VCrayConfirm 0.1.9"

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
    // --------------------------

    #define LINE_MAX 200
    // A length that should never be reached.

    // INCORPORATE VSCMD_VER IN THE LINE1 MESSAGE.

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

    // CAPTURE VCRAYVER FOR REPORTING AND ALSO SPECIAL CASES

    char *pVCrayVer = getenv("VCRAYVER");
    if (pVCrayVer == NULL)
         pVCrayVer = "unknown";

    char verstring[LINE_MAX+1] = { '\0' };

    strncat_s( verstring, LINE_MAX,
               pVCrayVer, _TRUNCATE);
        // capturing VCRAYVER

    // incorporate VCRAYVER in the line2 message.
    char line2[LINE_MAX+1] = { '\0' };

    strncat_s( line2, LINE_MAX,
               "Using raylib ", _TRUNCATE);
    strncat_s( line2, LINE_MAX,
               verstring, _TRUNCATE);

    // DETERMINE VARIABLE INFORMATION
    // determine whether a Dev version is being used
    bool isDev = false;
    int i = 0;

    while ( verstring[i] )
          if ( !strncmp(&verstring[i++], "-dev\"", 5) )
               { isDev = true;
                 break; }

    // ADAPT TO HOSTING, APP_EXE, AND SRC CASES


    // Determine isSRC and VCSRC[]
    char VCSRC[LINE_MAX+1] = { '\0' };

    bool isSRC = true;
    char *pVCappSRC = getenv("VCAPPSRC");
    if( pVCappSRC == NULL )
         { pVCappSRC = "not defined";
           isSRC = false; }

    strncat_s( VCSRC, LINE_MAX,
               pVCappSRC, _TRUNCATE );

    // Determine isEXE, hasName, and VCEXE[]
    char VCEXE[LINE_MAX+1] = { '\0' };

    bool isEXE = true;
    char *pVCappEXE = getenv("VCAPPEXE");
    if ( pVCappEXE == NULL)
         { pVCappEXE = "not defined";
           isEXE = false; }

     strncat_s( VCEXE, LINE_MAX,
               pVCappEXE, _TRUNCATE );

    bool hasName = true;
    if ( !strncmp(pVCappEXE, "RenameMe.exe", 12) )
         { hasName = false;
           strncat_s( VCEXE, LINE_MAX,
                      " (needs replacing)", _TRUNCATE );
           }

    // Identify Source, defined or not
    char line3[LINE_MAX+1] = { '\0' };
    strncat_s( line3, LINE_MAX,
               "SRC is ", _TRUNCATE);
    strncat_s( line3, LINE_MAX,
               VCSRC, _TRUNCATE );

    // Identify EXE, defined or not
    char line4[LINE_MAX+1] = { '\0' };
    strncat_s( line4, LINE_MAX,
               "EXE is ", _TRUNCATE);
    strncat_s( line4, LINE_MAX,
               VCEXE, _TRUNCATE );


    // Determine isHosted and VCrayAppHost[]
    char VCrayAppHost[LINE_MAX+1] = { '\0' };

    bool isHosted = true;
    char *pVCrayAppHost = getenv("VCrayAppHost");
    if ( pVCrayAppHost == NULL )
         {  pVCrayAppHost = "No identified host";
            isHosted = false; }

    strncat_s( VCrayAppHost, LINE_MAX,
               pVCrayAppHost, _TRUNCATE);

    // Determine hasURL and VCrayAppHostURL[]
    char VCrayAppHostURL[LINE_MAX+1] = { '\0' };

    bool hasURL = true;
    char *pVCrayAppHostURL = getenv("VCrayAppHostURL");
    if (pVCrayAppHostURL == NULL)
         { pVCrayAppHostURL = "https://example.com";
           hasURL = false; }

    strncat_s( VCrayAppHostURL, LINE_MAX,
               pVCrayAppHostURL, _TRUNCATE);

    // Identify Any Host
    char line5[LINE_MAX+1] = { '\0' };
    strncat_s( line5, LINE_MAX,
               VCrayAppHost, _TRUNCATE);
    strncat_s( line5, LINE_MAX,
               " is operating VCrayApp", _TRUNCATE);

    // Identify Any Host URL (used only if also isHosted)
    char line6[LINE_MAX+1] = { '\0' };
    strncat_s( line6, LINE_MAX,
               "See ", _TRUNCATE );
    strncat_s( line6, LINE_MAX,
               VCrayAppHostURL, _TRUNCATE );


    // RAYLIB INITIALIZATION
    //----------------------
    const int screenWidth = 800;
    const int screenHeight = 450;

    InitWindow(screenWidth, screenHeight,
               "VCrayApp 0.1.0 (beta) Cache Confirmation");

    SetTargetFPS(60);

    // MAIN RAYLIB GAME LOOP
    // ---------------------

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

            if (isHosted)
                 { DrawText(line5, // Host Name
                            90, nextLine, 20, BLUE );
                   if (hasURL)
                        { DrawText( line6, // URL only if Host
                                    90, nextLine+25, 20, GRAY );
                          nextLine += 50; }
                   else nextLine +=30;
                   }

            if (isHosted)
                 DrawText( "Settings are controlled by the host.",
                           140, nextLine, 20, GRAY );
            else if (!hasName || !isSRC)
                     DrawText( "Adjust the VCrayApp.bat settings"
                               " to compile project code.",
                               90, nextLine, 20, RED);

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
