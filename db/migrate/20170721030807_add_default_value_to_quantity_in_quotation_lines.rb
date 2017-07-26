class AddDefaultValueToQuantityInQuotationLines < ActiveRecord::Migration[5.1]
  def change
    change_column_default :quotation_lines, :quantity, 0
  end
end
