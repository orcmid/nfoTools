@echo off
REM mkSpeedFlipX.bat 0.0.2           UTF-8                         2025-10-15
rem |----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
rem
rem                          COMPILING speedFlipX
rem
rem    Compile speedFlip.exe the experimental nfoFlipX.c

CL /Fe:speedFlipX.exe speedFlip.c nfoFlipX.c @VCnfoFlip.opt

rem |----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
rem
rem 0.0.2  2025-10-15T19:26Z Correct output filename to speedFlipX.exe
rem 0.0.1  2025-10-15T19:08Z Transposition of mkSpeedFlip.bat 0.0.1
rem
rem                     *** end of mkSpeedFlipX.bat ***
