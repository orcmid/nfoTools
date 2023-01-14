/* rayconfirm.c 0.1.0                    UTF-8                    2023-01-14
   -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

                       CONFIRMATION OF RAYLIB APP BUILD SETUP

   raylib is licensed under an unmodified zlib/libpng license (View raylib.h
   for details).

   rayconfirm.c is adapted from raylib/projects/scripts/core_basic_windows.c
   Copyright (c) 2013-2016 Ramon Santamaria (@raysan5)

   This file is used to demonstrate successful compilation of a raylib-
   based native Windows app.  It is also useful in confirming VS Code
   highlighting, C/C++ Intellisense, and location of header file raylib.h.

   For further details, see <https://orcmid.github.io/nfoTools/dev/D211101a>
   and <https://orcmid.github.io/nfoTools/tools/> for additional information.

   */

#include <raylib.h>

int main(void)
{
    // Initialization
    //------------------------------------------------------------------------
    int screenWidth = 800;
    int screenHeight = 450;

    InitWindow(screenWidth, screenHeight,
               "VC raylib App Build Confirmation");

    SetTargetFPS(60);
    //------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())    // Detect window close button or ESC key
    {
        // Draw
        //--------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText("rayConfirm 0.0.2",
                     90, 50, 20, GRAY);

            DrawText("GREAT!! Your VCrayApp 0.1.0 setup is confirmed!",
                     190, 200, 20, BLUE);

            DrawText("Press ESC to Quit",
                     190, 400, 20, RED);

        EndDrawing();
        //--------------------------------------------------------------------
        }

    // De-Initialization
    //------------------------------------------------------------------------
    CloseWindow();        // Close window and OpenGL context
    //------------------------------------------------------------------------

    return 0;
}

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

   0.1.0 2023-01-14T18:52Z Adapt to reflect VCRayApp 0.1.0 (beta)
   0.0.1 2021-11-06T16:35Z draft reformatting and commentary
   0.0.0 2021-11-04T23:33Z boilerplate core_basic_windows.c distributed in the
         raylib 3.7.0.zip release downloaded 2021-10-08T00:41

                          *** end of rayConfirm.c ***
   */
