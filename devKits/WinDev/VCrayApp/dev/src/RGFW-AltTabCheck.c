/* RGFW-AltTabCheck.c 0.0.1         UTF-8                          2025-12-01
   -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

   Test for the FullScreen Alt-Tab behavior in the Defect Demonstration by
   @lucypero on 2025-01-01 at
   <https://github.com/raysan5/raylib/issues/3865#issuecomment-2567111185>

   I have transposed the code from Odin to Clean C.  I build it with VCrayApp
   and the    latest (5.6-dev) raylib main branch.

   The issue is that Alt-Tab of a RayApp in borderless-windowed mode, the
   window stays on top of all windows no matter what other application
   is selected.
   */

#include "raylib.h"

int main() {
    InitWindow(100, 100, "Alt-Tab-Test");

    ToggleBorderlessWindowed();

    while (!WindowShouldClose()) {
        BeginDrawing();
        ClearBackground(BLACK);
        EndDrawing();
    }
    CloseWindow();

    return 0;
}

/* -|----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

   0.0.1 2025-01-01T21:58Z VCrayApp tests version

                    ***** end of RGFW-AltTabCheck.c *****
   */
