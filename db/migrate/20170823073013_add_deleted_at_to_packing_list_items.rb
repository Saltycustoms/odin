class AddDeletedAtToPackingListItems < ActiveRecord::Migration[5.1]
  def change
    add_column :packing_list_items, :deleted_at, :datetime
    add_index :packing_list_items, :deleted_at
  end
end
