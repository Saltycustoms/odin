class PackingListsController < ApplicationController
  before_action :set_packing_list, only: [:show, :edit, :update, :destroy]
  before_action :set_deal, except: [:states, :show]

  def index
  end

  def new
    @job_request_ids = []
    @packing_list = PackingList.new
    @packing_list.build_address
    @deal.job_requests_with_designs.each do |job_request|
      job_request.selected_colors.each do |color|
        job_request.selected_sizes.each do |size|
          @packing_list.packing_list_items.new(job_request_id: job_request.id, color_id: color.id, size_id: size.id)
        end
      end
    end
  end

  def create
    new_params = packing_list_params.deep_dup
    @job_request_ids = params[:select_job_request].present? ? params[:select_job_request].collect {|id| id} : []
    new_params[:packing_list_items_attributes].each do |key, value|
      if !@job_request_ids.include? value[:job_request_id]
        value.merge!(_destroy: 1)
      end
    end
    @packing_list = @deal.packing_lists.new(new_params)
    if params[:attachments].present?
      params[:attachments].each do |attachment|
        @packing_list.attachments.new(attachment: attachment)
      end
    end
    if @packing_list.save
      send_notification(@packing_list, self)
      redirect_to deal_packing_lists_path(@deal), notice: "Packing list was successfully created."
    else
      @deal.job_requests_with_designs.each do |job_request|
        next if @job_request_ids.include? job_request.id.to_s
        job_request.selected_colors.each do |color|
          job_request.selected_sizes.each do |size|
            @packing_list.packing_list_items.new(job_request_id: job_request.id, color_id: color.id, size_id: size.id)
          end
        end
      end
      render :new
    end
  end

  def show
    open_notification(@packing_list, self, current_user) if params[:opened]
  end

  def edit
    @job_request_ids = params[:select_job_request].present? ? params[:select_job_request].collect {|id| id} : @packing_list.packing_list_items.pluck(:job_request_id).uniq.collect { |id| id.to_s }
    @deal.job_requests_with_designs.each do |job_request|
      job_request.selected_colors.each do |color|
        job_request.selected_sizes.each do |size|
          @packing_list.packing_list_items.find_or_initialize_by(job_request_id: job_request.id, color_id: color.id, size_id: size.id)
        end
      end
    end
  end

  def update
    new_params = packing_list_params.deep_dup
    @job_request_ids = params[:select_job_request].present? ? params[:select_job_request].collect {|id| id} : @packing_list.packing_list_items.pluck(:job_request_id).uniq.collect { |id| id.to_s }
    new_params[:packing_list_items_attributes].each do |key, value|
      if !@job_request_ids.include? value[:job_request_id]
        value.merge!(_destroy: 1)
      end
    end
    if params[:attachments].present?
      params[:attachments].each do |attachment|
        @packing_list.attachments.new(attachment: attachment)
      end
    end

    if @packing_list.update(new_params)
      send_notification(@packing_list, self)
      redirect_to deal_packing_lists_path(@deal), notice: "Packing list was successfully updated."
    else
      @deal.job_requests_with_designs.each do |job_request|
        next if @job_request_ids.include? job_request.id.to_s
        job_request.selected_colors.each do |color|
          job_request.selected_sizes.each do |size|
            @packing_list.packing_list_items.new(job_request_id: job_request.id, color_id: color.id, size_id: size.id)
          end
        end
      end
      render :edit
    end
  end

  def states
    @country = ISO3166::Country[params[:country]]
    @states = @country ? @country.states : []
    render :layout => false
  end

  def destroy
    @packing_list.destroy
    redirect_to deal_packing_lists_path, notice: "Packing list was successfully destroyed."
  end

  private
  def set_deal
    @deal = Deal.find(params[:deal_id])
  end

  def set_packing_list
    @packing_list = PackingList.find(params[:id])
  end

  def packing_list_params
    params.require(:packing_list).permit(:shipping_method, :department, :upload_attachment,
      address_attributes: [:name, :address1, :address2, :city, :postal_code, :country_code, :state, :_destroy, :id],
      pics_attributes: [:id, :name, :tel, :title, :email, :_destroy],
      packing_list_items_attributes: [:id, :design_id, :job_request_id, :quantity, :product_id, :size_id, :color_id],
      attachments_attributes: [:id, :attachment, :_destroy])
  end
end
