require File.expand_path('../app', __FILE__)
require 'sidekiq/web'

map '/sidekiq' do
  run Sidekiq::Web
end

map '/' do
  run App
end
