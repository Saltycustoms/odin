class Api::V1::PrintDetailsController < ApiController
  def index
    keys = params.keys.collect { |k| k if k.end_with?("_id")}.compact
    if keys
      @print_details = PrintDetail.where(build_options(keys))
    else
      @print_details = PrintDetail.all
    end
    respond_to do |format|
      format.json { render json: @print_details }
    end
  end

  def show
    @print_detail = PrintDetail.find_by(id: params[:id])
    respond_to do |format|
      format.json { render json: @print_detail || {} }
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
