<!-- index.md 0.2.14                UTF-8                          2023-08-24
     ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

                         T060101: C/C++ PROGRAMMING
     -->

# T060101: [C/C++ Programming](.)

| ***[nfoTools](../../)*** | [tools](../)[>t060101](.) | ***[index.html](index.html) 0.2.14 2023-08-24*** |
| :--                |       :-:          | --: |
| ![nfotools](../../images/nfoWorks-2014-06-02-1702-LogoSmall.png) | [Work in Progress](T60101.txt) | ![Hard Hat Area](../../images/hardhat-logo.gif) |

The purpose of this material is establishing an on-ramp and guard rails for
exploration and use of the C Language in development and maintenance of
computer software.  Setup and preparation for creation of C Language
projects on Microsoft Windows is featured, providing the base for confident
self-study toward mastery of C Language for challenging projects, including
games and graphical applications.  Coverage is suitable for recreational
computing as well as bridging to participation in cooperative and professional
software-development efforts.

This is not an organized tutorial on C/C++.  Instead there is selective focus
on minitopics, ones that illustrate facets of C Language and its standard
libraries.  The emphasis is on self-exploration and experimental confirmation
of understanding.  Benefit of the material is gained by hands-on exploration
and gradual mastery along with the mistakes and failures that the journey
entails.  Learning from mistakes is indispensible and expected.

