require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

RSpec.configure do |c|
  c.formatter = :documentation
  c.color = true
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(f)
  File.new(File.join(fixture_path, f))
end
