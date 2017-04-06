class Api::V1::OrdersController < JSONAPI::ResourceController
  # api already skip
  # skip_before_action :verify_authenticity_token
  # def index
  #   # @q = Order.ransack(params[:q])
  #   # @orders = @q.result(distinct: true)
  # end

  def create
    @order = Order.new(order_params)
    @order.save
    render json: @order
    #in case cannot create through the json api resource
    #create here, create Order first
    #then, create designs
    #based on design create lines

  end

  # def update
  #
  # end

  # def bulk_update
  #   #curl -X PATCH --data 'orders[0][id]=1&orders[0][values][status]=2&orders[0][values][tax_cents]=1000&orders[1][id]=2&orders[1][values][status]=3&orders[1][values][tax_cents]=2000' http://localhost:3000/api/v1/orders/bulk_update
  #   #0=>{ id: 0, values: [status: "process", amount: 1000] }
  #   failed_orders = []
  #   params[:orders].each do |o|
  #     permitted_params = params[:orders][o].permit(:id, values: [:status, :amount_cents])
  #     order = Order.find_by(id: permitted_params[:id])
  #     next if order.blank?
  #     byebug
  #     updated = order.update_attributes(permitted_params[:values])
  #     failed_orders << order.id if !updated
  #   end
  #   render json: failed_orders
  # end

  def bulk_update
    ids = bulk_order_params[:ids].map { |i| i[:id] }
    status = bulk_order_params[:status]
    update = Order.where(id: ids).update(status: status)
    render json: update
  end

  private

  def bulk_order_params
    params.require(:orders).permit([:status,ids:[:id]])
  end

  # def bulk_order_params
  #   params.permit(orders: [ :id, :uuid, :status, :coupon, :currency, :customer_id, :due_date,
  #     line_attributes: [:id, :description, :price_per_unit_cents, :price_cents, :quantity, :design_id],
  #     shipping_address_attributes: [:id, :att, :line1, :line2, :post_code, :country_code, :city, :state, :tel],
  #     billing_address_attributes: [:id, :att, :line1, :line2, :post_code, :country_code, :city, :state, :tel],
  #     design_attributes: [:id, :order_id, :properties, :_destroy]])
  # end
  def order_params
    params.require(:orders).permit([:id, :uuid, :coupon, lines_attributes: [:id, :blank_id, design_attributes: [
    :front_fg_x, :front_fg_y, :front_fg_width, :front_fg_height, :front_fg_image_data, :front_fg_text_data,
    :front_fg_is_text, :front_fg_text_font, :front_fg_text_color, :front_fg_attachment_id, :front_bg_x, :front_bg_y,
    :front_bg_width, :front_bg_height, :front_bg_image_data, :front_bg_attachment_id, :back_fg_x, :back_fg_y, :back_fg_width,
    :back_fg_height, :back_fg_image_data, :back_fg_text_data, :back_fg_is_text, :back_fg_text_font, :back_fg_text_color, :back_fg_attachment_id,
    :back_bg_x, :back_bg_y, :back_bg_width, :back_bg_height, :back_bg_image_data, :back_bg_attachment_id, :left_fg_x, :left_fg_y, :left_fg_width,
    :left_fg_height, :left_fg_image_data, :left_fg_text_data, :left_fg_is_text, :left_fg_text_font, :left_fg_text_color, :left_fg_attachment_id,
    :left_bg_x, :left_bg_y, :left_bg_width, :left_bg_height, :left_bg_image_data, :left_bg_attachment_id, :right_fg_x, :right_fg_y, :right_fg_width,
    :right_fg_height, :right_fg_image_data, :right_fg_text_data, :right_fg_is_text, :right_fg_text_font, :right_fg_text_color, :right_fg_attachment_id,
    :right_bg_x, :right_bg_y, :right_bg_width, :right_bg_height, :right_bg_image_data, :right_bg_attachment_id, :top_fg_x, :top_fg_y, :top_fg_width,
    :top_fg_height, :top_fg_image_data, :top_fg_text_data, :top_fg_is_text, :top_fg_text_font, :top_fg_text_color, :top_fg_attachment_id, :top_bg_x, :top_bg_y,
    :top_bg_width, :top_bg_height, :top_bg_image_data, :top_bg_attachment_id, :bottom_fg_x, :bottom_fg_y, :bottom_fg_width, :bottom_fg_height, :bottom_fg_image_data,
    :bottom_fg_text_data, :bottom_fg_is_text, :bottom_fg_text_font, :bottom_fg_text_color, :bottom_fg_attachment_id, :bottom_bg_x, :bottom_bg_y, :bottom_bg_width,
    :bottom_bg_height, :bottom_bg_image_data, :bottom_bg_attachment_id, :custom1_fg_x, :custom1_fg_y, :custom1_fg_width, :custom1_fg_height, :custom1_fg_image_data,
    :custom1_fg_text_data, :custom1_fg_is_text, :custom1_fg_text_font, :custom1_fg_text_color, :custom1_fg_attachment_id, :custom1_bg_x, :custom1_bg_y, :custom1_bg_width,
    :custom1_bg_height, :custom1_bg_image_data, :custom1_bg_attachment_id, :custom2_fg_x, :custom2_fg_y, :custom2_fg_width, :custom2_fg_height, :custom2_fg_image_data,
    :custom2_fg_text_data, :custom2_fg_is_text, :custom2_fg_text_font, :custom2_fg_text_color, :custom2_fg_attachment_id, :custom2_bg_x, :custom2_bg_y, :custom2_bg_width,
    :custom2_bg_height, :custom2_bg_image_data, :custom2_bg_attachment_id, :custom3_fg_x, :custom3_fg_y, :custom3_fg_width, :custom3_fg_height, :custom3_fg_image_data,
    :custom3_fg_text_data, :custom3_fg_is_text, :custom3_fg_text_font, :custom3_fg_text_color, :custom3_fg_attachment_id, :custom3_bg_x, :custom3_bg_y, :custom3_bg_width,
    :custom3_bg_height, :custom3_bg_image_data, :custom3_bg_attachment_id
    ]]])
  end

  def bulk_params
    params.permit(orders: [:id, values: [:status, :amount_cents]])
  end
end
