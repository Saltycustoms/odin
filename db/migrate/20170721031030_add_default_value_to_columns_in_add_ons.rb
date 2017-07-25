class AddDefaultValueToColumnsInAddOns < ActiveRecord::Migration[5.1]
  def change
    change_column_default :add_ons, :price_per_unit_cents, 0
    change_column_default :add_ons, :total_cents, 0
  end
end
