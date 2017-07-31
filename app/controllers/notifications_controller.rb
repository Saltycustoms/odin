class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications(q: { s: "id desc" })
    # @unopened_notifications = @notifications.where(opened_at: nil)
    # @unopened_notifications.update_all(opened_at: Time.now)
  end
end
