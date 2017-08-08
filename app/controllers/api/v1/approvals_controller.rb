class Api::V1::ApprovalsController < ApiController
  def index
    @approvals = Approval.all
    respond_to do |format|
      format.json { render json: @approvals }
    end
  end

  def show
    @approval = Approval.find_by(id: params[:id])
    respond_to do |format|
      format.json { render json: @approval || {} }
    end
  end
end
