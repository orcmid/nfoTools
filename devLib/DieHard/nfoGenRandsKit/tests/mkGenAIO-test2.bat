@echo off
REM mkGenAIO-test2.bat 2.0.0        UTF-8                         2026-01-02
rem |----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
rem
rem                   COMPILING nfoGenAIO TEST PROGRAM #2
rem
rem    Compile nfoGenAIO-test2.exe with optionization for maximum speed.

CL @VCoptions.opt nfoGenAIO-test2.c ../dev/nfoGenAIO.c ../dev/nfoGenAIO-win32.c

rem |----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
rem
rem 2.0.0  2026-01-02T21:51Z Update to include nfoGenAIO-win32.c for Windows.
rem 1.0.0  2025-12-04T00:28Z Initial version.
rem
rem                  *** end of mkGenAIO-test2.bat ***
