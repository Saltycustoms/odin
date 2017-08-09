class VisualProperty < ActiveResource::Base
  self.site = "#{Figaro.env.locate_design_app}/api/v1/"

  def property
    BlankProperty.find(self.property_id)
  end
end
