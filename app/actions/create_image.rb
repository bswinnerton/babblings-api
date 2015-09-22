class CreateImage
  attr_reader :existing_image, :image_being_processed, :url

  def self.perform(params)
    new(url: params[:url]).perform
  end

  def initialize(url:)
    @url = url
  end

  def perform
    return existing_image if existing_image?
    create_placeholder_image.tap { process_image_in_background }
  end

  def existing_image?
    @existing_image ||= Image.find_by(origin: url)
  end

  def create_placeholder_image
    @image_being_processed ||= Image.create!(origin: url, processing: true)
  end

  def process_image_in_background
    CreateImageWorker.perform_async(image_being_processed.id, url)
  end
end
