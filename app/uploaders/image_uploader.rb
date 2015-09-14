class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  BASE_STORAGE_PATH = "uploads/#{ENV.fetch('RACK_ENV')}/images"

  process :store_dimensions

  version(:medium)  { process resize_to_fill: [600, 600] }
  version(:small)   { process resize_to_fill: [300, 300] }

  def store_dimensions
    return unless file && model
    return unless model.attributes.keys.include? 'width'
    return unless model.attributes.keys.include? 'height'

    model.height, model.width = MiniMagick::Image.open(file.file).dimensions
  end

  private

  def store_dir
    "#{BASE_STORAGE_PATH}/#{model.id}"
  end

  def cache_dir
    "#{BASE_STORAGE_PATH}/#{model.id}/tmp"
  end
end
