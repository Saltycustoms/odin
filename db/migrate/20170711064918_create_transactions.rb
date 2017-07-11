class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :order, foreign_key: true
      t.string :transaction_number
      t.string :currency
      t.integer :value_cents
      t.integer :gateway_id
      t.string :type
      t.text :raw
      t.string :token

      t.timestamps
    end
  end
end
