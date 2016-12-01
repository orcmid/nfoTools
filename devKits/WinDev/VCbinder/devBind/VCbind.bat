@echo off
rem VCbind.zip\VCbind.bat 0.1.1     UTF-8                           2016-11-29 
rem -----1---------2---------3---------4---------5---------6---------7-------*

rem                  SETTING VC++ COMMAND-SHELL ENVIRONMENT
rem                  ======================================

rem This procedure sets the Windows PC command-shell environment for command-
rem line use of the Visual C++ command-line compiler, cl.exe, and related
rem build tools.

rem Additional documentation of this procedure and its usage are found in the
rem accompanying VCbind-0.1.0.txt file.  For further information, see
rem <http://nfoWare.com/dev/2016/11/d161101.htm> and check for the latest
rem version at <http://nfoWare.com/dev/2016/11/d161101b.htm>.

rem Designate the distribution version 
SET VCverNum=0.1.1
rem     0.1.1+ semantic versioning candidate
rem     the least change past 0.1.0 is always the next candidate until
rem     an actual distribution candidate is staged.

rem SELECT TERSE OR VERBOSE
rem     %1 value "*" selects terse operation
rem     don't shift that %1 out until Command Extensions confirmed.
SET VCterse=
IF "%1" == "*" SET VCterse=^>NUL
rem                used to dump verbose echoes

rem ANNOUNCE THIS SCRIPT
IF "%1" == "*" GOTO :WHISPER
TITLE VC++ COMMAND-LINE BUILD ENVIRONMENT SETUP
COLOR 71
rem   Soft white background with blue text

CLS
ECHO:
:WHISPER
ECHO: [VCbind] %VCverNum% VC++ COMMAND-SHELL ENVIRONMENT SETUP
IF NOT CMDEXTVERSION 2 GOTO :FAIL0
ECHO:          %TIME% %DATE% on %USERNAME%'s %COMPUTERNAME%         %VCterse%
ECHO:          %~f0                                                 
rem            reporting full-path filename of this script

rem VERIFY LOCATION OF THE SCRIPT WHERE VCBIND.ZIP IS FULLY EXTRACTED
IF NOT EXIST "%~dp0LICENSE.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0NOTICE.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0VCbind-%VCverNum%.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0VCbind.bat" GOTO :FAIL1

rem DETERMINE PARAMETERS
rem    See :USAGE for the VCbind API contract
  
IF "%1" == "?" GOTO :USAGE
IF "%1" == "*" SHIFT /1

SET VCaskedConfig=x86
rem    make even the default explicit
IF NOT "%1" == "" SET VCaskedConfig=%1

SET VCasked=140
rem    default absent any other provision
IF DEFINED VCbound SET VCasked=%VCbound%
rem    if previous binding, use that toolset by default
IF NOT "%2" == "" SET VCasked=%2

rem VERIFY CONFIG
IF "%VCaskedConfig%" == "x86"  GOTO :CHECKCONFLICT
IF "%VCaskedConfig%" == "x86_amd64" GOTO :CHECKCONFLICT
IF "%PROCESSOR_ARCHITECTURE%" == "x86" GOTO :FAIL7
IF "%VCaskedConfig%" == "amd64" GOTO :CHECKCONFLICT
IF NOT "%VCaskedConfig%" == "amd64_x86" GOTO :FAIL7

:CHECKCONFLICT
rem CHECK WHETHER VCBIND SETTINGS HAVE ALREADY BEEN MADE
IF DEFINED VCbound GOTO :ALREADY

rem CHECK WHETHER THERE HAS BEEN SOME OTHER BINDING ALREADY 
IF DEFINED VCINSTALLDIR GOTO :FAIL4

rem VERIFY TOOLSET
IF "%VCasked%" == "140" GOTO :FINDTOOLSET
IF "%VCasked%" == "120" GOTO :FINDTOOLSET
IF "%VCasked%" == "110" GOTO :FINDTOOLSET
IF "%VCasked%" == "100" GOTO :FINDTOOLSET
IF NOT "%VCasked%" ==  "90" GOTO :FAIL7

:FINDTOOLSET
rem FIND LATEST-AVAILABLE RELEASED TOOLSET
rem      starting from VCasked   

SET VCtopTry=%VCasked%
rem      so we can report where checking started
GOTO :TRY%VCasked%

:TRY140
IF NOT DEFINED VS140COMNTOOLS GOTO :TRY120
SET VisualStudioVersion=14.0
rem    XXX: Because Build Tools case doesn't set it
CALL :VCTRY "%VS140COMNTOOLS%..\..\VC\" 140
IF NOT ERRORLEVEL 9 EXIT /B %ERRORLEVEL%
rem    XXX: :VCTRY has cleared VisualStudioVersion in that case
set VisualStudioVersion=
rem    XXX: Because guessed wrong

