@echo off
REM mkGenAIO-test1.bat 0.0.0        UTF-8                         2025-12-02
rem |----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
rem
rem                   COMPILING nfoGenAIO TEST PROGRAM #1
rem
rem    Compile nfoGenAIO-test1.exe with optionization for maximum speed.

CL @VCoptions.opt nfoGenAIO-test1.c ../dev/nfoGenAIO.c ../dev/nfoGenAIO-win32.c

rem |----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
rem
rem 0.1.0  2026-01-02T21:18Z Add nfoGenAIO-win32.c
rem 0.0.0  2025-12-02T22:54Z Initial version.
rem
rem                  *** end of mkGenAIO-test1.bat ***
