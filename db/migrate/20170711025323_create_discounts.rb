class CreateDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :discounts do |t|
      t.belongs_to :deal, foreign_key: true
      t.integer :value
      t.string :type

      t.timestamps
    end
  end
end
