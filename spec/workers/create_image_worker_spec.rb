require 'spec_helper'

RSpec.describe CreateImageWorker do
  let(:url) { 'http://i.imgur.com/XZwUFqM.jpg' }
  let(:image) { create :image, remote_source_url: nil }

  subject { CreateImageWorker.new }

  it 'downloads the image', uploader_requests_enabled: true, vcr: true do
    path = "#{ImageUploader.root}/#{ImageUploader::BASE_STORAGE_PATH}/*/*.*"
    expect { subject.perform(image.id, url) }.to change { Dir[path].count }.by(3)
  end
end
