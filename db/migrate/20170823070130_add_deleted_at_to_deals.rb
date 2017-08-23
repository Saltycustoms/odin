class AddDeletedAtToDeals < ActiveRecord::Migration[5.1]
  def change
    add_column :deals, :deleted_at, :datetime
    add_index :deals, :deleted_at
  end
end
