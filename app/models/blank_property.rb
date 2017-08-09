class BlankProperty < ActiveResource::Base
  self.site = "#{Figaro.env.locate_catalogue_app}/api/v1/"
  self.element_name = "property"
end
