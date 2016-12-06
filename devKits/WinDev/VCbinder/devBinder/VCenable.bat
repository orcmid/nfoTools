@echo off
rem VCensure.bat 0.0.1               UTF-8                       dh:2016-12-06
rem -----1---------2---------3---------4---------5---------6---------7-------*

rem              ENSURING VC++ COMMAND-LINE OPERATION ENABLED
rem              ============================================

rem      This script is included in construction sets as a common point for
rem      ensuring that VC++ command-line operation has been established.  If
rem      VCbind command-line setup has not previously succeeded, it will be
rem      attempted automatically.

rem      The main work of this script is to confirm that VCbind\ is nearby
rem      and then use the VCbind\VCbind.bat to establish VC++ command-line 
rem      operation if it has not already been done.

rem Additional documentation of this procedure and its usage are found in the
rem accompanying VCbinder-0.1.0.txt file.  For further information, see
rem <http://nfoWare.com/dev/2016/11/d161102.htm> and check for the latest
rem version at <http://nfoWare.com/dev/2016/11/d161102b.htm>.

rem Designate the distribution version 
SET VCensureVer=0.1.0
rem     semantic versioning candidate

rem SELECT EMBEDDED, TERSE, OR DEFAULT
rem     %1 value "+" selects smooth non-stop operation for splicing output
rem        into that of a calling script.
rem     %2 might then be "*" and allow for that.
rem 
SET VCterse=
rem     XXX: VCterse determined here will be identically determined in VCbind
SET VCensureSplice=%1
IF NOT "%1" == "+" GOTO :MAYBETERSE
IF "%2" == "*" SET VCterse=^>NUL

:MAYBETERSE
rem SELECT TERSE OR VERBOSE
rem     %1 value "*" here selects terse operation
rem
IF "%1" == "*" SET VCterse=^>NUL
rem                used to dump verbose echoes

rem ANNOUNCE THIS SCRIPT
IF "%1" == "*" GOTO :WHISPER
IF "%1" == "+" GOTO :WHISPER
TITLE ENSURING VC++ COMMAND-LINE ENVIRONMENT ENABLED
COLOR 71
rem   Soft white background with blue text

CLS
ECHO:
:WHISPER
ECHO: [VCensure] %VCensureVer% ENSURE VC++ COMMAND-LINE ENVIRONMENT ENABLED
IF NOT CMDEXTVERSION 2 GOTO :FAIL0

rem REQUIRE SCRIPT STORED IN CONSTRUCTION SET (%~dp0) VCBINDER ARTIFACTS
IF NOT EXIST "%~dp0VCenable.bat" GOTO :FAIL1
IF NOT EXIST "%~dp0VCbind.zip" GOTO :FAIL1

REM XXXXX CONTINUE MODELING MORE FROM VCBIND.BAT HERE

:FAIL1
ECHO:          **** FAIL: SCRIPT IS NOT IN THE REQUIRED LOCATION ****
ECHO:          VCensure.bat must be in the construction-set folder  %VCterse%
ECHO:          having VCbind.zip.  VCensure.bat is not designed to  %VCterse%
ECHO:          be separated from VCbind.zip in the construciton set.%VCterse%
ECHO:          %VCterse%
ECHO:          NO ENVIRONMENT CHANGES HAVE BEEN MADE                %VCterse%
ECHO:          Follow instructions for the construction set. Also   %VCterse%
ECHO:          see ^<http://nfoWare.com/dev/2016/11/d161102.htm^>.  %VCterse%
GOTO :BAIL

:FAIL0
ECHO:          **** FAIL: COMMAND SHELL EXTENSIONS REQUIRED ****
ECHO:          This construction set requires CMDEXTVERSION >= 2.    %VCterse%
ECHO:          This is available on all platforms the set supports.  %VCterse%
ECHO:          %VCterse%
ECHO:          NO ENVIRONMENT CHANGES HAVE BEEN MADE                 %VCterse%
ECHO:          To enable Command Extensions, arrange to initiate     %VCterse%
ECHO:          the command shell with /E:ON command-line option      %VCterse%
ECHO:          before using the current construction set.            %VCterse%
GOTO :BAIL

:USAGE
rem    PROVIDE USAGE INFORMATION
ECHO:   %VCterse%
ECHO:   USAGE: VCensure [+] ?
ECHO:          VCensure [+] [*] [config [toolset]]
ECHO:   where  the parameters are the same as for VCbind
IF NOT "%1" == "?" GOTO :BAIL
REM    XXX: ATTEMPT TO INCLUDE VCBIND HELP IF VCBIND REACHABLE
REM    THIS MIGHT OR MIGHT NOT BE SHARED CODE.
IF "%VCensueSplice%" == "+" EXIT /B 0
PAUSE
EXIT /B 0

:BAIL
ECHO:
IF NOT ERRORLEVEL 2 SET ERRORLEVEL=2
IF NOT "%VCterse%" == "" EXIT /B %ERRORLEVEL%
IF "%VCensureSplice%" == "+" EXIT /B %ERRORLEVEL%
COLOR 74
rem   Soft White background and Red text
ECHO:
PAUSE
EXIT /B %ERRORLEVEL%


rem -----1---------2---------3---------4---------5---------6---------7-------*

rem                    Copyright 2014 Dennis E. Hamilton
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

rem -----1---------2---------3---------4---------5---------6---------7-------*

rem 0.0.1 2016-12-06-10:22 Intermediate check-in for nfoTools/devKits/VCbinder 
rem       0.1.0 customization after renaming to VCensure.bat.
rem       Based on nfoTools/devKits/VCbinder/devBind/VCbind.bat 0.1.5 and
rem       ShowDefs/VC/VCbind.bat 0.00
rem 0.00 2014-12-25-20:43 Create Run Script
rem      This script verifies that VC\VCbind\VCbind.bat are in place and then
rem      defers to that script for the actual binding.  Based on the VS2013\
rem      Default\DefaultRun.bat version 0.03.

rem                     *** end of VCenable.bat ***