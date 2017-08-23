class AddDeletedAtToDiscounts < ActiveRecord::Migration[5.1]
  def change
    add_column :discounts, :deleted_at, :datetime
    add_index :discounts, :deleted_at
  end
end
