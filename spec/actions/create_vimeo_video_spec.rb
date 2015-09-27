require 'spec_helper'

RSpec.describe CreateVimeoVideo do
  let(:vimeo_id) { '122291819' }
  let(:vimeo_link) { instance_double(VimeoLink, id: vimeo_id) }
  let(:source) { "https://vimeo.com/#{vimeo_id}" }
  let(:params) { {source: source} }

  subject { CreateVimeoVideo.perform(params) }

  before do
    allow(VimeoLink)
      .to receive(:new)
      .with(source)
      .and_return(vimeo_link)
  end

  context 'new vimeo video' do
    it 'extracts the vimeo id' do
      subject
      expect(vimeo_link).to have_received(:id)
    end

    it 'creates the new video' do
      expect { subject }.to change { VimeoVideo.count }.by(1)
    end
  end

  context 'vimeo video already exists' do
    let(:vimeo_id) { 'ssf7P-Sgcrk' }
    let!(:video) { create :vimeo_video, vimeo_id: vimeo_id }

    it 'does not create a new video' do
      expect { subject }.to change { VimeoVideo.count }.by(0)
    end

    it 'returns the existing image' do
      expect(subject.vimeo_id).to eq vimeo_id
    end
  end
end
