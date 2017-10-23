class Deal < ApplicationRecord
  acts_as_paranoid
  # will use taggable to tag if this is a configurator deal or enterprise deal
  acts_as_taggable
  has_one :quotation
  has_one :discount, dependent: :destroy
  has_many :job_requests, dependent: :destroy
  has_many :packing_lists, dependent: :destroy
  has_many :packing_list_items, through: :packing_lists
  has_many :deadlines, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :add_ons, through: :job_requests
  has_many :quotation_lines, through: :job_requests
  # has_many :approvals
  accepts_nested_attributes_for :deadlines, allow_destroy: true, reject_if: proc { |attributes| attributes.all? { |key, value| key == "_destroy" || value.blank? } }
  belongs_to :department, optional: true
  belongs_to :organization, optional: true
  belongs_to :pic, optional: true
  validates :name, :employee_id, presence: true
  before_save :update_dept_and_org

  # def as_json(*)
  #   previous = super
    # previous[:display_name] = display_name
    # previous[:client_deadline] = client_deadline
    # previous[:quotation_lines] = quotation_lines
    # previous[:quotation] = quotation
    # previous[:employee] = employee
    # previous[:has_pending_job_requests?] = has_pending_job_requests?
    # previous[:has_pending_designs?] = has_pending_designs?
    # previous[:has_pending_quotations?] = has_pending_quotations?
    # previous[:has_pending_designs_for_job_requests?] = has_pending_designs_for_job_requests?
    # previous[:has_pending_delivery_schedules?] = has_pending_delivery_schedules?
    # previous[:has_pending_projects_for_designs?] = has_pending_projects_for_designs?
    # previous[:has_pending_approval?] = has_pending_approval?
    # previous[:has_pending_initial_payments?] = has_pending_initial_payments?
    # previous[:has_pending_sample_comment_from_ac?] = has_pending_sample_comment_from_ac?
    # previous[:has_pending_sample_comment_from_creative?] = has_pending_sample_comment_from_creative?
    # previous[:has_pending_shipping?] = has_pending_shipping?
    # previous[:has_pending_packing_lists?] = has_pending_packing_lists?
    # previous[:has_pending_deadline?] = has_pending_deadline?
  #   previous
  # end

  def approvals
    Approval.where(deal_id: self.id)
  end

  def employee
    Employee.find(employee_id)
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

  def delivery_schedules
    DeliverySchedule.where(deal_id: self.id)
  end

  def display_name
    "#{name} - #{department.organization.name}, #{department.name}"
  end

  def designs
    Design.where(deal_id: self.id)
  end

  def has_designs_with_design_version_for_production?
    designs.any? { |d| d.design_version_for_production }
  end

  def designs_with_design_version_for_production
    designs.select { |d| d.design_version_for_production }
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

  def projects
    Project.where(deal_id: self.id)
  end

  #conditions function goes here
  def has_pending_job_requests?
    !self.job_requests.present?
  end

  def has_pending_designs?
    !self.designs.present?
  end

  def has_pending_quotations?

  end

  def has_pending_designs_for_job_requests?
    return true if self.job_requests.blank?
    self.job_requests.each do |job_request|
      return true if DesignRequest.where(job_request_id: job_request.id).blank?
    end
    false
  end

  def has_pending_delivery_schedules?
    return true if self.delivery_schedules.blank?
    @ds_designs = self.delivery_schedules.collect { |ds| ds.design_id }
    @designs = self.designs.collect { |design| design.id }
    @pending_designs = @designs - @ds_designs
    @pending_designs.present?
  end

  def has_pending_projects_for_designs?
    return true if self.projects.blank?
    @project_designs = self.projects.collect { |project| project.design_id }
    @designs = self.designs.collect { |design| design.id }
    @pending_designs = @designs - @project_designs
    @pending_designs.present?
  end

  def has_pending_approval?
    self.approvals.where(status: "pending").present?
  end

  def has_pending_initial_payments?
    !self.transactions.present?
  end

  def has_pending_sample_comment_from_ac?
    self.projects.each do |project|
      # sample = project.samples.order(id: :asc).last
      sample = project.samples.last
      return true if sample && sample.ac_comments.blank?
    end
    false
  end

  def has_pending_sample_comment_from_creative?
    self.projects.each do |project|
      # sample = project.samples.order(id: :asc).last
      sample = project.samples.last
      return true if sample && sample.creative_comments.blank?
    end
    false
  end

  def has_pending_shipping?
    return true if self.delivery_schedules.blank?
    self.delivery_schedules.each do |delivery_schedule|
      return true if delivery_schedule.date_out.nil?
    end
    false
  end

  def has_pending_packing_lists?
    self.packing_lists.blank?
  end

  def has_pending_deadline?
    self.deadlines.blank?
  end

  def has_quotation
    quotation.present?
  end

  def rush_order?
    return false if deadlines.blank? || !deadlines.order(id: :desc).take.rush_order
    true
  end
end
