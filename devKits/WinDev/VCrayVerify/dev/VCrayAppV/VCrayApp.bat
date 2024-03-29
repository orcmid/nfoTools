@echo off
rem VCrayApp 0.1.0 VCrayApp.bat 0.0.64 UTF-8                       2023-05-08
rem |----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

rem                  BUILDING RAYLIB APP WITH VC/C++ TOOLS
rem                  =====================================

rem This code depends on the presence of cache\, app\, src\ and ..\raylib\.
rem It must be operated within a VS Command Prompt command-line environment.
rem Use this script and all of the associated files without modification
rem  until installation and operation are confirmed.
rem
rem In most cases of standalone usage, no changes are required to this file.
rem Additional documentation of this procedure and its usage are found in the
rem accompanying VCrayApp-0.1.0.txt file.  For further information, see
rem ^<https://orcmid.github.io/nfoTools/dev/D211101/e^> and also check for the
rem latest version.

rem ***** NO CHANGES EVER NEEDED BELOW HERE FOR STANDARD USAGE **************

rem Designate the semantic-versioned distribution of VCrayApp
SET VCrayApp=0.1.0

SET VCfrom=%CD%
rem remembering where VCrayApp.bat is called *from*, so it can be restored
rem on exit, including after errors.

rem If embedded, the host must enable extensions and VCrayApp.bat will expose
rem environment variables it defines, especially related to confirming a
rem cache.  Note that the variables set/cleared above are all in the locality
rem of any calling/host script.

SET ERRORLEVEL=0
SET VCsplice=%1

REM WE CAN BAIL AT ANY TIME BELOW HERE

IF "%VCsplice%" == "+" GOTO :ALLFLAVORS
VERIFY bogus 2>NUL
rem forcing an error in case CMD doesn't actually handle ENABLEEXTENSIONS
SETLOCAL ENABLEEXTENSIONS
IF ERRORLEVEL 1 GOTO :FAIL0

SET VCrayAppHost=
SET VCrayAppHostURL=
rem When VCrayApp is hosted by another script, VCrayAppHost can be set to
rem have this reported in the confirmation of VCrayApp cache creation.
rem When VCrayAppHost is set, a URL for additional handling of VCrayApp
rem failure messages can be presented if VCrayAppHostURL is set by the host.

:ALLFLAVORS
rem below here, extensions are employed, embedded or not
SET VCraylib=%~dp0..\raylib
rem XXX This is a fragile dependency also in cache\rayLibCode.opt files and
rem     other parts of this script.

rem SELECT EMBEDDED, TERSE, OR DEFAULT
rem     %1 value "+" selects smooth non-stop operation for splicing output
rem        into that of a calling script.
rem     %2 might then be "*" and allow for that.
rem don't shift anything out until %1-%2 handled.

SET VChush=
SET VCterse=
IF NOT "%1" == "+" GOTO :MAYBETERSE
IF NOT "%2" == "*" GOTO :MAYBETERSE
SET VCterse=^>NUL 2^>NUL
Set VChush=/nologo

:MAYBETERSE
rem SELECT TERSE OR VERBOSE
IF "%1" == "*" ( SET VCterse=^>NUL 2^>NUL
                 SET VChush=/nologo
                 )

rem CONFIRM COMMAND-LINE ENVIRONMENT
IF "%VSCMD_VER%" == "" GOTO FAIL3
WHERE cl.exe >NUL 2>NUL
IF ERRORLEVEL 1 goto FAIL3
ECHO: [VCrayApp] %VCrayApp% OPERATING WITH VC/C++ %VSCMD_VER% TOOLS

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

REM DETERMINE IF THERE IS A NAMED APP TO PRODUCE
SET VCAPPEXE=
IF NOT "%1" == "" (SET VCAPPEXE=%1
                   SHIFT /1)

