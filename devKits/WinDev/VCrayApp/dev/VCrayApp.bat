@echo off
rem VCrayApp 0.0.0 VCrayApp.bat 0.0.17 UTF-8                       2022-10-26
rem |----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

rem                  BUILDING RAYLIB APP WITH VC/C++ TOOLS
rem                  =====================================

rem This code depends on the presence of cache\, app\, src\ and ..\raylib\.
rem It must be operated within a VS Command Prompt command-line environment.
rem Use the script without modification until installation and operation is
rem confirmed.  Then alter the GAME_EXE and SRC vars for the specific project.

SETLOCAL ENABLEEXTENSIONS
IF ERRORLEVEL 1 GOTO :FAIL0

rem cache\rayConfirm.c is compiled as a simple example to confirm the setup.
rem After successful confirmation, substitute your app's .exe name here ...
SET GAME_EXE=rayConfirm.exe

rem ... and switch to your app's source code location, e.g., SRC=src\*.c
SET SRC=cache\rayConfirm.c


rem *********** NO CHANGES ARE NEEDED BELOW HERE *****************************
rem |----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

rem Designate the semantic-versioned distribution
SET VCrayApp=0.0.0

rem Additional documentation of this procedure and its usage are found in the
rem accompanying VCrayApp-%VCrayApp%.txt file.  For further information, see
rem ^<https:\\orcmid.github.org\nfoTools\D211101^> and check for the latest
rem version at ^<https:\\orcmid.github.org\nfoTools\D211101\D211101c^>.

rem Remebering where rayApp.bat is called *from*, so it can be restored on
rem exit including after errors.
SET VCfrom=%CD%

rem SELECT EMBEDDED, TERSE, OR DEFAULT
rem     %1 value "+" selects smooth non-stop operation for splicing output
rem        into that of a calling script.
rem     %2 might then be "*" and allow for that.
rem don't shift anything out until %1-%2 handled.
SET VCterse=
SET VChush=
SET VCsplice=%1
IF NOT "%1" == "+" GOTO :MAYBETERSE
IF NOT "%2" == "*" GOTO :MAYBETERSE
SET VCterse=^>NUL 2^>NUL
Set VChush=/nologo

:MAYBETERSE
rem SELECT TERSE OR VERBOSE
IF "%1" == "*" ( SET VCterse=^>NUL 2^>NUL
                 SET VChush=/nologo
                 )

rem ANNOUNCE THIS SCRIPT
IF "%1" == "*" GOTO :WHISPER
IF "%1" == "+" GOTO :WHISPER
CLS

:WHISPER
rem CONFIRM COMMAND-LINE ENVIRONMENT
IF "%VSCMD_VER%" == "" GOTO FAIL3
WHERE cl.exe >nul 2>nul
IF ERRORLEVEL 1 goto FAIL3
ECHO: [VCrayApp] %VCrayApp% BUILDING RAYLIB APP WITH VC/C++ TOOLS

IF "%VCsplice%" == "+" GOTO :PARMCHECK
ECHO:          %TIME% %DATE% on %USERNAME%'s %COMPUTERNAME%         %VCterse%
ECHO:          VCrayApp.bat at %~dp0                                %VCterse%

:PARMCHECK
rem DETERMINE PARAMETERS
rem    Do this before checking Location so that "?" can work regardless
rem    See :USAGE for the VCrayApp.bat API contract
IF "%1" == "+" SHIFT /1
IF "%1" == "?" GOTO :USAGE
IF "%1" == "*" SHIFT /1
SET VCclean=0
SET VCrun=0
IF "%1" == "-c" ( SET VCclean=1
                  SHIFT /1 )
IF "%1" == "-r" ( SET VCrun=1
                  SHIFT /1 )
IF NOT "%1" == "" GOTO FAIL2

:LOCATE
rem VERIFY LOCATION OF THE SCRIPT WHERE VCRayApp.zip IS FULLY EXTRACTED
rem Some are customizable, none should be removed, all %VCrayApp% specific
IF NOT EXIST "%~dp0cache\cache.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0cache\rayConfirm.c" GOTO :FAIL1
IF NOT EXIST "%~dp0cache\raylibCode.opt" GOTO :FAIL1
IF NOT EXIST "%~dp0cache\raylibVars.opt" GOTO :FAIL1
IF NOT EXIST "%~dp0cache\rayLinking.opt" GOTO :FAIL1
IF NOT EXIST "%~dp0cache\VCoptions.opt" GOTO :FAIL1
IF NOT EXIST "%~dp0app\app.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0src\src.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0VCrayApp-%VCrayApp%.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0VCrayApp.bat" GOTO :FAIL1

