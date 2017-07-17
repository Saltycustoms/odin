class Size < ActiveResource::Base
  self.site = "#{Figaro.env.locate_catalogue_app}/api/v1/"
  belongs_to :product
end
