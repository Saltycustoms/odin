class Employee < ActiveResource::Base
  include RoleModel
  self.site = "#{Figaro.env.locate_employee_app}/api/v1/"
  roles_attribute :roles_mask
  roles :admin, :apparel_consultant, :creative, :logistic, :procurement, :director
end
