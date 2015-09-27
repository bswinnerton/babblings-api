require 'spec_helper'

RSpec.describe VimeoVideo do
  describe '#content' do
    let(:vimeo_id) { '63609012' }
    subject { create :vimeo_video, vimeo_id: vimeo_id }

    it 'returns the iframe of the YouTube video' do
      expect(subject.content).to eq "https://player.vimeo.com/video/#{vimeo_id}?portrait=0&byline=0&title=0"
    end
  end
end
