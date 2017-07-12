class Discount < ApplicationRecord
  belongs_to :deal, optional: true
  has_one :quotation
  before_save :update_deal_id

  def update_deal_id
    self.deal_id = self.quotation.deal_id
  end
end
