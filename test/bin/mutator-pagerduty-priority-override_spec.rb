require 'json'
require_relative '../spec_helper.rb'
require_relative '../../bin/mutator-pagerduty-priority-override.rb'

describe 'Mutators' do
  before do
    @script = File.expand_path('../../bin/mutator-pagerduty-priority-override.rb', File.dirname(__FILE__))
  end

  it 'should pass event through -- critical' do
    mutator = Sensu::Mutator::PagerDuty::PriorityOverride.new
    io_obj = fixture('no_override_critical.json')

    raw_input = io_obj.read
    io_obj.rewind
    raw_output = mutator.execute(io_obj)

    event_input = JSON.parse(raw_input, symbolize_names: true)
    json_output = JSON.parse(raw_output, symbolize_names: true)

    expect(raw_output.strip).to eql(JSON.dump(event_input))
    expect(json_output[:client][:pager_team]).to eql(event_input[:client][:pager_team])
  end

  it 'should pass event through -- warning' do
    mutator = Sensu::Mutator::PagerDuty::PriorityOverride.new
    io_obj = fixture('no_override_warning.json')

    raw_input = io_obj.read
    io_obj.rewind
    raw_output = mutator.execute(io_obj)

    event_input = JSON.parse(raw_input, symbolize_names: true)
    json_output = JSON.parse(raw_output, symbolize_names: true)

    expect(raw_output.strip).to eql(JSON.dump(event_input))
    expect(json_output[:client][:pager_team]).to eql(event_input[:client][:pager_team])
  end

  it 'should override with baseline when status matches -- critical' do
    mutator = Sensu::Mutator::PagerDuty::PriorityOverride.new
    io_obj = fixture('baseline_override_critical_event.json')

    raw_input = io_obj.read
    io_obj.rewind
    raw_output = mutator.execute(io_obj)

    event_input = JSON.parse(raw_input, symbolize_names: true)
    json_output = JSON.parse(raw_output, symbolize_names: true)

    expect(raw_output.strip).not_to eql(JSON.dump(event_input))
    expect(json_output[:client][:pager_team]).to eql(event_input[:client][:pd_override][:baseline][:critical])
  end

  it 'should override with baseline when status matches -- warning' do
    mutator = Sensu::Mutator::PagerDuty::PriorityOverride.new
    io_obj = fixture('baseline_override_warning_event.json')

    raw_input = io_obj.read
    io_obj.rewind
    raw_output = mutator.execute(io_obj)

    event_input = JSON.parse(raw_input, symbolize_names: true)
    json_output = JSON.parse(raw_output, symbolize_names: true)

    expect(raw_output.strip).not_to eql(JSON.dump(event_input))
    expect(json_output[:client][:pager_team]).to eql(event_input[:client][:pd_override][:baseline][:warning])
  end

  it 'should override with check when status matches -- critical' do
    mutator = Sensu::Mutator::PagerDuty::PriorityOverride.new
    io_obj = fixture('check_override_critical_event.json')

    raw_input = io_obj.read
    io_obj.rewind
    raw_output = mutator.execute(io_obj)

    event_input = JSON.parse(raw_input, symbolize_names: true)
    json_output = JSON.parse(raw_output, symbolize_names: true)

    expect(raw_output.strip).not_to eql(JSON.dump(event_input))
    expect(json_output[:client][:pager_team]).to eql(event_input[:client][:pd_override][event_input[:check][:name].to_sym][:critical])
  end

  it 'should override with check when status matches -- warning' do
    mutator = Sensu::Mutator::PagerDuty::PriorityOverride.new
    io_obj = fixture('check_override_warning_event.json')

    raw_input = io_obj.read
    io_obj.rewind
    raw_output = mutator.execute(io_obj)

    event_input = JSON.parse(raw_input, symbolize_names: true)
    json_output = JSON.parse(raw_output, symbolize_names: true)

    expect(raw_output.strip).not_to eql(JSON.dump(event_input))
    expect(json_output[:client][:pager_team]).to eql(event_input[:client][:pd_override][event_input[:check][:name].to_sym][:warning])
  end

  it 'should use check override if baseline is also provided -- critical' do
    mutator = Sensu::Mutator::PagerDuty::PriorityOverride.new
    io_obj = fixture('check_and_baseline_override_critical_event.json')

    raw_input = io_obj.read
    io_obj.rewind
    raw_output = mutator.execute(io_obj)

    event_input = JSON.parse(raw_input, symbolize_names: true)
    json_output = JSON.parse(raw_output, symbolize_names: true)

    expect(raw_output.strip).not_to eql(JSON.dump(event_input))
    expect(json_output[:client][:pager_team]).to eql(event_input[:client][:pd_override][event_input[:check][:name].to_sym][:critical])
  end

  it 'should use check override if baseline is also provided -- warning' do
    mutator = Sensu::Mutator::PagerDuty::PriorityOverride.new
    io_obj = fixture('check_and_baseline_override_warning_event.json')

    raw_input = io_obj.read
    io_obj.rewind
    raw_output = mutator.execute(io_obj)

    event_input = JSON.parse(raw_input, symbolize_names: true)
    json_output = JSON.parse(raw_output, symbolize_names: true)

    expect(raw_output.strip).not_to eql(JSON.dump(event_input))
    expect(json_output[:client][:pager_team]).to eql(event_input[:client][:pd_override][event_input[:check][:name].to_sym][:warning])
  end

  it 'should use check on recovery if provided -- critical' do
    mutator = Sensu::Mutator::PagerDuty::PriorityOverride.new
    io_obj = fixture('recovery_check_critical_event.json')

    raw_input = io_obj.read
    io_obj.rewind
    raw_output = mutator.execute(io_obj)

    event_input = JSON.parse(raw_input, symbolize_names: true)
    json_output = JSON.parse(raw_output, symbolize_names: true)

    expect(raw_output.strip).not_to eql(JSON.dump(event_input))
    expect(json_output[:client][:pager_team]).to eql(event_input[:client][:pd_override][event_input[:check][:name].to_sym][:critical])
  end

  it 'should use check on recovery if provided -- warning' do
    mutator = Sensu::Mutator::PagerDuty::PriorityOverride.new
    io_obj = fixture('recovery_check_warning_event.json')

    raw_input = io_obj.read
    io_obj.rewind
    raw_output = mutator.execute(io_obj)

    event_input = JSON.parse(raw_input, symbolize_names: true)
    json_output = JSON.parse(raw_output, symbolize_names: true)

    expect(raw_output.strip).not_to eql(JSON.dump(event_input))
    expect(json_output[:client][:pager_team]).to eql(event_input[:client][:pd_override][event_input[:check][:name].to_sym][:warning])
  end

  it 'should use baseline on recovery if provided and check is not -- critical' do
    mutator = Sensu::Mutator::PagerDuty::PriorityOverride.new
    io_obj = fixture('recovery_baseline_critical_event.json')

    raw_input = io_obj.read
    io_obj.rewind
    raw_output = mutator.execute(io_obj)

    event_input = JSON.parse(raw_input, symbolize_names: true)
    json_output = JSON.parse(raw_output, symbolize_names: true)

    expect(raw_output.strip).not_to eql(JSON.dump(event_input))
    expect(json_output[:client][:pager_team]).to eql(event_input[:client][:pd_override][:baseline][:critical])
  end

  it 'should use baseline on recovery if provided and check is not -- warning' do
    mutator = Sensu::Mutator::PagerDuty::PriorityOverride.new
    io_obj = fixture('recovery_baseline_warning_event.json')

    raw_input = io_obj.read
    io_obj.rewind
    raw_output = mutator.execute(io_obj)

    event_input = JSON.parse(raw_input, symbolize_names: true)
    json_output = JSON.parse(raw_output, symbolize_names: true)

    expect(raw_output.strip).not_to eql(JSON.dump(event_input))
    expect(json_output[:client][:pager_team]).to eql(event_input[:client][:pd_override][:baseline][:warning])
  end

  it 'pass event recovery through when neither baseline nor check is used -- critical' do
    mutator = Sensu::Mutator::PagerDuty::PriorityOverride.new
    io_obj = fixture('recovery_no_override_critical.json')

    raw_input = io_obj.read
    io_obj.rewind
    raw_output = mutator.execute(io_obj)

    event_input = JSON.parse(raw_input, symbolize_names: true)
    json_output = JSON.parse(raw_output, symbolize_names: true)

    expect(raw_output.strip).to eql(JSON.dump(event_input))
    expect(json_output[:client][:pager_team]).to eql(event_input[:client][:pager_team])
  end

  it 'pass recovery event through when neither baseline nor check is used -- warning' do
    mutator = Sensu::Mutator::PagerDuty::PriorityOverride.new
    io_obj = fixture('recovery_no_override_warning.json')

    raw_input = io_obj.read
    io_obj.rewind
    raw_output = mutator.execute(io_obj)

    event_input = JSON.parse(raw_input, symbolize_names: true)
    json_output = JSON.parse(raw_output, symbolize_names: true)

    expect(raw_output.strip).to eql(JSON.dump(event_input))
    expect(json_output[:client][:pager_team]).to eql(event_input[:client][:pager_team])
  end
end
