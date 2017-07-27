class Transaction < ApplicationRecord
  belongs_to :deal
  monetize :value_cents
  validates :value, :gateway_id, presence: true
  belongs_to :gateway
  
  def amount
    if deal && deal.quotation && deal.quotation.currency.present?
      Money.new(value_cents, deal.quotation.currency)
    else
      value_cents
    end
  end
end
