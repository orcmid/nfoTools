@echo off
rem VCbind.bat 0.00                   UTF-8                    dh:2014-12-25
rem The identifying ECHO is produced using the :ANNOUNCE procedure, below.

rem **** DO NOT MODIFY THIS SCRIPT IN THE SHOWDEF VC\ CODE TREE
rem ****    This version is part of the public source tree and should not
rem ****    be modified in place.  The script in the folder extracted from
rem ****    VC\VCbind.zip is a local-only, modifiable working copy that this
rem ****    script executes when it is present where expected.

rem REQUIRE SCRIPT STORED IN THE SAME DIRECTORY (%~dp0) AS VC\ CODE
IF NOT EXIST "%~dp0VCbind.bat" GOTO :FAIL1
IF NOT EXIST "%~dp0VC.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0VCbind.zip" GOTO :FAIL1
IF NOT EXIST "%~dp0VCbind.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0.gitignore" GOTO :FAIL1
rem     Confirm as well as possible we're in a Default\ folder.

rem REQUIRE DEFAULTPROJECT.ZIP EXTRACTED TO SUBFOLDER
IF NOT EXIST "%~dp0VCbind\VCbind.bat" GOTO :FAIL2

rem EXECUTE VCbind\BCbind.bat, returning its ERROR CODE if any.
"%~dp0VCbind\VCbind.bat" %1
rem  quotes (") required in case there are spaces in %~dp0
EXIT

:FAIL1
CALL :ANNOUNCE
ECHO * SCRIPT IS NOT IN THE PROPER FOLDER LOCATION
ECHO *     This VCbind.bat must be located in the ShowDefs code-tree
ECHO *     VC\ folder, wherever it has been located.  Nothing should
ECHO *     have been modified there.  The script may be referenced
ECHO *     so long as it is in a location with the VC\ material.
ECHO:
EXIT /B 2

:FAIL2
CALL :ANNOUNCE
ECHO * VCbind\VCbind.bat COMMAND-LINE ENVIRONMENT SETUP NOT FOUND
ECHO *     The VCbind\ folder and needed files are not found.
ECHO *     It is necessary to extract the VCbind.zip archive into
ECHO *     the VCbind\ subfolder so its VCbind.bat or a customization
ECHO *     is present for setting up to use the VC compiler and tools.
ECHO:
EXIT /B 2

:ANNOUNCE
rem Identify this script only if we're done here.
ECHO * VCbind.bat 0.00 ESTABLISH VC++ COMPILER AND TOOLS ENVIRONMENT
ECHO:
EXIT /B 0
rem Exit /B code required to prevent global exit.

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

rem 0.00 2014-12-25-20:43 Create Run Script
rem      This script verifies that VC\VCbind\VCbind.bat are in place and then
rem      defers to that script for the actual binding.  Based on the VS2013\
rem      Default\DefaultRun.bat version 0.03.
rem

rem $Header:        $

rem                     *** end of VCbind.bat ***