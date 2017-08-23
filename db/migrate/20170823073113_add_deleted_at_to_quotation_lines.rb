class AddDeletedAtToQuotationLines < ActiveRecord::Migration[5.1]
  def change
    add_column :quotation_lines, :deleted_at, :datetime
    add_index :quotation_lines, :deleted_at
  end
end
