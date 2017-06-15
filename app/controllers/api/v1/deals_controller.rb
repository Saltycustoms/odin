class Api::V1::DealsController < ApiController
  def index
    @deals = Deal.all
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
