require 'spec_helper'

RSpec.describe API::V1::YoutubeVideosAPI do
  describe 'GET /api/v1/youtube-videos' do
    let!(:videos) { create_list :youtube_video, 30  }

    before { get '/api/v1/youtube-videos', params }

    context 'first page' do
      let(:params) { }

      it 'returns the first 25 videos' do
        video_ids = parsed_response.map { |video| video.fetch(:id) }
        expect(video_ids).to match_array videos.last(25).map(&:id)
      end
    end

    context 'second page' do
      let(:params) { {page: 2} }

      it 'returns the last 5 videos' do
        video_ids = parsed_response.map { |video| video.fetch(:id) }
        expect(video_ids).to match_array videos.first(5).map(&:id)
      end
    end
  end

  describe 'GET /api/v1/youtube-videos/:id' do
    let!(:video) { create :youtube_video }

    before { get "/api/v1/youtube-videos/#{id}" }

    context 'with the video id' do
      let(:id) { video.id }

      it 'returns the video' do
        expect(parsed_response).to eq({
          id: video.id,
          content: video.content,
          created_at: video.created_at.to_formatted_s(:iso8601),
          updated_at: video.updated_at.to_formatted_s(:iso8601),
        })
      end
    end
  end

  describe 'POST /api/v1/youtube-videos' do
    let(:source) { 'https://www.youtube.com/watch?v=tIdIqbv7SPo' }
    let(:video) { create :youtube_video }

    before do
      allow(CreateYoutubeVideo).to receive(:perform).and_return video
      post '/api/v1/youtube-videos', params
    end

    context 'with valid parameters' do
      let(:params) { {source: source} }

      it 'creates the video' do
        expect(CreateYoutubeVideo).to have_received(:perform)
      end
    end

    context 'without valid parameters' do
      let(:params) { }

      it 'returns an error' do
        expect(parsed_response).to eq [
          {
            params: ['source'],
            messages: ['is missing', 'is empty']
          }
        ]
      end
    end
  end

  describe 'DELETE /api/v1/youtube-videos/:id' do
    let(:make_request) { delete "/api/v1/youtube-videos/", id: video.id }

    before { |spec| make_request unless spec.metadata[:skip_request] }

    context 'video already exists' do
      let!(:video) { create :youtube_video }

      it 'returns a 200 OK' do
        expect(response_code).to eq 200
      end

      it 'deletes the video', skip_request: true do
        expect { make_request }.to change { YoutubeVideo.count }.from(1).to(0)
      end
    end

    context 'video does not exist' do
      let(:video) { double(id: 1) }

      it 'returns a 404 not found' do
        expect(response_code).to eq 404
      end
    end
  end
end
