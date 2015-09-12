ruby '2.2.3'
source 'https://rubygems.org'

# Environment Variables
gem 'dotenv', '~> 2.0.2', groups: [:development, :test]

# Server
gem 'puma', '~> 2.13.4', require: false

# Tasks
gem 'rake', '~> 10.4.2', require: false

# ActiveRecord
gem 'activerecord', '~> 4.2.3', require: 'active_record'
gem 'grape-activerecord', '~> 1.0.3'

# API
gem 'grape', '~> 0.12.0'
gem 'hashie-forbidden_attributes' # https://github.com/intridea/grape#rails

# API Facade
gem 'grape-entity', '~> 0.4.8'

# Datastore
gem 'pg', '~> 0.18.2'

# Uploaders
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
gem 'mini_magick', '~> 4.3.3'

# Debugging Tools
gem 'pry'
gem 'racksh', '~> 1.0.0'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rerun', '~> 0.10.0'
end

group :test do
  gem 'rspec', '~> 3.0.0'
  gem 'rack-test', '~> 0.6.2'
  gem 'factory_girl', '~> 4.0'
  gem 'database_cleaner', '~> 1.3.0'
  gem 'faker', '~> 1.5.0'
end
