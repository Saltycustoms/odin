class QuotationLine < ApplicationRecord
  belongs_to :quotation
  belongs_to :job_request
  before_save :calculate_total
  before_save :update_currency
  monetize :price_per_unit_cents, with_model_currency: :currency
  monetize :total_cents, with_model_currency: :currency

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

  def update_currency
    if self.quotation.currency
      self.currency = self.quotation.currency
    end
  end

  def display_name
    "#{product.name} #{color.name} #{size.name}"
  end
end
