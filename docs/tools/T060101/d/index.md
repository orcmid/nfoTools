<!-- index.md 0.0.4                 UTF-8                          2023-06-13
     ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

                   T060101d: HELLO, WHAT'S HAPPENING HERE?
     -->

# T060101d: [Hello, What's Happening Here?](.)

| ***[nfoTools](../../../)*** | [tools](../../)[>t060101](../)[>d](.) | ***[index.html](index.html) 0.0.4 2023-06-13*** |
| :--                |       :-:          | --: |
| ![nfotools](../../../images/nfoWorks-2014-06-02-1702-LogoSmall.png) | [Work in Progress](T060101d.txt) | ![Hard Hat Area](../../../images/hardhat-logo.gif) |


- [T060101d: Hello, What's Happening Here?](#t060101d-hello-whats-happening-here)
  - [1. Overall Operation](#1-overall-operation)
  - [2. Compile and Link](#2-compile-and-link)

## 1. Overall Operation

The overall objective is to convert single-file program, `hello.c`,
into a program, `hello.exe`, that can be run directly on the computer.  There
is a simple pattern using the
[command-line interface](https://en.wikipedia.org/wiki/Command-line_interface)
that is initiated along with the
[Developer Command Prompt](https://learn.microsoft.com/en-us/visualstudio/ide/reference/command-prompt-powershell)'s
initialization of a build tools environment.

The diagrammatic view, below, parallels the observed command-line operation in
[Getting to "Hello"](../c/#62-customized-command-prompt-operation).  This is a
generall pattern, using the specific example of `hello.c` for clarity.

![Overall Operation](T060101d1-2023-06-11-0919-CL-Hello.png)

Two command-line operations are performed.

- `>CL hello.c` to compile the file `hello.c` into the program file
`hello.exe` without error
- `>hello` to operate `hello.exe`, providing its output directly in the
command-line interface

**The Key Idea**. `hello.exe` is independently-usable repeatedly, while having
to be compiled only once.  The program can be used by others without building
it or even knowing how.

With the simple `>CL hello.c` command, The `hello.exe` program is
automatically produced as a Command-Line Application (CLA).  The program is
completely self-contained, although limited to operation with a command-line.

**An Experiment**.  From the File Explorer, double-click on the `hello.exe`
entry.  A command-line interface will open automatically, the program will
run, and the command-line interface will exit.  That can happen so rapidly
that it might not be observed at all, as if nothing happened.

For now, simply open a [command prompt](../../T060501/) first. Later, there
will be ways to have operation be accomplished more smoothly.

## 2. Compile and Link

The Build Tools program, `CL` operates as a precision multi-tool.  It has many
options and stages of operation.

A fundamental pattern is separation of compiling into two stages: compile and
then link.  The compile stage converts the source code to a file consisting
of the machine code for that source.  The link stage combines modules of such
code from many sources int a single executable, such as `hello.exe`.

![Compile+Link](T060101d2-2023-06-11-1545-Compile+Link.png)

- The compile stage accesses the file `hello.c` and resolves the
`#include <stdio.h>` there to draw in the file `stdio.h` among the includes
of the Software Development Kit (SDK) reachable in the Build Tools
Environment.  All of the C Language standard library facilities are accessed
in this manner.
- `hello.obj` is the machine-language code (in "object" file format) that is
derived from `hello.c`, `stdio.h`, and other settings of CL.  `hello.obj` is
decorated with information about how the code can be combined as a module
with other code.
  - There is an entry to the `hello.obj` code named `main`
  - There is a reference in the `hello.obj` to code expected from elsewhere
with entry named `fputs` (ignoring any finer details that may apply).
- The link stage pulls together the modules, along with hello.obj, that are
stitched together to form the complete `hello.exe` program.
  - Linking can be viewed as proceding from a startup code that requires a
`main` entry, including and linking into the module (`hello.obj` in this case)
that supplies it.
  - The process continues until all of the unsatisfied references in any of
the required modules are satisfied, e.g., in the manner a reference to `fputs`
from `hello.obj` is resolved in the SDK collection of C runtime library
modules.
  - The necessary modules are rewritten to form a single file ('hello.exe`)
with all interconnections fixed as part of combining the object codes into a
single file that can be loaded into the computer and operated as a unit.

---

Discussion about nfoTools is welcome at the
[Discussion section](https://github.com/orcmid/nfoTools/discussions).
Improvements and removal of defects in this particular documentation can be
reported and addressed in the
[Issues section](https://github.com/orcmid/nfoTools/issues).  There are also
relevant [projects](https://github.com/orcmid/nfoTools/projects?type=classic)
from time to time.

<!-- ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

     0.0.4 2023-06-13T17:23Z "@. Compile and Link" full draft
     0.0.3 2023-06-12T20:20Z Touchup, starting "2. Compile and Link"
     0.0.2 2023-06-11T16:48Z Improve with "1. Overall Operation" redrawn
     0.0.1 2023-06-08T20:41Z Add "The Simple Process" draft section
     0.0.0 2023-06-07T19:38Z Placeholder morphed from 0.1.0 T060101c index.md


                *** end of docs/tools/T060101/d/index.md ***
     -->
