class ImageUploader < Shrine
  require "image_processing/mini_magick"
  include ImageProcessing::MiniMagick
  plugin :default_url do |context|
    "public/images/default/no-image.svg"
  end
  plugin :processing
  plugin :versions   # enable Shrine to handle a hash of files
  plugin :delete_raw # delete processed files after uploading
  # plugins and uploading logic
  process(:store) do |io, context|
    original = io.download
    if ['image/jpeg','image/png','image/gif','image/jpg'].include? io.mime_type
      size_570 = resize_to_limit!(original, 570, -1)
      size_300 = resize_to_limit(size_570,  300, 300)
      {original: io, large: size_570, small: size_300}
    else
      {original: io, large: io.download, small: io.download}
    end
  end
end
