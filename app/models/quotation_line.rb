class QuotationLine < ApplicationRecord
  acts_as_paranoid
  belongs_to :quotation
  belongs_to :job_request
  before_save :calculate_total
  before_update :calculate_total
  monetize :price_per_unit_cents, with_model_currency: :currency, numericality: { greater_than_or_equal_to: 0 }
  monetize :total_cents, with_model_currency: :currency
  validates :quantity, numericality: {greater_than_or_equal_to: 0}
  before_save :save_description

  def currency
    if quotation
      quotation.currency
    end
  end

  def product
    Product.find(self.job_request.product_id)
  end

  def size
    Size.find(size_id)
  end

  def color
    Color.find(color_id)
  end

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

  def save_description
    self.description = "#{product.name}|#{size.name}|#{color.name}"
  end

  def product
    Product.find(product_id)
  end
end
