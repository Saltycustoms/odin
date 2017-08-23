class AddDeletedAtToQuotations < ActiveRecord::Migration[5.1]
  def change
    add_column :quotations, :deleted_at, :datetime
    add_index :quotations, :deleted_at
  end
end
