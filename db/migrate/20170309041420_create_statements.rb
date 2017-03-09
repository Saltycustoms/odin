class CreateStatements < ActiveRecord::Migration[5.0]
  def change
    create_table :statements do |t|
      t.string :uuid
      t.integer :shipment_total_cents, default: 0
      t.integer :subtotal_cents, default: 0
      t.integer :net_total_cents, default: 0
      t.integer :tax_cents, default: 0
      t.integer :grand_total_cents, default: 0
      t.string :type
      t.integer :order_id

      t.timestamps
    end
  end
end
