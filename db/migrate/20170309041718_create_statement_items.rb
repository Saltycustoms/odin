class CreateStatementItems < ActiveRecord::Migration[5.0]
  def change
    create_table :statement_items do |t|
      t.string :description
      t.integer :price_per_unit_cents, default: 0
      t.integer :price_cents, default: 0
      t.integer :quantity, default: 0
      t.integer :statement_id

      t.timestamps
    end
  end
end
