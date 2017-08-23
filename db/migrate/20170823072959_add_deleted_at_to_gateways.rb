class AddDeletedAtToGateways < ActiveRecord::Migration[5.1]
  def change
    add_column :gateways, :deleted_at, :datetime
    add_index :gateways, :deleted_at
  end
end
