class Transaction < ApplicationRecord
  belongs_to :deal
  monetize :value_cents
  validates :value, presence: true
  monetize :amount_cents

  def amount_cents
    if deal && deal.quotation && deal.quotation.currency.present?
      return Money.new(value_cents, deal.quotation.currency)
    else
      return value_cents
    end
  end
end
