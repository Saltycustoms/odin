class Deal < ApplicationRecord
  has_many :job_requests
  belongs_to :department
end