REM NOW SEE IF THERE IS A NON-DEFAULT SOURCE CODE LOCATION
SET VCAPPSRC=src\*.c
rem This is the default source file location.  It is treated as a special
rem case.  It can be over-ridden with a parameter at this point.
IF NOT "%1" == "" (SET VCAPPSRC=%1
                   SHIFT /1)

REM SO FAR, NO FURTHER PARAMETER IS ALLOWED FOR
IF NOT "%1" == "" GOTO FAIL2

:LOCATE
REM SUPPOSED PARAMETERS HAVE BEEN ESTABLISHED.  NOW CHECK INTEGRITY OF
rem THE VCrayApp PROJECT STRUCTURE AND THE RAYLIB LIBRARY LOCATION
rem Some are customizable, none should be removed, all %VCrayApp% specific
IF NOT EXIST "%~dp0cache\cache.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0cache\raylibCode.3.x.0.opt" GOTO :FAIL1
IF NOT EXIST "%~dp0cache\raylibCode.4.x.0.opt" GOTO :FAIL1
IF NOT EXIST "%~dp0cache\raylibVars.opt" GOTO :FAIL1
IF NOT EXIST "%~dp0cache\rayConfirmLinking.opt" GOTO :FAIL1
IF NOT EXIST "%~dp0cache\rayAppLinking.opt" GOTO :FAIL1
IF NOT EXIST "%~dp0cache\VCoptions.opt" GOTO :FAIL1
IF NOT EXIST "%~dp0cache\VCrayConfirm.c" GOTO :FAIL1
IF NOT EXIST "%~dp0cache\VCrayVerCheck.c" GOTO :FAIL1
IF NOT EXIST "%~dp0app\app.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0src\src.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0VCrayApp-%VCrayApp%.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0VCrayApp.bat" GOTO :FAIL1
IF NOT EXIST "%~dp0CHANGES-%VCrayApp%.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0NOTICE.txt" GOTO :FAIL1

IF NOT EXIST "%VCraylib%\src\raylib.h" GOTO :FAIL6
rem XXX *IMPORTANT* Another fragile dependency on location of raylib\

rem CACHE LINKABLE RAYLIB CODE IF NEEDED
IF NOT EXIST %~dp0cache\VCrayConfirm.exe GOTO :CACHENEEDED
rem If we had cratered on :FAIL4/:FAIL5, we must also rebuild cache,
rem signalled by deleating VCrayConfirm.exe. First run finds this too.
IF NOT EXIST %~dp0cache\rglfw.obj GOTO :CACHENEEDED
IF NOT "%VCclean%" == "1" GOTO :APPCHECK

:CACHENEEDED
DEL %~dp0cache\*.obj >NUL 2>NUL

REM COMPILE THE CACHE OF RAYLIB COMPONENTS FOR LINKING AS NEEDED
REM ************************************************************

CD %~dp0cache
rem FIRST, DETERMINE THE VERSION OF RAYLIB THAT IS AVAILABLE
rem VCrayVerCheck fishes any RAYLIB_VERSION from raylib.h
SET VCEXE=VCrayVerCheck.exe
rem       for customization of any FAIL5 message
CL %VChush% @VCoptions.opt VCrayVerCheck.c   %VCterse%
IF ERRORLEVEL 1 GOTO :FAIL5
IF NOT EXIST VCrayVerCheck.exe GOTO :FAIL5
del VCrayVer.bat >NUL 2>NUL
SET VCEXE=VCrayVer.bat
VCrayVerCheck.exe >VCrayVer.bat
del VCrayVerCheck.obj VCrayVerCheck.exe >NUL 2>NUL
IF NOT EXIST VCrayVer.bat GOTO :FAIL5
CALL VCrayVer.bat
IF ERRORLEVEL 1 GOTO :FAIL5
IF "%VCRAYVER%" == "" GOTO :FAIL5

REM %VCRAYVER% IS THE VERSION FROM raylib.h OR IT IS "unidentified"
IF %VCRAYVER% == "4.2" GOTO :FAIL8
REM **IMPORTANT**  Additional exclusions beyond "4.5" must go here.

