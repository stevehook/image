# frozen_string_literal: true

class ImagesController < ApplicationController
  def create
    image = Image.new(image_create_params)

    if image.save
      render json: {}, status: :created
    else
      render json: image.errors, status: :unprocessable_entity
    end
  end

  private

  def image_create_params
    params.require(:image).permit(:name)
  end
end
