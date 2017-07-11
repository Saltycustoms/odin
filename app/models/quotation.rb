class Quotation < ApplicationRecord
  belongs_to :deal, optional: true
  belongs_to :discount, optional: true
  belongs_to :job_request, optional: true
end
