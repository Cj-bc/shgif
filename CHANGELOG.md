# changelog

CHANGELOG is written in [keepchangelog](https://keepachangelog.com/en/1.0.0/) format
Unofficial Japanese docs for reference [keep-a-changelog softantenna](https://www.softantenna.com/wp/software/keep-a-changeloag/)

## WIP
  - bpkg support

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
