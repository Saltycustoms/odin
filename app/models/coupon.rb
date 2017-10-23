class Coupon < ApplicationRecord
  belongs_to :discount
  accepts_nested_attributes_for :discount, allow_destroy: true

  def valid?
    DateTime.now >= self.from && DateTime.now <= self.to
  end
end
