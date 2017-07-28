class Color < ActiveResource::Base
  self.site = "#{Figaro.env.locate_catalogue_app}/api/v1/"

  def display_name
    if pantone_code.present?
      "#{name} (#{pantone_code})"
    else
      "#{name}"
    end
  end
end
