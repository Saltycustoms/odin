class Quotation < ApplicationRecord
  belongs_to :deal
  belongs_to :discount
  belongs_to :job_request
end
