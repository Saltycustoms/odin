class Api::V1::JobRequestProductsController < ApiController
  def index
    keys = params.keys.collect { |k| k if k.end_with?("_id")}.compact
    if keys
      @job_request_products = JobRequestProduct.where(build_options(keys))
    else
      @job_request_products = JobRequestProduct.all
    end
    respond_to do |format|
      format.json { render json: @job_request_products }
    end
  end

  def show
    @job_request_product = JobRequestProduct.find_by(id: params[:id])
    respond_to do |format|
      format.json { render json: @job_request_product || {} }
    end
  end

  private

  def build_options(keys)
    options = {}
    keys.each do |key|
      options[key.to_sym] = params[key]
    end
    options
  end
end
