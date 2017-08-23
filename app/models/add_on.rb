class AddOn < ApplicationRecord
  acts_as_paranoid
  belongs_to :job_request
  belongs_to :quotation
  monetize :price_per_unit_cents, with_model_currency: :currency
  monetize :total_cents, with_model_currency: :currency
  validates :description, presence: true
  validates :quantity, numericality: {greater_than_or_equal_to: 0}

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
