<!-- index.md 0.1.13                UTF-8                          2021-09-20
     ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

                   VCBIND: VC/VC++ COMMAND-LINE SETUP SCRIPT
     -->

# ***VCbind** VC/VC++ Command-Line Setup Script*

| ***[D161101](index.html)*** | [dev]()../)[>D161101](.) | ***0.1.14 2021-09-20*** |
| :--                |       :-:          | --: |
| ![nfotools](../../images/nfoWorks-2014-06-02-1702-LogoSmall.png) | Work-in-Progress | ![Hard Hat Area](../../images/hardhat-logo.gif) |

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
| [D161101c](D161101c/) | 2016-11-25 | 0.0.7 2021-09-20 | VCbind 0.1.0 Release (Preservation) |
|                       |            |                  |     |
| [D161101a](D161101a.html) | 2016-11-12 | 0.0.2 2021-09-20 | Diary and Job Jar |

----

Discussion about nfoTools is welcome at the
[Discussion section](https://github.com/orcmid/nfoTools/discussions).
Improvements and removal of defects in this particular documentation can be
reported and addressed in the
[Issues section](https://github.com/orcmid/nfoTools/issues).  There are also
relevant [projects](https://github.com/orcmid/nfoTools/projects) from time to
time.

<!-- ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

     0.1.13 2021-09-17T22:45Z Add top banner, reflect D161101c, D161101a
     0.1.12 2021-09-17T20:08Z Add Discussion invitation
     0.1.11 2021-09-14T00:49Z D161101c 0.0.6
     0.1.10 2021-09-14T00:14Z D161101c 0.0.5
     0.1.9 2021-09-13T18:21Z Update D161101c version
     0.1.8 2021-09-13T18:06Z Add D161101c and review how command-line is
           mentioned
     0.1.7 2021-09-11T21:30Z Correct link to D161101a
     0.1.6 2021-09-11T21:24Z Add D161101a preservation step
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