COPY /Y raylibCode.4.x.0.opt raylibCode.opt >NUL 2>NUL
REM assuming that the same raylibCode.opt serves all 4.x versions

IF NOT %VCRAYVER% == "unidentified" GOTO :BUILDCACHE

rem Versions of raylib.h before 4.0 do not set RAYLIB_VERSION so some
rem    known fingeprints isolate supported versions.
IF EXIST %VCraylib%\appveyor.yml GOTO :FAIL7
IF EXIST %VCraylib%\.travis.yml GOTO :FAIL7
IF EXIST %VCraylib%\HELPME.md GOTO :FAIL7
COPY /Y raylibCode.3.x.0.opt rayLibCode.opt >NUL 2>NUL
SET VCRAYVER="3.7.0"
IF EXIST %VCraylib%\CONTRIBUTORS.md GOTO :BUILDCACHE
SET VCRAYVER="3.5.0"

:BUILDCACHE
REM AT LAST, WE ARE READY TO BUILD THE CACHE OF RAYLIB COMPONENTS

CL %VChush% /w /c @VCoptions.opt @raylibVars.opt @raylibCode.opt %VCterse%
IF ERRORLEVEL 2 GOTO :FAIL4
ECHO: [VCrayApp] FRESH CACHE OF RAYLIB %VCRAYVER% *.OBJ FILES COMPILED
ECHO: %VCterse%

:VCRAYCONFIRMBUILD
REM THE PROGRAM VCrayConfirm IS BUILT AND RUN AFTER EVERY CACHE BUILD
REM It is all built in cache\, leaving app\ and %VCAPPSRC% untouched.

SET VCEXE=VCrayConfirm.exe
SET VCSRC=%~dp0cache\VCrayConfirm.c

DEL *.exe >NUL 2>NUL
rem Flags
SET OUT=/Fe: "%VCEXE%"
SET SUBSYS=/SUBSYSTEM:WINDOWS /ENTRY:mainCRTStartup

rem Compiling the %VCSRC%
CL %VChush% /W3 /c @VCoptions.opt %VCSRC% %VCterse%
IF ERRORLEVEL 2 GOTO :FAIL5
ECHO: %VCterse%

rem Linking it all as %VCEXE%
CL %VChush% %OUT% @rayConfirmLinking.opt /link /LTCG %SUBSYS% %VCterse%
IF ERRORLEVEL 2 GOTO :FAIL5
ECHO: %VCterse%
DEL VCrayConfirm.obj >NUL 2>NUL

CD %VCfrom%
REM RESTORE ORIGINAL %CD% IN CASE WE FAIL OR ARE CLOSED HERE
IF NOT EXIST %~dp0cache\%VCEXE% GOTO :FAIL5

ECHO: [VCrayApp] Launching %VCEXE%.  Exit App to Continue Session  %VCterse%
ECHO: %VCterse%
%~dp0cache\%VCEXE%
IF ERRORLEVEL 1 GOTO :FAIL5

REM leaving VCrayConfirm.exe as indicator of cache-deemed good

:APPCHECK
REM THERE IS A CONFIRMED CACHE.  NOW SEE HOW TO ADVANCE THE PROJECT.
REM ****************************************************************

IF NOT "%VCAPPEXE%" == "" GOTO :APPBUILD
REM IF THAT PARAMETER WAS PROVIDED, IT IS TIME TO BUILD SOME PROJECT CODE

IF "%VCsplice%" == "+" GOTO :SUCCESS
REM BUT IF WE ARE RUNNING EMBEDDED THERE IS NO NEED FOR COMMENTARY

