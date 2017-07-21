class AddOn < ApplicationRecord
  belongs_to :job_request
  belongs_to :quotation
  monetize :price_per_unit_cents, with_model_currency: :currency
  monetize :total_cents, with_model_currency: :currency
  validates :description, :quantity, presence: true
  before_save :calculate_total
  before_save :update_currency


  def calculate_total
    if self.price_per_unit_cents && self.quantity
      self.total_cents = self.price_per_unit_cents * self.quantity
    end
  end

  def update_currency
    if self.quotation.currency
      self.currency = self.quotation.currency
    end
  end
end
