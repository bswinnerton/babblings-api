class CreateImageWorker
  include Sidekiq::Worker

  def perform(image_id, url)
    image = Image.find(image_id)
    image.update!(processing: false, remote_source_url: url)
  end
end
