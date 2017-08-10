class Api::V1::DealsController < ApiController
  def index
    if params[:q]
      q = Deal.ransack(params[:q])
      @deals = q.result
    else
      @deals = Deal.all
    end
    respond_to do |format|
      format.json { render json: @deals }
    end
  end

  def show
    @deal = Deal.find_by(id: params[:id])
    respond_to do |format|
      format.json { render json: @deal || {} }
    end
  end
end