IF NOT EXIST "%~dp0..\raylib\src\raylib.h" GOTO :FAIL6

rem COMPILE INTO THE CACHE IF NEEDED
IF NOT "%VCclean%" == "1" GOTO :CACHECHECK
DEL %~dp0cache\rglfw.obj

:CACHECHECK
IF EXIST %~dp0cache\rglfw.obj GOTO :APPBUILD
DEL %~dp0cache\*.obj > nul 2>nul
rem using presence of the last-built raylib .obj to determine full cache

CD %~dp0cache
CL %VChush% /w /c @VCoptions.opt @raylibVars.opt @raylibCode.opt %VCterse%
IF ERRORLEVEL 2 GOTO :FAIL4
ECHO: [VCrayApp] FRESH CACHE OF RAYLIB *.OBJ FILES COMPILED
ECHO: %VCterse%

:APPBUILD
CD %~dp0app
DEL *.exe >nul 2>nul
rem Flags
SET OUT=/Fe: "%GAME_EXE%"
SET SUBSYS=/SUBSYSTEM:WINDOWS /ENTRY:mainCRTStartup

rem Compiling the %SRC%
CL %VChush% /W3 /c @%~dp0cache\VCoptions.opt %~dp0%SRC%          %VCterse%
IF ERRORLEVEL 2 GOTO :FAIL5
ECHO: %VCterse%

rem Linking it all to %GAME_EXE%
CL %VChush% %OUT% @%~dp0cache\rayLinking.opt /link /LTCG %SUBSYS% %VCterse%
IF ERRORLEVEL 2 GOTO :FAIL5
ECHO: %VCterse%
DEL *.obj >nul 2>nul

ECHO: [VCrayApp] PROGRAM %GAME_EXE% COMPILED TO %~dp0app
ECHO: %VCterse%

CD %VCfrom%
IF NOT "%VCrun%" == "1" GOTO :SUCCESS
ECHO: [VCrayApp] Launching App.  Exit App to Continue Command Session
"%~dp0app\%GAME_EXE%"

:SUCCESS
ENDLOCAL
IF "%VCsplice%" == "+" EXIT /B 0
ECHO:  %VCterse%
IF NOT "%VCrun%" == "1" PAUSE
EXIT /B 0


:FAIL6
ECHO: [VCrayApp] **** FAILURE: RAYLIB NOT FOUND WHERE EXPECTED ****
ECHO:            expected at "%~dp0..\raylib\"                      %VCterse%
ECHO:            NO ACTIONS HAVE BEEN PERFORMED                     %VCterse%
GOTO :BAIL

:FAIL5
ECHO: [VCrayApp] ****COMPILING %GAME_EXE% FAILED ****
ECHO:            Review the errors reported for the compilation.    %VCterse%
ECHO:            Make repairs and reattempt.                        %VCterse%
ECHO:            RESULTS ARE UNPREDICTABLE                          %VCterse%
GOTO :BAIL

:FAIL4
ECHO: [VCrayApp] **** COMPILING CACHE OF RAYLIB FILES FAILED ****
ECHO:            Review the errors reported for the compilation.    %VCterse%
ECHO:            Make repairs and reattempt.                        %VCterse%
ECHO:            RESULTS ARE UNPREDICTABLE.  REBUILD CACHE.         %VCterse%
GOTO :BAIL

:FAIL3
ECHO: [VCrayApp] **** FAIL: NO VS NATIVE COMMAND-LINE ENVIRONMENT ****
ECHO:            VCrayApp.bat requires the command-line environment %VCterse%
ECHO:            for VS Native Build Tools to be established.       %VCterse%
ECHO:            See ^<some nfoTools support information^>.         %VCterse%
ECHO:            NO ACTIONS HAVE BEEN PERFORMED                     %VCterse%
GOTO :BAIL

:FAIL2
ECHO: [VCrayApp] **** FAIL: UNSUPPORTED VCRAYAPP.BAT PARAMETERS ****
ECHO:            Invalid Here: %*
ECHO:            %VCterse%
ECHO:            NO ACTIONS HAVE BEEN PERFORMED                     %VCterse%
GOTO :USAGE

