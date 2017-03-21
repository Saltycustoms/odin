class Api::V1::OrdersController < ApiController
  skip_before_action :verify_authenticity_token, only: [:bulk_update]
  # def index
  #   # @q = Order.ransack(params[:q])
  #   # @orders = @q.result(distinct: true)
  # end

  # def create
  #
  # end

  # def update
  #
  # end

  def bulk_update
    #curl -X PATCH --data 'orders[0][id]=1&orders[0][values][status]=2&orders[0][values][tax_cents]=1000&orders[1][id]=2&orders[1][values][status]=3&orders[1][values][tax_cents]=2000' http://localhost:3000/api/v1/orders/bulk_update
    #0=>{ id: 0, values: [status: "process", amount: 1000] }
    failed_orders = []
    byebug
    params[:orders].each do |o|
      permitted_params = params[:orders][o].permit(:id, values: [:status, :amount_cents])
      order = Order.find_by(id: permitted_params[:id])
      next if order.blank?
      byebug
      updated = order.update_attributes(permitted_params[:values])
      failed_orders << order.id if !updated
    end
    render json: failed_orders
  end

  private

  def bulk_order_params
    params.permit(orders: [ :id, :uuid, :status, :coupon, :currency, :customer_id, :due_date,
      line_attributes: [:id, :description, :price_per_unit_cents, :price_cents, :quantity, :design_id],
      shipping_address_attributes: [:id, :att, :line1, :line2, :post_code, :country_code, :city, :state, :tel],
      billing_address_attributes: [:id, :att, :line1, :line2, :post_code, :country_code, :city, :state, :tel],
      design_attributes: [:id, :order_id, :properties, :_destroy]])
  end

  def bulk_params
    params.permit(orders: [:id, values: [:status, :amount_cents]])
  end
end