:NOAPP
REM WE DON'T KNOW ANYTHING TO BUILD AND WE'LL BOW OUT NOW.
IF NOT "%VCrayAppHost%" == "" GOTO :FUMBLED
IF "%VCsplice%" == "+" GOTO :MUMBLED
ECHO: [VCrayApp] **** ALL SET. CACHE AVAILABLE. NO APP TO COMPILE YET. ****
ECHO:            When the project executable is named on the call to VCrayApp,
ECHO:            compilation of the project source code will be attempted.
ECHO:            Source code will be taken from the default src\*.c or from
ECHO:            the src parameter of the VCrayApp command.
:MAYBEAPP
ECHO:            See ^<https://orcmid.github.io/nfoTools/dev/D211101/e/^>.
ECHO: %VCterse%

IF NOT "%VCrun%" == "1" GOTO :SUCCESS
REM There is nothing we know to run, so shrug about the "-r".
SET VCrun=0
IF NOT "%VCrayAppHost%" == "" GOTO :FUMBLED
ECHO: [VCrayApp] **** IGNORING "-r" OPTION.  NAME THE EXECUTABLE FIRST. ****
GOTO :SUCCESS

:FUMBLED
ECHO: [VCrayApp] **** NO APP TO RUN YET FOR %VCrayAppHost% ****    %VCterse%
GOTO :SUCCESS

:MUMBLED
ECHO: [VCrayApp] NAMED HOST DESIRABLE FOR EMBEDDED ("+") OPERATION  %VCterse%
GOTO :MAYBEAPP

:APPBUILD
REM WE HAVE A PROJECT TO BUILD.  IT IS TIME TO BUILD IT.
REM ****************************************************

CD %~dp0app
DEL *.exe >NUL 2>NUL
rem Flags
SET OUT=/Fe: "%VCAPPEXE%"
SET SUBSYS=/SUBSYSTEM:WINDOWS /ENTRY:mainCRTStartup

REM COMPILING THE SOURCE CODE
SET VCSRC=%~dp0%VCAPPSRC%
IF "%VCAPPSRC%" == "src\*.c" GOTO :APPCOMPILE
rem otherwise, a different %SRC% has been set.
SET VCSRC=%VCAPPSRC%

:APPCOMPILE
SET VCEXE=%VCAPPEXE%
CL %VChush% /W3 /c @%~dp0cache\VCoptions.opt %VCSRC%          %VCterse%

IF ERRORLEVEL 2 GOTO :FAIL5
ECHO: %VCterse%

REM LINKING IT ALL TO MAKE %VCEXE%
CL %VChush% %OUT% @%~dp0cache\rayAppLinking.opt /link /LTCG %SUBSYS% %VCterse%
IF ERRORLEVEL 2 GOTO :FAIL5
ECHO: %VCterse%
DEL *.obj >NUL 2>NUL

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
ECHO:  %VCterse%
REM IF NOT "%VCrun%" == "1" PAUSE
GOTO :FALLOUT

:FAIL8
ECHO: [VCrayApp] **** FAILCODE8: RAYLIB %VCRAYVER% NOT SUPPORTED ****
ECHO:            USE 4.0 OR ONE LATER THAN 4.2 WITH VCrayApp        %VCterse%
ECHO:            NO SIGNIFICANT ACTIONS HAVE BEEN PERFORMED         %VCterse%
ECHO:            ^<https://orcmid.github.io/nfoTools/dev/D211101/f/FAIL8^>
GOTO :BAIL

:FAIL7
ECHO: [VCrayApp] **** FAILCODE7: RAYLIB VERSION NOT ^> 3.0.0 ****
ECHO:            3.5.0/3.7.0 ARE ONLY PRE-4.0 SUPPORTED BY VCrayApp %VCterse%
ECHO:            NO SIGNIFICANT ACTIONS HAVE BEEN PERFORMED         %VCterse%
ECHO:            ^<https://orcmid.github.io/nfoTools/dev/D211101/f/FAIL7^>
GOTO :BAIL

:FAIL6
ECHO: [VCrayApp] **** FAILCODE6: RAYLIB NOT FOUND WHERE EXPECTED ****
ECHO:            expected at "%VCraylib%\"
ECHO:            NO ACTIONS HAVE BEEN PERFORMED
ECHO:            ^<https://orcmid.github.io/nfoTools/dev/D211101/f/FAIL6^>
REM   XXXX ANOTHER DEPENDENCY ON raylib\ LOCATION
GOTO :BAIL

