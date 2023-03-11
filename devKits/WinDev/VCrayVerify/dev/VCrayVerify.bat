@echo off
rem VCrayVerify 0.0.0 VCrayVerify.bat 0.0.0 UTF-8                  2023-03-11
rem |----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

rem               VERIFYING RAYLIB EXAMPLES WITH VC/C++ TOOLS
rem               ===========================================

rem There are no customizations required here for usage of VCrayVerify.
rem This is a derivative of VCrayApp.bat 0.0.34 from the VCrayApp project.

SET VCrayVerify=0.0.0

SETLOCAL ENABLEEXTENSIONS
IF ERRORLEVEL 1 GOTO :FAIL0

REM *** NOTHING TO CUSTOMIZE. DON'T TOUCH. SPECIFIC TO VCrayVerify ONLY *****
REM *************************************************************************

rem Designate the semantic-versioned distribution
SET VCrayVerify=0.0.0
SET VCVraylib=%~dp0raylib

SET VCVfrom=%CD%
rem remembering where VCrayVerify.bat is called *from*, so it can be restored
rem on exit, including after errors.

rem SELECT EMBEDDED, TERSE, OR DEFAULT
rem     %1 value "+" selects smooth non-stop operation for splicing output
rem        into that of a calling script.
rem     %2 might then be "*" and allow for that.
rem don't shift anything out until %1-%2 handled.
SET VCVterse=
SET VCVhush=
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
SET VCclean=0
SET VCrun=0
IF "%1" == "-c" ( SET VCclean=1
                  SHIFT /1 )
IF "%1" == "-r" ( SET VCrun=1
                  SHIFT /1 )

REM **** WE NEED SOMETHING DIFFERENT HERE, AND ALSO DECISION ON "-r"
********************************************************************

REM **** CUSTOMIZE HERE FOR ADDITIONAL PARAMETER CASES ********************
REM ***********************************************************************

IF NOT "%1" == "" GOTO FAIL2

:LOCATE
rem VERIFY LOCATION OF THE SCRIPT WHERE VCRayAppVerify.zip IS FULLY EXTRACTED
rem Some are customizable, none should be removed, all %VCrayVerify% specific

IF NOT EXIST "%~dp0VCrayVerify-%VCrayVerify%.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0VCrayVerify.bat" GOTO :FAIL1

IF NOT EXIST "%VCraylib%\src\raylib.h" GOTO :FAIL6

rem CACHE LINKABLE RAYLIB CODE IF NEEDED
IF NOT "%VCclean%" == "1" GOTO :CACHECHECK
DEL %~dp0cache\rglfw.obj >nul 2>nul
rem XXX We depend on rglfw.c being compiled last and absence is taken
rem XXX to mean cache is absent/obsolete.

:CACHECHECK
IF EXIST %~dp0cache\rglfw.obj GOTO :APPBUILD
rem Using presence of the last-built raylib .obj to determine full cache.
rem *IMPORTANT* Keep consistent with %~dp0cache\raylibCode.opt cases
DEL %~dp0cache\*.obj >nul 2>nul

CD %~dp0cache
rem DETERMINING RAYLIB VERSION THAT IS INSTALLED
rem First Compile VCrayVerCheck that fishes any RAYLIB_VERSION from raylib.h
SET VCEXE=VCrayVerCheck.exe
CL %VChush% @VCoptions.opt VCrayVerCheck.c   %VCterse%
IF ERRORLEVEL 1 GOTO :FAIL5
IF NOT EXIST VCrayVerCheck.exe GOTO :FAIL5
del VCrayVer.bat >nul 2>nul
SET VCEXE=VCrayVer.bat
VCrayVerCheck.exe >VCrayVer.bat
del VCrayVerCheck.obj VCrayVerCheck.exe >nul 2>nul
IF NOT EXIST VCrayVer.bat GOTO :FAIL5
CALL VCrayVer.bat
IF ERRORLEVEL 1 GOTO :FAIL5
IF "%VCRAYVER%" == "" GOTO :FAIL5
REM Refine VCRAYVER based on additional information at %VCraylib%.
IF %VCRAYVER% == "4.2" GOTO :FAIL8
REM **IMPORTANT**  Additional beyond 4.0 exclusions go here
COPY /Y raylibCode.4.x.0.opt raylibCode.opt >nul 2>nul
IF NOT %VCRAYVER% == "unidentified" GOTO :BUILDCACHE
IF EXIST %VCraylib%\appveyor.yml GOTO :FAIL7
IF EXIST %VCraylib%\.travis.yml GOTO :FAIL7
IF EXIST %VCraylib%\HELPME.md GOTO :FAIL7
COPY /Y raylibCode.3.x.0.opt rayLibCode.opt >nul 2>nul
SET VCRAYVER="3.7.0"
IF EXIST %VCraylib%\CONTRIBUTORS.md GOTO :BUILDCACHE
SET VCRAYVER="3.5.0"

