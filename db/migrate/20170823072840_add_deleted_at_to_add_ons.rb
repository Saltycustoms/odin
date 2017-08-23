class AddDeletedAtToAddOns < ActiveRecord::Migration[5.1]
  def change
    add_column :add_ons, :deleted_at, :datetime
    add_index :add_ons, :deleted_at
  end
end
