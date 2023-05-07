<!-- index.md 0.0.4                 UTF-8                          2023-05-07
     ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

              FAILCODE4: COMPILING CACHE OF RAYLIB FILES FAILED
     -->

# ***VCrayApp** [FAILCODE4: COMPILING CACHE OF RAYLIB FILES FAILED](.)*

| ***[nfoTools](../../../../)*** | [dev](../../../)[>D211101](../../)[>f](../)[>FAIL4](.) | [index.html](index.html) ***0.0.4 2023-05-07*** |
| :--                |       :-:          | --: |
| ![nfotools](../../../../images/nfoWorks-2014-06-02-1702-LogoSmall.png) | Work-in-Progress | ![Hard Hat Area](../../../../images/hardhat-logo.gif) |
|              |                     |           |
| This Version | since VCrayApp 0.1.0 | [D211101e](../../e) |

## PROBABLE DIAGNOSIS

![FAILCODE4 Terse Message](FAIL4-terse-2023-04-13-1256-VCrayApp-0.1.0.png)

With all of the checks that have succeeded before this point in a run of VCrayApp, this FAILCODE is extremely unlikely.  It indicates that there has
been some form of damage or defect-introduction into the VCrayApp setup.

* If the installed raylib source code is from a release more-recent than 4.5,
there may be breaking changes that impact use of the VC/C++ compiler or
VCrayApp itself.
  * Check [D211101](../..) for any helpful notices.
  * Revert to raylib 4.5.0 or more-recent stable release known not to be
problematic.
* The installed raylib source code is from an under-development release in
which a defect or breaking changes impacts VS Build Tools operation.
  * If working on a raylib `-dev` release is important, check with the
[raylib project](https://github.com/raysan5/raylib/) and also ensure the
latest stable release of VS Build Tools is being used.
  * Otherwise, revert to use of a stable
 [raylib source-code release](https://github.com/raysan5/raylib/releases)
 known to be usable with VCrayApp.
* There have been modifications made to VCrayApp `cache\*.opt` files that
prevent successful compilation of raylib components into the cache.
  * Restore the `cache\*.opt` files that are supplied with the version of
VCrayApp being used.
* Modifications to VCrayApp.bat have corrupted cache-creation/-update
operation.  (That's how FAILCODE4 demonstration was forced for documentation.)
  * Reinstallation of VCrayApp is advisable.

## TROUBLE-SHOOTING

When VCrayApp is operate in terse (option "*") mode, there are no details
supporting determination of the failure.  Unless something obvious explains
this failure, it is important to repeat the operation using VCrayApp without any parameters. A cache rebuild will be attempted automatically.

IMPORTANT: If VCrayApp is being operated embedded in a larger procedure, it
is necessary to troubleshoot by operating VCrayApp.bat directly.  Building
of the cache depends on VCrayApp alone.  A standalone use of VCrayApp.bat
is necessary to obtain details behind the FAILCODE4.  No modifications of
VCrayApp.bat are required to accomplish this.  There will be no impact on
returning to embedded use once the problem is resolved.

![FAILCODE4 Verbose Message](FAIL4-verbose-2023-04-13-1259-VCrayApp-0.1.0.png)

On a verbose running of VCrayApp.bat, Any compiler messages that lead to
`FAILCODE4` should be seen between the `[VCrayApp] Using version ...` message
shown at the top of the screen capture above and the
`[VCrayApp] **** FAILCODE4 ...` message line.  The lines before the first
diagnostice message should be identical to the lines shown above, starting
with the `cl /utf8 ...` line.  If there are differences, the differences may
be a factor in the failure.

Although `FAILCODE4` is specific to compilation of raylib components into the
VCrayApp `cache\`, the analysis of diagnostic messages will be similar to the
cases for [`FAILCODE5`](..\FAIL5).  Consult
[VCrayApp Setup](../../D211101a) and [VCrayApp Operation](../../D211101b)
for further details.

----

Discussion about nfoTools is welcome at the
[Discussion section](https://github.com/orcmid/nfoTools/discussions).
Improvements and removal of defects in this particular documentation can be
reported and addressed in the
[Issues section](https://github.com/orcmid/nfoTools/issues).  There are also
relevant [projects](https://github.com/orcmid/nfoTools/projects?type=classic)
from time to time.

<!-- ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

     0.0.4 2023-05-07T19:57Z Reflect transposition to new location
     0.0.3 2023-04-21T19:28Z More touch-ups, final draft
     0.0.2 2023-04-20T23:35Z Draft touch-ups
     0.0.1 2023-04-20T20:12Z Intermediate draft
     0.0.0 2023-04-13T21:42Z Initial page from 0.0.0 FAIL3 boilerplate.

               *** end D211101/f/FAIL4/index.md ***
     -->
