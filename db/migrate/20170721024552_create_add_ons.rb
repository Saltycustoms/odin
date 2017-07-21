class CreateAddOns < ActiveRecord::Migration[5.1]
  def change
    create_table :add_ons do |t|
      t.string :description
      t.integer :price_per_unit_cents
      t.integer :quantity
      t.integer :total_cents
      t.belongs_to :job_request, foreign_key: true
      t.belongs_to :quotation, foreign_key: true

      t.timestamps
    end
  end
end
