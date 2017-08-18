class NotificationsController < ApplicationController
  def index
    employee = Employee.find(current_user.uid)
    @notifications = employee.notifications(q: { s: "id desc", target_id_eq: "#{employee.id}" })

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
