class AddDefaultValuesToQuotationLineCents < ActiveRecord::Migration[5.1]
  def change
    change_column :quotation_lines, :price_per_unit_cents, :integer, :default => 0
    change_column :quotation_lines, :total_cents, :integer, :default => 0
  end
end
