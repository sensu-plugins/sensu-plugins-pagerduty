#Change Log
This project adheres to [Semantic Versioning](http://semver.org/).

This CHANGELOG follows the format listed at [Keep A Changelog](http://keepachangelog.com/)

## [Unreleased]

## [1.0.0] - 2016-04-12

NOTE: There is no new functionality in this release but with the addition of test coverage we are
marking it as a stable 1.0.0 release.

### Added
- Add tests (@zbintliff)

### Fixed
- Fix tests that were always exiting 0
- Fix resolution of events (#21)

### Changed
- Update to rubocop 0.37

## [0.0.9] - 2015-12-10
### Fixed
- fix dependencies

## [0.0.8] - 2015-12-10
### Added
- Added a handler to allow overrides based on priority, now you can different 
  alerts trigger different PagerDuty API endpoints. For example one can hit a high 
  priority endpoint but warning can hit a lowpriority point.

### Changed
- Use pagerduty gem instead of redphone, now also sends description and event details when resolving

## [0.0.7] - 2015-10-29
### Changed
- handler-pagerduty: use json_config for incident key dedup_rules
- adding override from client

## [0.0.6] - 2015-07-31
### Added
- Added support for PagerDuty alert deduping.  See the Readme file for an example.

### Changed
- Updated rubocop to `0.32.1`

### Fixed
- fixed rubocop errors

## [0.0.5] - 2015-07-14
### Changed
- updated sensu-plugin gem to 1.2.0

## [0.0.4] - 2015-07-11
### Changed
- updated documentation links in the README and CONTRIBUTING
- set deps in gemspec and rakfile to be in alpha order
- removed unused tasks from rakefile

### Fixed
- fix binstubs to only be created for ruby files

## [0.0.3] - 2015-06-26
## Added
- added option for json_config

## [0.0.2] - 2015-06-03
### Fixed
- added binstubs

### Changed
- removed cruft from /lib
- added a new option for specifying the location of the json config file

## 0.0.1 - 2015-04-29
### Added
- initial release

[Unreleased]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/1.0.0...HEAD
[1.0.0]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/0.0.9...1.0.0
[0.0.9]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/0.0.8...0.0.9
[0.0.8]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/0.0.7...0.0.8
[0.0.7]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/0.0.6...0.0.7
[0.0.6]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/0.0.5...0.0.6
[0.0.5]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/0.0.4...0.0.5
[0.0.4]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/0.0.3...0.0.4
[0.0.3]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/0.0.2...0.0.3
[0.0.2]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/0.0.1...0.0.2
