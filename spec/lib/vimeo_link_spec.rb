require 'spec_helper'

RSpec.describe VimeoLink do
  let(:vimeo_id) { '2905022' }

  subject { VimeoLink.new(url) }

  describe '#id' do
    let(:url) { "https://vimeo.com/#{vimeo_id}" }

    it 'returns the Vimeo video ID' do
      expect(subject.id).to eq vimeo_id
    end
  end
end
