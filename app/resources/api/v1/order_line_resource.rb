class Api::V1::OrderLineResource < JSONAPI::Resource
  attributes :description, :price_per_unit_cents, :price_cents, :quantity, :design_id, :order_id, :blank_id, :created_at, :updated_at
  has_one :order
  has_one :design
  has_one :blank
end
