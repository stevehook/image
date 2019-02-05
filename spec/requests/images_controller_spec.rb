# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImagesController, type: :request do
  describe '#create' do
    it 'returns success' do
      file = fixture_file_upload(
        Rails.root.join('spec', 'fixtures', 'red.jpg'),
        'image/jpg'
      )
      post images_url, params: { image: { name: 'red', file: file } }
    end
  end
end
