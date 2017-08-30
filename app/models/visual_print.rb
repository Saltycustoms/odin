class VisualPrint < ActiveResource::Base
  self.site = "#{Figaro.env.locate_design_app}/api/v1"

  # def artwork_url
  #   if artwork_data
  #     "#{Figaro.env.locate_design_app}/uploads/store/#{JSON.parse(artwork_data)['id']}"
  #   end
  # end
end
