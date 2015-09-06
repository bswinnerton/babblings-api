require 'spec_helper'

RSpec.describe CreateImage do
  let(:url) { 'http://i.imgur.com/6ureTNj.png' }
  let(:params) { {url: url} }

  subject { CreateImage.perform(params) }

  before { allow_any_instance_of(ImageUploader).to receive(:download!) }

  context 'new image' do
    it 'creates the image' do
      expect { subject }.to change { Image.count }.by(1)
    end

    it 'persists the original URL' do
      expect(subject.origin).to eq url
    end

    it 'sets a URL to view the uploaded image' do
      expect(subject.source).to_not be_nil
    end
  end

  context 'image already exists' do
    before { CreateImage.perform(params) }

    it 'does not create a new image' do
      expect { subject }.to change { Image.count }.by(0)
    end

    it 'returns the existing image' do
      expect(subject.origin).to eq url
    end
  end
end
