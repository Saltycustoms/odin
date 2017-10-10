class DesignVersion < ActiveResourceRecord
  self.site = "#{Figaro.env.locate_design_app}/api/v1"
  belongs_to :design
  belongs_to :visual
end
