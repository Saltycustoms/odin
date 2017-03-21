json.array! @blanks do |blank|
  json.extract! blank, :id, :name, :price_cents
  json.surfaces blank.surfaces do |surface|
    json.extract! surface, :id, :image_data, :width, :height, :width_mm, :height_mm, :top, :left
  end
end
