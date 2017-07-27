class Sample < ActiveResource::Base
  self.site = "#{Figaro.env.locate_procurement_app}/api/v1"
  belongs_to :project
end
