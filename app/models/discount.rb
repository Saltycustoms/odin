class Discount < ApplicationRecord
  acts_as_paranoid
  belongs_to :deal, optional: true
  has_one :quotation
  before_save :update_deal_id
  validate :value_must_exist_if_type_exist
  validate :type_must_exist_if_value_exist


  def update_deal_id
    self.deal_id = self.quotation.deal_id
  end

  def value_must_exist_if_type_exist
    if self.type.present? && self.value.nil?
      errors.add(:value, "must exist")
    end
  end

  def type_must_exist_if_value_exist
    if self.type.empty? && self.value.present?
      errors.add(:type, "must exist")
    end
  end

  def info
    ""
  end
end
