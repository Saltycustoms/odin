class Sample < ActiveResource::Base
  include NotificationHandler
  self.site = "#{Figaro.env.locate_procurement_app}/api/v1"
  belongs_to :project
end
