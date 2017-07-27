class CreatePackingLists < ActiveRecord::Migration[5.1]
  def change
    create_table :packing_lists do |t|
      t.belongs_to :deal, foreign_key: true
      t.string :department
      t.integer :shipping_method

      t.timestamps
    end
  end
end
