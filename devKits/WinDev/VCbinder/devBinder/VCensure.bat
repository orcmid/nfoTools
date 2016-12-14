@echo off
rem VCensure.bat 0.0.4               UTF-8                       dh:2016-12-13
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

rem      VCensure.bat requires VCbind 0.2.0 or later for correct operation.
rem      See :USAGE for parameter [+] and [*] compatibility requirements. 

rem      For further information, see VCbinder 0.1.0 documentation at
rem      <http://nfoWare.com/dev/2016/11/d161102c.htm> and the distribution
rem      information at <http://nfoWare.com/dev/2016/11/d161102c-dist.htm>.

rem Designate the distribution version 
SET VCensureVer=0.1.0
rem     semantic versioning candidate

rem SELECT SPLICED, TERSE, OR DEFAULT VERBOSE
rem     %1 value "+" selects smooth non-stop operation for splicing output
rem        into that of a calling script.
rem     %2 might then be "*" and allow for that.
rem 
SET VCtersed=
SET VCensureSplice=%1
IF NOT "%1" == "+" GOTO :MAYBETERSE
IF "%2" == "*" SET VCtersed=%2

:MAYBETERSE
rem SELECT TERSE OR VERBOSE
rem     %1 value "*" here selects terse operation
rem
IF "%1" == "*" SET VCtersed=%1
rem                used to dump verbose echoes

SET VCterse=
IF DEFINED VCtersed SET VCterse=^>NUL

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
IF "%VCensureSplice%" == "+" GOTO :LOCATE
ECHO:          %TIME% %DATE% on %USERNAME%'s %COMPUTERNAME%%VCterse%
ECHO:          %~dp0%VCterse%     
rem            reporting construction-set folder location

:LOCATE
rem REQUIRE SCRIPT STORED IN VCBINDER ARTIFACTS OF CONSTRUCTION SET (%~dp0)
IF NOT EXIST "%~dp0VCensure.bat" GOTO :FAIL1
IF NOT EXIST "%~dp0VCbind.zip" GOTO :FAIL1

rem DETERMINE REQUIRED ACTION
rem    See :USAGE for the VCbind API contract
IF "%1" == "+" SHIFT /1  
rem    XXX: Making invariant %* without any [+] 
IF "%1" == "?" GOTO :USAGE

rem CONFIRM EXTRACTION OF VCBIND.ZIP
IF NOT EXIST "%~dp0VCbind\VCbind.bat" GOTO :FAIL2

rem LET VCBIND DO THE REST
CALL "%~dp0VCbind\VCbind.bat" + %1 %2 %3
rem    XXX: Always splicing VCbind and passing through the rest
SET VCterse=
IF DEFINED VCtersed SET VCterse=^>NUL
rem    XXX: Not counting on %VCterse% preservation by VCBind.bat
IF ERRORLEVEL 2 GOTO :FAIL3

:SUCCESS
IF "%VCensureSplice%" == "+" EXIT /B 0
ECHO:  %VCterse%
IF "%VCterse%" == "" PAUSE
EXIT /B 0

:FAIL3
ECHO: [VCensure] COMMAND-LINE ENVIRONMENT NOT ENSURED
GOTO :BAIL

:FAIL2
ECHO:          **** FAIL: VCBIND.ZIP NOT EXTRACTED WHERE EXPECTED ****
ECHO:          Extract VCbind.zip to the sub-folder VCbind\ in the  %VCterse%
ECHO:          construction set where VCensure.bat and VCbind.zip   %VCterse%
ECHO:          are located.                                         %VCterse%
GOTO :NOJOY

:FAIL1
ECHO:          **** FAIL: SCRIPT IS NOT IN THE REQUIRED LOCATION ****
ECHO:          VCensure.bat must be in the construction-set folder  %VCterse%
ECHO:          having VCbind.zip.  VCensure.bat is not designed to  %VCterse%
ECHO:          be separated from VCbind.zip in the construciton set.%VCterse%
:NOJOY
ECHO:          %VCterse%
ECHO:          COMMAND-LINE ENVIRONMENT ADJUSTMENTS WERE NOT MADE   %VCterse%
ECHO:          Follow instructions for the construction set. Also   %VCterse%
ECHO:          see ^<http://nfoWare.com/dev/2016/11/d161102.htm^>.  %VCterse%
GOTO :BAIL

:FAIL0
ECHO:          **** FAIL: COMMAND SHELL EXTENSIONS REQUIRED ****
ECHO:          This construction set requires CMDEXTVERSION >= 2.    %VCterse%
ECHO:          This is available on all platforms the set supports.  %VCterse%
ECHO:          %VCterse%
ECHO:          COMMAND-LINE ENVIRONMENT ADJUSTMENTS ARE NOT MADE     %VCterse%
ECHO:          To enable Command Extensions, arrange to initiate     %VCterse%
ECHO:          the command shell with /E:ON command-line option      %VCterse%
ECHO:          before using the current construction set.            %VCterse%
GOTO :BAIL

:USAGE
rem    PROVIDE USAGE INFORMATION
ECHO:   USAGE: VCensure [+] ?
ECHO:          VCensure [+] [*] [config [toolset]]
ECHO:          where the parameters are the same as for VCbind
ECHO:          the exit conditins are the same as for VCbind
IF EXIST "%~dp0VCbind\VCbind.bat" GOTO :BINDUSAGE
ECHO:   VCensure requires VCbind.zip to be extracted first.
GOTO :SUCCESS

:BINDUSAGE
CALL "%~dp0VCbind\VCbind.bat" + ?
SET VCterse=
IF DEFINED VCtersed SET VCterse=^>NUL
rem    XXX: Not counting on %VCterse% preservation by VCBind.bat
IF NOT ERRORLEVEL 2 GOTO :SUCCESS
GOTO :BAIL

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

rem 0.0.4 2016-12-13-19:48 Harmonize with WinConKit %WinCon%Built.bat
rem       Avoid extraneous success spacing when spliced.
rem 0.0.3 2016-12-06-20:26 Harmonize with VCbind 0.2.0 via joint testing
rem 0.0.2 2016-12-06-16:03 Working candidate for VCbinder 0.1.0 
rem 0.0.1 2016-12-06-10:22 Intermediate check-in for nfoTools/devKits/VCbinder 
rem       0.1.0 customization after renaming to VCensure.bat.
rem       Based on nfoTools/devKits/VCbinder/devBind/VCbind.bat 0.1.5 and
rem       ShowDefs/VC/VCbind.bat 0.00
rem 0.00 2014-12-25-20:43 Create Run Script
rem      This script verifies that VC\VCbind\VCbind.bat are in place and then
rem      defers to that script for the actual binding.  Based on the VS2013\
rem      Default\DefaultRun.bat version 0.03.

rem                     *** end of VCenable.bat ***