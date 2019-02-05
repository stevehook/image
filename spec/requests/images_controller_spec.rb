# frozen_string_literal: true

RSpec.describe ImagesController, type: :request do
  describe '#create' do
    it 'returns success' do
      file = fixture_file_upload(
        Rails.root.join('spec', 'fixtures', 'red.jpg'),
        'image/jpg'
      )
      post :create, params: { image: { name: 'red', file: file } }
    end
  end
end
