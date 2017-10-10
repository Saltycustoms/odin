class Size < ActiveResourceRecord
  self.site = "#{Figaro.env.locate_catalogue_app}/api/v1/"
  belongs_to :product
end
