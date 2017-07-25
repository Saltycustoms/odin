class AddSizeIdAndColorIdToQuotationLines < ActiveRecord::Migration[5.1]
  def change
    add_column :quotation_lines, :size_id, :integer
    add_column :quotation_lines, :color_id, :integer
  end
end
