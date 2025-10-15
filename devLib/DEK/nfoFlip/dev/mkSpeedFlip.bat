@echo off
REM mkSpeedFlip.bat 0.0.1            UTF-8                         2025-10-15
rem |----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
rem
rem                          COMPILING speedFlip
rem
rem    Compile speedFlip.exe with optionization for maximum speed.

CL /Fe:speedFlip.exe speedFlip.c nfoFlip.c @VCnfoFlip.opt

rem |----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
rem

rem 0.0.1  2025-10-14T00:55Z Initial version.
rem
rem                     *** end of mkSpeedFlip.bat ***
