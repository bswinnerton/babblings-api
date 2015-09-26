require 'spec_helper'

RSpec.describe CreateYoutubeVideo do
  let(:youtube_id) { 'F5FEj9U-CJM' }
  let(:youtube_link) { instance_double(YoutubeLink, id: youtube_id) }
  let(:source) { "https://www.youtube.com/watch?v=#{youtube_id}" }
  let(:params) { {source: source} }

  subject { CreateYoutubeVideo.perform(params) }

  before do
    allow(YoutubeLink)
      .to receive(:new)
      .with(source)
      .and_return(youtube_link)
  end

  context 'new youtube video' do
    it 'extracts the youtube id' do
      subject
      expect(youtube_link).to have_received(:id)
    end

    it 'creates the new video' do
      expect { subject }.to change { YoutubeVideo.count }.by(1)
    end
  end

  context 'youtube video already exists' do
    let(:youtube_id) { 'ssf7P-Sgcrk' }
    let!(:video) { create :youtube_video, youtube_id: youtube_id }

    it 'does not create a new video' do
      expect { subject }.to change { YoutubeVideo.count }.by(0)
    end

    it 'returns the existing image' do
      expect(subject.youtube_id).to eq youtube_id
    end
  end
end
