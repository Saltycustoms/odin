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

  def generate_link
    begin
      "#{Figaro.env.send("locate_"+ self.parameters.send("notification.application_name") +"_app")}/" +
      "#{self.parameters.send("notification.model_plural")}/#{self.notify_id}" +
      "?opened=1"
    rescue => err
      Rails.logger.info(err)
      false
    end
  end
end
