require 'sinatra/activerecord'
require './config/environment'

class App < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  set :root, File.dirname(__FILE__) + '/app'

  configure do
    enable :logging
  end
end
