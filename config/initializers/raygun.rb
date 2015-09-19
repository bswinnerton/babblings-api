Raygun.setup do |config|
  config.api_key = ENV.fetch('RAYGUN_APIKEY')
  config.enable_reporting = (ENV.fetch('TRACK_EXCEPTIONS') == 'true')
end
