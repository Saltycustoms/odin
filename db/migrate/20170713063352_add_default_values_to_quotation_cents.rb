class AddDefaultValuesToQuotationCents < ActiveRecord::Migration[5.1]
  def change
    change_column :quotations, :shipping_cents, :integer, :default => 0
    change_column :quotations, :net_total_cents, :integer, :default => 0
    change_column :quotations, :sub_total_cents, :integer, :default => 0
    change_column :quotations, :tax_cents, :integer, :default => 0
  end
end
