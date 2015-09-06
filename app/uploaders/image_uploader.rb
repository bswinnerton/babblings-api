class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  version(:medium)  { process resize_to_fill: [600, 600] }
  version(:small)   { process resize_to_fill: [300, 300] }

  def store_dir
    "uploads/#{ENV.fetch('RACK_ENV')}/images/"
  end

  def cache_dir
    "uploads/#{ENV.fetch('RACK_ENV')}/images/tmp/"
  end
end
