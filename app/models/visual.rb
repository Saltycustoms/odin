class Visual < ActiveResource::Base
  self.site = "#{Figaro.env.locate_design_app}/api/v1"
  # has_many :visual_prints
  # has_many :visual_properties
  #
  # def visual_product
  #   VisualProduct.where(visual_id: self.id).first
  # end

  def attachment_url
    if attachment_data
      "#{Figaro.env.locate_design_app}/uploads/store/#{JSON.parse(attachment_data)['id']}"
    end
  end

  # [:pantone, :care_label, :measurement, :other_detail, :print_label].each do |info|
  #   define_method("#{info.to_s.pluralize}") {
  #     "VisualAdditionalInfo::#{info.to_s.classify}".constantize.where(visual_id: self.id)
  #   }
  # end
  #
  #
  # [:binding_collar, :backtape, :binding_sleeve,
  #   :double_needle_stitch, :pocket].each do |property|
  #   define_method("#{property}_visual_properties") {
  #     VisualProperty.where(property_type: property, visual_id: self.id)
  #   }
  # end
end
