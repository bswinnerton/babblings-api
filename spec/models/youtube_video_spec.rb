require 'spec_helper'

RSpec.describe YoutubeVideo do
  describe '#content' do
    let(:youtube_id) { 'O0RU_Nyr4l4' }
    subject { create :youtube_video, youtube_id: youtube_id }

    it 'returns the iframe of the YouTube video' do
      expect(subject.content).to eq "https://www.youtube.com/embed/#{youtube_id}?showinfo=0&controls=0"
    end
  end
end
