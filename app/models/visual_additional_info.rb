class VisualAdditionalInfo < ActiveResource::Base
  self.site = "#{Figaro.env.locate_design_app}/api/v1/"
end
