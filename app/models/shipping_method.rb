class ShippingMethod < ApplicationRecord
  belongs_to :shipping_zone
  belongs_to :calculator

  def possible?(order)
    zone_location = shipping_zone.locations.where(country_code: order.shipping_address.country_code, state: ['',nil, order.shipping_address.state ])
    zone_location.exists?
  end

  def calculate(order=nil)
    if order.nil?
      calculator.calculate
    else
      return false if !possible?(order)
      calculator.calculate(amount_cents: order.subtotal_cents)
    end
  end
end
