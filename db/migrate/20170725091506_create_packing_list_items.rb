class CreatePackingListItems < ActiveRecord::Migration[5.1]
  def change
    create_table :packing_list_items do |t|
      t.belongs_to :packing_list, foreign_key: true
      t.integer :design_id
      t.integer :job_request_id
      t.integer :quantity, default: 0
      t.integer :product_id
      t.integer :size_id
      t.integer :color_id

      t.timestamps
    end
  end
end
