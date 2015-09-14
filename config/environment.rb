APP_ROOT = Pathname.new(__FILE__) + '../../'
$LOAD_PATH.unshift(APP_ROOT)

require 'dotenv'
Dotenv.load

require 'bundler'
Bundler.require(:default, ENV.fetch('RACK_ENV'))

ActiveRecord::Base.schema_format = :sql
ActiveRecord::Base.raise_in_transactional_callbacks = true

require 'carrierwave/orm/activerecord'

paths = [
  Dir['lib/**/*.rb'],
  Dir['config/initializers/*.rb'],
  Dir['app/uploaders/*rb'],
  Dir['app/**/*.rb']
]

# Sort each collection of paths alphabetically (globbing does not behave
# consistently across platforms).
paths.map(&:sort).flatten.each { |path| require(path) }

require File.expand_path("#{APP_ROOT}/api", __FILE__)
