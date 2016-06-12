ruby '2.3.1'
source 'https://rubygems.org'

# Environment Variables
gem 'dotenv'

# Server
gem 'puma', require: false

# Tasks
gem 'rake', require: false

# ActiveRecord
gem 'activerecord'
gem 'sinatra-activerecord'

# API
gem 'sinatra'

# Datastore
gem 'pg'

# Data Query Language
gem 'graphql-relay'

# Soft Deletes
gem 'paranoia'

# Uploaders
gem 'carrierwave'
gem 'mini_magick'
gem 'fog', require: 'fog/aws'

# Background processing
gem 'sidekiq'

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
