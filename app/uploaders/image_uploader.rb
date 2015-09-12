class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process :store_dimensions

  version(:medium)  { process resize_to_fill: [600, 600] }
  version(:small)   { process resize_to_fill: [300, 300] }

  def store_dir
    "uploads/#{ENV.fetch('RACK_ENV')}/images/"
  end

  def cache_dir
    "uploads/#{ENV.fetch('RACK_ENV')}/images/tmp/"
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
