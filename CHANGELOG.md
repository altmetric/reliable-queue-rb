# Change Log

All notable changes to this project will be documented in this file. This
project adheres to [Semantic Versioning](http://semver.org/).

## [1.0.1] - 2026-04-08

### Fixed

- Rename `lib/reliable_queue_rb.rb` back to `lib/reliable-queue-rb.rb` so Bundler can auto-require the gem correctly

## [1.0.0] - 2026-03-27

### Changed

- Replace deprecated `rpoplpush`/`brpoplpush` with `lmove`/`blmove` (requires Redis 6.2+)
- Modernise dev dependencies
- Replace Travis CI with GitHub Actions
- Add house_style and apply the corrections
- Change the supporting Ruby versions to 2.7 onwards

## [0.4.0] - 2023-11-10

### Changed

- Minimum required Redis client version bumped to 5.0+
- Updated the code to support the current Redis API

## [0.3.0] - 2021-09-09

### Changed

- Upgrade redis

## [0.2.0] - 2020-12-16

### Changed

- A single require for both classes

## [0.1.0] - 2020-12-14

### Added

- Initial release
