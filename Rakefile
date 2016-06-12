require './config/environment'
require 'dotenv/tasks'
require 'sinatra/activerecord/rake'

Dir['lib/tasks/*.rake'].each { |file| load(file) }

namespace :db do
  task :load_config do
    require './app'
  end
end
