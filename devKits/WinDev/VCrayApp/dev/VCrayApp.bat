@echo off
rem VCrayApp 0.1.0 VCrayApp.bat 0.0.43 UTF-8                       2023-04-02
rem |----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

rem                  BUILDING RAYLIB APP WITH VC/C++ TOOLS
rem                  =====================================

rem This code depends on the presence of cache\, app\, src\ and ..\raylib\.
rem It must be operated within a VS Command Prompt command-line environment.
rem Use the script without modification until installation and operation is
rem confirmed.  Then alter the VCAPPEXE and VCAPPSRC vars as appropriate
rem for a specific standalone project.

rem NOTE: If VCrayApp.bat is incorporated as a component of a larger project,
rem       indicated by option "+", this file does not require modification.

REM *** PROLOGUE*** READ CAREFULLY, CHANGE THESE SETTINGS AS NECESSARY ****
REM *** THESE SETTING ONLY MATTER FOR STANDALONE USAGE OF VCRAYAPP     ****
REM *** WHEN CALLED FROM A HOST PROJECT (OPTION "+") THESE ARE IGNORED.****
REM *** See ^<https://orcmid.github.io/nfoTools/dev/D211101^>.         ****
REM ***********************************************************************

IF "%1" == "+" GOTO :NOCHANGES
REM DO NOT REMOVE THIS LINE.  IT DOES NOT INTERFERE WITH STANDALONE USAGE

rem VCrayApp does not compile a standalone project's source code until
rem VCAPPEXE is set.

SET VCAPPEXE=RenameMe.exe
rem Hint: don't use RenameMe.exe for your app.  Do use the complete .exe name.
rem When VCrayApp is operated embedded in another project, this is skipped.

rem VCrayApp will not attempt to compile a standalone project's source code
rem until VCAPPSRC is also set. When VCrayApp is operated embedded in
rem another project, this is also skipped.

SET VCAPPSRC=src\*.c
rem VCrayApp treats this as a special case.  If this is defined to a location
rem and files elsewhere, a complete absolute location must be provided.
rem It is strongly-recommended that src\ be used for standalone raylib app
rem projects, especially for novice applications of raylib.

rem *********** NO CHANGES EVER NEEDED BELOW HERE ****************************
rem |----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

:NOCHANGES
rem Designate the semantic-versioned distribution
SET VCrayApp=0.1.0
SET VCraylib=%~dp0..\raylib
rem XXX This is a fragile dependency also in cache\rayLibCode.opt files and
rem     other parts of this script.

rem Additional documentation of this procedure and its usage are found in the
rem accompanying VCrayApp-%VCrayApp%.txt file.  For further information, see
rem ^<https://orcmid.github.io/nfoTools/dev/D211101^> and check for the latest
rem version.

SET VCfrom=%CD%
rem remembering where VCrayApp.bat is called *from*, so it can be restored
rem on exit, including after errors.
SET VCterse=
SET VChush=
SET VCsplice=%1
rem can :BAIL from any point now

rem If embedded, the host must set locality and VCrayApp.bat will expose the
rem environment variables it defines, especially related to confirming a
rem cache.  Note that the variables set/cleared above are all in the locality
rem of any calling/host script.
SET ERRORLEVEL=0
IF NOT "%1" == "+" SETLOCAL ENABLEEXTENSIONS
IF ERRORLEVEL 1 GOTO :FAIL0

IF NOT "%1" == "+" SET VCrayAppHost=
rem When VCrayApp is hosted by another script, VCrayAppHost can be set to
rem have this reported in the confirmation of VCrayApp cache creation.

IF NOT "%1" == "+" SET VCrayAppHostURL=
rem When VCrayAppHost is set, a URL for additional handling of VCrayApp
rem failure messages can be presented if VCrayAppHostURL is set by the host.

rem SELECT EMBEDDED, TERSE, OR DEFAULT
rem     %1 value "+" selects smooth non-stop operation for splicing output
rem        into that of a calling script.
rem     %2 might then be "*" and allow for that.
rem don't shift anything out until %1-%2 handled.

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
ECHO: [VCrayApp] %VCrayApp% BUILDING RAYLIB APP WITH VC/C++ %VSCMD_VER% TOOLS

IF "%VCsplice%" == "+" GOTO :PARMCHECK
ECHO:          %TIME% %DATE% on %USERNAME%'s %COMPUTERNAME%         %VCterse%
ECHO:          VCrayApp at %~dp0                                    %VCterse%

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
IF NOT EXIST "%~dp0cache\raylibCode.3.x.0.opt" GOTO :FAIL1
IF NOT EXIST "%~dp0cache\raylibCode.4.x.0.opt" GOTO :FAIL1
IF NOT EXIST "%~dp0cache\raylibVars.opt" GOTO :FAIL1
IF NOT EXIST "%~dp0cache\rayLinking.opt" GOTO :FAIL1
IF NOT EXIST "%~dp0cache\VCoptions.opt" GOTO :FAIL1
IF NOT EXIST "%~dp0cache\VCrayConfirm.c" GOTO :FAIL1
IF NOT EXIST "%~dp0cache\VCrayVerCheck.c" GOTO :FAIL1
IF NOT EXIST "%~dp0app\app.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0src\src.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0VCrayApp-%VCrayApp%.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0VCrayApp.bat" GOTO :FAIL1
IF NOT EXIST "%~dp0CHANGES.txt" GOTO :FAIL1

