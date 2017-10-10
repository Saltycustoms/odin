class Project < ActiveResourceRecord
  self.site = "#{Figaro.env.locate_procurement_app}/api/v1"
  belongs_to :deal
  belongs_to :design
  has_many :samples
end
