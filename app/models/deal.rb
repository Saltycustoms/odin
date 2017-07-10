class Deal < ApplicationRecord
  has_many :job_requests
  has_many :deadlines
  accepts_nested_attributes_for :deadlines, allow_destroy: true, reject_if: proc { |attributes| attributes.all? { |key, value| key == "_destroy" || value.blank? } }
  belongs_to :department
  validates :name, presence: true
  validates :department_id, presence: true

  def client_deadline
    last_deadline = deadlines.order(id: :desc).first
    if last_deadline
      last_deadline.deadline
    end
  end

  def display_name
    "#{name} - #{department.organization.name}, #{department.name}"
  end
end
