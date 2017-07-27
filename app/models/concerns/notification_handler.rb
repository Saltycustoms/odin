module NotificationHandler
  extend ActiveSupport::Concern

  def label_with_model_name
    hash = self.attributes
    hash["notification.model_name"] = self.model_name.name
    hash["notification.model_plural"] = self.model_name.plural
    hash["notification.model_singular"] = self.model_name.singular
    hash["notification.application_name"] = "deal"
    hash
  end

  def notify_to(target, key, parameters)
    @notification = Notification.new(target_type: target.model_name.name,
                                     target_id: target.id,
                                     notify_type: self.model_name.name,
                                     notify_id: self.id,
                                     key: key,
                                     parameters: parameters)
    @notification.save
  end

  def notify_by(target, key, parameters)
    @notification = Notification.new(target_type: target.model_name.name,
                                     target_id: target.id,
                                     notifier_type: self.model_name.name,
                                     notifier_id: self.id,
                                     key: key,
                                     parameters: parameters)
    @notification.save
  end

  def foo
    puts "Foolamak"
  end
end
