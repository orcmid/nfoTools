/* VCrayconfirm.c 0.1.2                  UTF-8                    2023-02-23
   -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

                    CONFIRMATION OF RAYLIB APP CACHE SETUP

   raylib is licensed under an unmodified zlib/libpng license (View raylib.h
   for details).

   rayconfirm.c is adapted from raylib/projects/scripts/core_basic_windows.c
   Copyright (c) 2013-2016 Ramon Santamaria (@raysan5)

   This file is used to demonstrate successful compilation of a raylib-
   based native Windows app.  It is also useful in confirming VS Code
   highlighting, C/C++ Intellisense, and location of header file raylib.h.

   For further details, see <https://orcmid.github.io/nfoTools/dev/D211101>
   and <https://orcmid.github.io/nfoTools/tools/> for additional information.

   */

#include <stdlib.h>   // for getenv() and exit()
#include <string.h>   // for strcmp() and text-output building

#include <raylib.h>

int main(void)
{
    // Initialization
    //------------------------------------------------------------------------
    int screenWidth = 800;
    int screenHeight = 450;

    InitWindow(screenWidth, screenHeight,
               "VCrayApp 0.1.0 (beta) Cache Confirmation");

    SetTargetFPS(60);
    //------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())    // Detect window close button or ESC key
    {
        // Draw
        //--------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText("VCrayConfirm 0.1.2",
                     90, 50, 20, GRAY);

            DrawText("VCrayApp 0.1.0 cache set for raylib ",
                     190, 100, 20, BLUE);

            DrawText("Press ESC to Continue",
                     190, 400, 20, RED);

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

   0.1.2 2023-02-23T17:24Z Bring message lines closer together, clean exit
   0.1.1 2023-02-23T18:57Z Initial adjustments to new name and purpose.
   0.1.0 2023-01-14T18:52Z Adapt to reflect VCRayApp 0.1.0 (beta)
   0.0.1 2021-11-06T16:35Z draft reformatting and commentary
   0.0.0 2021-11-04T23:33Z boilerplate core_basic_windows.c distributed in the
         raylib 3.7.0.zip release downloaded 2021-10-08T00:41

                        *** end of VCrayConfirm.c ***
   */
