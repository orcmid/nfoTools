<!-- T060101b.md 0.2.5              UTF-8                          2023-06-17
     ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

                        T060101: C/C++ PROGRAMMING

                             T060101b: RESOURCES
     -->

# T060101b: [C/C++ Programming Resources](.)

| ***[nfoTools](../../../)*** | [tools](../../)[>T060101](../)[>b](.) | ***[index.html](index.html) 0.2.5 2023-06-17*** |
| :--                |       :-:          | --: |
| ![nfotools](../../../images/nfoWorks-2014-06-02-1702-LogoSmall.png) | [Work-in-Progress](T060101b.txt) | ![Hard Hat Area](../../../images/hardhat-logo.gif) |

These resources are suitable for anyone who has personal use of a recent
(Windows 10 or later) desktop PC system and wants to engage in self-study
for C/C++ Programming.  This is an useful foundation for becoming involved in
commercial and open-source projects targeted to the Microsoft Windows
platform.

An odd proclivity in books and courses is the extensive reliance on *nix
(Unix and Linux) tools which seems to be out of balance with the overwhelming
prevalence of Microsoft and Apple desktop personal computers.  For C Language
and its portable application, crossing among platforms is not that difficult
except for differences in nomenclature and operational details.  The overall principles are comparable.

Reliance on freely-available Microsoft tools here is strictly a matter of
the author's familiarity and preferences.  Focus on a single platform's
technology is helpful in providing concrete focus.  There are no ideological
claims.  With practice, one can adapt what is learned across technologies.
Use what works for you.

