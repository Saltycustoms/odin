class DeliverySchedule < ActiveResourceRecord
  self.site = "#{Figaro.env.locate_procurement_app}/api/v1"
  belongs_to :deal
  belongs_to :design
end
