Raygun.setup do |config|
  config.api_key = ENV.fetch('RAYGUN_API_KEY')
  config.enable_reporting = (ENV.fetch('TRACK_EXCEPTIONS') == 'true')
end
