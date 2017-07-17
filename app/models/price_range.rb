class PriceRange < ActiveResource::Base
  self.site = "#{Figaro.env.locate_catalogue_app}/api/v1/"
end
