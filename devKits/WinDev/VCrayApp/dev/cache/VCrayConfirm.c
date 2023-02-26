/* VCrayConfirm.c 0.1.6               UTF-8                       2023-02-26
   -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

                    CONFIRMATION OF RAYLIB APP CACHE SETUP

   ************************************************************************
   *                                                                      *
   * THIS PROGRAM IS MEANT TO BE RETAINED IN A VCrayApp cache\ FOLDER AND *
   * USED INTERNALLY BY VcrayApp.bat.  IT IS ONLY SUPPORTED AS INTENDED   *
   * IN THAT LOCATION WITHIN A VCrayApp RELEASE.                          *
   *                                                                      *
   ************************************************************************

   raylib is licensed under an unmodified zlib/libpng license (View raylib.h
   for details).

   VCrayConfirm.c is inspired by raylib/projects/scripts/core_basic_windows.c
   Copyright (c) 2013-2016 Ramon Santamaria (@raysan5).  VCrayConfirm.c has
   more details and dependency on operation under VCrayApp.bat.

   VCrayConfirm is used following successful compilation of the VCrayApp
   cache of raylib .obj files to demonstrate a successful build using that
   cache with VC/C++ under a VS Developer Command Prompt.

   For further details, see <https://orcmid.github.io/nfoTools/dev/D211101>
   and <https://orcmid.github.io/nfoTools/tools/> for additional information.

   VCrayConfirm.c FEATURES REQUIRE STANDARD C11 OR LATER COMPILATION.

   */

#include <string.h>   // for strncat_s(), strcmp(), and text-output building

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

#include <stdbool.h>  // for bool type, true and false


int main(void)
{   // SETUP DISPLAYED TEXT LINES
    // --------------------------

    #define LINE_MAX 80
    // A length that should never be reached.

    // incorporate VSCMD_VER in the first message.
    char line1[LINE_MAX+1] = { '\0'};
         // assuring always a final '\0' "after" the buffer.
         // See definition of strncat about this.

    strncat_s( line1, LINE_MAX,
               "Compiling with VC/C++ VS version ", _TRUNCATE);
    strncat_s( line1, LINE_MAX,
               getenv("VSCMD_VER"), _TRUNCATE);

    // capture VCRAYVER for reporting and also detection of special cases
    char verstring[LINE_MAX+1] = { '\0' };

    strncat_s( verstring, LINE_MAX,
               getenv("VCRAYVER"), _TRUNCATE);
        // capturing VCRAYVER

    // incorporate VCRAYVER in the second message.
    char line2[LINE_MAX+1] = { '\0' };

    strncat_s( line2, LINE_MAX,
               "Using raylib ", _TRUNCATE);
    strncat_s( line2, LINE_MAX,
               verstring, _TRUNCATE);

    // determine whether a Dev version is being used
    bool isDev = false;
    int i = 0;

    while ( verstring[i] )
          if ( !strncmp(&verstring[i++], "-dev\"", 5) )
               { isDev = true;
                 break; }


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

            DrawText("VCrayConfirm 0.1.6",
                     90, 50, 20, GRAY);

            DrawText(line1,
                     90, 100, 20, BLUE);
            DrawText("17.5.0 and later have "
                     "improved C99/C11 support.",
                     140, 130, 20, GRAY);

            DrawText(line2,
                     90, 160, 20, BLUE);
            if (isDev)
                 { DrawText("Thank you for testing with a -dev version.",
                            140, 185, 20, GRAY);
                   DrawText("When stable builds needed, "
                            "use release version.",
                            140, 210, 20, GRAY); }

            DrawText("Press ESC to Continue",
                     90, 400, 20, RED);

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
