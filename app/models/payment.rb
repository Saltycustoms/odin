class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :gateway
  monetize :amount_cents
end