IF NOT EXIST "%VCraylib%\src\raylib.h" GOTO :FAIL6
rem XXX *IMPORTANT* Another fragile dependency on location of raylib\

rem CACHE LINKABLE RAYLIB CODE IF NEEDED
IF NOT "%VCclean%" == "1" GOTO :CACHECHECK
DEL %~dp0cache\rglfw.obj >nul 2>nul
rem XXX We depend on rglfw.c being compiled last and absence is taken
rem XXX to mean cache is absent/obsolete.

:CACHECHECK
IF EXIST %~dp0cache\rglfw.obj GOTO :APPCHECK
rem Using presence of the last-built raylib .obj to determine full cache.
rem *IMPORTANT* Keep consistent with %~dp0cache\raylibCode.opt cases
DEL %~dp0cache\*.obj >nul 2>nul

REM COMPILE THE CACHE OF RAYLIB FILES THAT MAY BE NEEDED
REM ****************************************************

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
rem Versions of raylib.h before 4.0 do not set RAYLIB_VERSION so we must
rem    use some known fingeprints of earlier versions.
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
ECHO: [VCrayApp] FRESH CACHE OF RAYLIB %VCRAYVER% *.OBJ FILES COMPILED
ECHO: %VCterse%

:VCRAYCONFIRMBUILD
REM THE PROGRAM VCrayConfirm IS BUILT AND RUN AFTER EVER CACHE BUILD
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

:APPCHECK
REM THERE IS A CONFIRMED CACHE.  NOW COMPILE AND RUN THE PROJECT APP AS NEEDED
REM **************************************************************************

IF "%VCAPPEXE%" == "" GOTO :NOAPP
IF NOT "%VCAPPEXE%" == "RenameMe.exe" GOTO :APPBUILD
IF "%VCsplice%" == "+" GOTO :SUCCESS

:NOAPP
IF NOT "%VCrayAppHost%" == "" GOTO :FUMBLED
ECHO: [VCrayApp] **** ALL SET. CACHE CONFIRMED. NO APP TO COMPILE YET. ****
ECHO:            Have the C Language source code and any headers at
ECHO:            VCAPPSRC.  Then put the app .exe name in the VCAPPEXE
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
ECHO: [VCrayApp] *** NO APP TO RUN YET FOR %VCrayAppHost%      %VCterse%
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

IF NOT "%VCrun%" == "1" GOTO :SUCCESS
ECHO: [VCrayApp] Launching App.  Exit App to Continue Command Session
"%~dp0app\%VCEXE%"
IF ERRORLEVEL 1 GOTO FAIL5

:SUCCESS
CD %VCfrom%
IF "%VCsplice%" == "+" GOTO :FALLOUT
ENDLOCAL
SET VCAPPEXE=
SET VCAPPSRC=
rem    Protecting against a subsequent splicing re-entry to VCrayApp.bat
ECHO:  %VCterse%
REM IF NOT "%VCrun%" == "1" PAUSE
GOTO :FALLOUT

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

:FAIL3
ECHO: [VCrayApp] **** FAIL: NO VS NATIVE COMMAND-LINE ENVIRONMENT ****
ECHO:            VCrayApp.bat requires the command-line environment %VCterse%
ECHO:            for VS Native Build Tools to be established.  See  %VCterse%
ECHO:            ^<https://orcmid.github.com/nfoTools/dev/D211101^>.%VCterse%
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
ECHO:            VCrayApp.bat requires CMDEXTVERSION 2 or greater.
ECHO:            This is available wherever VCrayApp.bat is usable.
ECHO:
ECHO:            NO ACTIONS HAVE BEEN PERFORMED
GOTO :BAIL

