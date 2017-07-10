class Deal < ApplicationRecord
  has_many :job_requests
  belongs_to :department
  validates :name, presence: true
  validates :department_id, presence: true
end
