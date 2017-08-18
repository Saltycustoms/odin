module NotificationHandlerController
  extend ActiveSupport::Concern

  included do
    def send_notification(model, controller)
      message = model.label_with_model_name
      message["notification.key"] = "#{model.model_name.singular}.#{controller.action_name}"
      message["notifier.name"] = "Employee"
      message["notifier.id"] = current_user.uid
      NotificationService.notify(message)
    end

    def open_notification(model, controller, user)
      notifications = Notification.all(params: {
                        q:{
                          target_id_eq: user.uid,
                          target_type_eq: "Employee",
                          notify_type_eq: model.model_name.name,
                          notify_id_eq: model.id,
                          opened_at_null: true
                        }
                      })
      notifications.each do |notification|
        notification.opened_at = Time.now
        notification.save
      end
    end

    helper_method :send_notification
    helper_method :open_notification
  end
end
