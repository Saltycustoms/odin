class Approval < ActiveResource::Base
  self.site = "#{Figaro.env.locate_employee_app}/api/v1/"
  has_many :acknowledgers
  has_many :approvers
  attr_accessor :acknowledger_ids, :approver_ids

  def pending?
    status == "pending"
  end
end
