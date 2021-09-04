<!-- index.md 0.1.5                 UTF-8                          2021-09-04
     ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

                   VCBIND: VC/VC++ COMMAND-LINE SETUP SCRIPT
     -->

# ***VCbind** VC/VC++ Command-Line Setup Script*

***VCbind*** consists of a Zip package that can be included in a software
construction set to simplify command-line compiling of C/C++ language programs
using Microsoft Windows developer tools.  ***VCbind*** is easily deployed
within GitHub carried projects.

## Intended Usage

When code containing **`VCbind.zip`** is found in a software construction set,
extract the contents of the Zip package into a folder.  Rely on the script
and other materials in the folder to establish the command-line environment
for use of Microsoft Build Tools.  The extracted **`VCbind.bat`** file sets up
the command-line environment for use of the Microsoft command-line compiler,
 **`cl.exe`**, and other development tools.

When construction sets have their own procedures for their overall operation,
those instructions are relied upon for how and when ***VCbind*** is used.

## Purpose

Provide a redistributable script that automatically locates and sets up a
command-line environment for operations of the installed Windows C/C++
development tools.
  
## Principles

* Only tools already available as part of Microsoft Windows Desktop PCs are
needed, along with the simplest addition of freely-available development
tools.
* Simple use of Microsoft "batch commands" is all that's required, with any
parameters entirely optional.
* For the few prerequisites, links to tutorials and examples are plentiful.
* Error messages guide users in providing remedies and in finding additional
trouble-shooting details.
* The software is "code in the open" that can be customized for local use and
adapted for additional construction sets, language localizations, and other
custom purposes.

## Available Materials

| **ID** | **Started** | **Status** | **Topic** |
|   :-:   |   :-:   |  :-:   |  ---  |
| _Dyymmnn link_ | _yyyy-mm-dd_ | _semver yyyy-mm-dd_ | _Topic Title_ |

<!-- ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

     0.1.5 2021-09-04T05:21Z Simplify the description, moving other factors
           into D161101.txt.
     0.1.4 2021-09-03T23:17Z Switch to unnumbered lists correctly
     0.1.3 2021-09-03T22:30Z Switch to unnumbered lists
     0.1.2 2021-09-03T22:11Z Try again
     0.1.1 2021-09-03T22:02Z Numbered-List Fixup
     0.1.0 2021-09-03T21:33Z Transposition to nfoTools/dev/D161101/
     0.0.3 2017-12-26-12:08 Touch up and link to d161102/3
     0.0.2 2017-02-22-17:16 Add Synopsis and the 5Ps
     0.0.1 2016-11-25-11:32 Establish VCbind 0.1.0
     0.0.0 2016-11-12-17:32 create bootstrap placeholder to morph into the
           necessary material

                 *** end of docs/dev/D161101/index.md ***
     -->
