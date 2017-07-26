class AddCurrencyToAddOns < ActiveRecord::Migration[5.1]
  def change
    add_column :add_ons, :currency, :string
  end
end
