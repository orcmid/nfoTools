<!-- index.md 0.1.0                 UTF-8                          2021-09-03
     ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

                   VCBIND: VC/VC++ COMMAND-LINE SETUP SCRIPT
     -->

# ***VCbind** VC/VC++ Command-Line Setup Script*

***VCbind*** consists of a Zip package that can be included in a software
construction set to simplify command-line use of Microsoft Windows developer
tools for compiling C/C++ language programs.

## Intended Usage

When code containing **`VCbind.zip`** is found in a software construction set,
extract the contents of the Zip package into a folder.  Rely on the script
and other materials in the folder to establish the command-line environment
for use of Microsoft Build Tools.  The extracted **`VCbind.bat`** file sets up
the command-line environment for use of the Microsoft command-line compiler,
 **`cl.exe`**, and other development tools.

When construction sets have their own procedures for their overall operation,
rely on those instructions for how and when ***VCbind*** is setup for usage.

## Purpose

Provide a redistributable script that automatically locates and sets up a
command-line environment for operations of the installed Windows C/C++
development tools.
  
## Principles

1. Only tools already available as part of Microsoft Windows Desktop PCs are
needed, along with the simplest addition of freely-available development
tools.

2. Simple use of Microsoft "batch commands" is all that's required, with any
parameters entirely optional.

3. For the few prerequisites, links to tutorials and examples are plentiful.

4. Error messages guide users in providing remedies and in finding additional
trouble-shooting details.

5. The software is "code in the open" that can be customized for local use and
adapted for additional construction sets, language localizations, and other
custom purposes.

6. All use is in a separate working location initialized and customizable
without the the distributed version of VCbind.  The **`VCbind.zip`** version
of the script and collateral material be restored to the working location
as needed.
  
## Priorities

1. Operation with freely-available and free-to-use development tools.

2. Simple manual instructions for free-standing use and for incorporation
in construction sets designed for novice usage.

3. Sufficient for incorporation in other more-elaborate construction sets.
 
## Plan

1. Develop VCbind on GitHub as part of the nfoTools project.

2. Provide pilot demonstration in selected projects

3. Roll-up stable-enough versions to VCbinder packagings

4. Confirm in prototype WinCon Construction Sets

5. Roll up VCbind and VCbinder into a WinCon Construction Kit that is reliable
as a source for additional construction sets and their updates.

## People

1. Initially, developers and interested parties who want to build releases
from source that has WinCon construction sets.  Novices and students will be
able to employ VCbind and the related construction sets.

2. Secondly, developers who want to apply the same techniques and components
in construction sets of their own.

3. Finally, developers who take an interest in testing, improvement, and
documentation of VCbind and how to apply it.

## Available Materials

| **ID** | **Started** | **Status** | **Topic** |
|   :-:   |   :-:   |  :-:   |  ---  |
| _Dyymmnn link_ | _yyyy-mm-dd_ | _semver yyyy-mm-dd_ | _Topic Title_ |

<!-- ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

     0.1.0 2021-09-03T21:33Z Transposition to nfoTools/dev/D161101/
     0.0.3 2017-12-26-12:08 Touch up and link to d161102/3
     0.0.2 2017-02-22-17:16 Add Synopsis and the 5Ps
     0.0.1 2016-11-25-11:32 Establish VCbind 0.1.0
     0.0.0 2016-11-12-17:32 create bootstrap placeholder to morph into the
           necessary material

                 *** end of docs/dev/D161101/index.md ***
     -->
