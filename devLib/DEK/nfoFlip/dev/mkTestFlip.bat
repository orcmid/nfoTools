@echo off
REM mkTestFlip.bat 0.0.0            UTF-8                         2025-10-13
rem |----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
rem
rem                          COMPILING testFlip
rem
rem    Compile testFlip.exe with optionization for maximum speed.

CL /Fe:testFlip.exe testFlip.c nfoFlip.c @VCflip.opt

rem |----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
rem
rem 0.0.1  2025-10-14T14:48Z Add @VCflip.opt for optimization options.
rem 0.0.0  2023-06-14T01:35Z Initial version.
rem
rem                     *** end of mkTestFlip.bat ***
