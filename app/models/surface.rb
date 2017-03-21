class Surface < ApplicationRecord
  belongs_to :blank
  require "image_processing/mini_magick"
  include ImageUploader[:image]
  enum side: { front: 0, back: 1 }
end
