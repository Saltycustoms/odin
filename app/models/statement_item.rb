class StatementItem < ApplicationRecord
  belongs_to :statement
  monetize :price_per_unit_cents
  monetize :price_cents
end
