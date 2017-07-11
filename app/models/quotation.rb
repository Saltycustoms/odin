class Quotation < ApplicationRecord
  belongs_to :deal, optional: true
  belongs_to :discount, optional: true
  belongs_to :job_request, optional: true
  has_many :quotation_lines, dependent: :destroy
  accepts_nested_attributes_for :quotation_lines, allow_destroy: true, reject_if: proc { |attributes| attributes.all? { |key, value| key == "_destroy" || value.blank? } }
  accepts_nested_attributes_for :discount
end
