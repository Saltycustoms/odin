class Design < ActiveResource::Base
  self.site = "#{Figaro.env.locate_design_app}/api/v1/"
  has_many :design_requests
  belongs_to :version_for_production, class_name: "Version"

  def version_for_production_image_url
    visual = version_for_production.visual
    if visual.manual?
      return visual.attachment_url
    else
      visual.visual_prints.each do |visual_print|
        if visual_print.artwork_data
          return visual_print.artwork_url
        end
      end
    end
  end
end
