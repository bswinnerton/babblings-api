# https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server
workers         ENV.fetch('WEB_CONCURRENCY', 2).to_i
thread_count  = ENV.fetch('MAX_THREADS', 1).to_i # Increase only if thread safe
threads         thread_count, thread_count

preload_app!

rackup      DefaultRackup
port        ENV.fetch('PORT', 3000)
environment ENV.fetch('RACK_ENV', 'development')

on_worker_boot { ActiveRecord::Base.establish_connection }
