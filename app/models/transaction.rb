class Transaction < ApplicationRecord
  acts_as_paranoid
  belongs_to :deal
  monetize :value_cents
  validates :value, :gateway_id, presence: true
  belongs_to :gateway
  #set value make Transaction new must specify deal_id
  after_initialize :set_value
  enum status: {pending: 0, succeeded: 1, failed: 2, cancelled: 3} do
    event :success do
      transition :pending => :succeeded
    end

    event :fail do
        transition :pending => :failed
    end

    event :cancel do
      transition all - [:cancelled] => :cancelled
    end
  end

  def amount
    if deal && deal.quotation && deal.quotation.currency.present?
      Money.new(value_cents, deal.quotation.currency)
    else
      value_cents
    end
  end

  def set_value
    self.value = deal.remaining_amount if self.new_record?
    true
  end
end
