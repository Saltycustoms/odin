class Design < ActiveResource::Base
  self.site = "#{Figaro.env.locate_design_app}/api/v1/"
  has_many :design_requests
end
