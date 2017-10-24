class Sample < ActiveResourceRecord
  include NotificationHandler
  self.site = "#{Figaro.env.locate_procurement_app}/api/v1"
  belongs_to :project

  def deal_name
    project = self.project
    "#{project.deal_id}##{project.deal_name}"
  end
end
