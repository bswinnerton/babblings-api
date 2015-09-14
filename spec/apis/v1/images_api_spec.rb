require 'spec_helper'

RSpec.describe API::V1::ImagesAPI do
  describe 'GET /api/v1/images' do
    let!(:images) { create_list :image, 30, remote_source_url: Faker::Avatar.image }

    before { get '/api/v1/images', params }

    context 'first page' do
      let(:params) { }

      it 'returns the first 25 images' do
        image_ids = parsed_response.map { |image| image.fetch(:id) }
        expect(image_ids).to match_array images.last(25).map(&:id)
      end
    end

    context 'second page' do
      let(:params) { {page: 2} }

      it 'returns the last 5 images' do
        image_ids = parsed_response.map { |image| image.fetch(:id) }
        expect(image_ids).to match_array images.first(5).map(&:id)
      end
    end
  end

  describe 'GET /api/v1/images/:id' do
    let(:source) { 'http://i.imgur.com/d9S1zFo.jpg' }
    let!(:image) { create :image, remote_source_url: source }

    before { get "/api/v1/images/#{id}" }

    context 'with the image identifier' do
      let(:id) { image.id }

      it 'returns the image' do
        expect(parsed_response).to eq({
          id: image.id,
          content: image.source.url,
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
    let(:image) { create(:image) }

    before do
      allow(CreateImage).to receive(:perform).and_return image
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
        expect(parsed_response).to eq [
          {
            params: ['url'],
            messages: ['is missing', 'is empty']
          }
        ]
      end
    end
  end

  describe 'DELETE /api/v1/images/:id' do
    let(:make_request) { delete "/api/v1/images/", id: image.id }

    before { |spec| make_request unless spec.metadata[:skip_request] }

    context 'image already exists' do
      let!(:image) { create :image }

      it 'returns a 200 OK' do
        expect(response_code).to eq 200
      end

      it 'deletes the image', skip_request: true do
        expect { make_request }.to change { Image.count }.from(1).to(0)
      end
    end

    context 'image does not exist' do
      let(:image) { double(id: 1) }

      it 'returns a 404 not found' do
        expect(response_code).to eq 404
      end
    end
  end
end