:FAIL1
ECHO: [VCrayApp] **** FAIL: INCORRECT VCrayApp FILES CONFIGURATION ****
ECHO:            VCrayApp.bat must be in a folder that VCrayApp.zip %VCterse%
ECHO:            is extracted into, along with the cache\ app\ and  %VCterse%
ECHO:            src\ subfolders.  See                              %VCterse%
ECHO:            ^<other nfoTools support information^>.            %VCterse%
ECHO:            NO ACTIONS HAVE BEEN PERFORMED                     %VCterse%
GOTO :BAIL

:FAIL0
ECHO: [VCrayApp] **** FAIL: COMMAND SHELL EXTENSIONS REQUIRED ****
ECHO:            VCrayApp.bat requires CMDEXTVERSION 2 or greater.  %VCterse%
ECHO:            This is available wherever VCrayApp.bat is usable. %VCterse%
ECHO:            %VCterse%
ECHO:            NO ACTIONS HAVE BEEN PERFORMED                     %VCterse%
GOTO :BAIL

:USAGE
rem    PROVIDE USAGE INFORMATION
ECHO:   USAGE: VCrayApp [+] ?
ECHO:          VCrayApp [+] [*] [-c] [-r]
IF NOT "%1" == "?" GOTO :BAIL
ECHO:   where  ? produces this usage information.
ECHO:          + for operating non-stop without any screen clearing
ECHO:            and pausing.  Good for use called as a helper.
ECHO:          * selects terse output.  If operation fails, repeat
ECHO:            without this option for more details.
ECHO:         -c for a complete rebuild of any cache
ECHO:         -r for running the app on successful build
ECHO:
ECHO:    Exit code 0 is produced on all successful operations.
ECHO:    Exit codes greater than 1 are produced for any failure.
ECHO:
ENDLOCAL
IF "%VCsplice%" == "+" EXIT /B 0
PAUSE
EXIT /B 0

:BAIL
ECHO:
IF NOT ERRORLEVEL 2 SET ERRORLEVEL=2
CD %VCfrom%                                                         %VCterse%
rem always leave with the one that brung us
IF NOT "%VCterse%" == "" EXIT /B %ERRORLEVEL%
IF "%VCsplice%" == "+" EXIT /B %ERRORLEVEL%
ECHO:
ENDLOCAL
PAUSE
EXIT /B %ERRORLEVEL%

rem |----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
rem
rem                 Copyright 2021-2022 Dennis E. Hamilton
rem
rem Licensed under the Apache License, Version 2.0 (the "License");
rem you may not use this file except in compliance with the License.
rem You may obtain a copy of the License at
rem
rem     http://www.apache.org/licenses/LICENSE-2.0
rem
rem Unless required by applicable law or agreed to in writing, software
rem distributed under the License is distributed on an "AS IS" BASIS,
rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
rem See the License for the specific language governing permissions and
rem limitations under the License.
rem
rem For additional information, see the accompanying NOTICE.txt file.
rem
rem |----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
rem
rem 0.0.17 2022-10-26T16:38Z More message cleanups
rem 0.0.16 2022-10-17T18:35Z Cleanup compilation failure and success messages
rem 0.0.15 2022-08-24T23:22Z Add Copyright, touch-ups
rem 0.0.14 2022-08-20T21:21Z Correct compilation to app\ message.
rem 0.0.13 2022-08-14T20:03Z Improve some message
rem 0.0.12 2022-07-10T21:34Z Require src\src.txt to be present
rem 0.0.11 2022-06-21T14:38Z Catch some missed name changes + some touch-ups
rem 0.0.10 2022-05-29T21:29Z Switch to VCrayApp name and review, tidy up.
rem 0.0.9 2021-11-20T20:59Z Adjust error checks and preserving original %CD%
rem 0.0.8 2021-11-11T20:13Z Checking for expected presence of raylib/
rem 0.0.7 2021-11-11T17:52Z Moving all *.opt files to cache/
rem 0.0.6 2021-11-10T03:30Z Confirmed and touched-up ready for nfoTools
rem 0.0.5 2021-11-10T00:08Z Complete draft of guard-railed script
rem 0.0.4 2021-11-08T23:43Z First stage provisional built
rem 0.0.3 2021-11-08T22:05Z Start blending VCbind on-ramp and guard rails
rem 0.0.2 2021-11-07T23:43Z Rename and continue prototyping.
rem 0.0.1 2021-11-05T21:39Z Trial Simplification for nfoTools + FC_CPP
rem 0.0.0 2021-04-26T00:01Z 3.7.0 raylib/projects/scripts/build_windows.bat
