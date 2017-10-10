class Employee < ActiveResourceRecord
  include RoleModel
  self.site = "#{Figaro.env.locate_employee_app}/api/v1/"
  roles_attribute :roles_mask
  roles :admin, :apparel_consultant, :creative, :logistic, :procurement, :director

  def notifications(params=nil)
    if params
      Notification.all(params: params)
    else
      Notification.where(target_id: self.id, target_type: self.model_name.name)
    end
  end
end
