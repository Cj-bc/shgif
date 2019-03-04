# changelog

CHANGELOG is written in [keepchangelog](https://keepachangelog.com/en/1.0.0/) format
Unofficial Japanese docs for reference [keep-a-changelog softantenna](https://www.softantenna.com/wp/software/keep-a-changeloag/)

## WIP
  - bpkg support

## [1.5.3] - 2019-03-04
### Fixed
  * Use proper regex for case command(case command uses regex, not glob)


## [1.5.2] - 2019-03-04
### Fixed
  * Allow less than 10 and more than 99 x coordinates in config file

## [1.5.1] - 2019-03-03
### Changed
  * use blib to manage libshgif

## [1.5.0] - 2019-03-02
### Changed
  * Use blib to manage libraries

### Fixed
  * Can't find library

## [1.4.3] - 2018-11-11
### Fix
  - Remove bug that adds empty line on the second line for each picture

## [1.4.2] - 2018-11-11
### Fix
  - Remove bug that can't treat background color code

## [1.4.1] - 2018-11-11
### Change
  - Write CHANGELOG for 1.4.0
## [1.4.0] - 2018-11-11
### Added
  - Tput's `blink`/`bold` option are supported

## [1.3.0] - 2018-10-30
### Added
  - homebrew support

## [1.2.0] - 2018-10-30
### Added
  - color support
  - close #3/#4
### Fix
  - follow shellcheck

## [1.1] - 2018-10-08
### Added
  - introduce rule for CHANGELOG
  - `.tar`/`.tar.gz` file support
### Changed
  - all codes are now in functions.


## [1.0.1] - 2018-10-07
### Fixed
  - Don't clear each time `Draw::DrawAt` is called
  - Fix example/walking_cat to fit with avobe fix.

## [1.0] - 2018-10-07
### Added
  - The first release.
  - `./shgif.sh <your shgif file>` to run shgif file
  - The shgif file should be directory.
  - shgif file supported commands:
    - `sleep`
    - `<x> <y> <file>`
