if defined? Raygun
  Raygun.setup do |config|
    config.api_key = ENV['RAYGUN_API_KEY']
  end
end
