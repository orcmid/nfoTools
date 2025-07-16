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
    InitWindow(100, 100, "Alt-Tab-Test")
    ;
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

**********************************************************************
** Visual Studio 2022 Developer Command Prompt v17.11.5
** Copyright (c) 2022 Microsoft Corporation
**********************************************************************
[vcvarsall.bat] Environment initialized for: 'x64'

H:\Documents\GitHub\nfoTools\devKits\WinDev\VCrayApp\dev>VCrayApp ?
 [VCrayApp] 0.1.0 OPERATING WITH VC/C++ 17.11.5 TOOLS
          14:14:27.67 2025-01-01 on orcmi's ASTRAENDO2
          VCrayApp at H:\Documents\GitHub\nfoTools\devKits\WinDev\VCrayApp\dev\
   USAGE: VCrayApp [+] ?                            VCrayApp-0.1.0
          VCrayApp [+] [*] [-c] [[-r] exe [src]]
   where  ? produces this usage information.
          + ONLY FOR OPERATING AS A HELPER FROM ANOTHER SCRIPT, with
            non-stop operation, among other adjustments.
          * selects terse output.  If operation fails, repeat
            without this option for more details.
         -c for a complete rebuild of any cache
         -r for running the app on successful build
        exe the name of the executable to be built in app\
        src the location of source code to compile when not the
            default src\*.c location

    ERRORLEVEL 0 is produced on all successful operations;
    codes greater than 1 are produced for any failures.

    VCrayApp depends on VSCMD_VER being set by the VS Command Prompt
    with CMDEXTVERSION 2 or better available for operation.
    There is use/clearing of environment variables VCrayApp, VCfrom,
    and VCsplice.  Others are exposed when operating embedded under
    another script (option "+").

    See <https://orcmid.github.io/nfoTools/dev/D211101/e> for details.


H:\Documents\GitHub\nfoTools\devKits\WinDev\VCrayApp\dev>VCrayApp RGFW-AltTabCheck.exe
 [VCrayApp] 0.1.0 OPERATING WITH VC/C++ 17.11.5 TOOLS
          14:15:45.04 2025-01-01 on orcmi's ASTRAENDO2
          VCrayApp at H:\Documents\GitHub\nfoTools\devKits\WinDev\VCrayApp\dev\
Microsoft (R) C/C++ Optimizing Compiler Version 19.41.34123 for x64
Copyright (C) Microsoft Corporation.  All rights reserved.

cl /utf-8 /validate-charset /TC /EHsc
   /std:c11 /O1 /GL /favor:blend /fp:precise
   /I"..\..\raylib\src" /I"..\..\raylib\src\external\glfw\include"

RGFW-AltTabCheck.c

Microsoft (R) C/C++ Optimizing Compiler Version 19.41.34123 for x64
Copyright (C) Microsoft Corporation.  All rights reserved.

cl ..\cache\*.obj *.obj
   kernel32.lib user32.lib shell32.lib winmm.lib gdi32.lib opengl32.lib

Microsoft (R) Incremental Linker Version 14.41.34123.0
Copyright (C) Microsoft Corporation.  All rights reserved.

/out:RGFW-AltTabCheck.exe
/LTCG
/SUBSYSTEM:WINDOWS
/ENTRY:mainCRTStartup
..\cache\*.obj
*.obj
kernel32.lib
user32.lib
shell32.lib
winmm.lib
gdi32.lib
opengl32.lib
Generating code
Finished generating code

 [VCrayApp] PROGRAM RGFW-AltTabCheck.exe COMPILED TO H:\Documents\GitHub\nfoTools\devKits\WinDev\VCrayApp\dev\app

                   *** end of RGFW-AltTabCheck.exe ***
*/
