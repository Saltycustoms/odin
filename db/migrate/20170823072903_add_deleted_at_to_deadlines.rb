class AddDeletedAtToDeadlines < ActiveRecord::Migration[5.1]
  def change
    add_column :deadlines, :deleted_at, :datetime
    add_index :deadlines, :deleted_at
  end
end
