ENV['RACK_ENV'] = 'test'

require 'support/vcr'
require 'support/code_climate'
require './config/environment'
require 'carrierwave/test/matchers'
require 'sidekiq/testing'

Dir['spec/support/**/*.rb'].each { |f| require f }

FactoryGirl.find_definitions

Sidekiq::Testing.fake!

RSpec.configure do |config|
  config.include CarrierWave::Test::Matchers
  config.include FactoryGirl::Syntax::Methods
  config.include JSONHelpers
  config.include Rack::Test::Methods

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:each) do |spec|
    unless spec.metadata[:uploader_requests_enabled]
      allow_any_instance_of(ImageUploader).to receive(:download!)
    end
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
    FileUtils.rm_rf(Dir[ImageUploader::BASE_STORAGE_PATH])
  end

  def app
    $app ||= API::Root.new
  end
end
