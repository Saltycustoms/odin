class Employee < ActiveResource::Base
  self.site = "#{Figaro.env.locate_employee_app}/api/v1/"
end