:TRY120
IF NOT DEFINED VS120COMNTOOLS GOTO :TRY110
CALL :VCTRY "%VS120COMNTOOLS%..\..\VC\" 120
IF NOT ERRORLEVEL 9 EXIT /B %ERRORLEVEL%

:TRY110
IF NOT DEFINED VS110COMNTOOLS GOTO :TRY100
CALL :VCTRY "%VS110COMNTOOLS%..\..\VC" 110
IF NOT ERRORLEVEL 9 EXIT /B %ERRORLEVEL%

:TRY100
IF NOT DEFINED VS100COMNTOOLS GOTO :TRY90
CALL :VCTRY "%VS100COMNTOOLS%..\..\VC" 100
IF NOT ERRORLEVEL 9 EXIT /B %ERRORLEVEL%

:TRY90
IF NOT DEFINED VS90COMNTOOLS GOTO :FAIL6
CALL :VCTRY "%VS90COMNTOOLS%..\..\VC" 90
IF NOT ERRORLEVEL 9 EXIT /B %ERRORLEVEL%
GOTO :FAIL6

:VCTRY
rem TRY ESTABLISHING A PARTICULAR VC++ VERSION 
rem       %1 is the quoted full path to the expected VC folder
rem       %2 is the common tools version (e.g., 140 for VS 14.0, 2015)
rem ERRORLEVEL 9 is returned if a VC\ setup is not present
rem            2 is returned if there was a reported FAIL case
rem              XXX: VisualStudioVersion is unset in this case, removing the
rem                   anticipation of success with a toolset that does not
rem                   set it.  See :TRY140
rem            0 is returned if there was a reported SUCCESS case

SET ERRORLEVEL=
SET VCasked=%2%
IF NOT EXIST %1\vcvarsall.bat EXIT /B 9
CALL %1\vcvarsall.bat %VCaskedConfig%
IF NOT DEFINED VCINSTALLDIR GOTO :FAIL5

:WINNER
ECHO:          Success: VC++ %VisualStudioVersion% %VCaskedConfig% config set.
ECHO:          %VCINSTALLDIR% %VCterse%
GOTO :SUCCESS

:ALREADY
rem CHECK IF THERE IS A CONFLICT WITH THE PREVIOUS BINDING
IF NOT "%VCasked%" == "%VCbound%" GOTO :FAIL2
IF NOT "%VCaskedConfig%" == "%VCboundConfig%" GOTO :FAIL2

rem CHECK IF ANOTHER CONFLICT HAS ARISEN
IF NOT "%VCboundVer%" == "%VisualStudioVersion%" GOTO :FAIL3

rem TRUST PREVIOUS SETTINGS TO BE REUSABLE
rem      Avoid multiple running of VC\ settings and duplicating the PATH and
rem      other parameter settings.
ECHO:          Using existing VC++ %VCboundVer% %VCboundConfig% config setup. 
ECHO:          %VCINSTALLDIR% %VCterse%
GOTO :SUCCESS

:SUCCESS
SET VCbound=%VCasked%
SET VCboundConfig=%VCaskedConfig%
SET VCboundVer=%VisualStudioVersion%
rem    appropriate whether or not already set
ECHO:  %VCterse%
IF "%VCterse%" == "" PAUSE
EXIT /B 0

:FAIL7
ECHO:          *** UNSUPPORTED VCBIND PARAMETER(S) ***
ECHO:          Invalid Here: %*
ECHO:          %VCterse%
ECHO:          NO ENVIRONMENT CHANGES HAVE BEEN MADE                %VCterse%
GOTO :USAGE

:FAIL6
ECHO:          *** NO VC++ TOOLSET FOUND ***
ECHO:          None of toolset %VCtopTry% or older are available.
ECHO:          %VCterse%
ECHO:          NO ENVIRONMENT CHANGES HAVE BEEN MADE                %VCterse%              
ECHO:          See ^<http://nfoWare.com/dev/2016/11/d161101.htm^>   %VCterse%
ECHO:          for suitable freely-available versions.              %VCterse%
GOTO :BAIL

:FAIL5
set VisualStudioVersion=
rem     XXX: in case incorrectly guessed at :TRY140
ECHO: [VCbind] *** FOUND TOOLSET %VCasked% CONFIG %VCaskedConfig% FAILS ***
ECHO:          Check preceding message(s) for details.  A missing   %VCterse% 
ECHO:          config might be unsupported or simply not installed. %VCterse%
ECHO:          %VCterse%
ECHO:          NO ENVIRONMENT CHANGES HAVE BEEN MADE                %VCterse%         
GOTO :BAIL

