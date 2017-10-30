class JobRequestsController < ApplicationController
  before_action :authorize_user, only: [:new, :edit, :create, :update, :destroy, :duplicate, :create_duplicate]
  before_action :set_job_request, only: [:show, :edit, :update, :destroy, :duplicate, :create_duplicate]
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
    JobRequestProperty.name_and_placeholders.each do |property_name, property_value|
      @job_request.job_request_properties.build(name: property_name)
    end
  end

  # GET /job_requests/1/edit
  def edit
    @product = @job_request.product
    @color_ids = @job_request.selected_color_ids
    @size_ids = @job_request.selected_size_ids
  end

  # POST /job_requests
  # POST /job_requests.json
  def create
    new_params = job_request_params.deep_dup
    if new_params[:job_request_properties_attributes].present?
      new_params[:job_request_properties_attributes].each_pair do |key, property_attribute|
        property_attribute[:name] = property_attribute[:name].split(" ").join(" ").humanize
      end
    end
    @job_request = @deal.job_requests.new(new_params)
    if params[:attachments].present?
      params[:attachments].each do |attachment|
        @job_request.attachments.new(attachment: attachment)
      end
    end
    # Reject empty string and convert each of them to string so can be compared.
    @color_ids = new_params[:colors].present? ? new_params[:colors].reject { |c| c.empty? }.map { |c| c.to_i } : []
    @size_ids = new_params[:sizes].present? ? new_params[:sizes].reject { |s| s.empty? }.map { |s| s.to_i } : []
    begin
      respond_to do |format|
        if @job_request.valid? && @color_ids.present? && @size_ids.present?
          # Publisher.publish("design", @job_request.attributes)
          @job_request.save(validate: false)
          format.html { redirect_to @deal, notice: 'Job request was successfully created.' }
          format.json { render :show, status: :created, location: @job_request }
        else
          @product = @job_request&.product
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
    new_params = job_request_params.deep_dup
    @product = Product.find(new_params[:product_id]) if new_params[:product_id].present?
    if new_params[:job_request_properties_attributes].present?
      new_params[:job_request_properties_attributes].each_pair do |key, property_attribute|
        property_attribute[:name] = property_attribute[:name].split(" ").join(" ").humanize
      end
    end
    if params[:attachments].present?
      params[:attachments].each do |attachment|
        @job_request.attachments.new(attachment: attachment)
      end
    end
    @color_ids = new_params[:colors].present? ? new_params[:colors].reject { |c| c.empty? }.map { |c| c.to_i } : []
    @size_ids = new_params[:sizes].present? ? new_params[:sizes].reject { |s| s.empty? }.map { |s| s.to_i } : []
    @job_request.assign_attributes(new_params)
    respond_to do |format|
      if @job_request.valid? && @color_ids.present? && @size_ids.present?
        @job_request.save(validate: false)
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

  def duplicate
    @new_job_request = JobRequest.new
  end

  def create_duplicate
    new_params = job_request_params.deep_dup.merge(@job_request.attributes.slice("remark", "budget", "client_comment", "provide_artwork", "design_brief", "concept"))
    if @job_request.provide_artwork
    end
    print_details_attributes = {}
    job_request_properties_attributes = {}
    attachments_attributes = {}
    @job_request.print_details.each_with_index do |print_detail, index|
      print_details_attributes[index] = print_detail.attributes.slice("position", "block", "color_count", "print_method")
    end
    @job_request.job_request_properties.each_with_index do |property, index|
      job_request_properties_attributes[index] = property.attributes.slice("name", "value")
    end
    @job_request.attachments.each_with_index do |attachment, index|
      attachments_attributes[index] = attachment.attributes.slice("attachment_data")
    end
    new_params.merge!({print_details_attributes: print_details_attributes, job_request_properties_attributes: job_request_properties_attributes, attachments_attributes: attachments_attributes})
    @product = Product.find(new_params[:product_id]) if new_params[:product_id].present?
    @color_ids = new_params[:colors].present? ? new_params[:colors].reject { |c| c.empty? }.map { |c| c.to_i } : []
    @size_ids = new_params[:sizes].present? ? new_params[:sizes].reject { |s| s.empty? }.map { |s| s.to_i } : []
    @new_job_request = @deal.job_requests.new(new_params)
    if @new_job_request.valid? && @color_ids.present? && @size_ids.present?
      @new_job_request.save
      redirect_to @deal, notice: 'Job request was successfully duplicated.'
    else
      render :duplicate
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
      params.require(:job_request).permit(:deal_id, :product_id, :name, :sleeve, :relabeling, :woven_tag, :hang_tag, :provide_artwork, :design_brief, :concept, :pantone_code, :remark, :sample_required, :budget, :client_comment, colors: [], sizes: [],
      print_details_attributes: [:id, :position, :print_method, :block, :color_count, :_destroy],
      job_request_properties_attributes: [:id, :name, :value, :_destroy],
      attachments_attributes: [:id, :attachment, :_destroy],
    end

    def authorize_user
      if !current_user.has_any_role? :admin, :apparel_consultant, :director
        redirect_to request.referrer ? request.referrer : root_path, notice: "You are not authorized."
      end
    end
end
