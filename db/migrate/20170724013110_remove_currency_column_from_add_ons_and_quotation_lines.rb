class RemoveCurrencyColumnFromAddOnsAndQuotationLines < ActiveRecord::Migration[5.1]
  def change
    remove_column :add_ons, :currency, :string
    remove_column :quotation_lines, :currency, :string
  end
end
