require './config/environment'
require 'dotenv/tasks'
require 'grape/activerecord/rake'

Dir['lib/tasks/*.rake'].each { |file| load(file) }

desc 'API Routes'
task :routes do
  API::Root.routes.each do |api|
    method = api.route_method.ljust(10)
    path = api.route_path
    puts "     #{method} #{path}"
  end
end
