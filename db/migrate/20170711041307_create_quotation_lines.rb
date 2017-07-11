class CreateQuotationLines < ActiveRecord::Migration[5.1]
  def change
    create_table :quotation_lines do |t|
      t.belongs_to :quotation, foreign_key: true
      t.string :description
      t.integer :price_per_unit_cents
      t.integer :quantity
      t.integer :total_cents

      t.timestamps
    end
  end
end
