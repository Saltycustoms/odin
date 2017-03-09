class CreateOrderLines < ActiveRecord::Migration[5.0]
  def change
    create_table :order_lines do |t|
      t.string :description
      t.integer :price_per_unit_cents, default: 0
      t.integer :price_cents, default: 0
      t.integer :quantity, default: 0
      t.integer :design_id
      t.integer :order_id

      t.timestamps
    end
  end
end