:BUILDCACHE
CL %VChush% /w /c @VCoptions.opt @raylibVars.opt @raylibCode.opt %VCterse%
IF ERRORLEVEL 2 GOTO :FAIL4
ECHO: [VCrayApp] FRESH CACHE OF RAYLIB %RAYVER% *.OBJ FILES COMPILED
ECHO: %VCterse%

:VCRAYCONFIRMBUILD
SET VCEXE=VCrayConfirm.exe
SET VCSRC=%~dp0cache\VCrayConfirm.c
CD %~dp0app
DEL *.exe >nul 2>nul
rem Flags
SET OUT=/Fe: "%VCEXE%"
SET SUBSYS=/SUBSYSTEM:WINDOWS /ENTRY:mainCRTStartup

rem Compiling %VCSRC%
CL %VChush% /W3 /c @%~dp0cache\VCoptions.opt %VCSRC%        %VCterse%
IF ERRORLEVEL 2 GOTO :FAIL5
ECHO: %VCterse%

rem Linking it all to %VCEXE%
CL %VChush% %OUT% @%~dp0cache\rayLinking.opt /link /LTCG %SUBSYS% %VCterse%
IF ERRORLEVEL 2 GOTO :FAIL5
ECHO: %VCterse%
DEL *.obj >nul 2>nul

CD %VCfrom%
IF NOT EXIST %~dp0app\%VCEXE% GOTO :FAIL5
ECHO: [VCrayApp] Launching %VCEXE%.  Exit App to Continue Session  %VCterse%
ECHO: %VCterse%
%~dp0app\%VCEXE%
IF ERRORLEVEL 1 GOTO :FAIL5

IF "%VCAPPEXE%" == "" GOTO :NOAPP
IF NOT "%VCAPPEXE%" == "RenameMe.exe" GOTO :APPBUILD
IF "%VCsplice%" == "+" GOTO :SUCCESS

:NOAPP
IF NOT "%VCrayAppHost%" == "" GOTO :FUMBLED
ECHO: [VCrayApp] **** ALL SET. CACHE CONFIRMED. NO APP TO COMPILE YET. ****
ECHO:            Have the C Language source code and any headers at
ECHO:            VCRAYSRC.  Then put the app .exe name in the VCAPPEXE
ECHO:            setting at the beginning of VCrayApp.bat.
:MAYBEAPP
ECHO:            Once that's done, VCrayApp.bat will compile the app.
ECHO:            For more information,
ECHO:            see ^<https://orcmid.github.io/nfoTools/dev/D211101/^>.
ECHO: %VCterse%

IF NOT "%VCrun%" == "1" GOTO :SUCCESS
SET VCrun=0
IF NOT "%VCrayAppHost%" == "" GOTO :FUMBLED
ECHO: [VCrayApp] **** CANNOT RUN AN APP YET. DO THE SETUP. ****
GOTO :SUCCESS

:FUMBLED
ECHO: [VCrayApp] *** NO APP TO RUN YET FOR %VCrayAppHost%
GOTO :SUCCESS

:NOSRC
ECHO: [VCrayApp] **** NO SOURCE CODE LOCATION SUPPLIED ****
ECHO:            The VCAPPSRC environment variable must be set the location of
ECHO:            the App source code to be compiled.  This should be either
ECHO:            "SET VCAPPSRC=src\*.c" or a full-path location to use.
GOTO :MAYBEAPP

:APPBUILD
CD %~dp0app
DEL *.exe >nul 2>nul
rem Flags
SET OUT=/Fe: "%VCAPPEXE%"
SET SUBSYS=/SUBSYSTEM:WINDOWS /ENTRY:mainCRTStartup

