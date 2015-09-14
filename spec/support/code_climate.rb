if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'

  SimpleCov.start do
    add_filter 'api.rb'
    add_filter 'config/'
    add_filter 'vendor/'
  end

  CodeClimate::TestReporter.start
end
