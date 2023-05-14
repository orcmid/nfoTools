<!-- index.md 0.0.6                 UTF-8                          2023-05-14
     ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

              FAILCODE4: COMPILING CACHE OF RAYLIB FILES FAILED
     -->

# ***VCrayApp** [FAILCODE4: COMPILING CACHE OF RAYLIB FILES FAILED](.)*

| ***[nfoTools](../../../../)*** | [dev](../../../)[>D211101](../../)[>f](../)[>FAIL4](.) | [index.html](index.html) ***0.0.6 2023-05-14*** |
| :--                |       :-:          | --: |
| ![nfotools](../../../../images/nfoWorks-2014-06-02-1702-LogoSmall.png) | Work-in-Progress | ![Hard Hat Area](../../../../images/hardhat-logo.gif) |
|              |                     |           |
| This Version | since VCrayApp 0.1.0 | [D211101e](../../e) |

## PROBABLE DIAGNOSIS

![FAILCODE4 Terse Message](FAIL4-terse-2023-05-13-0749-VCrayApp-0.1.0.png)

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
operation.
  * Reinstallation of VCrayApp is advisable.

## TROUBLE-SHOOTING

When VCrayApp is operate in terse (option "*") mode, there are no details
supporting determination of the failure.  Unless something obvious explains
this failure, it is important to repeat the operation using VCrayApp without any parameters. A cache rebuild will be attempted automatically.

IMPORTANT: If VCrayApp is being operated embedded in a larger procedure, it
is necessary to troubleshoot by operating VCrayApp.bat directly.  Building
of the cache depends on VCrayApp alone.  A direct use of VCrayApp.bat
is necessary to obtain details behind the FAILCODE4.  No modifications of
VCrayApp.bat are required to accomplish this.  There will be no impact on
returning to embedded use once the problem is resolved.

Repeat running of VCrayApp.bat in verbose mode.  The beginning of the report
should have no special messages.

![Expected Verbose Startup](FAIL4-verbose-2023-05-13-0807-TroubleShooting.png)

The troubleshooting startup should be similar to the the information in the
screen capture above.  Fine details will differ with regard to time, location,
and versions of tools.  It should all be uneventful until the FAILCODE4
message and termination of the VCrayApp.bat script.

![FAILCODE4 Verbose Message](FAIL4-verbose-2023-05-13-0755-VCrayApp-0.1.0.png)

Scroll down in the command output to find the illustrated compile command.
For a *successful* build of the cache, this is what will appear in verbose
operation with a raylib version 4.x.

Any compiler error messages should appear among the list of `raylib\src` files
as they are compiled.  It could also be that files are not being found.

Although `FAILCODE4` is specific to compilation of raylib components into the
VCrayApp `cache\`, the analysis of diagnostic messages will be similar to the
cases for [`FAILCODE5`](..\FAIL5).  The complication is that
the problem will not be with code for the VCrayApp project, but with raylib code if not obviously with the setup of the `raylib\` folder.

In case the difficulty is with files not being found,
it may be necessary to check with the
[raylib project](https://github.com/raysan5/raylib/) for related issues.

Consult [VCrayApp Setup](../../a) and [VCrayApp Operation](../../b)
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

     0.0.6 2023-05-14T16:50Z Correct two image links
     0.0.5 2023-05-13T15:40Z Align with release candidate using demo project
     0.0.4 2023-05-07T19:57Z Reflect transposition to new location
     0.0.3 2023-04-21T19:28Z More touch-ups, final draft
     0.0.2 2023-04-20T23:35Z Draft touch-ups
     0.0.1 2023-04-20T20:12Z Intermediate draft
     0.0.0 2023-04-13T21:42Z Initial page from 0.0.0 FAIL3 boilerplate.

               *** end D211101/f/FAIL4/index.md ***
     -->
