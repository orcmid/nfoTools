<!-- index.md 0.0.4                 UTF-8                          2023-05-07
     ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

            FAILCODE1: INCORRECT VCrayApp FILES CONFIGURATION
     -->

# ***VCrayApp** [FAILCODE1: INCORRECT VCrayApp FILES CONFIGURATION](.)*

| ***[nfoTools](../../../../)*** | [dev](../../../)[>D211101](../../)[>f](../)[>FAIL1](.) | [index.html](index.html) ***0.0.4 2023-05-07*** |
| :--                |       :-:          | --: |
| ![nfotools](../../../../images/nfoWorks-2014-06-02-1702-LogoSmall.png) | Work-in-Progress | ![Hard Hat Area](../../../../images/hardhat-logo.gif) |
|              |                     |           |
| This Version | since VCrayApp 0.1.0 | [D211101e](../../D211101e) |

![FAILCODE1 Message](FAIL1-2023-04-11-1559-VCrayApp-0.1.0.png)

`VCrayApp.bat` conducts an integrity check on the folders and files that it
is installed with.  If any of the files that are installed directly by
unzipping the VCrayApp-*semver*.zip distribution are missing, this check will
fail, with `FAILCODE1` reported.

The check is for presence of the named files.  Removal or renaming of the
VCrayApp-provided files, and folders, will cause the integrity check to fail.
IN-place modification of the files is not detected directly; there may be
other consequences however.

The strict checking is by design.
If confirmation fails in an unmodified VCrayApp setup, please report in
an [nfoTools Discussion](https://github.com/orcmid/nfoTools/discussions)
mentioning VCrayApp FAIL1.

For more on the files and their usage, including modifications, see the
[VCrayApp Operation](../../b/) and
[VCrayApp Testing/Lifecycle](../../c/) materials.

----

Discussion about nfoTools is welcome at the
[Discussion section](https://github.com/orcmid/nfoTools/discussions).
Improvements and removal of defects in this particular documentation can be
reported and addressed in the
[Issues section](https://github.com/orcmid/nfoTools/issues).  There are also
relevant [projects](https://github.com/orcmid/nfoTools/projects?type=classic)
from time to time.

<!-- ----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*

     0.0.4 2023-05-07T19:42Z Reflect transposition to new location
     0.0.3 2023-04-21T17:10Z Touch-ups
     0.0.2 2023-04-14T17:40Z Fix simple typo
     0.0.1 2023-04-11T23:04Z Replace with improved screen capture
     0.0.0 2023-04-10T22:07Z Initial account

               *** end D211101/f/FAIL1/index.md ***
     -->