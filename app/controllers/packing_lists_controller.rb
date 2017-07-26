class PackingListsController < ApplicationController
  before_action :set_packing_list, only: [:show, :edit, :update, :destroy]
  before_action :set_deal, except: [:states]

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
    @job_request_ids = params[:select_job_request].present? ? params[:select_job_request].collect {|id| id.to_i} : []
    @packing_list = @deal.packing_lists.new(new_params)
    
    if @packing_list.valid?
      if params[:select_job_request].present?
        new_params[:packing_list_items_attributes].each do |key, value|
          if !params[:select_job_request].include? value[:job_request_id]
            value.merge!(_destroy: 1)
          end
        end
      end
      @deal.packing_lists.create(new_params)
      redirect_to @deal, notice: "Packing list was successfully created."
    else
      render :new
    end
  end

  def edit
    @job_request_ids = @packing_list.packing_list_items.pluck(:job_request_id).uniq
    @deal.job_requests_with_designs.each do |job_request|
      next if @job_request_ids.include? job_request.id
      job_request.selected_colors.each do |color|
        job_request.selected_sizes.each do |size|
          @packing_list.packing_list_items.new(job_request_id: job_request.id, color_id: color.id, size_id: size.id)
        end
      end
    end
  end

  def update
    new_params = packing_list_params.deep_dup
    @job_request_ids = params[:select_job_request].present? ? params[:select_job_request].collect {|id| id.to_i} : []
    @packing_list.assign_attributes new_params.except(:pics_attributes)

    if @packing_list.valid?
      if params[:select_job_request].present?
        new_params[:packing_list_items_attributes].each do |key, value|
          if !params[:select_job_request].include? value[:job_request_id]
            value.merge!(_destroy: 1)
          end
        end
      end
      @packing_list.update(new_params)
      redirect_to @deal, notice: "Packing list was successfully updated."
    else
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
    redirect_to @deal, notice: "Packing list was successfully destroyed."
  end

  private
  def set_deal
    @deal = Deal.find(params[:deal_id])
  end

  def set_packing_list
    @packing_list = PackingList.find(params[:id])
  end

  def packing_list_params
    params.require(:packing_list).permit(:shipping_method, :department,
      address_attributes: [:name, :address1, :address2, :city, :postal_code, :country_code, :state, :_destroy, :id],
      pics_attributes: [:id, :name, :tel, :title, :_destroy],
      packing_list_items_attributes: [:id, :design_id, :job_request_id, :quantity, :product_id, :size_id, :color_id])
  end
end
