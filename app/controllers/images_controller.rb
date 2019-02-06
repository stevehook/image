# frozen_string_literal: true

class ImagesController < ApplicationController
  def create
    image = Image.new(image_create_params)

    if image.save
      render json: { id: image.id }, status: :created
    else
      render json: image.errors, status: :unprocessable_entity
    end
  end

  def show
    image = Image.find(params[:id])
    file = get_file_for(image, params[:format])
    send_data(
      file.download,
      filename: file.blob.filename,
      type: file.blob.content_type,
      disposition: 'inline'
    )
  end

  private

  def get_file_for(image, format)
    return image.file if format.blank?
    image.file.variant(format: format).processed
  end

  def image_create_params
    params.require(:image).permit(:name, :file)
  end
end
