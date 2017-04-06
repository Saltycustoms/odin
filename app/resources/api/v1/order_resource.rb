class Api::V1::OrderResource < JSONAPI::Resource
  attributes :uuid, :status, :coupon, :currency, :customer_id, :due_date
  # , :designs, :lines
  has_one :shipping_address, class_name: "ShippingAddress"
  has_one :billing_address, class_name: "BillingAddress"
  has_many :lines, class_name: "OrderLine"
  relationship :designs, to: :many

  filters :id, :status

  # def designs
  #   @model.designs.pluck(:id)
  # end
  #
  # # Setter (because designs needed for creation)
  # def designs=(new_designs)
  #   @model.designs.find_or_initialize_by(new_designs.permit(new_designs.keys))
  # end
  #
  # def lines
  #   @model.lines.pluck(:id)
  # end
  #
  # def lines=(new_line)
  #   byebug
  #   @model.lines.find_or_initialize_by()
  # end
end
