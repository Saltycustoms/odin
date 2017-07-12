class Product < ActiveResource::Base
  self.site = "http://localhost:3003/api/v1/"
  has_many :sizes
  has_many :colors
  has_many :price_ranges
  
  def color_ids
    colors.collect { |c| c.id }
  end

  def size_ids
    sizes.collect { |s| s.id }
  end
end
