class AddCurrencyToQuotationLine < ActiveRecord::Migration[5.1]
  def change
    add_column :quotation_lines, :currency, :string
  end
end
