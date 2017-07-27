class Deal < ApplicationRecord
  include NotificationHandler
  has_one :quotation
  has_many :job_requests
  has_many :packing_lists
  has_many :packing_list_items, through: :packing_lists
  has_many :deadlines, dependent: :destroy
  has_many :transactions
  has_many :add_ons, through: :job_requests
  has_many :quotation_lines, through: :job_requests
  # has_many :approvals
  accepts_nested_attributes_for :deadlines, allow_destroy: true, reject_if: proc { |attributes| attributes.all? { |key, value| key == "_destroy" || value.blank? } }
  belongs_to :department, optional: true
  belongs_to :organization, optional: true
  belongs_to :pic, optional: true
  validates :name, presence: true
  before_save :update_dept_and_org

  def approvals
    Approval.where(deal_id: self.id)
  end

  def update_dept_and_org
    self.department_id = self.pic.belongable.id
    self.organization_id = self.pic.belongable.organization.id
  end

  def client_deadline
    last_deadline = deadlines.order(id: :desc).first
    if last_deadline
      last_deadline.deadline
    end
  end

  def display_name
    "#{name} - #{department.organization.name}, #{department.name}"
  end

  def designs
    Design.where(deal_id: self.id)
  end

  def has_designs_with_version_for_production?
    designs.any? { |d| d.version_for_production }
  end

  def designs_with_version_for_production
    designs.select { |d| d.version_for_production }
  end

  def job_requests_with_designs
    job_requests.select {|j| j.designs.present?}
  end

  def remaining_amount
    if quotation && quotation.currency.present?
      quotation.net_total - paid_amount
    else
      0
    end
  end

  def paid_amount
    if quotation && quotation.currency.present?
      Money.new(transactions.sum(:value_cents), quotation.currency)
    else
      transactions.sum(:value_cents)
    end
  end
end
