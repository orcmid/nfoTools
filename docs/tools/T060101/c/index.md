<!-- index.md 0.0.3                UTF-8                          2023-05-27
     ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

                         T060101c: GETTING TO "HELLO"
     -->

# ***T060101c** [Getting to "Hello"](.)*

| ***[nfoTools](../../../)*** | [tools](../../)[>t060101](../)[>c](.) | ***[index.html](index.html) 0.0.3 2023-05-27*** |
| :--                |       :-:          | --: |
| ![nfotools](../../../images/nfoWorks-2014-06-02-1702-LogoSmall.png) | Getting to "Hello" | ![Hard Hat Area](../../../images/hardhat-logo.gif)[Construction Zone](T060101c.txt) |

C Language has a famous first program.  Creating and operating that program is sketched, with links to expanded detail that may be needed.

## 1. Install C/C++ Compiler Software

There is not far to get without having software that compiles C Language
programs into programs that run on the computer.  In this sketch,
[Visual Studio Build Tools](../../T211002/) are installed already.

## 2. Make a Folder for the Work

Create a computer folder for holding your work.  It can be tentative for now.
Have it in a place for personal data, not in any folder where software is
installed.  On a Windows PC, the Documents folder of a personal account will
 work; it's preferable on a PC that is shared with others.

 ![Initial myCleanC Folder](T060101c1.png)

 The example `Documents\myCleanC` folder is established using a Windows 10
 File Explorer view that is handy when working on software projects.  The file
 `hello.c` has already been created there.  This is a text file with extension
 `.c` instead of `.txt`.

## 3. Make the `hello.c` Code

![hello.c in Notepad](T060101c2.png)

This is the very first program presented in the
\[[Kernighan1988](..\b\#Kernighan1988)\] book, *The C Programming Language*.
This program should be typed exactly and saved as file `hello.c` where it
will be used.  Be exact, character-by-character, line-by-line.

There is
[Hello World lore](https://en.wikipedia.org/wiki/%22Hello,_World!%22_program)
on all of the ways this "first program" have been accomplished.

## 4. Initiate the Compilation Command Prompt

In the All Programs option on the Start Menu, find the Visual Studio folder
and expand it ("v") to find the "x64 Native Tools Command Prompt ..." or
equivalent wording.  The key element is "x64 Native."  Click that entry.

![Locating x64 Native Tools Command Prompt](T060101c3.png)

## 5. Compile and Run the Program

A console window (sometimes calle a terminal) will be opened on the desktop.
There is identification of initialization as a Command Prompt in this case.
Commands are entered, step by step.

![Compiling the my CleanC\hello.c Program](T060101c4.png)

### 5.1 Navigate to `myCleanC`

The console session starts at the location of the build tools, not where the
project is.  The command

```CMD
cd /D H:\Documents\myCleanC
```

changes to the drive and directory where the `hello.c` example is stored.

### 5.2 Compile `hello.c`

The command

```CMD
CL hello.c
```

instructs the VC/C++ command-line compiler (CL) to compile `hello.c`

### 5.3 Observe the Compilation

If your `hello.c` is **exactly** the version shown, the compiler
identification should be followed by the name of the program to compile
and there should be nothing more before the Incremental Linker is
identified.

If there is anything else instead, there will be brief diagnostic messages
identifying the difficulties.  Any difficulties must be resolved and the
process begun anew, step by step.

After the linker identification, there will be automatic determination to
produce `hello.exe` from the file `hello.obj` that was produced by the
successful compile of `hello.c`.

### 5.4 Execute the resulting Program

There being no misadventures, the file `hello.exe` is there in `myCleanC`.

```CMD
hello
```

typed at the prompt

```CMD
H:\Dcouments\myCleanC>
```

will product the expected output on the next line:

```text
hello, world
```

### 5.5 Look around in `myCLeanC`

Finally, the command line

```CMD
H:\Documents\myCleanC\dir
```

reports the content of the `myCleanC` folder.  The file `hello.obj` is
produced by the compiler processing of `hello.c`.  That `hello.obj`
intermediate is taken by the linker and combined with needed library and
setup code to produce `hello.exe` a complete program to carry out the
operation of the `hello.c` C Language.

The simple 67-character `hello.c` is compiled to a `2,367 byte `hello.obj` of
native computer code and information on what libraries it depends on.  The
final, complete, native program is 137,728 bytes of complete executable-format
code.

## 6. Down the Road








----

Discussion about nfoTools is welcome at the
[Discussion section](https://github.com/orcmid/nfoTools/discussions).
Improvements and removal of defects in this particular documentation can be
reported and addressed in the
[Issues section](https://github.com/orcmid/nfoTools/issues).  There are also
relevant [projects](https://github.com/orcmid/nfoTools/projects?type=classic)
from time to time.

<!-- ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

     0.0.3 2023-05-27T21:47Z First draft, sections 1-5
     0.0.2 2023-05-20T23:05Z Touch-ups for T060101/c/ transposition
     0.0.1 2022-06-16T23:14Z improve title header strip
     0.0.0 2021-11-25T00:20Z bootstrap placeholder and boilerplate

               *** end of docs/tools/T060101/c/index.md ***
     -->
