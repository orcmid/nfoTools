<!-- T060101b.md 0.2.3              UTF-8                          2023-05-31
     ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

                        T060101: C/C++ PROGRAMMING

                             T060101b: RESOURCES
     -->

# T060101b: [C/C++ Programming Resources](.)

| ***[nfoTools](../../../)*** | [tools](../../)[>T060101](../)[>b](.) | ***[index.html](index.html) 0.2.2 2023-05-27*** |
| :--                |       :-:          | --: |
| ![nfotools](../../../images/nfoWorks-2014-06-02-1702-LogoSmall.png) | [Work-in-Progress](T060101b.txt) | ![Hard Hat Area](../../../images/hardhat-logo.gif) |

These resources are suitable for anyone who has personal use of a recent
(Windows 10 or later) desktop PC system and wants to engage in self-study
for C/C++ Programming.  This is an useful foundation for becoming involved in
nfoWare projects and other open-source projects targeted to the Microsoft
Windows platform.

- [1. Books](#1books)
- [2. Online Resources](#2onlineresources)
  -

This is not a comprehensive selection. Some were created after a bookstore
crawl.  The choices are based on suitability of the material for someone not
familiar with programming and wanting to work their way into a reasonable
working knowledge of C/C++.   This progression should be enough for
confidently using C/C++ compilers and performing standard compilation
procedures.

I will add items from time to time as the come to my attention.
If I have extended information to provide on how to use the material with a
current compiler and other tips, I'll provide suitable links along with the
references.

For more exotic topics, such as working with the Microsoft Component Object
Model (COM) and building applications for the Microsoft Windows Graphical User
Interface (GUI), cloud-based apps, etc.,  different specialized material is
required.

## 1. Books

The amount of printed material focused specifically on C Language has
diminished along with the popularity of C++ and more-recent
programming-language developments.

Printed books can still be found in libraries and also on sale as used books.
The use of electronic versions other than PDF forms are not recommended.  The
formulas and code examples are often transformed incorrectly to electronic
editions.

### \[<a name="Harbison2002">Harbison2002</a>\] C, A Reference Manual

Harbison, Samuel P. III., Steele, Guy L. Jr. *C, A Reference Manual*, Ed.5.
Prentice-Hall (Englewood Cliffs, NJ: 2002).  ISBN 0-13-089592-X pbk.
I find this the most comprehensive and understandable reference available on
the C Language.  Not written as a programming text, it is a reference manual
that also has examples and exercises.  The exemplary material is non-trivial,
making nuances of the language more apparent and encouraging stronger
understanding. This edition is current with ISO/IEC 9899:1999 (C99). It also
introduces and emphasizes Clean C for the quality it encourages and also for
its consistency with C++.  The International Standard for C Language has
continued to be updated, and compilers might also support the 2011 (C11) and
2017 (C17) updates even as developers cling to C99 as the gold standard.  It
is unfortunate that no supplement for those has been undertaken.

### \[<a name=Kernighan1988>Kernighan1988</a>\] The C Programming Language

Kernighan, Brian W., Ritchie, Dennis M. *The C Programming Language*, Second Edition.  Prentice-Hall (Englewood Cliffs NJ: 1988) ISBN 0-13-110362-8 pbk.
This edition updates the original 1978 publication to be entirely in "ANSI C,"
also known as C89 ANSI X3.159-1989 and the identical C90, ISO/IEC 9899:1990.
The full progression is captured on Wikipedia
[ANSI C](https://en.wikipedia.org/wiki/ANSI_C#C89). This book, affectionately
known as K&R, is a testament to the longevity of the C Language and how today
Clean C is "unrecognizably different" to borrow a prediction made about the
evolution of FORTRAN language.   The examples can be adjusted to Clean C
in most cases.  Historically important, this book is supplanted as a
reference by \[[Harbison2002](#Harbison2002)\].


### \[<a name="McGrath2018">McGrath2018</a>\] C Programming in Easy Steps

McGrath, Mike. *C Programming in Easy Steps:*
*grasp the nuts and bolts of programming*, ed.5. In Easy Steps Limited
(Warwickshire, UK: 2018).
ISBN 978-1-84078-840-2 pbk.  Book description and source-code downloads
available at
[In Easy Steps](https://ineasysteps.com/products-page/c-programming-easy-steps-5th-edition-2/).
Based on an earlier edition, this is a perfect book for getting started in C
Programmng.  There are examples to work every step of the way, focusing on C Language for learning the basic concepts.  The examples
are illustrated using the GCC compiler.  Adjustment for Microsoft Visual
C/C++ is easily made.

### \[<a name="Plauger1992">Plauger1992</a>\] The Standard C Library

Plauger, P.J. *The Standard C Library*.  Prentice-Hall (Englewood Cliffs, NJ:
1992) ISBN 0-13-131509-9 pbk. This is based on the C89 standard, quoting the
standard as it unravels each C Language standard header file. That makes it
comprehensive although not current with
[the additions made](https://en.wikipedia.org/wiki/C_standard_library)
in subsequent ISO Standards.

### \[<a name="Prata2014">Prata2014</a>\] C Primer Plus

Prata, Stephen. *C Primer Plus*, ed.6.  Addison-Wesley (Upper Saddle River,
NJ: 2014).  A [Developer's Library](https://informit.com/devlibrary)
reference.  ISBN 978-0-321-77640-2.  This extensive book is current with the
ISO C11 Standard.  At over 1000 pages, this is a leisurely and extensive tour
of C Language with numerous examples.  There are exercises with
 back-of-the-book examples.  There is no explicit attention to Clean C,
 although good practices are recommended and appied.  Appendix B is a 100 page
 Reference Section with an useful account of the language, the libraries,
 and coverage of the C99 and C11 enhancements.

### \[<a name="Prinz2003">Prinz2003</a>\] C Pocket Reference

Prinz, Peter., Kirch-Prinz, Ulla.  *C Pocket Reference*. Translated by Tony
 Crawford.  O'Reilly Media (Sebastopol, CA: 2003).  134pp.
ISBN 0-596-00436-2 pbk.  Originally published in German as "C kurz & gut"
(short and good), I found this thumbnail convenient, with an organization that
is easy for me to find material in.  Lately, I find myself using on-line
materials.

### \[<a name="Shaw2016">Shaw2016</a>\] Learn C the Hard Way

Shaw, Zed A.  *Learn C the Hard Way: Practical Exercises on the Computational
Subjects You Keep Avoiding (Like C)*.  Addison-Wesley (New York: 2016)
ISBN 0-321-88492-2 pbk with DVD-ROM.  I admire the emphasis on defensive
programming and other ways to better understand what programs, and the
programmer, are doing.  There are two aspects that give me pause.  First,
There is C Language in use, but not with attention to the standards (other
than dismay over the amount of unspecified behavior in those documents).
Secondly, the focus is entirely on tools and the compilers for the *nix world,
especially Linux. These can be worked around although I think `make` is
introduced far too soon before the student can experience the problem that
`make` helps solve.  In that respect, I share the attitude about debuggers
and IDEs.


## 2. Online Resources


## C/C++ Compilers

For basic development of C and C++ Language programs, there are
freely-available professional-level compilers that operate on current
Microsoft Windows platforms.

### Microsoft® Visual C++® Toolkit 2003, version 1.01.0000, June 29, 2004.

\[***Author Note: Rewrite in favor of Microsoft Build Tools***\]

Previously available for download at
[MSDN](http://msdn.microsoft.com/visualc/vctoolkit2003/) (accessed 2005 March
3), this compiler is no longer available.  It has been replaced by the Visual
C++ 2005 Express Edition.

This is the optimizing compiler that was shipped as part of Visual Studio
.NET 2003 Professional.  It is a command-line compiler that is also fully
usable for study and experimentation in standard C and C++ command-line
application development.  The compiler can also be used to build complete
Microsoft Windows applications once additional libraries and development
utilities are obtained.

Although no longer available, some of the early nfoWare projects are verified
with this compiler as well as more-recent VC++ editions.

### Microsoft Visual Studio Community Edition

\[***Author Note: Rewrite in favor of VS Community Edition***\]

The advantage of all of these versions is the inclusion of an integrated
development environment and additional tools required for development of
Microsoft Windows applications.

A key feature is inclusion of a version of the Visual Studio Integrated
Development Environment for editing and building programs.  The tutorial and
reference materials available with this version may make it appealing for
usage in command-line compiling as well.

\[***Author Note: Recognize that VS 2022 can be used without the default
approach to projects and solutions.  Something should be provided around
that, just as for VS Code***\]

### GCC: GNU Compiler Collections and MingW

\[***Author Note: Rewrite for MingW case and that it is also used and
encouraged with VS and VS Code, and oh yeah, WSL***\]

Windows versions available via
[Gnu Project](http://gcc.gnu.org/install/binaries.html).
These compilers are designed for operation on GNU/Linux.  Versions for Windows
require installation of additional software for creation of a Unix-like
environment.   Using these compilers on Windows is useful for someone
interested in learning about and developing for the GNU/Linux environment.
If the target for application is the Microsoft Windows platform, the Windows
command-line environment for developing with VS Build Tools is pursued here.

Those interested in compiler technology and digging farther into
programming-language theory and compiling techniques may find taking an
interest in GCC after becoming more adept at programming.

## Editors and Development Environments

\[***Author Note: Feature VS Code and lay out the levels of IDE strength ***\]

For all programming projects, a text editor is required for creation and
modification of program files, creation of batch files, and other utility
operations involving text.  Initially, the Windows Notepad application is
sufficient.

For substantial programming work, a programming editor is recommended.
These editors have special features that make it easier to write and modify
programs.  Some support rapid switching between editing, compiling, and
matching compiler error-messages to the source-program text.

Integrated Development Environments provide even greater integration for an
overall software-development process.

\[***Author Note: Explain about not using Make, CMake, VS Solutions ***\]


----

Discussion about nfoTools is welcome at the
[Discussion section](https://github.com/orcmid/nfoTools/discussions).
Improvements and removal of defects in this particular documentation can be
reported and addressed in the
[Issues section](https://github.com/orcmid/nfoTools/issues).  There are also
relevant [projects](https://github.com/orcmid/nfoTools/projects?type=classic)
from time to time.

<!-- ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

     0.2.3 2023-05-31T22:28Z More additions and reorganization in progress
     0.2.2 2023-05-27T16:50Z Continue adjusting title anchors
     0.2.1 2023-05-27T14:47Z Experimentation with title anchors
     0.2.0 2023-05-20T22:53Z Transpose to T060101/b/index.md
     0.1.4 2022-06-16T23:25Z Use preferred header title strip
     0.1.3 2021-11-18T04:51Z Provice a TOC and cross references
     0.1.2 2021-11-17T20:01Z Reorganize and begin updating the selections
     0.1.1 2021-11-16T23:25z Cleaning up and fixing the formatting
     0.1.0 2021-11-16T18:02Z Transpose to nfoTools as boilerplate to curate
     0.0.30 2007-08-13T23:09Z Last update on nfoWare.com
     0.0.0 2005-09-08T19:02Z Create Initial Placeholder (on nfoWare.com)

           *** end of docs/tools/T060101/T060101b.md ***
     -->
