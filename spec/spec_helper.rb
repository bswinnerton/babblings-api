ENV['RACK_ENV'] = 'test'

require './config/environment'
require 'spec/support/json_helpers'

FactoryGirl.find_definitions

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include JSONHelpers
  config.include Rack::Test::Methods

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # Database Cleaner
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  def app
    $app ||= API::Root.new
  end
end
