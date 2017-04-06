class Api::V1::SurfaceResource < JSONAPI::Resource
  attributes :image_data, :blank_id, :side, :width, :height,
             :width_mm, :height_mm, :top, :left, :safe_print_area_width_mm,
             :safe_print_area_height_mm, :image_original_url
  has_one :blank

  def image_original_url
    @model.image[:original].url
  end
end
