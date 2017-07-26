class Visual < ActiveResource::Base
  self.site = "#{Figaro.env.locate_design_app}/api/v1"
  has_many :visual_prints

  def attachment_url
    if attachment_data
      "#{Figaro.env.locate_design_app}/uploads/store/#{JSON.parse(attachment_data)['id']}"
    end
  end
end
