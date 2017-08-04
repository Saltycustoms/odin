class JobRequestsController < ApplicationController
  before_action :set_job_request, only: [:show, :edit, :update, :destroy]
  before_action :set_deal

  # GET /job_requests
  # GET /job_requests.json
  def index
    @job_requests = JobRequest.all
  end

  # GET /job_requests/1
  # GET /job_requests/1.json
  def show
  end

  # GET /job_requests/new
  def new
    @job_request = JobRequest.new
    @product = Product.find(params[:product_id]) if params[:product_id]
    @deal.properties_type.each do |property_name|
      @job_request.properties.build(name: property_name)
    end
  end

  # GET /job_requests/1/edit
  def edit
    @product = @job_request.product
  end

  # POST /job_requests
  # POST /job_requests.json
  def create
    new_params = job_request_params.deep_dup
    new_params[:properties_attributes].each_pair do |key, property_attribute|
      property_attribute[:name] = property_attribute[:name].split(" ").join(" ").humanize
    end
    @job_request = @deal.job_requests.new(new_params)
    begin
      respond_to do |format|
        if @job_request.save
          # Publisher.publish("design", @job_request.attributes)
          format.html { redirect_to @deal, notice: 'Job request was successfully created.' }
          format.json { render :show, status: :created, location: @job_request }
        else
          @product = Product.first
          format.html { render :new }
          format.json { render json: @job_request.errors, status: :unprocessable_entity }
        end
      end
    rescue
      flash.now[:notice] = "Can't have more than 1 property with same name."
      render :new
    end
  end

  # PATCH/PUT /job_requests/1
  # PATCH/PUT /job_requests/1.json
  def update
    @product = @job_request.product
    new_params = job_request_params.deep_dup
    new_params[:properties_attributes].each_pair do |key, property_attribute|
      property_attribute[:name] = property_attribute[:name].split(" ").join(" ").humanize
    end
    respond_to do |format|
      if @job_request.update(new_params)
        format.html { redirect_to [@deal, @job_request], notice: 'Job request was successfully updated.' }
        format.json { render :show, status: :ok, location: @job_request }
      else
        format.html { render :edit }
        format.json { render json: @job_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_requests/1
  # DELETE /job_requests/1.json
  def destroy
    @job_request.destroy
    respond_to do |format|
      format.html { redirect_to @deal, notice: 'Job request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_request
      @job_request = JobRequest.find(params[:id])
    end

    def set_deal
      @deal = Deal.find(params[:deal_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_request_params
      params.require(:job_request).permit(:deal_id, :product_id, :name, :sleeve, :relabeling, :woven_tag, :hang_tag, :pantone_code, :remark, :sample_required, :budget, :client_comment, colors: [], sizes: [],
      print_details_attributes: [:id, :position, :print_method, :block, :color_count, :_destroy],
      properties_attributes: [:id, :name, :value, :_destroy])
    end
end
