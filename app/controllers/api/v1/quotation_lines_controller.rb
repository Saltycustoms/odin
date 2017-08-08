class Api::V1::QuotationLinesController < ApiController
  def index
    if params[:q]
      @q = QuotationLine.ransack(params[:q])
      @quotation_lines = @q.result
    else
      @quotation_lines = QuotationLine.where(quotation_lines_params)
    end
    respond_to do |format|
      format.json { render json: @quotation_lines }
    end
  end

  def show
    @quotation_line = QuotationLine.find_by(id: params[:id])
    respond_to do |format|
      format.json { render json: @quotation_line || {} }
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

  def quotation_lines_params
    params.permit(:id, :quotation_id, :description, :price_per_unit_cents, :quantity,
     :total_cents, :created_at, :updated_at, :job_request_id, :size_id, :color_id)
  end
end
