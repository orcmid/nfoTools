<!-- index.md 0.0.0                 UTF-8                          2023-04-13
     ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

              FAILCODE4: COMPILING CACHE OF RAYLIB FILES FAILED
     -->

# ***VCrayApp** [FAILCODE4: COMPILING CACHE OF RAYLIB FILES FAILED](.)*

| ***[nfoTools](../../../../)*** | [dev](../../../)[>D211101](../../)[>fails](../)[>FAIL4](.) | [index.html](index.html) ***0.0.0 2023-04-13*** |
| :--                |       :-:          | --: |
| ![nfotools](../../../../images/nfoWorks-2014-06-02-1702-LogoSmall.png) | Work-in-Progress | ![Hard Hat Area](../../../../images/hardhat-logo.gif) |
|              |                     |           |
| This Version | since VCrayApp 0.1.0 beta release | [D211101e](../../D211101e) |

![FAILCODE4 Terse Message](FAIL4-terse-2023-04-13-1256-VCrayApp-0.1.0.png)

This is a difficult failure to demonstrate.  In terse (option "*") operation,
VC/C++ compiler (CL.exe) error messages should have occured and been displayed
just before the `FAILCODE4` message.

If the messages that appear in an actual case are insufficient clues, it can
be useful to repeat the operation in verbose ("*"-absent) mode.

![FAILCODE4 Verbose Message](FAIL4-verbose-2023-04-13-1259-VCrayApp-0.1.0.png)

Any compiler messages that lead to `FAILCODE4` should be seen between the
`[VCrayApp] Using version ...` message at the top of that screen capture
and the `[VCrayApp] **** FALCODE4 ...` message line.  The lines before the
first error message should be identical to the lines shown starting with the
`cl /utf8 ...` line.  If there are differences, the differences may be a
factor in the failure.

There are two factors in understanding what the problem is, assuming it is not
obvious: (2) what has succeeded so far, and (2) what are possible factors
now.


----

Discussion about nfoTools is welcome at the
[Discussion section](https://github.com/orcmid/nfoTools/discussions).
Improvements and removal of defects in this particular documentation can be
reported and addressed in the
[Issues section](https://github.com/orcmid/nfoTools/issues).  There are also
relevant [projects](https://github.com/orcmid/nfoTools/projects?type=classic)
from time to time.

<!-- ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

     0.0.0 2023-04-13T21:42Z Initial page from 0.0.0 FAIL3 boilerplate.

               *** end D211101/fails/FAIL4/index.md ***
     -->
