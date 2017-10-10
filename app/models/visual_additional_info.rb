class VisualAdditionalInfo < ActiveResourceRecord
  self.site = "#{Figaro.env.locate_design_app}/api/v1/"
end
