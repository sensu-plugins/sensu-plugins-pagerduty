#!/usr/bin/env ruby
#
# This handler creates and resolves PagerDuty incidents, refreshing
# stale incident details every 30 minutes
#
# Copyright 2011 Sonian, Inc <chefs@sonian.net>
#
# Released under the same terms as Sensu (the MIT license); see LICENSE
# for details.
#
# Note: The sensu api token could also be configured on a per client or per check basis.
#       By defining the "pager_team" attribute in the client config file or the check config.
#       The override order will be client > check > json_config
#
# Dependencies:
#
#   sensu-plugin >= 1.0.0
#

require 'sensu-handler'
require 'pagerduty'

#
# Pagerduty
#
class PagerdutyHandler < Sensu::Handler
  option :json_config,
         description: 'Config Name',
         short: '-j JsonConfig',
         long: '--json_config JsonConfig',
         required: false,
         default: 'pagerduty'

  def incident_key
    source = @event['check']['source'] || @event['client']['name']
    incident_id = [source, @event['check']['name']].join('/')
    dedup_rules = settings[json_config]['dedup_rules'] || {}
    dedup_rules.each do |key, val|
      incident_id = incident_id.gsub(Regexp.new(key), val)
    end
    incident_id
  end

  def json_config
    @json_config ||= config[:json_config]
  end

  def api_key
    @api_key ||=
      if @event['client']['pager_team']
        settings[json_config][@event['client']['pager_team']]['api_key']
      elsif @event['check']['pager_team']
        settings[json_config][@event['check']['pager_team']]['api_key']
      elsif @event['check']['pager_status'] && !settings[json_config][@event['check']['pager_status']]['api_key'].nil?
        settings[json_config][@event['check']['pager_status']]['api_key']
      else
        settings[json_config]['api_key']
      end
  end

  def handle(pd_client = nil)
    incident_key_prefix = settings[json_config]['incident_key_prefix']
    description_prefix = settings[json_config]['description_prefix']
    begin
      timeout(5) do
        pagerduty = pd_client || Pagerduty.new(api_key)

        begin
          case @event['action']
          when 'create'
            pagerduty.trigger([description_prefix, event_summary].compact.join(' '),
                              incident_key: [incident_key_prefix, incident_key].compact.join(''),
                              details: @event)
          when 'resolve'
            pagerduty.get_incident([incident_key_prefix, incident_key].compact.join('')).resolve(
              description: [description_prefix, event_summary].compact.join(' '), details: @event)
          end
          puts 'pagerduty -- ' + @event['action'].capitalize + 'd incident -- ' + incident_key
        rescue Net::HTTPServerException => error
          puts 'pagerduty -- failed to ' + @event['action'] + ' incident -- ' + incident_key + ' -- ' +
            error.response.code + ' ' + error.response.message + ': ' + error.response.body
        end
      end
    rescue Timeout::Error
      puts 'pagerduty -- timed out while attempting to ' + @event['action'] + ' a incident -- ' + incident_key
    end
  end
end
