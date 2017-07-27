class Notification < ActiveResource::Base
  self.site = "#{Figaro.env.locate_employee_app}/api/v1/"

  def parameters_keys
    JSON.parse self.parameters
  end

  def parameters_to_hash
    JSON.parse self.parameters.to_json if self.parameters.class == Notification::Parameters
  end

  def target
    self.target_type.constantize.find(self.target_id)
  end

  def notifier
    self.notifier_type.constantize.find(self.notifier_id)
  end
end