rem Compiling the %SRC%
IF "%VCAPPSRC%" == "" GOTO :NOSRC
SET VCSRC=%~dp0%VCAPPSRC%
IF "%VCAPPSRC%" == "src\*.c" GOTO :APPCOMPILE
rem otherwise, a different %SRC% has been set.
SET VCSRC=%VCAPPSRC%

:APPCOMPILE
SET VCEXE=%VCAPPEXE%
CL %VChush% /W3 /c @%~dp0cache\VCoptions.opt %VCSRC%          %VCterse%

IF ERRORLEVEL 2 GOTO :FAIL5
ECHO: %VCterse%

rem Linking it all to make %VCEXE%
CL %VChush% %OUT% @%~dp0cache\rayLinking.opt /link /LTCG %SUBSYS% %VCterse%
IF ERRORLEVEL 2 GOTO :FAIL5
ECHO: %VCterse%
DEL *.obj >nul 2>nul

ECHO: [VCrayApp] PROGRAM %VCEXE% COMPILED TO %~dp0app
ECHO: %VCterse%

CD %VCfrom%
IF NOT "%VCrun%" == "1" GOTO :SUCCESS
ECHO: [VCrayApp] Launching App.  Exit App to Continue Command Session
"%~dp0app\%VCEXE%"
IF ERRORLEVEL 1 GOTO FAIL5

:SUCCESS
ENDLOCAL
IF "%VCsplice%" == "+" EXIT /B 0
ECHO:  %VCterse%
IF NOT "%VCrun%" == "1" PAUSE
EXIT /B 0

:FAIL8
ECHO: [VCrayApp] **** FAILURE: RAYLIB %VCRAYVER% NOT SUPPORTED ****
ECHO:            USE 4.0 OR ONE LATER THAN 4.2 WITH VCrayApp        %VCterse%
ECHO:            NO SIGNIFICANT ACTIONS HAVE BEEN PERFORMED         %VCterse%
GOTO :BAIL

:FAIL7
ECHO: [VCrayApp] **** FAILURE: RAYLIB VERSION NOT ^> 3.0.0 ****
ECHO:            3.5.0/3.7.0 ARE ONLY PRE-4.0 SUPPORTED BY VCrayApp %VCterse%
ECHO:            NO SIGNIFICANT ACTIONS HAVE BEEN PERFORMED         %VCterse%
GOTO :BAIL

:FAIL6
ECHO: [VCrayApp] **** FAILURE: RAYLIB NOT FOUND WHERE EXPECTED ****
ECHO:            expected at "%VCraylib%    \"                      %VCterse%
ECHO:            NO ACTIONS HAVE BEEN PERFORMED                     %VCterse%
REM   XXXX ANOTHER DEPENDENCY ON raylib\ LOCATION
GOTO :BAIL

:FAIL5
ECHO: [VCrayApp] ****PRODUCING OR OPERATING %VCEXE% FAILED ****
ECHO:            Review any reported errors.                        %VCterse%
ECHO:            Make repairs and reattempt.                        %VCterse%
ECHO:            RESULTS ARE UNPREDICTABLE                          %VCterse%
GOTO :BAIL

:FAIL4
ECHO: [VCrayApp] **** COMPILING CACHE OF RAYLIB FILES FAILED ****
ECHO:            Review the errors reported for the compilation.    %VCterse%
ECHO:            Make repairs and reattempt.                        %VCterse%
ECHO:            RESULTS ARE UNPREDICTABLE.  REBUILD CACHE.         %VCterse%
GOTO :BAIL

REM ***** VCRAYVERIFY FAIL CUSTOMIZATIONS DONE BELOW HERE ******************

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
ECHO:         -r for compiling and running examples
ECHO:
ECHO:    Exit code 0 is produced on all successful operations.
ECHO:    Exit codes greater than 1 are produced for any failure.
ECHO:
ECHO:    There is definition/use of environment variables VCAPPEXE, VCAPPSRC,
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
rem 0.0.0 2023-03-11T23:09Z Placeholder using VCrayApp.bat 0.0.34 boilerplate.
rem
rem                     *** end of VCrayVerify.bat ***
