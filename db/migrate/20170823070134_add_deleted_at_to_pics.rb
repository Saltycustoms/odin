class AddDeletedAtToPics < ActiveRecord::Migration[5.1]
  def change
    add_column :pics, :deleted_at, :datetime
    add_index :pics, :deleted_at
  end
end
