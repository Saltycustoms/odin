class Quotation < ApplicationRecord
  acts_as_paranoid
  belongs_to :deal, optional: true
  belongs_to :discount, optional: true
  validates :currency, presence: true
  has_many :quotation_lines, dependent: :destroy
  has_many :add_ons, dependent: :destroy
  has_many :job_requests, through: :quotation_lines
  accepts_nested_attributes_for :add_ons, allow_destroy: true, reject_if: proc { |attributes| attributes.all? { |key, value| key == "_destroy" || value.blank? } }
  accepts_nested_attributes_for :quotation_lines, allow_destroy: true, reject_if: proc { |attributes| attributes.all? { |key, value| key == "_destroy" || value.blank? } }
  accepts_nested_attributes_for :discount, allow_destroy: true
  monetize :shipping_cents, with_model_currency: :currency
  monetize :discount_amount_cents, with_model_currency: :currency
  monetize :net_total_cents, with_model_currency: :currency
  monetize :sub_total_cents, with_model_currency: :currency
  monetize :tax_cents, with_model_currency: :currency
  # after_save :calculate_total
  before_save :calculate_total

  def calculate_total
    sub_total_cents = 0
    discount_amount_cents = 0
    tax_cents = 0

    self.quotation_lines.each do |line|
      sub_total_cents += (line.quantity * line.price_per_unit_cents)
    end
    self.add_ons.each do |add_on|
      next if add_on.marked_for_destruction?
      sub_total_cents += (add_on.quantity * add_on.price_per_unit_cents)
    end

    if self.discount && self.discount.type.present?
      discount_amount_cents = self.discount.type.constantize.new(value: self.discount.value).calculate(sub_total_cents)
    end
    taxable_cents = (sub_total_cents - discount_amount_cents) + self.shipping_cents

    tax_cents = calculate_tax_cents(self.currency, taxable_cents)

    self.tax_cents = tax_cents
    self.sub_total_cents = sub_total_cents
    self.discount_amount_cents = discount_amount_cents
    self.net_total_cents = self.sub_total_cents + self.shipping_cents + self.tax_cents - self.discount_amount_cents
  end

  def tax_info
    case self.currency
    when "MYR"
      "6%"
    when "SGD"
      "7%"
    else
      "0%"
    end
  end


  def calculate_tax_cents(currency, taxable_cents)
    case currency
    when "MYR"
      (taxable_cents * 0.06).round
    when "SGD"
      (taxable_cents * 0.07).round
    else
      0
    end
  end
end
