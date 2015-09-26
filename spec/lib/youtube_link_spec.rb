require 'spec_helper'

RSpec.describe YoutubeLink do
  let(:youtube_id) { 'WibmcsEGLKo' }

  subject { YoutubeLink.new(url) }

  describe '#id' do
    context 'clean desktop link' do
      let(:url) { "https://www.youtube.com/watch?v=#{youtube_id}" }

      it 'returns the YouTube video ID' do
        expect(subject.id).to eq youtube_id
      end
    end

    context 'desktop link with lots of query params' do
      let(:url) { "https://www.youtube.com/watch?index=12&v=#{youtube_id}&list=LLq9aDxj7rn4ZEWp9rxcEAnw" }

      it 'returns the YouTube video ID' do
        expect(subject.id).to eq youtube_id
      end
    end

    context 'mobile link' do
      let(:url) { "http://youtu.be/#{youtube_id}" }

      it 'returns the YouTube video ID' do
        expect(subject.id).to eq youtube_id
      end
    end
  end
end
