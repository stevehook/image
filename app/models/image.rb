# frozen_string_literal: true

class Image < ApplicationRecord
  validates :name, presence: true
  has_one_attached :file
end
