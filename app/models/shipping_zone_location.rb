class ShippingZoneLocation < ApplicationRecord
  belongs_to :shipping_zone, inverse_of: :locations
end
