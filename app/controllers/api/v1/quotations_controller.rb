class Api::V1::QuotationsController < ApiController
  def index
    keys = params.keys.collect { |k| k if k.end_with?("_id")}.compact
    if keys
      @quotations = Quotation.where(build_options(keys))
    else
      @quotations = Quotation.all
    end
    respond_to do |format|
      format.json { render json: @quotations }
    end
  end

  def show
    @quotation = Quotation.find_by(id: params[:id])
    respond_to do |format|
      format.json { render json: @quotation || {} }
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