If there is concern with respect to the relevance of C and its C++ connection,
there is
[current evidence (July 2023)](https://www.infoworld.com/article/3702350/rising-c-plus-plus-closes-in-on-c-language.html)
that learning C Language remains worthwhile.  Some lessons of C Language
explorations also apply, in altered form, to others of the most prominent
programming languages of the day.

- [T060101: C/C++ Programming](#t060101-cc-programming)
  - [C/C++ Programming for Beginners and the Curious](#cc-programming-for-beginners-and-the-curious)
  - [Keeping It Clean C](#keeping-it-clean-c)
  - [Available Materials](#available-materials)
  - [Recommended Tools](#recommended-tools)
  - [Historical Context](#historical-context)
  - [Really, What's the Best Programming Language?](#really-whats-the-best-programming-language)

## C/C++ Programming for Beginners and the Curious

This material is intended to be supplemental to the extensive guidance
[available elsewhere](b/) in books, web materials, and courses, especially
the many free and inexpensive on-line ones.  Technical use, here, starts with
"[Getting to Hello](c/)."

One of the most helpful avenues in learning to program is reading the
exemplary work of others.  Learning to build, operate, modify, and extend
interesting programs is invaluable.  There are differences in styles and
chosen tools to learn as well.  Understanding those differences is preparation
for adopting personal styles and also employing the styles of projects where
one is participating.

Here, worked examples and full projects using C Language will be  written and
demonstrated using the
Microsoft Windows Desktop PC as the instrument and as the target.  The
programming-language tools will be the freely-available
[Visual Studio Build Tools](../T211002/) and the VC/C++ compiler that is part
of that suite.  There are sample programs and demonstrations of their
operation that can be replicated to confirm understanding and successful
setup.

## Keeping It Clean C

For nfoTools projects of all kinds, use of the C Programming Language
will be in
[Clean C](b/#Harbison2002),
a form which can be compiled as "pure"
C Language and also as C++ Language.  The use of "C/C++" emphasizes
that connection.  Modern compilers tend to be C/C++ compilers (at least) and
will accept Clean C as either C or C++.

There will be little attention to C++ features that are unacceptable
in C Language (and *vice versa*).  Focus is on Clean C
to illustrate software-development principles and as a launching pad for
further efforts, whether expanding into C++ or other programming
languages/dialects.  Exploration of alternative platforms and tools can also
be done using experience with achieved results here as a confident starting
point.

## Available Materials

| **ID** | **Started** | **Status** | **Topic** |
|   :-:   |   :-:   |  :-:   |  ---  |
| [T060101b](b/) | 2006-05-20 | 0.2.12 2023-08-24 | C/C++ Resources |
| [T060101c](c/) | 2021-11-25 | 0.1.1 2023-06-08 | Getting to "Hello" |
| [T050101d](d/) | 2023-06-08 | 0.0.4 2023-06-13 | Hello, What's Happening Here? |
|                           |            |                   |           |
| [T060101a](a/) | 2005-09-08 | 0.2.0 2023-05-20 | Legacy Diary & Job Jar |

## Recommended Tools

- [T211002](../T211002) VS Build Tools
- [T060501](../T060501) Windows CMD Command-Line Environment
- [T211001](../T211001) Visual Studio Code for Windows

## Historical Context

C and C++ are now heavily-used programming languages.  Substantial software,
especially open-source software, is being
developed and maintained using C Language.  C++ programs
can and often do rely on existing code libraries written in C.  Many other
programming systems allow components authored in C Language to be added/used
and may be implemented in C Language themselves.

[C Programming Language](https://en.wikipedia.org/wiki/C_(programming_language))
was introduced in the 1970s, evolved over time, formalized in
International  Standards, and now spoken of as ISO Standard C.  (The term ANSI
C is archaic, generally refering to the
[C89 ISO counterpart](https://en.wikipedia.org/wiki/C_(programming_language)#History).
There are some variations defined in
[POSIX](https://en.wikipedia.org/wiki/POSIX) that are
not incorporated in the ISO Standards.)

From the outset, the appeal of C Language has been its ability to be used
to make hardware-close programs that can also be carried
portably in their C Language form to multiple hardware/software platforms.
Portability of C Language programs started with flavors of Unix, including the
eventual Linux. By virtue of its closeness to computer hardware (and relative
ease of compiling), C Language became popular on minicomputers and then on
microprocessors, along with [BASIC](https://en.wikipedia.org/wiki/BASIC) and
[Fortran](https://en.wikipedia.org/wiki/Fortran).  C was supported on MS-DOS
as well as Windows PC desktops, the Apple Macintosh, and now the newer forms
of laptops,tablets, and other devices, including those powered by Google
Android and Apple iOS.

It is not unusual for subsystems and libraries developed in C Language to be
usable via "language bindings" in higher-level and alternative programming
systems, such as Java and Python.  In the case of C++, such usability of
Clean C modules and libraries is immediate.

In concert with these varied applications, C has evolved over time, sometimes
to strengthen its connection with C++, to improve portable use, and
to encourage dependable programming practices, including with respect to
programming secure code.

An important shift
occured between [C99](https://en.wikipedia.org/wiki/C99) (issued around 1999)
and [C11](https://en.wikipedia.org/wiki/C11_(C_standard_revision)) (issued
around 2011).  There are more features in C11, including some optional ones
that were not part of C99.  At the same time, C11 reduced some mandatory
provisions of C99 to be optional.

The current specification,
[C17](https://en.wikipedia.org/wiki/C17_(C_standard_revision)), is a
maintenance release.  [C23](https://en.wikipedia.org/wiki/C2x) is imminent at
this time.  C23 will provide some new extensions and deprecate or completely
obsolete some older features that are now discouraged.

## Really, What's the Best Programming Language?

Before one is eligible to enter the great programming-language debate,
qualifying rounds must be endured to answer two crucial questions:

- What is the best vehicle, make and model?
- What is the best electric guitar model for playing blues?  (Substitute any
  instrument and genre of your choice.  Be convincing.)

Be clear on why choice of programming-language matters to you.  If it is about
choosing a career, read job postings and, most of all, talk to people who
have achieved beyond-entry-level employment about what they are actually
using, not what they claim to prefer.  Also pay attention to the diverse
areas in which programming is done and how that factors in.

----

Discussion about nfoTools is welcome at the
[Discussion section](https://github.com/orcmid/nfoTools/discussions).
Improvements and removal of defects in this particular documentation can be
reported and addressed in the
[Issues section](https://github.com/orcmid/nfoTools/issues).  There are also
relevant [projects](https://github.com/orcmid/nfoTools/projects?type=classic)
from time to time.

<!-- ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

     0.2.14 2023-08-24T16:10Z Touch-ups and Really, What's the Best?
     0.2.13 2023-07-14T16:44Z Clean-up synopsis on emphasis and approach
     0.2.12 2023-06-15T13:23Z T060101d
     0.2.11 2023-06-08T20:04Z T060101c
     0.2.10 2023-06-03T18:41Z T060101b-c
     0.2.9 2023-06-01T17:15Z Emphasize Clean C more
     0.2.8 2023-05-28T23:59Z T060101c
     0.2.7 2023-05-27T20:05Z Completed full draft.
     0.2.6 2023-05-27T17:55Z Shuffle and also fix cross references
     0.2.5 2023-05-24T16:23Z More wordsmithing
     0.2.4 2023-05-23T15:49Z Wordsmithing and some elaboration
     0.2.3 2023-05-22T23:39Z Improve wording about portability
     0.2.2 2023-05-22T22:41Z Touch-ups
     0.2.1 2023-05-22T21:54Z Cleaned-up and Explained
     0.2.0 2023-05-20T23:15Z Folio re-organization
     0.1.3 2022-06-23T23:32Z Adopt improved title strip header
     0.1.2 2021-11-25T00:27Z T060101c
     0.1.1 2021-11-16T19:40Z Touch-ups
     0.1.0 2021-11-16T17:17Z Transposition to nfoTools as placeholder and
           boilerplate
     0.0.20 2007-09-13T22:42Z Final nfoWare Toolcraft version
     0.0.0 2005-09-08T19:09Z bootstrap placeholder and boilerplate on nfoWare

               *** end of docs/tools/T060101/index.md ***
     -->
