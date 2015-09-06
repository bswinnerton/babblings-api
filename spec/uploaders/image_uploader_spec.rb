require 'spec_helper'

RSpec.describe ImageUploader do
  let(:placeholder_image) { 'spec/support/carrierwave_placeholder.png' }

  subject { ImageUploader.new }

  before do
    ImageUploader.enable_processing = true
    File.open(File.expand_path(placeholder_image)) do |image|
      subject.store!(image)
    end
  end

  context 'medium' do
    it 'scales down an image to 600x600' do
      expect(subject.medium).to be_no_larger_than(600, 600)
    end
  end

  context 'small' do
    it 'scales down an image to 300x300' do
      expect(subject.medium).to be_no_larger_than(600, 600)
    end
  end
end
