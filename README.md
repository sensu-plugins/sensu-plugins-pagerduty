## Sensu-Plugins-pagerduty

[![Build Status](https://travis-ci.org/sensu-plugins/sensu-plugins-pagerduty.svg?branch=master)](https://travis-ci.org/sensu-plugins/sensu-plugins-pagerduty)
[![Gem Version](https://badge.fury.io/rb/sensu-plugins-pagerduty.svg)](http://badge.fury.io/rb/sensu-plugins-pagerduty)
[![Code Climate](https://codeclimate.com/github/sensu-plugins/sensu-plugins-pagerduty/badges/gpa.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-pagerduty)
[![Test Coverage](https://codeclimate.com/github/sensu-plugins/sensu-plugins-pagerduty/badges/coverage.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-pagerduty)
[![Dependency Status](https://gemnasium.com/sensu-plugins/sensu-plugins-pagerduty.svg)](https://gemnasium.com/sensu-plugins/sensu-plugins-pagerduty)

## Functionality

## Files
 * bin/handler-pagerduty.rb
 * bin/mutator-pagerduty-priority-override.rb

## Usage of Handler

PagerDuty supports dedup. Dedup is useful when you want to create a single alert (for a group of checks). Only one alert is sent out even if the checks fail at the same time. The following example groups check_service_`n` together for a single host. `dedup_rules` take in regular expressions as keys and re-write rules as values. `dedup_rules` entry is optional.

```
{
  "pagerduty": {
    "api_key": "12345",
    "team_name1": {
      "api_key": "23456"
    },
    "team_name2": {
      "api_key": "34567"
    },
    "dedup_rules": {
      "(.*)/check_service_(\\d+)": "\\1/check_service"
    }
  }
}
```

In the Client hash you can define a `pager_team` key value pair.  If the the client hash contains the `pager_team` key it will then no longer use the default `pagerduty.api_key` from the above hash but will look for the value given in the client. The following client hash will  alert using the team_name1 api key instead of the default api_key. This will allow different teams/hosts to alert different escalation paths.

```
{
  "client": {
    "name": "my.host.fqdn,
    "address": "8.8.8.8",
    "subscriptions": [
      "production",
      "webserver",
      "mysql"
    ],
    "pager_team": "team_name1"
  }
}
```

Please note, this sets the escalation path on the whole host. If you want more granular control on escalation paths please view the Mutator section below.

In the Check hash you can define a `pagerduty_contexts` list to send contextual links and images with your events. This list should conform to the [PagerDuty documentation](https://developer.pagerduty.com/documentation/integration/events/trigger#contexts) about contexts.

## Usage of Priority Overide Mutator

This mutator allows you to have fine grain control on PagerDuty escalation paths based on data within the client hash.  The mutator will look in the following locations where `#{event_level}` is `warning` and `critical` (unknown, is replaced by critical), and `#{check_name}` is the name of the check. Items located lower in the list take precedence:

```
client['pager_team']
client['pd_override']['baseline'][#{event_level}]
client['pd_override'][#{check_name}][#{event_level}]
```

For example if I have the following pager_duty escalations defined on my Sensu server:

```
{
  "pagerduty": {
    "api_key": "12345",
    "low_priority": {
      "api_key": "23456"
    },
    "ops": {
      "api_key: "7890"
    }
  }
}
```

And I also have the following client hash:

```
{
  "client": {
    "name": "my.host.fqdn",
    "address": "8.8.8.8",
    "subscriptions": [
      "production",
      "webserver",
      "mysql"
    ],
    "pd_override": {
      "baseline" : {
        "warning": "low_priority"
      },
      "check_disk": {
        "warning": "ops",
        "critical": "ops"
      }
    }
  }
}

```

## Usage of Proxy

```
{
  "pagerduty": {
    "api_key": "12345",
    "proxy_host": "my.proxy.fqdn",
    "proxy_port": "8080",
    "proxy_username": "",
    "proxy_password": ""
  }
}
```

If a `critical` event is triggered from "my.host.fqdn" that is not named `check_disk` it will alert the default (with value api_key: 12345).  If a `warning` event is triggered that is not `check_disk` it will alert the `low_proirity` escalation service.  If any `check_disk` alert is triggerd it will the alert the `ops` escalation.


## Adding Dynamic Event Description Prefix

You can add a custom field from the Sensu client config as a description prefix, like the host name, to add more context to the event description:

```
{
  "pagerduty": {
    "api_key": "12345",
    "dynamic_description_prefix_key" : "name",
  }
}
```

## Flapping Incidents
By default handlers do not handle flapping incidents: [handler configuration documentation](https://sensuapp.org/docs/0.24/reference/handlers.html#handler-configuration) in order to change this you must set handle_flapping in your handler config like this:
```json
{
  "pagerduty": {
    "api_key": "12345",
    "handle_flapping": true
  }
}
```

## Installation

[Installation and Setup](http://sensu-plugins.io/docs/installation_instructions.html)

## Notes
