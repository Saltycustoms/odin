class PackingListsController < ApplicationController
  before_action :set_packing_list, only: [:show, :edit, :update, :destroy]
  before_action :set_deal, except: [:states]

  def index
  end

  def new
    @packing_list = PackingList.new
    @packing_list.build_address
    @deal.job_requests_with_designs.each do |job_request|
      job_request.selected_colors.each do |color|
        job_request.selected_sizes.each do |size|
          PackingListItem.new(job_request_id: job_request.id, color_id: color.id, size_id: size.id)
        end
      end
    end
  end

  def create
  end

  def states
    @country = ISO3166::Country[params[:country]]
    @states = @country ? @country.states : []
    render :layout => false
  end

  private
  def set_deal
    @deal = Deal.find(params[:deal_id])
  end

  def set_packing_list
    @packing_list = PackingList.find(params[:id])
  end

  def packing_list_param
    params.require(:packing_list).permit(:shipping_method, :department,
      address_attributes: [:name, :address1, :address2, :city, :postal_code, :country_code, :state, :_destroy, :id],
      pics_attributes: [:id, :name, :tel, :title, :_destroy],
      packing_list_items_attributes: [:id, :design_id, :job_request_id, :quantity, :product_id, :size_id, :color_id])
  end
end
