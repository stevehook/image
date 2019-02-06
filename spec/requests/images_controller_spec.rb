# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe ImagesController, type: :request do
  let(:file_path) { Rails.root.join('spec', 'fixtures', 'red.jpg') }
  let(:file) { fixture_file_upload(file_path, 'image/jpg') }

  describe '#show' do
    context 'with a valid image id' do
      let(:image) { Image.create(name: 'red', file: file) }

      it 'returns success code' do
        get image_url(id: image.id)
        expect(response).to be_successful
      end

      let(:expected_response_body) { File.read(file_path) }
      it 'returns the image file' do
        get image_url(id: image.id)
        expect(response.body.bytes).to eq expected_response_body.bytes
      end
    end

    context 'with an invalid image id' do
      let(:image) { Image.create(name: 'red', file: file) }

      it 'returns not found' do
        get image_url(id: image.id + 1)
        expect(response).to be_not_found
      end
    end
  end

  describe '#create' do
    context 'with valid input params' do
      let(:params) { { image: { name: 'red', file: file } } }

      it 'returns success' do
        post images_url, params: params
        expect(response).to be_successful
      end

      it 'creates an image record' do
        expect do
          post images_url, params: params
        end.to change { Image.count }.by(1)
      end

      it 'creates an attachment record' do
        expect do
          post images_url, params: params
        end.to change { ActiveStorage::Attachment.count }.by(1)
      end

      it 'returns the id of the new Image' do
        post images_url, params: params
        expect(JSON.parse(response.body).symbolize_keys).to eq(id: Image.last.id)
      end
    end

    context 'with invalid input params' do
      let(:params) { { image: { title: 'red', file: file } } }

      it 'returns success' do
        post images_url, params: params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'creates an image record' do
        expect do
          post images_url, params: params
        end.not_to(change { Image.count })
      end

      it 'creates an attachment record' do
        expect do
          post images_url, params: params
        end.not_to(change { ActiveStorage::Attachment.count })
      end

      it 'returns error message' do
        post images_url, params: params
        expect(JSON.parse(response.body).symbolize_keys).to eq(name: ['can\'t be blank'])
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
