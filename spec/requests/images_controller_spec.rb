# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImagesController, type: :request do
  let(:file) do
    fixture_file_upload(
      Rails.root.join('spec', 'fixtures', 'red.jpg'),
      'image/jpg'
    )
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

      it 'returns the id of the new Image' do
        post images_url, params: params
        expect(JSON.parse(response.body).symbolize_keys).to eq({ id: Image.last.id })
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
        end.not_to change { Image.count }
      end

      it 'returns error message' do
        post images_url, params: params
        expect(JSON.parse(response.body).symbolize_keys).to eq(name: ['can\'t be blank'])
      end
    end
  end
end
