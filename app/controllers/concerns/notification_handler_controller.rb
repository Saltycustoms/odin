module NotificationHandlerController
  extend ActiveSupport::Concern

  included do
    def send_notification(model, controller)
      user = Employee.where(q: {email_eq: current_user.email}).first
      message = model.label_with_model_name
      message["notification.key"] = "#{model.model_name.singular}.#{controller.action_name}"
      message["notifier.name"] = "Employee"
      message["notifier.id"] = user.id
      NotificationService.notify(message)
    end

    def open_notification(model, controller, user)
      user = Employee.where(q: {email_eq: user.email}).first
      notifications = Notification.all(params: {
                        q:{
                          target_id_eq: user.id,
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
