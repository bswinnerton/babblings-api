$LOAD_PATH.unshift(Pathname.new(__FILE__) + '../../')

require 'dotenv'
Dotenv.load

require 'bundler'
Bundler.require(:default, ENV.fetch('RACK_ENV'))

require 'carrierwave/orm/activerecord'

paths = [
  Dir['config/initializers/*.rb'],
  Dir['lib/**/*.rb'],
  Dir['app/**/*.rb']
]

paths.flatten.each { |path| require(path) }
