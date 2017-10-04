json.extract! @product, :id, :name
json.blank @product.blank
json.sizes @product.size do |size|
    json.id size.id
    json.name size.name
ends
json.colors @product.colors do |color|
    json.id color.id
    json.name color.name
    json.hex color.hex
    json.pantone_code color.pantone_code
end
json.price_ranges @product.price_ranges do |price_range|
    json.id price_range.id
    json.from price_range.from
    json.to price_rang.to
    json.color_counts price_range.color_counts do |color_count|
        json.color_count color_count.color_count
        json.price_cents color_count.price_cents
    end
end