:USAGE
rem    PROVIDE USAGE INFORMATION
ECHO:   USAGE: VCrayApp [+] ?
ECHO:          VCrayApp [+] [*] [-c] [-r]
IF NOT "%1" == "?" GOTO :BAIL
ECHO:   where  ? produces this usage information.
ECHO:          + for operating as a helper from another script, providing
ECHO:            non-stop operation without any screen clearing and without
ECHO:            pausing, among other adjustments.
ECHO:          * selects terse output.  If operation fails, repeat
ECHO:            without this option for more details.
ECHO:         -c for a complete rebuild of any cache
ECHO:         -r for running the app on successful build
ECHO:
ECHO:    Exit code 0 is produced on all successful operations.
ECHO:    Exit codes greater than 1 are produced for any failure.
ECHO:
ECHO:    VCrayApp depends on VSCMD_VER being set by the VS Command Prompt
ECHO:    with CMDEXTEVERSION 2 or better available for operation.
ECHO:
ECHO:    There is use/clearing of environment variables VCAPPEXE, VCAPPSRC,
ECHO:    VCfrom, VChush, VCrayApp, VCrayAppHost, VCrayAppHostURL, VCraylib,
ECHO:    VCsplice, and VCterse.  When VCrayApp is operated under another
ECHO:    script (option "+"), additional variables are exposed to that host.
ECHO:
IF "%VCsplice%" == "+" GOTO :FALLOUT
ENDLOCAL
SET VCAPPEXE=
SET VCAPPSRC=
rem     Prevent these from leaking into embedded ("+") VSrayApp.bat re-entry
GOTO :FALLOUT

:BAIL
ECHO:
IF NOT ERRORLEVEL 2 SET ERRORLEVEL=2
CD %VCfrom%                                                         %VCterse%
rem always leave with the one that brung us
IF "%VCsplice%" == "+" EXIT /B %ERRORLEVEL%
ENDLOCAL
SET VCAPPEXE=
SET VCAPPSRC=
rem    Also prevent leaking into an embedded ("+") re-entry to VCrayApp.bat
IF NOT "%VCterse%" == "" EXIT /B %ERRORLEVEL%
ECHO:
PAUSE
EXIT /B %ERRORLEVEL%

:FALLOUT
rem All success exits fall through the end to avoid exiting a calling script
SET ERRORLEVEL=0
rem now just fall off the end of the file

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
rem 0.0.43 2023-04-02T20:45Z Clean up exits to prevent EXE/SRC leaking
rem 0.0.42 2023-04-02T16:37Z Improved embedding, release-candidate touch-ups
rem 0.0.41 2023-03-28T19:44Z Streamline "+" and VCrayAppHost considerations
rem 0.0.40 2023-03-28T19:16Z Fix: Correct some misplaced VCrayVerify change
rem                          Work on proper ordering of operations
rem 0.0.39 2023-03-28T16:18Z Fix: Silly typo
rem 0.0.38 2023-03-22T22:20Z Fix: Backport successful hosted subordination
rem 0.0.37 2023-03-21T22:17Z Fix: Preliminaries so :BAIL is always clean.
rem 0.0.36 2023-03-11T22:29Z Fix :FAIL1 before %VCterse% and don't pause on
rem        successful cases
rem 0.0.35 2023-03-10T18:52Z Fix VCRAYSRC/VCAPPSRC typo
rem 0.0.34 2023-03-10T02:17Z Initial Beta Candidate
rem 0.0.33 2023-03-10T00:07Z Notification on launching VCrayConfirm
rem 0.0.32 2023-03-09T00:16Z Verify setting cases and touch-up the handling
rem 0.0.31 2023-03-08T21:13Z Complete Filtering on the prologue settings.
rem 0.0.30 2023-03-03T21:10Z Initial VCrayAppHost and VCrayAppHostURL setting
rem 0.0.29 2023-03-02T19:19Z Introduce VCrayAppHost and clean up around it.
rem 0.0.28 2023-02-27T21:14Z Defend against undefined APP_EXE and SRC
rem 0.0.27 2023-02-27T02:22Z Wrap up as candidate for VCrayApp 0.1.0
rem 0.0.26 2023-02-27T02:14Z Add separate VCrayConfirm.c building, update
rem        to handle with or without app code introduced.
rem 0.0.25 2023-02-24T18:44Z Renamed raylibCode.4.0.0.opt to 4.x.0, and
rem        touching up, annotating for further changes.
rem 0.0.25 2023-02-23T06:02Z Narrow down VCRAYVER when no REYLIB_VERSION
rem 0.0.24 2023-02-21T02:59Z Revert to using VCrayVerCheck.c from .cz
rem 0.0.23 2023-02-21T01:19Z Introduce code to derive VCRAYVER variable.
rem        Rename rayConfirm.c to VCrayConfirm.c and VCrayConfirm.exe
rem        Make fixes found in having VCrayVerCheck procedure work
rem 0.0.22 2023-02-19T21:00Z Check all required cache/ files including the
rem        newly-named VCrayVerCheck.cx
rem 0.0.21 2023-02-18T23:43Z Update Usage and show Tools Version
rem 0.0.20 2023-02-09T22:48Z Review for automation of raylib version checking
rem        and reporting
rem 0.0.19 2023-01-14T19:25Z Update for VCrayApp 0.1.0
rem
rem                      *** end of VCrayApp.bat ***
