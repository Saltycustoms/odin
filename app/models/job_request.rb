class JobRequest < ApplicationRecord
  # has_many :design_requests
  # has_many :designs, through: :design_requests
  has_many :quotation_lines
  has_many :add_ons
  belongs_to :deal
  has_many :print_details, dependent: :destroy
  jsonb_accessor :metadata,
    sizes: [:string],
    colors: [:string]
  accepts_nested_attributes_for :print_details, allow_destroy: true, reject_if: proc { |attributes| attributes.all? { |key, value| key == "_destroy" || value.blank? } }
  validates :product_id, :colors, :sizes, presence: true
  # after_save :find_or_initialize_quotation_and_lines

  def as_json(*)
    previous = super
    previous[:selected_colors] = selected_colors
    previous[:selected_sizes] = selected_sizes
    previous
  end

  def design_name
    job_request_designs = designs
    if job_request_designs.present?
      job_request_designs.first.name
    else
      ""
    end
  end

  def configurator_price_per_piece
    price_cents = 0
    product.price_ranges.each do |price_range|
      if quotation_lines.sum(:quantity).between?(price_range.from_quantity, price_range.to_quantity)
        price_cents = price_range.price_cents
      end
    end

    "#{product.currency} #{Money.new(price_cents, product.currency).to_i}"
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

  def selected_size_ids
    selected_sizes.collect { |s| s.id }
  end

  def selected_color_ids
    selected_colors.collect { |s| s.id }
  end

  def find_or_initialize_quotation_and_lines
    colors = selected_colors
    sizes = product.sizes
    quotation = Quotation.find_or_initialize_by(deal_id: deal.id)

    colors.each do |color|
      sizes.each do |size|
        quotation.quotation_lines.find_or_initialize_by(color_id: color.id, size_id: size.id, quotation: quotation, job_request_id: self.id)
      end
    end

    quotation.save

    color_ids = colors.collect { |c| c.id }
    quotation_color_ids = self.quotation_lines.pluck(:color_id).uniq

    (quotation_color_ids - color_ids).each do |unselected_color_id|
      self.quotation_lines.where(color_id: unselected_color_id).delete_all
    end
  end
end
