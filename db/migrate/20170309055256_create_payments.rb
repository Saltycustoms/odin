class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.string :ref
      t.string :amount_cents, default: 0
      t.integer :order_id
      t.integer :gateway_id
      t.string :type
      t.text :raw_data
      t.integer :status
      t.jsonb :properties

      t.timestamps
    end
  end
end
