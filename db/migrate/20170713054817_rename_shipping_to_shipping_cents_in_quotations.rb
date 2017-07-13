class RenameShippingToShippingCentsInQuotations < ActiveRecord::Migration[5.1]
  def change
    rename_column :quotations, :shipping, :shipping_cents
  end
end
