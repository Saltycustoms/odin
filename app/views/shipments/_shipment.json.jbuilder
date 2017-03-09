json.extract! shipment, :id, :order_id, :shipping_method_id, :status, :address_id, :amount_cents, :tracking, :created_at, :updated_at
json.url shipment_url(shipment, format: :json)
