<!-- index.md 0.0.4                UTF-8                          2023-05-28
     ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

                         T060101c: GETTING TO "HELLO"
     -->

# T060101c: [Getting to "Hello"](.)

| ***[nfoTools](../../../)*** | [tools](../../)[>t060101](../)[>c](.) | ***[index.html](index.html) 0.0.342023-05-28*** |
| :--                |       :-:          | --: |
| ![nfotools](../../../images/nfoWorks-2014-06-02-1702-LogoSmall.png) | Getting to "Hello" | ![Hard Hat Area](../../../images/hardhat-logo.gif)[Construction Zone](T060101c.txt) |

C Language has a famous first program.  Creating and operating that program is sketched, with links to expanded detail that may be needed.

- 1. Install C/C++ Compiler Software
- 2. Make a Folder for the Work
- 3. Make the `hello.c` Code
- 4. Initiate a Command Prompt
- 5. Compile and Run the Program
  - 5.1 Navigate to `myCleanC`
  - 5.2 Compile `hello.c`
  - 5.3 Observe the compilation
  - 5.4 Execute the resulting Program
  - 5.5 Look around in `myCleanC`
- 6. Looking Down the Road
  - 6.1 Improved project file organization
  - 6.2 Customized Command Prompt operation
  - 6.3 Incorporation of Visual Studio Code

## 1. Install C/C++ Compiler Software

There is not far to get without having software that compiles C Language
files into programs that run on the computer.  In this sketch,
[Visual Studio Build Tools](../../T211002/) are installed and ready for use.

## 2. Make a Folder for the Work

Create a computer folder for holding your work.  It can be tentative for now.
Have it in a place for personal data, not in any folder where software is
installed.  On a Windows PC, the Documents folder of a personal account will
 work; and that's preferable on a PC that is shared with others.

 ![Initial myCleanC Folder](T060101c1.png)

 The example `Documents\myCleanC` folder is established using a Windows 10
 File Explorer view that is handy when working on software projects.  The file
 `hello.c` has already been created there.  This is a text file with extension
 `.c` instead of `.txt`.

## 3. Make the `hello.c` Code

![hello.c in Notepad](T060101c2.png)

This is the very first program presented in the
\[[Kernighan1988](..\b\#Kernighan1988)\] book, *The C Programming Language*.
This program should be typed exactly and saved as file `hello.c`.  Be exact, character-by-character, line-by-line.

There is
[Hello World lore](https://en.wikipedia.org/wiki/%22Hello,_World!%22_program)
on all of the ways this "first program" has been accomplished.

## 4. Initiate a Command Prompt

In the All Programs option on the Windows Start Menu, find the Visual Studio
folder and expand it ("v") to find the "x64 Native Tools Command Prompt ..."
or equivalent wording.  The key element is "x64 Native."  Click that entry.

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

changes to the drive and directory where the `hello.c` example is stored in
this example.

### 5.2 Compile `hello.c`

The command

```CMD
CL hello.c
```

instructs the VC/C++ command-line compiler (CL) to compile `hello.c`

### 5.3 Observe the compilation

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

### 5.4 Execute the resulting program

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

The simple 67-character `hello.c` is compiled to a 2,367 byte `hello.obj` of
native computer code and information on what libraries it depends on.  The
final `hello.exe` is 137,728 bytes of complete executable-format
code.  It is constructed to be run from a command prompt.

## 6. Looking Down the Road

With practice and increasing proficiency, there will be improvements in the
cycle of programming, compiling, and confirmation.  Along the way there will
be ways to have project work go more smoothly.

### 6.1 Improved project file organization

To collect projects together in a handy place, the `myCleanC\` folder is
changed to have individual sub-folders for different programs, starting
with `myCLeanC\hello\`.

![myCLeanC Organization](T060101c7.png)

Along with this, a shortcut is created for creation of the Command Prompt
directly at `myCleanC\`.  This will be handy for workng on all of the projects
that will be placed under `myCleanC\`.

A new Command Prompt right there is initiated by double-clicking the shortcut.

### 6.2 Customized Command Prompt operation

![Compiling the new Hello](T060101c5.png)

As can be seen in this session, the initialized Command Prompt starts
directly at `myCleanC` and it is a short hop to the `hello` project.

The change in appearance is accomplished by customizing the shortcut.  There
are many choices available.  It is also possible to alter the prompt text,
choosing something different than `H:\Documents\myCleanC>` and the like.

Summarizing the commands that were entered,

```CMD
H:\Documents\myCleanC>cd hello
H:\Documents\myCleanC\hello>CL hello.c
H:\Documents\myCleanC\hello>hello
Hello again, world

H:\Documents\myCleanC\hello\dir
H:\Documents\myCleanC\hello\code .
H:\Documents\MyCleanC\hello\exit
```

The change in the directory reflects changes in the `hello.c` program, which
have the file be more verbose.  Yet the `hello.obj` and `hello.exe` files are
smaller than at [5.4], above.

There is also a new component, the subdirectory `.vscode\`.  This is entirely
for use in conjunction with Visual Studio Code and need not be of any concern.
It only has effect when Visual Studio code is opened on the `hello\` folder.

### 6.3 Incorporation of Visual Studio Code

The command entry

```CMD
H:\Documents\myCleanC\hello>code .
```
 causes [Visual Studio Code](../../T21001/) to be initiated from within the
 Command Prompt and oriented to where we are operating (established by the "."
 parameter).  The benefit of initiating VS Code in this manner is for its
 recognition of the initialized environment, using it for review and
 annotation of files that are opened for review and possible editing.

 ![hello.c 0.2.2 in VS Code](T060101c6.png)

 All of the green text is commentary.  Only lines 11-16 provide the C Language
 code.

 The color highlighting is provided automatically as readability hints of the
 program's C Language structure.

 The `hello.c` program is now in Clean C.  What makes the difference is the
 first line,

 ```C
 int main(void)
 ```

 Visual Studio Code will recognize various defects in a C Language program.
 For this `hello.c` none are identified.

 What will become more important is coming to appreciate what is **not**
 provoking any VS Code commentary.

 - The ```include <stdio.h>``` has been resolved to a file in the VC/C++
 environment.
 - The `int main(void)` is recognized as the beginning of a valid main
 function.
 - the fputs() matches with the definition in `stdio.h` and the two parameters
 are of the proper form.
 - `stdout` is recognized as the indicator of the standard output stream,
 usually the Command Prompt output, also defined in `stdio.h`.

 All of this built-in checking will be valuable as more programs are
 developed.

----

Discussion about nfoTools is welcome at the
[Discussion section](https://github.com/orcmid/nfoTools/discussions).
Improvements and removal of defects in this particular documentation can be
reported and addressed in the
[Issues section](https://github.com/orcmid/nfoTools/issues).  There are also
relevant [projects](https://github.com/orcmid/nfoTools/projects?type=classic)
from time to time.

<!-- ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

     0.0.4 2023-05-28T20:14Z First full draft
     0.0.3 2023-05-27T21:47Z First draft, sections 1-5
     0.0.2 2023-05-20T23:05Z Touch-ups for T060101/c/ transposition
     0.0.1 2022-06-16T23:14Z improve title header strip
     0.0.0 2021-11-25T00:20Z bootstrap placeholder and boilerplate

               *** end of docs/tools/T060101/c/index.md ***
     -->
