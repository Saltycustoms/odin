class JobRequest < ApplicationRecord
  # has_many :design_requests
  # has_many :designs, through: :design_requests
  belongs_to :deal
  has_many :print_details, dependent: :destroy
  jsonb_accessor :metadata,
    sizes: [:string],
    colors: [:string]
  accepts_nested_attributes_for :print_details, allow_destroy: true, reject_if: proc { |attributes| attributes.all? { |key, value| key == "_destroy" || value.blank? } }
  validates :product_id, :colors, :sizes, presence: true
  after_save :update_quotation_and_lines

  def as_json(*)
    previous = super
    previous[:selected_colors] = selected_colors
    previous[:selected_sizes] = selected_sizes
    previous
  end

  def designs
    @design_requests = DesignRequest.where(job_request_id: self.id)
    return [] if @design_requests.blank?
    @designs = Design.where(id: @design_requests.collect { |dr| dr.design_id })
    return @designs
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

  def price_per_piece
    quotation_lines.first.display_price_per_unit
  end

  def quotation_lines
    quotation = Quotation.find_by(deal_id: deal.id)
    lines = quotation.quotation_lines.order(id: :asc).select {|l| l.description.split("_").first == "#{self.id}"}
  end

  def quotation_lines_quantity
    sum = 0
    quotation_lines.each do |line|
      sum += line.quantity if line.quantity
    end
    return sum
  end

  def selected_size_ids
    selected_sizes.collect { |s| s.id }
  end

  def selected_color_ids
    selected_colors.collect { |s| s.id }
  end

  def update_quotation_and_lines
    quotation = Quotation.find_or_initialize_by(deal_id: deal.id)
    sizes = product.sizes
    colors = selected_colors
    colors.each do |color|
      sizes.each do |size|
        quotation.quotation_lines.find_or_initialize_by(description: "#{self.id}_product_#{product.name}_#{size.name}_#{color.name}")
      end
    end
    quotation.save
  end
end
