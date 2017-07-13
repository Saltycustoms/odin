class Quotation < ApplicationRecord
  belongs_to :deal, optional: true
  belongs_to :discount, optional: true
  belongs_to :job_request, optional: true
  has_many :quotation_lines, dependent: :destroy
  accepts_nested_attributes_for :quotation_lines, allow_destroy: true, reject_if: proc { |attributes| attributes.all? { |key, value| key == "_destroy" || value.blank? } }
  accepts_nested_attributes_for :discount
  monetize :shipping_cents, with_model_currency: :currency, :allow_nil => true
  monetize :net_total_cents, with_model_currency: :currency, :allow_nil => true
  monetize :sub_total_cents, with_model_currency: :currency, :allow_nil => true
  monetize :tax_cents, with_model_currency: :currency, :allow_nil => true
  before_save :calculate_total

  def calculate_total
    sub_total = 0
    self.quotation_lines.each do |line|
      sub_total += line.total_cents if line.total
    end
    self.sub_total_cents = sub_total
    self.net_total_cents = self.sub_total_cents + self.shipping_cents + self.tax_cents
  end
end
