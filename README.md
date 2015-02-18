## Sensu-Plugins-pagerduty

[![Build Status](https://travis-ci.org/sensu-plugins/sensu-plugins-pagerduty.svg?branch=master)](https://travis-ci.org/sensu-plugins/sensu-plugins-pagerduty)
[![Gem Version](https://badge.fury.io/rb/sensu-plugins-pagerduty.svg)](http://badge.fury.io/rb/sensu-plugins-pagerduty)
[![Code Climate](https://codeclimate.com/github/sensu-plugins/sensu-plugins-pagerduty/badges/gpa.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-pagerduty)
[![Test Coverage](https://codeclimate.com/github/sensu-plugins/sensu-plugins-pagerduty/badges/coverage.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-pagerduty)
[![Dependency Status](https://gemnasium.com/sensu-plugins/sensu-plugins-pagerduty.svg)](https://gemnasium.com/sensu-plugins/sensu-plugins-pagerduty)

## Functionality

## Files
 * bin/handler-pagerdut

## Usage

```
{
  "pagerduty": {
    "api_key": "12345",
    "team_name1": {
      "api_key": "23456"
    },
    "team_name2": {
      "api_key": "34567"
    }
  }
}
```
## Installation

Add the public key (if you haven’t already) as a trusted certificate

```
gem cert --add <(curl -Ls https://raw.githubusercontent.com/sensu-plugins/sensu-plugins.github.io/master/certs/sensu-plugins.pem)
gem install sensu-plugins-pagerduty -P MediumSecurity
```

You can also download the key from /certs/ within each repository.

#### Rubygems

`gem install sensu-plugins-pagerduty`

#### Bundler

Add *sensu-plugins-disk-checks* to your Gemfile and run `bundle install` or `bundle update`

#### Chef

Using the Sensu **sensu_gem** LWRP
```
sensu_gem 'sensu-plugins-pagerduty' do
  options('--prerelease')
  version '0.0.1'
end
```

Using the Chef **gem_package** resource
```
gem_package 'sensu-plugins-pagerduty' do
  options('--prerelease')
  version '0.0.1'
end
```

## Notes
