class Acknowledger < ActiveResourceRecord
  self.site = "#{Figaro.env.locate_employee_app}/api/v1/"
  belongs_to :approval
end
