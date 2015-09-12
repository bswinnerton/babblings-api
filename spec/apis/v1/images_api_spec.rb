require 'spec_helper'

RSpec.describe API::V1::ImagesAPI do
  let(:source) { 'http://i.imgur.com/d9S1zFo.jpg' }

  describe 'GET /api/v1/images' do
    let!(:images) { create_list :image, 3, remote_source_url: Faker::Avatar.image }

    before { get '/api/v1/images' }

    it 'returns all of the images' do
      image_ids = parsed_response.map { |image| image.fetch(:id) }
      expect(image_ids).to match_array images.map(&:id)
    end
  end

  describe 'GET /api/v1/images/:id' do
    let!(:image) { create :image, remote_source_url: source }

    before { get "/api/v1/images/#{id}" }

    context 'with the image identifier' do
      let(:id) { image.id }

      it 'returns the image' do
        expect(parsed_response).to eq({
          id: image.id,
          content: image.source.current_path,
          width: image.width,
          height: image.height,
          created_at: image.created_at.to_formatted_s(:iso8601),
          updated_at: image.updated_at.to_formatted_s(:iso8601),
        })
      end
    end
  end

  describe 'POST /api/v1/images' do
    let(:origin) { Faker::Avatar.image }

    before do
      allow(CreateImage).to receive(:perform).and_return double
      post '/api/v1/images', params
    end

    context 'with valid parameters' do
      let(:params) { {url: origin} }

      it 'creates the image' do
        expect(CreateImage).to have_received(:perform)
      end
    end

    context 'without valid parameters' do
      let(:params) { }

      it 'returns an error' do
        expect(parsed_response).to eq({
          errors: {
            url: [
              {error: 'is_missing'}
            ]
          }
        })
      end
    end
  end

  describe 'DELETE /api/v1/images/:id' do
    let(:make_request) { delete "/api/v1/images/", id: image.id }

    before { |spec| make_request unless spec.metadata[:skip_request] }

    context 'image already exists' do
      let!(:image) { create :image }

      it 'returns a 200 OK' do
        expect(last_response.status).to eq 200
      end

      it 'deletes the image', skip_request: true do
        expect { make_request }.to change { Image.count }.from(1).to(0)
      end
    end

    context 'image does not exist' do
      let(:image) { double(id: 1) }

      it 'returns a 404 not found' do
        expect(last_response.status).to eq 404
      end
    end
  end
end
