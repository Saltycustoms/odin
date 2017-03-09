class CreateShipments < ActiveRecord::Migration[5.0]
  def change
    create_table :shipments do |t|
      t.integer :order_id
      t.integer :shipping_method_id
      t.integer :status, default: 0
      t.integer :address_id
      t.integer :amount_cents, default: 0
      t.string :tracking

      t.timestamps
    end
  end
end
