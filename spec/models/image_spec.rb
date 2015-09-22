require 'spec_helper'

RSpec.describe Image do
  let(:width) { 100 }
  let(:height) { 100 }

  subject { build_stubbed :image, width: width, height: height }

  describe '#reprocess!' do
    subject!(:image) do
      create :image, origin: 'http://i.imgur.com/1UJxgwf.jpg', processing: true
    end

    it 'resets the remote source url' do
      expect(image.source).to receive(:download!)
      subject.reprocess!
    end

    it 'sets processing to false' do
      subject.reprocess!
      expect(image.processing).to eq false
    end
  end

  describe '#content' do
    context 'source is set' do
      let(:source) { 'https://i.imgur.com/eWFJI2i.png' }

      before do
        allow(subject).to receive_message_chain(:source, :url).and_return source
      end

      it 'returns the url' do
        expect(subject.content).to eq source
      end
    end

    context 'source is not set' do
      it 'returns the placeholder' do
        expect(subject.content).to eq "http://placehold.it/#{width}x#{height}.png"
      end
    end
  end

  describe '#placeholder' do
    context 'width is set, height is not' do
      let(:height) { nil }

      it 'returns the placeholder with the set width and default height' do
        expect(subject.placeholder).to eq "http://placehold.it/#{width}x300.png"
      end
    end

    context 'height is set, width is not' do
      let(:width) { nil }

      it 'returns the placeholder with the set height and default width' do
        expect(subject.placeholder).to eq "http://placehold.it/300x#{height}.png"
      end
    end

    context 'width and height are set' do
      it 'returns the placeholder with the set width and height' do
        expect(subject.placeholder).to eq "http://placehold.it/#{width}x#{height}.png"
      end
    end

    context 'neither width nor height are set' do
      let(:width) { nil }
      let(:height) { nil }

      it 'returns the placeholder with the default width and height' do
        expect(subject.placeholder).to eq 'http://placehold.it/300x300.png'
      end
    end
  end
end
