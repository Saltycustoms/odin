class Api::V1::JobRequestsController < ApiController
  def index
    keys = params.keys.collect { |k| k if k.end_with?("_id")}.compact
    if keys
      @job_requests = JobRequest.where(build_options(keys))
    else
      @job_requests = JobRequest.all
    end
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

  private

  def build_options(keys)
    options = {}
    keys.each do |key|
      options[key.to_sym] = params[key]
    end
    options
  end
end
