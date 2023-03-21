@echo off
rem VCrayVerify 0.0.0 VCrayVerify.bat 0.0.1 UTF-8                  2023-03-21
rem |----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

rem               VERIFYING RAYLIB EXAMPLES WITH VC/C++ TOOLS
rem               ===========================================

rem There are no customizations required here for usage of VCrayVerify.
rem This is a derivative of VCrayApp.bat 0.0.34 from the VCrayApp project.


REM *** NOTHING TO CUSTOMIZE. DON'T TOUCH. SPECIFIC TO VCrayVerify ONLY *****
REM *************************************************************************

rem Designate the semantic-versioned distribution
SET VCrayVerify=0.0.0
SET VCVraylib=%~dp0raylib

SET VCVfrom=%CD%
rem remembering where VCrayVerify.bat is called *from*, so it can be restored
rem on exit, including after errors.
SET VCVterse=
SET VCVhush=
rem can :BAIL from any point now

SETLOCAL ENABLEEXTENSIONS
IF ERRORLEVEL 1 GOTO :FAIL0

rem SELECT EMBEDDED, TERSE, OR DEFAULT
rem     %1 value "+" selects smooth non-stop operation for splicing output
rem        into that of a calling script.
rem     %2 might then be "*" and allow for that.
rem don't shift anything out until %1-%2 handled.

SET VCVsplice=%1
IF NOT "%1" == "+" GOTO :MAYBETERSE
IF NOT "%2" == "*" GOTO :MAYBETERSE
SET VCVterse=^>NUL 2^>NUL
Set VCVhush=/nologo

