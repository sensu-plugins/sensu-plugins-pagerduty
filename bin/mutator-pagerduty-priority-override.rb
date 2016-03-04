#!/usr/bin/env ruby
#
# PagerDuty
# ===
#
# DESCRIPTION:
#   This mutator take the Client hash and looks for overrides of the pager_team.
#   PagerDuty Handler looks for client['pager_team'] to know which pager duty api token to use.
#   This will allow user to set high and low priority alerts on the client as a whole,
#   or on a check by check basis.  This will also allow override on a warning and critical basis
#   for each check.
#
#  EX: Override all warnings on host
#  client.pd_override.baseline.warning: <value to override pager_team with>
#
#  EX: Override warning on host for specific check
#  client.pd_override.<check_name>.warning: <value to override pager_team with>
#
# OUTPUT:
#   Sensu event with pager_team value changed if an override is passed.
#
# PLATFORM:
#   all
#
# DEPENDENCIES:
#   none
#
# Copyright 2015 Zach Bintliff <https://github.com/zbintliff>
#
# Released under the same terms as Sensu (the MIT license); see LICENSE
# for details.
require 'json'

module Sensu
  module Mutator
    class PagerDuty
      class PriorityOverride
        ## Make it a class that takes an IO object for easier testing
        def execute(input = STDIN)
          # parse event
          event = JSON.parse(input.read, symbolize_names: true)

          check_name = event[:check][:name]
          status = get_status_string(event[:check])

          baseline_override = get_override(event, 'baseline', status)
          check_override = get_override(event, check_name, status)

          if !check_override.nil?
            event[:client][:pager_team] = check_override
          elsif !baseline_override.nil?
            event[:client][:pager_team] = baseline_override
          end
          JSON.dump(event)
        end

        def get_status_string(check)
          status = check[:status]
          if status == 1
            return 'warning'
          elsif status == 0 # rubocop:disable Style/GuardClause
            ## 0 means its a resolve event, to know which PagerDuty API to resolve on
            ## we need to look at previous alert
            ## strangely enough the history array in the event is an array of strings...
            return get_status_string(status: check[:history][-2].to_i)
          else
            return 'critical'
          end
        end

        def get_override(event, check, status)
          return nil if !event[:client].key?(:pd_override) || !event[:client][:pd_override].key?(check.to_sym)
          event[:client][:pd_override][check.to_sym][status.to_sym]
        end
      end
    end
  end
end

## Is called from Gem script. Program name is full path to this script
### __FILE__ is the initial script ran, which is
### /usr/local/bin/mutator-pagerduty-priority-override.rb
if $PROGRAM_NAME.include?(__FILE__.split('/').last)
  mutator = Sensu::Mutator::PagerDuty::PriorityOverride.new
  puts mutator.execute
end
