<!-- index.md 0.0.4                 UTF-8                          2022-08-16
     ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

               VCRAYAPP: VC/C++ COMMAND-LINE RAYLIB APP DEVKIT
     -->

# ***VCrayApp** [D211101: VC/C++ Command-Line raylib App DevKit](.)*

| ***[nfoTools](../../)*** | [dev](../)[>D211101](.) | ***[index.html](index.html) 0.0.4 2022-08-16*** |
| :--                |       :-:          | --: |
| ![nfotools](../../images/nfoWorks-2014-06-02-1702-LogoSmall.png) | Work-in-Progress | ![Hard Hat Area](../../images/hardhat-logo.gif) |

VCrayApp is a Zip package for a folder to be used in creating a Microsoft
Windows program using the
[`raysan5/raylib`](https://www.raylib.com/) library for graphical
applications.

Initial VCrayApp setup includes confirmation of correct operation that
can then be confidently customized for a new project.

## Overview

VCrayApp provides compilation of raylib apps using the Microsoft Visual
C/C++ command-line compiler, `CL.exe`, along with other freely-available
developer tools, including others from Microsoft.

If VCrayApp is found incorporated in a larger project, check for any
custom instructions that apply to specific usage in that project.

The expected setup of VCrayApp is with the following folder structure:

```text
    your-development-files-location\
     |- raylib\                 // folder where raylib *source* is
     :  ...                     // extracted
     |- VCrayApp-semver.zip     // at the same level, same drive
     |- your-extracted-VCrayApp-semver-folder-renamed\
         |- .vscode\            // suggested .vscode settings
         |- app\                // folder where you App is compiled to
         |- cache\              // folder for working files and VCrayApp
         |                      // materials
         |- src\                // optional default location for your
         |                      // source files
         |- VCrayApp.bat        // the batch script for compiling your app
         |- VCrayApp-semver.txt // manifest and readme for the version
```

Semantic versioning is used.  E.g., the Alpha release has semver 0.0.0
and is packaged as VCrayApp-0.0.0.zip.  There are explanatory materials and
other files in the extracted VCrayApp version and its four subfolders.

The VCrayApp.bat file is initially set to compile a sample program that
is provided in the cache\ folder.  After installation and operation is
confirmed, VCrayApp.bat must be modified to specify the name for your
application and the location of your source files.  No other modifications
are required.

Performing command "VCrayApp ?" will provide usage information.

```text
   _______________________________________________________________
  | USAGE: VCrayApp [+] ?                                         |
  |       VCrayApp [+] [*] [-c] [-r]                              |
  | where  ? produces this usage information.                     |
  |        + for operating non-stop without any screen clearing   |
  |          and pausing.  Good for use called as a helper.       |
  |        * selects terse output.  If operation fails, repeat    |
  |          without this option for more details.                |
  |       -c for a complete rebuild of any cache                  |
  |       -r for running the app on successful build              |
  |                                                               |
  |  Exit code 0 is produced on all successful operations.        |
  |  Exit codes greater than 1 are produced for any failure.      |
  |_______________________________________________________________|
```

Without any of the optional parameters, a VCrayApp command will provide
a verbose compilation that builds the cache only if needed.

A successful compile will provide an executable in the app\ subfolder
for operation along with whatever assets have been placed there.  It is
possible to deploy a successfully-built application from app\\.

## Prerequisites and Dependencies

For novice developers, the creation of raylib applications can be carried out
by compiling the many samples and finding additional support in the usage
of the minimum prerequisites.  For self-study, other resources should be
used to develop familiarity and confidence in the tools to be mastered.

***SUCCESSFUL USE OF VCrayAPP REQUIRES CONFIDENT USE OF C LANGUAGE AND A
C/C++ LANGUAGE COMPILER*** for creation of clean programs involving source
files, include files, and the interfaces (APIs) of standard libraries as well
as the special-purpose raylib libraries.  For more on C Language usage, see
***TBD***.

It is assumed that Microsoft Windows 7 Professional or later are used.
Thorough VCrayApp testing is with Microsoft Windows 10 latest versions.

Development with VCrayApp and illustration of usage involves the following
tools along with confident use of C Language:

* Windows File Explorer
* Windows Built-in Zip-Folder Tool
* Visual Studio Native Build Tools
* Developer Command Prompt
* VC/C++ Command Line Compiler, CL.exe
* raylib *source* code *release* downloaded and unzipped

----

* Visual Studio Code for editing of source code, other files, and
  confirmation of library integration
* Git4Win implementation for source-code control
* TortoiseGit for File Explorer integration of Git
* GitHub Windows Client for public access to development projects
* GPG4Win for creation and verification of digital signatures

The first six are essential.  The remainder are recommended.  No nfoTools
support is provided for use of alternatives.  For further details on
dependencies, see ***pending-locations***.

VCrayApp is designed to work with versions of Visual Studio that are free
for personal use, including the Visual Studio Build Tools (recommended)
and the Visual Studio Community editions.  Additional levels of Visual
Studio can also be used, all via their Native Tools Command Prompt.  No
use is made of Visual Studio projects, solutions, and the conventional
separation of debug and release builds.  With nfoTools, emphasis is on
testing and confirmation of what is shipped: only release-build stages.

## Available Materials

| **ID** | **Started** | **Status** | **Topic** |
|   :-:   |   :-:   |  :-:   |  ---  |
| [D211101c](D211101c/) | 2022-06-09 | placeholder | VCrayApp 0.0.0 (alpha) |
|                       |            |                  |     |

## Development

Development within the GitHub
[orcmid/nfoTools](https://github.com/orcmid/nfoTools) project is at the
[devKits/WinDev/VCrayApp](https://github.com/orcmid/nfoTools/tree/master/devKits/WinDev/VCrayApp)
main branch.

## Principles

* Operation with freely-available and free-to-use development tools.
* Safe for novice developers and others keen to develop games and graphical
  applications on native Windows.
* Simple manual instructions for free-standing use and for incorporation
  in projects designed for novice and advanced usage.
* Sufficient for incorporation inside more-elaborate construction sets.
* Designed for confirmation of operation and confident employment.

## Plan

* Develop VCrayApp on GitHub as part of the nfoTools project.
* Provide pilot demonstration in confirmation of raylib examples
* Release alpha and beta versions for confirmation and early-adopter trial
* Include confirmation materials and approaches.
* Deal with levels of prerequisite and progressive disclosure
* Address life-cycle issues with respect to VCrayApp and interdependency with
  raylib releases
* Address usage with raylib work-in-progress for raylib contributors

----

Discussion about nfoTools is welcome at the
[Discussion section](https://github.com/orcmid/nfoTools/discussions).
Improvements and removal of defects in this particular documentation can be
reported and addressed in the
[Issues section](https://github.com/orcmid/nfoTools/issues).  There are also
relevant [projects](https://github.com/orcmid/nfoTools/projects) from time to
time.

<!-- ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

     0.0.4 2022-08-16T22:44Z Add Introductory Materials
     0.0.3 2022-06-11T21:25Z Introduce Standard Top banner
     0.0.2 2022-06-10T02:38Z Correct mouse track
     0.0.1 2022-06-10T02:28Z Touch-ups and confirmation of material
     0.0.0 2022-06-10T00:16Z Placeholder for initial development of a complete
           folio

                 *** end of docs/dev/D211101/index.md ***
     -->
