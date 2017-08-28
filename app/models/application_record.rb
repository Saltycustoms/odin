class ApplicationRecord < ActiveRecord::Base
  include NotificationHandler
  self.abstract_class = true
  has_paper_trail
end
