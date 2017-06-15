class JobRequest < ApplicationRecord
  # has_many :design_requests
  # has_many :designs, through: :design_requests
  has_many :print_details
  jsonb_accessor :metadata,
    sizes: [:string]

  accepts_nested_attributes_for :print_details

  def designs
    @design_requests = DesignRequest.where(job_request_id: self.id)
    return [] if @design_requests.blank?
    @designs = Design.where(id: @design_requests.collect { |dr| dr.design_id })
    return @designs
  end
end