:MAYBETERSE
rem SELECT TERSE OR VERBOSE
IF "%1" == "*" ( SET VCVterse=^>NUL 2^>NUL
                 SET VCVhush=/nologo
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
ECHO: [VCrayVerify] %VCrayVerify% BUILDING EXAMPLES WITH VC/C++ %VSCMD_VER%

IF "%VCsplice%" == "+" GOTO :PARMCHECK
ECHO:          %TIME% %DATE% on %USERNAME%'s %COMPUTERNAME%         %VCVterse%
ECHO:          VCrayVerify at %~dp0                                 %VCVterse%

:PARMCHECK
rem DETERMINE PARAMETERS
rem    Do this before checking Location so that "?" can work regardless
rem    See :USAGE for the VCrayApp.bat API contract
IF "%1" == "+" SHIFT /1
IF "%1" == "?" GOTO :USAGE
IF "%1" == "*" SHIFT /1
SET VCVclean=0
SET VCVrun=0
IF "%1" == "-c" ( SET VCVclean=1
                  SHIFT /1 )
IF "%1" == "-r" ( SET VCVrun=1
                  SHIFT /1 )

REM **** WE NEED SOMETHING DIFFERENT HERE, AND ALSO DECISION ON "-r"
REM ********************************************************************

REM **** CUSTOMIZE HERE FOR ADDITIONAL PARAMETER CASES ********************
REM ***********************************************************************

IF NOT "%1" == "" GOTO FAIL2

:LOCATE
rem VERIFY LOCATION OF THE SCRIPT WHERE VCRayAppVerify.zip IS FULLY EXTRACTED
rem Some are customizable, none should be removed, all %VCrayVerify% specific

IF NOT EXIST "%~dp0VCrayVerify-%VCrayVerify%.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0VCrayVerify.bat" GOTO :FAIL1
IF NOT EXIST "%~dp0NOTICE.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0dev.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0.gitignore" GOTO :FAIL1
IF NOT EXIST "%~dp0VCrayAppV\VCrayApp.bat" GOTO :FAIL1
rem    VCrayAppV will check additional configuration and raylib\ details

REM **** In order to know the Version of Raylib, we need to build the
REM **** VCrayApp cache, whether we need it rebuilt or not.

SET VCAPPEXE=
SET VCAPPSRC=

VCrayAppV\VCrayApp + * -c
IF ERROLEVEL 1 GOTO :FAIL4

rem now we know versions, other information, and can continue.

:SUCCESS
ENDLOCAL
IF "%VCsplice%" == "+" EXIT /B 0
ECHO:  %VCterse%
IF NOT "%VCrun%" == "1" PAUSE
REM *************** FIX THIS DEPENDING ON HOW THINGS RUN DOWN HERE **********
EXIT /B 0

REM :FAIL8
ECHO: [VCrayApp] **** FAILURE: RAYLIB %VCRAYVER% NOT SUPPORTED ****
ECHO:            USE 4.0 OR ONE LATER THAN 4.2 WITH VCrayApp        %VCterse%
ECHO:            NO SIGNIFICANT ACTIONS HAVE BEEN PERFORMED         %VCterse%
GOTO :BAIL

REM :FAIL7
ECHO: [VCrayApp] **** FAILURE: RAYLIB VERSION NOT ^> 3.0.0 ****
ECHO:            3.5.0/3.7.0 ARE ONLY PRE-4.0 SUPPORTED BY VCrayApp %VCterse%
ECHO:            NO SIGNIFICANT ACTIONS HAVE BEEN PERFORMED         %VCterse%
GOTO :BAIL

REM :FAIL6
ECHO: [VCrayApp] **** FAILURE: RAYLIB NOT FOUND WHERE EXPECTED ****
ECHO:            expected at "%VCraylib%    \"                      %VCterse%
ECHO:            NO ACTIONS HAVE BEEN PERFORMED                     %VCterse%
REM   XXXX ANOTHER DEPENDENCY ON raylib\ LOCATION
GOTO :BAIL

REM :FAIL5
REM *** SEEMS VCrayApp SPECIFIC
ECHO: [VCrayApp] ****PRODUCING OR OPERATING %VCEXE% FAILED ****
ECHO:            Review any reported errors.                        %VCterse%
ECHO:            Make repairs and reattempt.                        %VCterse%
ECHO:            RESULTS ARE UNPREDICTABLE                          %VCterse%
GOTO :BAIL

REM ***** VCRAYVERIFY FAIL CUSTOMIZATIONS DONE BELOW HERE ******************

:FAIL4
ECHO: [VCrayVerify] **** COMPILING/CONFIRMING RAYLIB CACHE FILES FAILED ****
ECHO:            Review the errors reported for the compilation.    %VCVterse%
ECHO:            Make repairs and reattempt.                        %VCVterse%
ECHO:            RESULTS ARE UNPREDICTABLE.                         %VCVterse%
GOTO :BAIL

:FAIL3
ECHO: [VCrayVerify] **** FAIL: NO VS NATIVE COMMAND-LINE ENVIRONMENT ****
ECHO:            VCrayVerify requires the command-line environment  %VCVterse%
ECHO:            for VS Native Build Tools to be established. See   %VCVterse%
ECHO:           ^<https://orcmid.github.io/nfoTools/dev/D230202/^>. %VCVterse%
ECHO:            NO ACTIONS HAVE BEEN PERFORMED                     %VCVterse%
GOTO :BAIL

:FAIL2
ECHO: [VCrayVerify] **** FAIL: UNSUPPORTED VCRAYVERIFY.BAT PARAMETERS ****
ECHO:            Invalid Here: %*
ECHO:            %VCVterse%
ECHO:            NO ACTIONS HAVE BEEN PERFORMED                     %VCVterse%
GOTO :USAGE

:FAIL1
ECHO: [VCrayVerify] **** FAIL: INCORRECT VCrayVerify FILES CONFIGURATION ****
ECHO:            VCrayVerify.bat must be where VCrayVerify.zip      %VCVterse%
ECHO:            is extracted to, along with VCrayAppV\ subfolder   %VCVterse%
ECHO:            and an extracted raylib\ subfolder. For details,   %VCVterse%
ECHO:           ^<https://orcmid.github.io/nfoTools/dev/D230202/^>. %VCVterse%
ECHO:            %VCVterse%
ECHO:            NO ACTIONS HAVE BEEN PERFORMED                     %VCVterse%
GOTO :BAIL

:FAIL0
ECHO: [VCrayVerify] **** FAIL: COMMAND SHELL EXTENSIONS REQUIRED ****
ECHO:            VCrayVerify.bat requires CMDEXTVERSION 2 or greater.
ECHO:            This is available wherever VCrayVerify is usable.
ECHO:
ECHO:            NO ACTIONS HAVE BEEN PERFORMED
GOTO :BAIL

REM **** VCRAYVERIFY USAGE AND EXITS NOT COMPLETE BELOW HERE ***************
REM ************************************************************************

:USAGE
rem    PROVIDE USAGE INFORMATION
ECHO:   USAGE: VCrayVerify [+] ?
ECHO:          VCrayVerify [+] [*] [-c]
IF NOT "%1" == "?" GOTO :BAIL
ECHO:   where  ? produces this usage information.
ECHO:          + for operating non-stop without any screen clearing
ECHO:            and pausing.  Good for use called as a helper.
ECHO:          * selects terse output.  If operation fails, repeat
ECHO:            without this option for more details.
ECHO:         -c for a complete rebuild of any cache
REM ECHO:         -r for compiling and running examples
ECHO:
ECHO:    Exit code 0 is produced on all successful operations.
ECHO:    Exit codes greater than 1 are produced for any failure.
ECHO:
ECHO:    [VCrayApp] Confirmations and Error messags can arise in the internal
ECHO:    use of VCrayApp by VCraVerify.  It may be necessary to trouble-shoot
ECHO:    such failures using the provided information.
ECHO:
ECHO:    There is definition/use of environment variables VCAPPEXE, VCAPPSRC,
ECHO:    VCrayVerify, VCrayAppHost, VCrayAppHostURL,
ECHO:    VCVCrayApp, VCfrom, VCterse, VChush, VCsplice, VCclean, VCrun, VCEXE,
ECHO:    VCSRC, VCRAYVER, VCrayAppHost, and VCrayAppHostURL.  VSCMD_VER is
ECHO:    depended on for confirming operation is under a VS Command Prompt.
ECHO:
ENDLOCAL
IF "%VCVsplice%" == "+" EXIT /B 0
PAUSE
EXIT /B 0

:BAIL
ECHO:
IF NOT ERRORLEVEL 2 SET ERRORLEVEL=2
CD %VCVfrom%                                                        %VCVterse%
rem always leave with the one that brung us
IF NOT "%VCVterse%" == "" EXIT /B %ERRORLEVEL%
IF "%VCVsplice%" == "+" EXIT /B %ERRORLEVEL%
ECHO:
ENDLOCAL
PAUSE
EXIT /B %ERRORLEVEL%

rem |----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
rem
rem                 Copyright 2021-2023 Dennis E. Hamilton
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
rem 0.0.1 2023-03-21T23:21Z Initial VCrayAppV cache building confirmed
rem 0.0.0 2023-03-11T23:09Z Placeholder using VCrayApp.bat 0.0.34 boilerplate.
rem
rem                     *** end of VCrayVerify.bat ***
