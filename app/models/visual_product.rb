class VisualProduct < ActiveResource::Base
  self.site = "#{Figaro.env.locate_design_app}/api/v1/"
  has_many :visual_product_colors

  def product
    Product.find(self.product_id)
  end

  def colors
  #   @color_options = ColorOption.where(product_id: self.id)
  #   return [] if @color_options.blank?
  #   @colors = Color.where(id: @color_options.collect { |co_op| co_op.color_id})
  #   return @colors
    @color_ids = self.visual_product_colors.collect { |vpc| vpc.color_id }
    Color.where(id: @color_ids)
  end
end
