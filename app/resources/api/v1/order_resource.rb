class Api::V1::OrderResource < JSONAPI::Resource
  attributes :id, :uuid, :status, :coupon, :currency, :customer_id, :due_date
  has_one :shipping_address, class_name: "Address"
  has_one :billing_address, class_name: "Address"
end
