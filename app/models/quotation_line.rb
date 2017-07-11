class QuotationLine < ApplicationRecord
  belongs_to :quotation
  before_save :calculate_total
  validates :price_per_unit_cents, :quantity, :description, presence: true

  def calculate_total
    if self.price_per_unit_cents && self.quantity
      self.total_cents = self.price_per_unit_cents * self.quantity
    end
  end
end
