class ShippingZone < ApplicationRecord
  has_many :locations, class_name: 'ShippingZoneLocation', inverse_of: :shipping_zone
  accepts_nested_attributes_for :locations, allow_destroy: true
  has_many :shipping_methods, dependent: :destroy
end
