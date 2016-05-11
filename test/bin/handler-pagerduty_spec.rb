require 'json'
require_relative '../spec_helper.rb'
require_relative '../../bin/handler-pagerduty.rb'

# rubocop:disable Style/ClassVars
class PagerdutyHandler
  at_exit do
    @@autorun = false
  end

  def settings
    @settings ||= JSON.parse(fixture('pagerduty_settings.json').read)
  end
end

describe 'Handlers' do
  before do
    @handler = PagerdutyHandler.new
  end

  describe '#incident_key' do
    it 'should return incident key with warning' do
      io_obj = fixture('no_override_warning.json')
      @handler.read_event(io_obj)
      incident_key = @handler.incident_key
      expect(incident_key).to eq('i-424242/frontend_http_check')
    end

    it 'should return incident key with critical' do
      io_obj = fixture('no_override_critical.json')
      @handler.read_event(io_obj)
      incident_key = @handler.incident_key
      expect(incident_key).to eq('i-424242/frontend_http_check')
    end

    it 'should return incident key with warning on resolve' do
      io_obj = fixture('recovery_no_override_warning.json')
      @handler.read_event(io_obj)
      incident_key = @handler.incident_key
      expect(incident_key).to eq('i-424242/frontend_http_check')
    end

    it 'should return incident key with warning on resolve' do
      io_obj = fixture('recovery_no_override_critical.json')
      @handler.read_event(io_obj)
      incident_key = @handler.incident_key
      expect(incident_key).to eq('i-424242/frontend_http_check')
    end
  end

  describe '#json_config' do
    it 'should return pagerduty' do
      expect(@handler.json_config).to eq('pagerduty')
    end

    it 'should return custom' do
      json_config = PagerdutyHandler.new('-j custom_key'.split).json_config
      expect(json_config).to eq('custom_key')
    end
  end

  describe '#api_key' do
    it 'should return base key' do
      io_obj = fixture('pd_no_override.json')
      @handler.read_event(io_obj)
      expect(@handler.api_key).to eq('BASE_KEY')
    end

    it 'should return check override' do
      io_obj = fixture('pd_check_override.json')
      @handler.read_event(io_obj)
      expect(@handler.api_key).to eq('CHECK_OVERRIDE')
    end

    it 'should return client override' do
      io_obj = fixture('pd_client_override.json')
      @handler.read_event(io_obj)
      expect(@handler.api_key).to eq('CLIENT_OVERRIDE')
    end
  end

  describe '#handle' do
    it 'should create ticket' do
      stub_pd_client = double
      io_obj = fixture('minimal_create.json')
      @handler.read_event(io_obj)
      allow(@handler).to receive(:json_config).and_return('pagerduty')
      allow(@handler).to receive(:incident_key).and_return('stub_incident_key')
      allow(@handler).to receive(:event_summary).and_return('test_summary')
      expect(stub_pd_client).to receive(:trigger).with(
        'test_summary',
        incident_key: 'stub_incident_key',
        details: {
          'action' => 'create',
          'occurrences' => 1,
          'check' => {},
          'client' => {}
        }
      )
      @handler.handle(stub_pd_client)
    end

    it 'should resolve ticket' do
      stub_pd_client = double
      stub_incident = double
      io_obj = fixture('minimal_resolve.json')
      @handler.read_event(io_obj)
      allow(@handler).to receive(:json_config).and_return('pagerduty')
      allow(@handler).to receive(:incident_key).and_return('stub_incident_key')
      allow(@handler).to receive(:event_summary).and_return('test_summary')
      allow(stub_pd_client).to receive(:get_incident).and_return(stub_incident)
      expect(stub_pd_client).to receive(:get_incident).with('stub_incident_key')
      expect(stub_incident).to receive(:resolve).with(
        'test_summary',
        'action' => 'resolve',
        'occurrences' => 1,
        'check' => {},
        'client' => {}
      )
      @handler.handle(stub_pd_client)
    end
  end
end