- [1. Books](#1-books)
- [2. Online Resources](#2-online-resources)
- [3. Courses](#3-courses)


This is not a comprehensive selection. Some were created after a bookstore
crawl.  Others turn up in Internet searches.

For more exotic topics, such as working with the Microsoft Component Object
Model (COM) and building applications for the Microsoft Windows Graphical User
Interface (GUI), cloud-based apps, etc.,  specialized materials not covered
here are required.  See material on [Tools](../../), [Dev](../../../dev),
and [Skills](../../../skills) for additional coverage.

## 1. Books

The amount of printed material focused specifically on C Language has
diminished along with the popularity of C++ and more-recent
programming-language developments.  Some materials featuring C++ start with
what counts as Clean C, but appealing to the popular interest in C++.

Printed books can still be found in libraries and also on sale as used books.
The use of electronic versions other than PDF forms are not recommended.  The
formulas and code examples have been reported to be transformed incorrectly
in electronic editions.

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
is unfortunate that no supplement for those has been undertaken for C11 and
beyond.

### \[<a name=Kernighan1988>Kernighan1988</a>\] The C Programming Language

Kernighan, Brian W., Ritchie, Dennis M. *The C Programming Language*, Second Edition.  Prentice-Hall (Englewood Cliffs NJ: 1988) ISBN 0-13-110362-8 pbk.
This edition updates the original 1978 publication to be entirely in "ANSI C,"
also known as C89 ANSI X3.159-1989 and the identical C90, ISO/IEC 9899:1990.
The full progression is captured on Wikipedia topic
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
 back-of-the-book solutions.  There is no explicit attention to Clean C,
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
programmer, are doing.  There also are aspects that give me pause.

- First,
there is C Language in use, but not with attention to the standards other
than dismay over the amount of explicitly-unspecified behavior in
specifications of those standards.

- Secondly, the focus is entirely on tools and the compilers for the *nix
world,
especially Linux. These can be worked around.

- I think `make` is
introduced far too soon before the student can experience the problem that
`make` helps solve.  I do share the attitude about avoiding debuggers and IDEs
while a beginner.

## 2. Online Resources

### \[<a name="Jaeschke2022">Jaeschke2022</a>\] Portability and the C Language

Jaeschke, Rex.  *Portability and the C Language*, ed.2. Wikibooks edition
(January 2022).   Available on the Internet at
<https://en.wikibooks.org/wiki/Portability_and_the_C_Language>, accessed on
2023-06-01.  This book is entirely focused on portability considerations and
much about how to achieve it in a given setting under particular conditions.
As such, this is not a reference on C Language, although there is much that
can be learned with respect to portability and where the C Language standards
have something to say that requires understanding/consideration.  There are
some nasty pitfalls, such as accidental use of sequences that happen to be
recognized as trigraphs by some compilers.  There are many more identified
here.

### \[<a name="Microsoft2021">Microsoft2021</a>\] C Language Reference

Microsoft Corporation.  C Language Reference.  Microsoft Learn Documentation,
available on the Internet at
<https://learn.microsoft.com/en-us/cpp/c-language/c-language-reference>,
accessed on 2023-06-01.  This on-line material can also be downloaded in PDF
format.  The description is specific to C89 as implemented by Microsoft with
Microsoft extensions and with a nod to Microsoft's support for C11 and C17.

### \[<a name="Microsoft2022a">Microsoft2022a</a>\] Walkthrough: Compile a C Program on the Command Line

Microsoft Corporation. Walkthrough: Compile a C Program on the Command Line.
Microsoft Learn Documentation available on the Internet at
<https://learn.microsoft.com/en-us/cpp/build/walkthrough-compile-a-c-program-on-the-command-line>,
accessed on 2023-06-01.  This is anothere take on
[Getting to Hello](../c) with a bit more Visual Studio lore in contrast.

### \[<a name="Microsoft2022b">Microsoft2022b</a>\] C Language Documentation

Microsoft Corporation.  C Language Documentation.  Microsoft Learn
Documentation available on the Internet at
<https://learn.microsoft.com/en-us/cpp/c-language/>, accessed on 2013-06-01.
This is the overall coverage, including \[[Microsoft2021](#Microsoft2021)\]
and \[[Microsoft2022a](Microsoft2022a)\].  There is extensive documentation
of the Microsoft toolset for C Language.

### \[<a name="SC22N1570">SC23N1570</a>\] ISO/IEC C11 Draft

International Standard ISO/IEC 9899:201x Committee Draft N1570 (SC22 WG14:
April 12, 2011). PDF available on the Internet at
<https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf>, accessed
2023-06-02. This is the final draft for ISO Standard C11.  It is not the
authoritative version of the standard.  At 701 pages, it exemplifies the
complexity of the International Standards process and capture of so many fine
details.  Anything found here must be considered unofficial (though likely).
The advantage of the PDF format, in this case, is the ability to search the
document using a standard PDF viewer.  You'll find answers aplenty to
questions you didn't know you had.

## 3. Courses

For on-line courses, it is valuable to always look at the syllabus and any
free videos that are provided with the course descriptions.
I suggest this for free courses and paid courses as well.  It should be
possible to determine in advance what tools are required/featured, if any.

### \[<a name="Nazif2022">Nazif2022</a>\] 10 Best Free C Programming Courses

Nazif, Elham.  10 Best Free C Programming Courses to Take in 2023.
([Class Central](https://www.classcentral.com/): 2022-06-20),
available on the Internet at
<https://www.classcentral.com/report/best-free-c-programming-courses/>,
accessed 2023-06-03.

### \[<a name="CC2023">CC2023</a>\] Free Online C Programming Courses

[Class Central](https://www.classcentral.com/) Report, with 207 courses listed
as of 2023-06-03.  Available on the Internet at
<https://www.classcentral.com/subject/c-programming>.

### \[<a name="Udemy2023">Udemy2023</a>\] 10,000 results for "C Language"

[Udemy](https://www.udemy.com/) search at
<https://www.udemy.com/courses/search/?p=2&q=C+Language>, accessed on the
Internet on 2023-06-03.  These are not free courses and the quality is
highly variable.  There are
almost always discounted offers (and the list prices are doubtful).  An
advantage of these courses is subscriptions are perpetual and everything is
self-paced, rather than on an academic-calendar basis. There's also no
distinction between auditing and not.

## 4. Algorithms and Computer Science

### \[<a name="Knuth1997">Knuth1997</a>\] The Art of Computer Programming, Volume 1: Fundamental Algorithms

Knuth, Donald E. *The Art of Computer Programming, vol.1: Fundamental
Algorithms*. ed.3.  Addison Wesley Longman (Reading, MA: 1968, 1973, 1997).
ISBN 0-201-89683-4.
When I was a freshman science major, the two volumes on calculus by Richard
Courant were the must-have texts, although they weren't books used as the
calculus class texts.  To some degree, the subsequent emergence of Computer
Science had the Knuth volumes (now at vol.4A) in *The Art of Computer
Programming* (a.k.a *TAoCP*) as must-haves and they were used as texts for a
time.  I once asked why these, and especially this vol.1, were no longer used
as the texts for courses any longer and I was told it was too
difficult to teach from.  I continue to recommend these and other KnuthBooks.
For beginners, keep in mind that this is a foundation volume of a larger
sequence and some of the "preliminaries" here may be mathematically
challenging.  It's not necessary to master all of that.  There are only two
chapters in this book and the important sections for getting started are
1.1 Algorithms, 1.2 Mathematical Preliminaries only enough to be familiar
with what the understandable coverages are, and 1.3 MIX to understand the
typical structure of computers via an easily-understood fictitious machine.
Chapter 2, Information Structures, and subsequent volumes can be taken as
references.  The developed algorithms are useful and independent of particular
programming languages.  The Knuth formulations of algorithms are nicely
adaptable to C Language implementations and are great resources for that
purpose.

### \[<a name="Knuth1998">Knuth1998</a>\] The Art of Computer Programming, Volume 2: Seminumerical Algorithms

Knuth, Donald E.  *The Art of Computer Programming, vol.2: Seminumerical
Algorithms*.  ed.3.  Addision Wesley Longman (Reading MA: 1973, 1998).  ISBN
0-201-89685-0.
This volume of *TAoCP* has two chapters: 3. Random Numbers and 4. Arithmetic.
It will be applicable to understanding computer arithmetic and much more. Of
great value is how one determines/confirms that a program-generated number
might be "random" and how computer arithmetics are understandable and their
limitations understood, an important concern for programming and also for
understanding of the limitation of results in the use of computer software.

---

Discussion about nfoTools is welcome at the
[Discussion section](https://github.com/orcmid/nfoTools/discussions).
Improvements and removal of defects in this particular documentation can be
reported and addressed in the
[Issues section](https://github.com/orcmid/nfoTools/issues).  There are also
relevant [projects](https://github.com/orcmid/nfoTools/projects?type=classic)
from time to time.

<!-- ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

     0.2.5 2023-06-17T21:14Z Touch-ups, adding Section 4
     0.2.4 2023-06-03T18:19Z First complete draft
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
