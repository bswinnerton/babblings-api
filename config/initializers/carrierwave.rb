CarrierWave.configure do |config|
  if ENV.fetch('S3_UPLOADS_ENABLED') == 'true'
    config.storage = :fog
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV.fetch('AWS_ACCESS_KEY_ID'),
      aws_secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
    }
    config.fog_directory  = ENV.fetch('S3_BUCKET')
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
  else
    config.storage = :file
    config.root = Rack::Directory.new('').root
    config.enable_processing = true
  end
end
