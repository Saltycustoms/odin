class JobRequest < ApplicationRecord
  # has_many :design_requests
  # has_many :designs, through: :design_requests
  belongs_to :deal
  has_many :print_details, dependent: :destroy
  has_one :quotation
  jsonb_accessor :metadata,
    sizes: [:string],
    colors: [:string]
  accepts_nested_attributes_for :print_details, allow_destroy: true, reject_if: proc { |attributes| attributes.all? { |key, value| key == "_destroy" || value.blank? } }
  validates :product_id, :colors, :sizes, presence: true
  def designs
    @design_requests = DesignRequest.where(job_request_id: self.id)
    return [] if @design_requests.blank?
    @designs = Design.where(id: @design_requests.collect { |dr| dr.design_id })
    return @designs
  end
end
