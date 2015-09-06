require 'spec_helper'

RSpec.describe CreateImage do
  let(:content) { 'http://i.imgur.com/6ureTNj.png' }
  let(:params) { {content: content} }

  subject { CreateImage.perform(params) }

  context 'new image' do
    it 'creates the image' do
      expect { subject }.to change { Image.count }.by(1)
    end

    it 'returns the newly created image' do
      expect(subject.content).to eq content
    end
  end

  context 'image already exists' do
    before { Image.create(content: content) }

    it 'does not create a new image' do
      expect { subject }.to change { Image.count }.by(0)
    end

    it 'returns the existing image' do
      expect(subject.content).to eq content
    end
  end
end
