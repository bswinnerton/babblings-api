require 'spec_helper'

RSpec.describe CreateImage do
  let(:url) { 'http://i.imgur.com/6ureTNj.png' }
  let(:params) { {url: url} }

  subject { CreateImage.perform(params) }

  context 'new image' do
    it 'creates the image' do
      expect { subject }.to change { Image.count }.by(1)
    end

    it 'persists the original URL' do
      expect(subject.origin).to eq url
    end

    it 'sets the image as processing' do
      expect(subject.processing).to eq true
    end

    it 'enqueues the create image worker' do
      expect { subject }.to change(CreateImageWorker.jobs, :size).by(1)
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
