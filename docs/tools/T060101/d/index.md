<!-- index.md 0.0.2                 UTF-8                          2023-06-11
     ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

                   T060101d: HELLO, WHAT'S HAPPENING HERE?
     -->

# T060101d: [Hello, What's Happening Here?](.)

| ***[nfoTools](../../../)*** | [tools](../../)[>t060101](../)[>d](.) | ***[index.html](index.html) 0.0.2 2023-06-11*** |
| :--                |       :-:          | --: |
| ![nfotools](../../../images/nfoWorks-2014-06-02-1702-LogoSmall.png) | [Work in Progress](T060101d.txt) | ![Hard Hat Area](../../../images/hardhat-logo.gif) |


- [T060101d: Hello, What's Happening Here?](#t060101d-hello-whats-happening-here)
  - [1. Overall Operation](#1-overall-operation)

## 1. Overall Operation

The overall objective is to convert single-file program, `hello.c`,
into a program, `hello.exe` that can be run directly on the computer.  There
is a simple pattern using the
[command-line interface](https://en.wikipedia.org/wiki/Command-line_interface)
that is initiated along with the
[Developer Command Prompt](https://learn.microsoft.com/en-us/visualstudio/ide/reference/command-prompt-powershell)'s
initialization of a build tools environment.

![Overall Operation](T060101d1-2023-06-11-0919-CL-Hello.png)

Two command-line operations are performed.

- `>CL hello.c` to compile the file `hello.c` into the program file
`hello.exe` without error
- `>hello` to operate `hello.exe` as a command-line application (CLA),
providing its output directly in the command-line interface

With the simple `>CL hello.c`, The `hello.exe` program is automatically
compiled as a command-line application.  The program is completely
self-contained, although limited to command-line operation.  There are ways
to have that operation be accomplished more smoothly.

**An Experiment**.  From the File Explorer, double-click on the `hello.exe`
entry.  A command-line interface will open automatically, the program will
run, and the command-line interface will exit.  The can happen so rapidly
that it might not be observed at all, as if nothing happened.  For now, simply
open a [command prompt](../../T060501/) first.

----

Discussion about nfoTools is welcome at the
[Discussion section](https://github.com/orcmid/nfoTools/discussions).
Improvements and removal of defects in this particular documentation can be
reported and addressed in the
[Issues section](https://github.com/orcmid/nfoTools/issues).  There are also
relevant [projects](https://github.com/orcmid/nfoTools/projects?type=classic)
from time to time.

<!-- ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

     0.0.2 2023-06-11T16:48Z Improve with "1. Overall Operation" redrawn
     0.0.1 2023-06-08T20:41Z Add "The Simple Process" draft section
     0.0.0 2023-06-07T19:38Z Placeholder morphed from 0.1.0 T060101c index.md


                *** end of docs/tools/T060101/d/index.md ***
     -->
