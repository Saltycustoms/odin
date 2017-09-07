class JobRequest < ApplicationRecord
  acts_as_paranoid
  # has_many :design_requests
  # has_many :designs, through: :design_requests
  has_many :quotation_lines
  has_many :add_ons
  has_many :attachments, as: :attachable, dependent: :destroy
  belongs_to :deal
  has_many :print_details, dependent: :destroy
  has_many :job_request_properties, dependent: :destroy
  jsonb_accessor :metadata,
    sizes: [:string],
    colors: [:string]
  accepts_nested_attributes_for :print_details, allow_destroy: true, reject_if: proc { |attributes| attributes.all? { |key, value| key == "_destroy" || value.blank? } }
  accepts_nested_attributes_for :job_request_properties, allow_destroy: true, reject_if: proc { |attributes| attributes.all? { |key, value| key == "_destroy" || value.blank? } }
  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: proc { |attributes| attributes.all? { |key, value| key == "_destroy" || value.blank? } }
  validates :product_id, :colors, :name, :sizes, presence: true
  before_save :update_quotation_and_lines
  before_save :update_artwork

  def as_json(*)
    previous = super
    previous[:selected_colors] = selected_colors
    previous[:selected_sizes] = selected_sizes
    previous[:attachments] = attachments
    previous[:product] = product
    previous
  end

  def design_name
    job_request_designs = designs
    if job_request_designs.present?
      job_request_designs.first.name
    else
      name
    end
  end

  def configurator_price_per_piece
    price_cents = 0
    product.price_ranges.each do |price_range|
      if quotation_lines.sum(:quantity).between?(price_range.from_quantity, price_range.to_quantity)
        price_cents = price_range.price_cents
      end
    end

    "#{product.currency} #{Money.new(price_cents, product.currency)}"
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

  def update_quotation_and_lines
    if quotation_lines.present?
      quotation_color_ids = quotation_lines.pluck(:color_id).uniq
      quotation_size_ids = quotation_lines.pluck(:size_id).uniq

      quotation = quotation_lines.take.quotation

      job_request_color_ids = selected_color_ids
      job_request_size_ids = selected_size_ids

      #create new quotation line if job request select new color or size when update job request
      job_request_color_ids.each do |color_id|
        job_request_size_ids.each do |size_id|
          quotation.quotation_lines.find_or_initialize_by(color_id: color_id, size_id: size_id, job_request_id: self.id)
        end
      end

      unselected_color_ids = quotation_color_ids - job_request_color_ids
      unselected_size_ids = quotation_size_ids - job_request_size_ids

      #delete previous quotation lines
      quotation_lines.where(color_id: unselected_color_ids).delete_all
      quotation_lines.where(size_id: unselected_size_ids).delete_all

      quotation.calculate_total
      quotation.save
    end
  end

  def update_artwork
    if provide_artwork
      self.design_brief = nil
      self.concept = nil
    else
      self.attachments.delete_all
    end
  end
end
