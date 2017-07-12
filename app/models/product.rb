class Product < ActiveResource::Base
  self.site = "http://localhost:3003/api/v1/"
  has_many :sizes
  has_many :colors
end
