class Size < ActiveResource::Base
  self.site = "http://localhost:3003/api/v1/"
  belongs_to :product
end
