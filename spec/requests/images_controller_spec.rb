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
    it 'returns success' do
      post images_url, params: { image: { name: 'red', file: file } }
      expect(response).to be_success
    end
  end
end
