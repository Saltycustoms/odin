module NotificationHandler
  extend ActiveSupport::Concern

  def label_with_model_name
    hash = self.attributes
    hash["notification.model_name"] = self.model_name.name
    hash["notification.model_plural"] = self.model_name.plural
    hash["notification.model_singular"] = self.model_name.singular
    #application name follow figaro, as it will get the domain to each app base on application name
    hash["notification.application_name"] = "deal"
    hash
  end
end
