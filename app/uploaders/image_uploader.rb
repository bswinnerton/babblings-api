class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  BASE_STORE_DIR="uploads/#{ENV.fetch('RACK_ENV')}/images"
  BASE_CACHE_DIR="uploads/#{ENV.fetch('RACK_ENV')}/images/tmp"

  process :store_dimensions

  version(:medium)  { process resize_to_fill: [600, 600] }
  version(:small)   { process resize_to_fill: [300, 300] }

  def store_dir
    "#{BASE_STORE_DIR}/#{model.id}"
  end

  def cache_dir
    "#{BASE_CACHE_DIR}//#{model.id}"
  end

  private

  def store_dimensions
    return unless file && model
    return unless model.attributes.keys.include? 'width'
    return unless model.attributes.keys.include? 'height'

    height, width = MiniMagick::Image.open(file.file).dimensions
    model.update(height: height, width: width)
  end
end
