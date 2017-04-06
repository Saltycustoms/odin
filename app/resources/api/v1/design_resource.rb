class Api::V1::DesignResource < JSONAPI::Resource
  sides = Design.sides
  side_data = []
  sides.each do |side|
    side_data << ["#{side}_fg_x","#{side}_fg_y","#{side}_fg_width", "#{side}_fg_height",
                  "#{side}_fg_text_font", "#{side}_fg_text_color", "#{side}_fg_image_data",
                  "#{side}_fg_text_data","#{side}_fg_is_text", "#{side}_fg_attachment_id",
                  "#{side}_bg_x","#{side}_bg_y","#{side}_bg_width","#{side}_bg_height",
                  "#{side}_bg_image_data", "#{side}_bg_attachment_id"]
  end
  symbols = [:order_id]
  side_data.flatten.each do |side|
    symbols << side.to_sym
  end
  attributes *symbols
end
