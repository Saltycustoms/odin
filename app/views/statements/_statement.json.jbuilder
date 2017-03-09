json.extract! statement, :id, :uuid, :shipment_total_cents, :subtotal_cents, :net_total_cents, :tax_cents, :grand_total_cents, :type, :order_id, :created_at, :updated_at
json.url statement_url(statement, format: :json)
