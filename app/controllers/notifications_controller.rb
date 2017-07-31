class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications(q: { s: "id desc" })
    # @unopened_notifications = @notifications.all(params: {
    #                             q: {
    #                               opened_at_null: true
    #                             }
    #                           })
    # @unopened_notifications.each do |notification|
    #   notification.opened_at = Time.now
    #   notification.save
    # end
  end
end
