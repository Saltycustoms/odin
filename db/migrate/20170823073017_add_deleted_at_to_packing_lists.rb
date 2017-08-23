class AddDeletedAtToPackingLists < ActiveRecord::Migration[5.1]
  def change
    add_column :packing_lists, :deleted_at, :datetime
    add_index :packing_lists, :deleted_at
  end
end