:FAIL4
ECHO:          *** FAIL: VC ENVIRONMENT ALREADY SET BY OTHER MEANS ***  
ECHO:          The environment is already set for compiling with a  %VCterse%
ECHO:          VC++ compiler version %VisualStudioVersion%          %VCterse%
ECHO:          %VCINSTALLDIR% %VCterse%
GOTO :NOMIXING

:FAIL3
ECHO:          *** FAIL: VCBIND ENVIRONMENT HAS BEEN ALTERED ***
ECHO:          Binding to VC++ %VisualStudioVersion% is changed     %VCterse%
ECHO:          from version %VCboundVer% set by VCbind.  Now at     %VCterse%
ECHO:          %VCINSTALLDIR% %VCterse%
ECHO:          Continuing this session may have unexpected results. %VCterse%
GOTO :NOMIXING

:FAIL2
ECHO:          **** FAIL: PRIOR VCBIND %VCboundConfig% %VCbound% CONFLICT ****
ECHO:          The current request conflicts with settings already  %VCterse%
ECHO:          in effect for the VS %VisualStudioVersion% compiler. %VCterse%
ECHO:          %VCINSTALLDIR% %VCterse%
GOTO :NOMIXING

:NOMIXING
ECHO:          %VCterse%
ECHO:          NO ENVIRONMENT CHANGES HAVE BEEN MADE                %VCterse%
ECHO:          Do not attempt to change or mix VCbind settings in   %VCterse%
ECHO:          a command-shell session in which VC++ environment    %VCterse%
ECHO:          settings have already been made.                     %VCterse%
GOTO :BAIL

:FAIL1
ECHO:          **** FAIL: SCRIPT IS NOT IN THE REQUIRED LOCATION ****
ECHO:          VCbind.bat must be in the folder that VCbind.zip     %VCterse%
ECHO:          is extracted into.  VCbind.bat is not designed to be %VCterse%
ECHO:          separated from the extracted contents of VCbind.zip. %VCterse%
ECHO:          %VCterse%
ECHO:          NO ENVIRONMENT CHANGES HAVE BEEN MADE                %VCterse%
ECHO:          Follow instructions in the VCbind-%VCverNum%.txt     %VCterse%
ECHO:          file for extracting all of VCbind.zip content to a   %VCterse%
ECHO:          working location and using the VCbind.bat there. Also%VCterse%
ECHO:          see ^<http://nfoWare.com/dev/2016/11/d161101.htm^>.  %VCterse%
GOTO :BAIL

:FAIL0
ECHO:          **** FAIL: COMMAND SHELL EXTENSIONS REQUIRED ****
ECHO:          VCbind requires CMDEXTVERSION 2 or greater.           %VCterse%
ECHO:          This is available on all platforms VCbind supports.   %VCterse%
ECHO:          %VCterse%
ECHO:          NO ENVIRONMENT CHANGES HAVE BEEN MADE                 %VCterse%
ECHO:          To enable Command Extensions, arrange to initiate     %VCterse%
ECHO:          the command shell with the /E:ON command-line option  %VCterse%
ECHO:          before VCbind.bat is performed directly or indirectly.%VCterse%
GOTO :BAIL

:USAGE
rem    PROVIDE USAGE INFORMATION
ECHO:   %VCterse%
ECHO:   USAGE: VCbind ?
ECHO:          VCbind [*][config [toolset]]
IF NOT "%1" == "?" GOTO :BAIL
ECHO:   where
ECHO:           ? produces this usage information.
ECHO:
ECHO:           * selects terse output
ECHO:
ECHO:      config is one of the VC++ "platform" configuration types:
ECHO:                      x86 for producing x86 code via the x86 compiler
ECHO:                    amd64 for producing x64 code via the x64 compiler
ECHO:                amd64_x86 for producing x86 code via the x64 compiler
ECHO:                x86_amd64 for producing x64 code via the x86 compiler
ECHO:             Toolset installations may vary which cases are supported.
ECHO:             x86 is the default and always works for desktop toolsets.
ECHO:
ECHO:     toolset identifies which common tools to start checking from:
ECHO:                 140 for Visual Studio 2015 (14.0) flavors, then 
ECHO:                 120 for Visual Studio 2013 (12.0) flavors, then
ECHO:                 110 for Visual Studio 2012 (11.0) flavors, then
ECHO:                 100 for Visual Studio 2010 (10.0) flavors, and then
ECHO:                  90 for Visual Studio 2008 (9.0) flavors
ECHO:             140 is the default  
ECHO:
ECHO:   Three environment variables are set whenever VCbind succeeds.
ECHO:
ECHO:          VCbound identifes the common tools (e.g., 140) that were used
ECHO:    VCboundConfig is the bound configuration type (e.g., x86)
ECHO:       VCboundVer is the version (e.g., 14.0) of Visual Studio
ECHO:                  that the VC++ build tools correspond to.
ECHO:
ECHO:    Other VC* environment-variable names are used transiently.  They
ECHO:    will be used without checking whether they are already defined.
PAUSE
EXIT /B 0

