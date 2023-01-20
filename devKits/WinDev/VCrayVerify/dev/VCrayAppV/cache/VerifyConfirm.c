/* VerifyConfirm.c 0.0.0            UTF-8                         2023-01-20
   -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

                    CONFIRM VCrayVerify SETUP FOR OPERATION

   raylib is licensed under an unmodified zlib/libpng license (View raylib.h
   for details).

   VerifyConfirm.c is adapted from VCrayApp rayConfirm.c 0.0.1 of 2021-11-06,
   based on the file raylib/projects/scripts/core_basic_windows.c that is
   Copyright (c) 2013-2016 Ramon Santamaria (@raysan5)

   This file is used to demonstrate successful compilation of a raylib-
   based native Windows app as part of the confirmation of VCrayVerify setup
   and cache building.  That confirms the setup is in place for running
   (selected) verification operations.

   For further details, see <**web-location-to-be-supplied**>.

   */

#include <raylib.h>

int main(void)
{
    // Initialization
    //------------------------------------------------------------------------
    int screenWidth = 800;
    int screenHeight = 450;

    InitWindow(screenWidth, screenHeight,
               "VC raylib App Build Confirmation for VCrayVerify");

    SetTargetFPS(60);
    //------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())    // Detect window close button or ESC key
    {
        // Draw
        //--------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText("VerifyConfirm 0.0.0",
                     90, 50, 20, GRAY);

            DrawText("VCrayVerify initialization is confirmed.",
                     190, 200, 20, BLUE);
            DrawText("Verification of examples can commence.")

            DrawText("Press ESC to Continue",
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


   0.0.0 2023-01-20T23:09Z boilerplate VCrayApp 0.0.0 rayConfirm.c 0.0.1
         adapted for VCrayAppV as part of VCrayVerify.

                        *** end of VerifyConfirm.c ***
   */
