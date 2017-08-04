class Property < ApplicationRecord
  belongs_to :job_request
  validates :name, uniqueness: { scope: :job_request_id }
end
