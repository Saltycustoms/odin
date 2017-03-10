class Shipment < ApplicationRecord
  belongs_to :order
  belongs_to :shipping_method
  belongs_to :address
  before_save :set_amount
  before_update :set_amount
  monetize :amount_cents

  enum status: {start: 0, packing: 1, shipped: 2} do
    event :pack do
      transition :start => :packing
    end

    event :ship do
        transition :packing => :shipped
    end

  end

  def set_amount
    if start?
      self.amount_cents = 0
      if shipping_method
        calculated = shipping_method.calculate(order)
        if calculated
          self.amount_cents = calculated
        else
          self.shipping_method = possible_shipping_method.first
          raise "No Available Shipping Method" if !self.shipping_method
          self.amount_cents = self.shipping_method.calculate(order)
        end
      end
    end
    true
  end
end
