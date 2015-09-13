ENV['RACK_ENV'] = 'test'

require './config/environment'
require 'carrierwave/test/matchers'

Dir['spec/support/**/*.rb'].each { |f| require f }

FactoryGirl.find_definitions

RSpec.configure do |config|
  config.include CarrierWave::Test::Matchers
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

  # Carrierwave
  config.after(:each) do
    ImageUploader.enable_processing = false
  end

  config.after(:all) do
    FileUtils.rm_rf(Dir[ImageUploader.store_dir])
  end

  def app
    $app ||= API::Root.new
  end
end
