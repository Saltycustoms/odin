class Api::V1::AddOnsController < ApiController
  def index
    if params[:q]
      @q = AddOn.ransack(params[:q])
      @add_ons = @q.result
    else
      @add_ons = AddOn.where(add_ons_params)
    end
    respond_to do |format|
      format.json { render json: @add_ons }
    end
  end

  def show
    @add_on = AddOn.find_by(id: params[:id])
    respond_to do |format|
      format.json { render json: @add_on || {} }
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

  def add_ons_params
    params.permit(:id, :description, :price_per_unit_cents, :quantity,
     :total_cents, :job_request_id, :quotation_id, :created_at, :updated_at)
  end
end
