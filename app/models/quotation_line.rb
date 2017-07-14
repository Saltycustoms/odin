class QuotationLine < ApplicationRecord
  belongs_to :quotation
  before_save :calculate_total
  monetize :price_per_unit_cents, :allow_nil => true
  monetize :total_cents, :allow_nil => true

  def calculate_total
    if self.price_per_unit_cents && self.quantity
      self.total_cents = self.price_per_unit_cents * self.quantity
    end
  end

  def display_name
    if description
      if description.split("_").size > 1
        return description.split("_").drop(2).join(", ")
      else
        return description
      end
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
