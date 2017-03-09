class AddCurrencyToStatement < ActiveRecord::Migration[5.0]
  def change
    add_column :statements, :currency, :string
  end
end
