class AddProductIdToQuotationLines < ActiveRecord::Migration[5.1]
  def change
    add_column :quotation_lines, :product_id, :integer
  end
end
