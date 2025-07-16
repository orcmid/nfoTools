/* RGFW-Resolution.c 0.0.1          UTF-8                          2024-11-23
   -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

   Replication of the Defect Demonstration by @xroberx on 2024-11-23 at
   <https://github.com/raysan5/raylib/issues/4522#issuecomment-2495441745>

   I have included the code verbatim.  I build it with VCrayApp and the
   latest (5.6-dev) raylib main branch.  The comment has a demonstration
   of the defective display.
   */

#include <raylib.h>

int main() {
    InitWindow(800, 600, "TEST");
    SetTargetFPS(60);

    while (!WindowShouldClose()) {
        BeginDrawing();
        ClearBackground(BLACK);
        DrawRectangleLines(0, 0, 800, 600, WHITE);
        EndDrawing();
    }
    CloseWindow();

    return 0;
}

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

   0.0.1 2024-11-23T16:37Z VCrayApp tests version

                    ***** end of RGFW-Resolution.c *****
   */
