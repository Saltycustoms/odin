class ApplicationRecord < ActiveRecord::Base
  include NotificationHandler
  self.abstract_class = true
end
