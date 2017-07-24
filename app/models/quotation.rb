class Quotation < ApplicationRecord
  belongs_to :deal, optional: true
  belongs_to :discount, optional: true
  belongs_to :job_request, optional: true
  has_many :quotation_lines, dependent: :destroy
  has_many :add_ons, dependent: :destroy
  has_many :job_requests, through: :quotation_lines
  accepts_nested_attributes_for :add_ons, allow_destroy: true, reject_if: proc { |attributes| attributes.all? { |key, value| key == "_destroy" || value.blank? } }
  accepts_nested_attributes_for :job_requests, allow_destroy: true, reject_if: proc { |attributes| attributes.all? { |key, value| key == "_destroy" || value.blank? } }
  accepts_nested_attributes_for :quotation_lines, allow_destroy: true, reject_if: proc { |attributes| attributes.all? { |key, value| key == "_destroy" || value.blank? } }
  accepts_nested_attributes_for :discount, allow_destroy: true
  monetize :shipping_cents, with_model_currency: :currency
  monetize :discount_amount_cents, with_model_currency: :currency
  monetize :net_total_cents, with_model_currency: :currency
  monetize :sub_total_cents, with_model_currency: :currency
  monetize :tax_cents, with_model_currency: :currency
  after_save :calculate_total

  def calculate_total
    sub_total_cents = 0
    discount_amount_cents = 0
    tax_cents = 0

    self.quotation_lines.each do |line|
      sub_total_cents += line.total_cents if line.total
    end
    self.add_ons.each do |add_on|
      sub_total_cents += add_on.total_cents if add_on.total
    end

    if self.discount.type.present?
      discount_amount_cents = self.discount.type.constantize.new(value: self.discount.value).calculate(sub_total_cents)
    end

    taxable_cents = (sub_total_cents - discount_amount_cents) + self.shipping_cents

    if self.currency.present?
      case self.currency
      when "MYR"
        tax_cents = (taxable_cents * 0.06).round
      when "SGD"
        tax_cents = (taxable_cents * 0.07).round
      else
        tax_cents = 0
      end
    end

    net_total_cents = sub_total_cents + self.shipping_cents + tax_cents - discount_amount_cents

    self.update_columns(sub_total_cents: sub_total_cents, net_total_cents: net_total_cents, discount_amount_cents: discount_amount_cents, tax_cents: tax_cents, updated_at: DateTime.now)
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
end
