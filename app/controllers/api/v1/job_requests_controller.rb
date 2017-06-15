class Api::V1::JobRequestsController < ApiController
  def index
    @job_requests = JobRequest.all
    respond_to do |format|
      format.json { render json: @job_requests }
    end
  end

  def show
    @job_request = JobRequest.find_by(id: params[:id])
    respond_to do |format|
      format.json { render json: @job_request || {} }
    end
  end
end
