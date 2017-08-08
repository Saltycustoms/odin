class Api::V1::PicsController < ApiController
  def index
    @pics = Pic.all
    respond_to do |format|
      format.json { render json: @pics }
    end
  end

  def show
    @pic = Pic.find_by(id: params[:id])
    respond_to do |format|
      format.json { render json: @pic || {} }
    end
  end
end
