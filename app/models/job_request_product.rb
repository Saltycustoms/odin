class JobRequestProduct < ApplicationRecord
  belongs_to :job_request
  validates :product_id, presence: true
  jsonb_accessor :metadata,
    sizes: [:string],
    colors: [:string]

  def as_json(*)
    previous = super
    previous[:selected_colors] = selected_colors
    previous[:selected_sizes]  = selected_sizes
    previous[:product] = product
    previous
  end

  def product
    Product.find(product_id) if product_id
  end

  def selected_sizes
    if sizes && JSON.parse(sizes).reject { |s| s.empty? }.present?
      Size.where(id: JSON.parse(sizes))
    else
      []
    end
  end

  def selected_colors
    if colors && JSON.parse(colors).reject { |c| c.empty? }.present?
      Color.where(id: JSON.parse(colors))
    else
      []
    end
  end

  def selected_size_ids
    selected_sizes.collect { |s| s.id }
  end

  def selected_color_ids
    selected_colors.collect { |s| s.id }
  end
end
