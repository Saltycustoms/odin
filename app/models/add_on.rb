class AddOn < ApplicationRecord
  belongs_to :job_request
  belongs_to :quotation
  monetize :price_per_unit_cents, with_model_currency: :currency
  monetize :total_cents, with_model_currency: :currency
  validates :description, :quantity, presence: true
  before_save :calculate_total
  before_update :calculate_total

  def calculate_total
    if self.price_per_unit_cents && self.quantity
      self.total_cents = self.price_per_unit_cents * self.quantity
    end
  end

  def display_price_per_unit
    currency = self.quotation.currency
    if currency
      Money.new(price_per_unit_cents, currency)
    else
      price_per_unit
    end
  end

  def display_total
    currency = self.quotation.currency
    if currency
      Money.new(total_cents, currency)
    else
      total
    end
  end
end
