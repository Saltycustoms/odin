class PriceRange < ActiveResourceRecord
  self.site = "#{Figaro.env.locate_catalogue_app}/api/v1/"
  has_many :color_counts
end
