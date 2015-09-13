require File.expand_path('../api', __FILE__)

# https://github.com/jhollinger/grape-activerecord#important
use ActiveRecord::ConnectionAdapters::ConnectionManagement

use Raygun::Middleware::RackExceptionInterceptor

map '/' do
  run API::Root
end
