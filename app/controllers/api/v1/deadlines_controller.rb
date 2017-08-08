class Api::V1::DeadlinesController < ApiController
  def index
    keys = params.keys.collect { |k| k if k.end_with?("_id")}.compact
    if keys
      @deadlines = Deadline.where(build_options(keys)).order(id: :desc)
    else
      @deadlines = Deadline.all
    end
    respond_to do |format|
      format.json { render json: @deadlines }
    end
  end

  def show
    @deadline = Deadline.find_by(id: params[:id])
    respond_to do |format|
      format.json { render json: @deadline || {} }
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