:BAIL
ECHO:
IF NOT ERRORLEVEL 2 SET ERRORLEVEL=2
IF NOT "%VCterse%" == "" EXIT /B %ERRORLEVEL%
COLOR 74
rem   Soft White background and Red text
ECHO:
PAUSE
EXIT /B %ERRORLEVEL%

rem -----1---------2---------3---------4---------5---------6---------7-------*

rem                    Copyright 2006 Dennis E. Hamilton

rem This file reflects ideas applied at the Apache Software Foundation for
rem <https://archive.apache.org/dist/openoffice/4.1.2-patch1/binaries/Windows>

rem Licensed under the Apache License, Version 2.0 (the "License");
rem you may not use this file except in compliance with the License.
rem You may obtain a copy of the License at
rem     <http://www.apache.org/licenses/LICENSE-2.0>

rem Unless required by applicable law or agreed to in writing, software
rem distributed under the License is distributed on an "AS IS" BASIS,
rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
rem See the License for the specific language governing permissions and
rem limitations under the License.


rem -----1---------2---------3---------4---------5---------6---------7-------*

rem 0.1.1  2016-11-29-14:33 Small changes to messages and remarks to include
rem        in whatever the next distribution is.
rem 0.1.0  2016-11-25-08:21 Set for stepping toward 0.1.1+ next-chosen semantic
rem        version, as appropriate when distribution candidate selected.
rem 0.0.18 2016-11-24-11:19 Add another overlooked VCINSTALLDIR report case
rem 0.0.17 2016-11-24-10:56 Add one overlooked VCINSTALLDIR reporting
rem 0.0.16 2016-11-24-10:45 Report VCINSTALLDIR of the set environment
rem        aiding trouble-shooting of success and of error cases.
rem 0.0.15 2016-11-22-09:05 Touch-ups, smoothing connections to other material
rem 0.0.14 2016-11-20-13:41 Complete annotations.  Re-order checking for
rem        a previous setup, whether simple repetition or conflicting.
rem        Designate for candidate VCbind.zip 0.1.0 with version number
rem        in the VCbind-%VCverNum%.txt file.
rem 0.0.13 2016-11-16-15:00 Implement "?" option for Usage Information plus
rem        small cleanups
rem 0.0.12 2016-11-16-09:03 Correct detection of failure in :VCTRY, tune 
rem        error messages. 
rem 0.0.11 2016-11-15-17:21 Complete Parameter Filtering
rem 0.0.10 2016-11-15-14:31 Introduce Terse operation;  smooth messages.
rem 0.0.9 2016-11-15-11:03 Define parameters, choose "config" naming of
rem       platform types, and smooth messages and comments some more.
rem 0.0.8 2016-11-14-17:43 Add Try ladder for determining the latest version
rem       installed.  Simplify message layout further.
rem 0.0.7 2016-11-14-09:55 Smooth output of messages
rem       The output messages are smoothed to be more condensed in
rem       non-failure cases.  There is better clarity and terminology.
rem 0.0.6 2016-11-13-11:52 Add Checks for All Conflict Cases     
rem 0.0.5 2016-11-08-10:54 Rearrange comments and move TODOs to the
rem       devBind.txt working file.  Check for acceptable CMDEXTVERSION 
rem       and location (%dp0) where this script is located.
rem 0.0.4 2016-10-27-11:43 Boilerplate in VCbinder/devBind folder 
rem       for morphing into a more robust, automatic version that works
rem       free-standing as part of a command-line construction set for
rem       creating Microsoft Windows programs on Microsft Windows.
rem       Scavenged from ShowDefs version 0.03. 
rem 0.03 2014-12-28-19:11 Get vcvarsall Handshake CALL working
rem      Handshake set up and failure case managed.
rem 0.02 2014-12-28-17:06 Correct vcvarsall Usage
rem      The quotation of the program name is corrected and the ERRORLEVEL
rem      is passed out to the caller.
rem 0.01 2014-12-25-20:41 Confirm that VC\vcvarsall.bat is all we need to
rem      setup plain Visual C++ compiling.
rem 0.00 2014-12-22-17:35 Cloned from OdmVC++.bat 0.27 of 2006-11-04-16:35

rem                     *** end of VCbind.bat ***
