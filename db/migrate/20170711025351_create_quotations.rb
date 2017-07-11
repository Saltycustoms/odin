class CreateQuotations < ActiveRecord::Migration[5.1]
  def change
    create_table :quotations do |t|
      t.belongs_to :deal, foreign_key: true
      t.belongs_to :discount, foreign_key: true
      t.belongs_to :job_request, foreign_key: true
      t.string :payment_term
      t.integer :discount_value
      t.string :currency
      t.integer :shipping
      t.integer :net_total_cents
      t.integer :sub_total_cents
      t.integer :tax_cents

      t.timestamps
    end
  end
end
