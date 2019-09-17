# Change Log
This project adheres to [Semantic Versioning](http://semver.org/).

This CHANGELOG follows the format listed [here](https://github.com/sensu-plugins/community/blob/master/HOW_WE_CHANGELOG.md)

## [Unreleased]

## [5.0.0] - 2019-09-16
### Breaking Changes
- Bump `sensu-plugin` dependency from `~> 2.5` to `~> 4.0` you can read the changelog entries for [4.0](https://github.com/sensu-plugins/sensu-plugin/blob/master/CHANGELOG.md#400---2018-02-17), [3.0](https://github.com/sensu-plugins/sensu-plugin/blob/master/CHANGELOG.md#300---2018-12-04), and [2.0](https://github.com/sensu-plugins/sensu-plugin/blob/master/CHANGELOG.md#v200---2017-03-29)
- Bump `ruby-version` from `~> 2.0` to `~> 2.3`

### Added
- Travis build automation to generate Sensu Asset tarballs that can be used n conjunction with Sensu provided ruby runtime assets and the Bonsai Asset Index
- Require latest sensu-plugin for [Sensu Go support](https://github.com/sensu-plugins/sensu-plugin#sensu-go-enablement)

## [4.1.0] - 2018-12-04
### Changed
- updated `pagerduty` dependancy (@dependabot)

## [4.0.0] - 2018-06-04
### Breaking Changes
- Bumped dependency of `sensu-plugin` to 2.x which will globally disable deprecated event filtering. You can read about it [here](https://github.com/sensu-plugins/sensu-plugin/blob/master/CHANGELOG.md#v145---2017-03-07) (@rajiv-g)

## [3.1.0] - 2018-03-17
### Added
- error handling when `json_config` key is not found to help users deal with the problem. Not great but better than a `NilClass` error (@majormoses)

### Changed
- changed the description of `json_config` to reflect that this is a key not the json file (@majormoses)

## [3.0.1] - 2018-02-16
### Added
- ruby 2.4 testing (@majormoses)

### Fixed
- PR template typo (@majormoses)
- if pager_team is not found in the handler json config, the default key will be used instead (@internaught)

### Changed
- updated changelog guidelines location (@majormoses)

## [3.0.0] - 2017-06-01
### Breaking Change
- changed the precedence of pager_team evaluation from `client -> check -> json_config`  to `check -> client -> json_config` (@guru-beach)
### Added
- support for flapping events to be created (@majormoses)

## [2.2.0] - 2017-03-23
### Added
- Add retries for Timeouts and HTTP errors (@johanek)

## [2.1.0] - 2017-02-28
### Added
- Add contexts support (@zroger)
- Update timeout syntax and extend to 10 seconds. (@luckymike)
- Allow adding some dynamic fields (from the event sensu client config) to the PD event description (@Oded-B)

## [2.0.0] - 2016-06-29
### Added
- Proxy support (@lcrisci)
- Support for Ruby 2.3

### Removed
- Support for Ruby 1.9.3

### Changed
- Update to Rubocop 0.40 and cleanup

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

[Unreleased]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/5.0.0...HEAD
[5.0.0]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/4.1.0...5.0.0
[4.1.0]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/4.0.0...4.1.0
[4.0.0]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/3,1,0...4.0.0
[3.1.0]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/3.0.1...3,1.0
[3.0.1]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/3.0.0...3.0.1
[3.0.0]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/2.2.0...3.0.0
[2.2.0]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/2.1.0...2.2.0
[2.1.0]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/2.0.0...2.1.0
[2.0.0]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/1.0.0...2.0.0
[1.0.0]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/0.0.9...1.0.0
[0.0.9]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/0.0.8...0.0.9
[0.0.8]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/0.0.7...0.0.8
[0.0.7]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/0.0.6...0.0.7
[0.0.6]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/0.0.5...0.0.6
[0.0.5]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/0.0.4...0.0.5
[0.0.4]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/0.0.3...0.0.4
[0.0.3]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/0.0.2...0.0.3
[0.0.2]: https://github.com/sensu-plugins/sensu-plugins-pagerduty/compare/0.0.1...0.0.2
