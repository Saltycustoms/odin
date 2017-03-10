class Statement < ApplicationRecord
  belongs_to :order
  monetize :shipment_total_cents, with_model_currency: :currency
  monetize :subtotal_cents, with_model_currency: :currency
  monetize :net_total_cents, with_model_currency: :currency
  monetize :tax_cents, with_model_currency: :currency
  monetize :grand_total_cents, with_model_currency: :currency
end
