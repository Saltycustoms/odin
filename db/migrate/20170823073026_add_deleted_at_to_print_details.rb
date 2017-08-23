class AddDeletedAtToPrintDetails < ActiveRecord::Migration[5.1]
  def change
    add_column :print_details, :deleted_at, :datetime
    add_index :print_details, :deleted_at
  end
end
