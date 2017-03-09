json.extract! order, :id, :uuid, :billing_address_id, :shipping_address_id, :status, :shipment_total_cents, :subtotal_cents, :net_total_cents, :tax_cents, :grand_total_cents, :coupon, :currency, :customer_id, :due_date, :created_at, :updated_at
json.url order_url(order, format: :json)