:FAIL5
IF NOT "%VCEXE%" == "%VCAPPEXE%" DEL %~dp0cache\VCrayConfirm.exe >NUL 2>NUL
rem ensure that the cache will be rebuilt except when the problem is later.
ECHO: [VCrayApp] **** FAILCODE5: PRODUCING/OPERATING %VCEXE% FAILED ****
ECHO:            Review any reported errors.                        %VCterse%
ECHO:            Make repairs and reattempt.                        %VCterse%
ECHO:            RESULTS ARE UNPREDICTABLE                          %VCterse%
ECHO:            ^<https://orcmid.github.io/nfoTools/dev/D211101/f/FAIL5^>
GOTO :BAIL

:FAIL4
DEL %~dp0cache\rglfw.obj %~dp0cache\VCrayConfirm.exe >NUL 2>NUL
rem   ensure that attempting to use the cache can't be worked-around
ECHO: [VCrayApp] **** FAILCODE4: CACHING RAYLIB %VCRAYVER% FILES FAILED ****
ECHO:            Review the errors reported for the compilation.    %VCterse%
ECHO:            Make repairs and reattempt.                        %VCterse%
ECHO:            RESULTS ARE UNPREDICTABLE.  REBUILD CACHE.         %VCterse%
ECHO:            ^<https://orcmid.github.io/nfoTools/dev/D211101/f/FAIL4^>

GOTO :BAIL

:FAIL3
ECHO: [VCrayApp] **** FAILCODE3: NO VS NATIVE COMMAND-LINE ENVIRONMENT ****
ECHO:            VCrayApp.bat requires command-line operation under %VCterse%
ECHO:            the "x64 Native Tools Command Prompt" environment. %VCterse%
ECHO:            NO ACTIONS HAVE BEEN PERFORMED                     %VCterse%
ECHO:            ^<https://orcmid.github.io/nfoTools/dev/D211101/f/FAIL3^>
GOTO :BAIL

:FAIL2
ECHO: [VCrayApp] **** FAILCODE2: UNSUPPORTED VCRAYAPP.BAT PARAMETERS ****
ECHO:            Invalid Here: %*
ECHO:            NO ACTIONS HAVE BEEN TAKEN. For more information, %VCterse%
ECHO:            ^<https://orcmid.github.io/nfoTools/dev/D211101/f/FAIL2^>.
ECHO:            %VCterse%
GOTO :USAGE

:FAIL1
ECHO: [VCrayApp] **** FAILCODE1: INCORRECT VCrayApp FILES CONFIGURATION ****
ECHO:            VCrayApp.bat must be in a folder that VCrayApp.zip %VCterse%
ECHO:            is extracted into, along with the cache\ app\ and  %VCterse%
ECHO:            src\ subfolders.  NO ACTIONS HAVE BEEN TAKEN.  See %VCterse%
ECHO:            ^<https://orcmid.github.io/nfoTools/dev/D211101/f/FAIL1^>.
GOTO :BAIL

:FAIL0
ECHO: [VCrayApp] **** FAILCODE0: COMMAND SHELL EXTENSIONS REQUIRED ****
ECHO:            VCrayApp.bat requires CMDEXTVERSION 2 or greater.
ECHO:            This is available wherever VCrayApp.bat is usable.
ECHO:            NO ACTIONS HAVE BEEN PERFORMED. For more information,
ECHO:            ^<https://orcmid.github.io/nfoTools/dev/D211101/f/FAIL0^>.
GOTO :BAIL

