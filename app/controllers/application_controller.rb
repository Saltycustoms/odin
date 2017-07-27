class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  # byebug
  # auth = request.env['omniauth.auth']
  # render json: auth.to_json
  def send_notification(model, controller)
    message = model.label_with_model_name
    message["notification.key"] = "#{model.model_name.singular}.#{controller.action_name}"
    message["notifier.name"] = "Employee"
    message["notifier.id"] = current_user.id
    NotificationService.notify(message)
  end
  helper_method :send_notification
end
