ruby '2.2.3'
source 'https://rubygems.org'

# Environment Variables
gem 'dotenv', '~> 2.0.2'

# Server
gem 'puma', '~> 2.13.4', require: false

# Tasks
gem 'rake', '~> 10.4.2', require: false

# ActiveRecord
gem 'activerecord', '~> 4.2.3', require: 'active_record'
gem 'grape-activerecord', '~> 1.0.3'

# API
gem 'grape', '~> 0.12.0'

# API Facade
gem 'grape-entity', '~> 0.4.8'

# API Pagination
gem 'grape-kaminari', '~> 0.1.8'

# Datastore
gem 'pg', '~> 0.18.2'

# Soft Deletes
gem 'paranoia', '~> 2.0'

# Uploaders
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave', ref: 'c2ee2e8'
gem 'mini_magick', '~> 4.3.3'
gem 'fog', require: 'fog/aws'

# Background processing
gem 'sidekiq', '~> 3.5.0'

# Debugging Tools
gem 'pry'
gem 'racksh', '~> 1.0.0'

# Exception Tracking
gem 'raygun4ruby'

group :development do
  gem 'rerun', '~> 0.10.0', github: 'alexch/rerun', ref: '65664e5'
end

group :test do
  gem 'rspec', '~> 3.0.0'
  gem 'rack-test', '~> 0.6.2'
  gem 'factory_girl', '~> 4.0'
  gem 'database_cleaner', '~> 1.3.0'
  gem 'faker', '~> 1.5.0'
  gem 'webmock', '~> 1.21.0'
  gem 'vcr', '~> 2.9.3'
  gem 'codeclimate-test-reporter', require: false
end
