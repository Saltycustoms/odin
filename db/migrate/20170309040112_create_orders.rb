class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :uuid
      t.integer :billing_address_id
      t.integer :shipping_address_id
      t.integer :status, default: 0
      t.integer :shipment_total_cents, default: 0
      t.integer :subtotal_cents, default: 0
      t.integer :net_total_cents, default: 0
      t.integer :tax_cents, default: 0
      t.integer :grand_total_cents, default: 0
      t.string :coupon
      t.string :currency
      t.integer :customer_id
      t.datetime :due_date

      t.timestamps
    end
  end
end