:USAGE
rem    PROVIDE USAGE INFORMATION
ECHO:   USAGE: VCrayApp [+] ?                            VCrayApp-%VCRAYAPP%
ECHO:          VCrayApp [+] [*] [-c] [[-r] exe [src]]
IF NOT "%1" == "?" GOTO :BAIL
ECHO:   where  ? produces this usage information.
ECHO:          + ONLY FOR OPERATING AS A HELPER FROM ANOTHER SCRIPT, with
ECHO:            non-stop operation, among other adjustments.
ECHO:          * selects terse output.  If operation fails, repeat
ECHO:            without this option for more details.
ECHO:         -c for a complete rebuild of any cache
ECHO:         -r for running the app on successful build
ECHO:        exe the name of the executable to be built in app\
ECHO:        src the location of source code to compile when not the
ECHO:            default src\*.c location
ECHO:
ECHO:    ERRORLEVEL 0 is produced on all successful operations;
ECHO:    codes greater than 1 are produced for any failures.
ECHO:
ECHO:    VCrayApp depends on VSCMD_VER being set by the VS Command Prompt
ECHO:    with CMDEXTVERSION 2 or better available for operation.
ECHO:    There is use/clearing of environment variables VCrayApp, VCfrom,
ECHO:    and VCsplice.  Others are exposed when operating embedded under
ECHO:    another script (option "+").
ECHO:
ECHO:    See ^<https://orcmid.github.io/nfoTools/dev/D211101/e^> for details.
ECHO:

IF "%VCsplice%" == "+" GOTO :FALLOUT
ENDLOCAL
GOTO :FALLOUT

:BAIL
ECHO:
IF NOT ERRORLEVEL 2 SET ERRORLEVEL=2
CD %VCfrom%                                                         %VCterse%
rem always leave with the one that brung us
IF "%VCsplice%" == "+" EXIT /B %ERRORLEVEL%
ENDLOCAL
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
rem 0.0.64 2023-05-08T16:22Z Touch-up references to D211101 a little.
rem 0.0.63 2023-05-08T01:29Z Adjust Messages to D211101/f structure
rem 0.0.62 2023-05-06T00:22Z Add VCrayApp Version to Usage Information
rem 0.0.61 2023-05-03T04:33Z MAJOR REORGANIZATION AND USAGE CHANGES
rem 0.0.60 2023-04-23T20:24Z Always give verbose FAILCODE6 report
rem 0.0.59 2023-04-21T22:41Z Improve FAILCODE6-FAILCODE8 reporting
rem 0.0.58 2023-04-16T19:01Z More FAILCODE4/5 cache rebuild forcing edge cases
rem 0.0.57 2023-04-16T17:42Z Ensure no VCrayConfirm.exe upon :FAIL4, forcing
rem        rebuild of cache on next run.
rem 0.0.56 2023-04-15T15:29Z Fix incorrect :FAIL5 check on VCrayConfirm.exe
rem 0.0.55 2023-04-14T19:33Z Force cache rebuild after a FAILCODE4
rem 0.0.54 2023-04-13T19:55Z Improve FAILCODE4/5 reporting
rem 0.0.53 2023-04-12T19:46Z Improve FAILCODE3 reporting
rem 0.0.52 2023-04-11T22:23Z Improve FAILCODE2 reporting
rem 0.0.51 2023-04-11T22:14Z Remove screen clearing at beginning and improve
rem        successful conclusion when no project .exe identified yet.
rem 0.0.50 2023-04-10T19:21Z Add NOTICE.txt to required files
rem 0.0.49 2023-04-10T18:32Z Finalize :FAIL1 and FAIL2 messages with links
rem 0.0.48 2023-04-09T19:52Z Finalize :FAIL0 message with link
rem 0.0.47 2023-04-08T20:48Z Fixes to build VCrayConfirm in cache\, not app\
rem 0.0.46 2023-04-08T19:55Z Improve CMDEXTENSIONS check, touch-ups, fixes
rem 0.0.45 2023-04-04T20:43Z Update Usage Information, now release candidate
rem 0.0.44 2023-04-04T20:21Z Fix an embedded case, some comment touch-ups
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
